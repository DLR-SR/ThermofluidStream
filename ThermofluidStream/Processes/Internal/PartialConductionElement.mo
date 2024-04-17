within ThermofluidStream.Processes.Internal;
partial model PartialConductionElement "Partial model of quasi-stationary mass and heat transfer"

  extends Interfaces.SISOFlow(final clip_p_out=false);

  parameter SI.Volume V(displayUnit="l")=0.001 "Volume";
  parameter Internal.InitializationMethodsCondElement init=ThermofluidStream.Processes.Internal.InitializationMethodsCondElement.inlet "Initialization for specific enthalpy"
    annotation (Dialog(tab="Initialization", group="Specific enthalpy"));
  parameter Medium.Temperature T_0 = Medium.T_default "Initial Temperature"
    annotation(Dialog(tab="Initialization", group="Specific enthalpy", enable=(init == Internal.InitializationMethodsCondElement.T)));
  parameter SI.SpecificEnthalpy h_0 = Medium.h_default "Initial specific enthalpy"
    annotation(Dialog(tab="Initialization", group="Specific enthalpy", enable=(init == Internal.InitializationMethodsCondElement.h)));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimal density"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean neglectPressureChanges = true "=true, if pressure changes are neglected"
    annotation(Dialog(tab="Advanced"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.MassFlowRate m_flow_assert(max=0) = -dropOfCommons.m_flow_reg "Assertion threshold for negative massflows"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean enforce_global_energy_conservation = false "= true, if global conservation of energy is enforced"
    annotation(Dialog(tab="Advanced",group="Global energy conservation"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Time T_e = 100 "Time constant for global conservation of energy"
    annotation(Dialog(tab="Advanced",group="global energy conservation", enable = enforce_global_energy_conservation));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(Q_flow=Q_flow, T=T_heatPort) annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));

  SI.SpecificEnthalpy h(start=Medium.h_default, stateSelect = StateSelect.prefer) "Volume? specific enthalpy";

  Medium.ThermodynamicState state = Medium.setState_phX(p_in, h, Xi_in) "Volume thermodynamic state";
  SI.Temperature T = Medium.temperature(state) "Volume temperature";
  SI.ThermalConductance k "Thermal conductance";

  SI.Energy deltaE_system(start=0, fixed=true) "Energy difference between m_flow*(h_in-h_out) and Q_flow";

  SI.Mass M "Mass (of the volume)";

protected
  SI.Density rho = max(rho_min, Medium.density(state)) "Volume density";

  //for stability reasons the model for reverse flow is different. see documentation/information
  SI.SpecificEnthalpy h_in_norm = if noEvent(inlet.m_flow >= 0) then h_in else h "Inlet specific enthalpy";

  SI.Temperature T_heatPort "Heatport Temperature";
  SI.HeatFlowRate Q_flow "Heat flow rate";

initial equation
  if init == Internal.InitializationMethodsCondElement.T then
    h = Medium.specificEnthalpy(Medium.setState_pTX(p_in, T_0, Xi_in));
  elseif init == Internal.InitializationMethodsCondElement.h then
    h = h_0;
  else
    h = Medium.specificEnthalpy(inlet.state);
  end if;

equation
  assert(noEvent(inlet.m_flow > m_flow_assert), "Negative mass flow rate at inlet", dropOfCommons.assertionLevel);

  //mass is assumed to be quasisationary-> this violates the conservation of mass since m_flow_in = -m_flow_out. see documentation/information
  M = V*rho;

  // Mass is assumed to be (quasi-)stationary-> assumption: der(M)=0.
  // V=const
  // lhs: der(U) = der(H - pV) = der(M)*h +  M*der(h) - V*der(p) = M*der(h)
  // one can not simply add der(M)*h to the left side, since the right side is also assuming sationary mass (m_flow_in=-m_flow_out)
  // on RHS: Q_flow + m_flow_in*h_in + m_flow_out*h = Q_flow + m_flow_in*h_in + (m_flow_in-m_flow_in+ m_flow_out)*h = Q_flow + m_flow_in*(h_in-h) + der(M)*h = Q_flow + m_flow*(h_in-h)
  // or:     Q_flow + m_flow_in*h_in + m_flow_out*h = Q_flow + (m_flow_in+m_flow_out-m_flow_out)*h_in + m_flow_out*h = Q_flow + m_flow_out*(h-h_in) + der(M)*h_in = Q_flow + m_flow*(h_in - h)
  // so there is a resulting term on the RHS with der(M)*(h(k) + h_out(1-k)) with k in [0,1]; that also would have to be accounted for when der(M) not 0 on LHS
  // to improve the equation p_in and M would have to be filtered and a value for k would have to be found, all that resulted in only moderate improvements
  // therefore energy that is accumulated with system border around the component (deltaE_system) is slowly fed back into the system when enforce_global_energy_conservation is true
  //(then energy stored in the system e.g. by evaproation/condension, while still being visible short-term, neglegted in logterm)
  if not neglectPressureChanges then
    M*der(h) = Q_flow + m_flow*(h_in_norm - h) + V*der(p_in) + (if enforce_global_energy_conservation then deltaE_system/T_e else 0);
  else
    //neglegt V*der(p), since p might not be smooth -> to notice a difference der(p) must be about 1e7 Pa/s. see documentation/information
    M*der(h) = Q_flow + m_flow*(h_in_norm - h)+ (if enforce_global_energy_conservation then deltaE_system/T_e else 0);
  end if;
  if enforce_global_energy_conservation then
    der(deltaE_system) = Q_flow + m_flow*(h_in_norm - h);
  else
    deltaE_system = 0;
  end if;

  Q_flow = k*(T_heatPort - T);

  dp = 0;
  h_out = h;
  Xi_out = Xi_in;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
       Text(visible=displayInstanceName,
          extent={{-150,80},{150,120}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
       Line(
         points={{-100,0},{100,0}},
         thickness=0.5,
         color={28,108,200}),
       Ellipse(
         extent={{-60,-60},{60,60}},
         lineColor={28,108,200},
         lineThickness=0.5,
         fillColor={170,213,255},
         fillPattern=FillPattern.Solid,
         pattern=LinePattern.Solid),
       Line(points={{-40,-30},{40,-30}}, color={191,0,0}),
       Line(points={{-40,-15},{40,-15}}, color={191,0,0}),
       Line(points={{-40,0},{40,0}}, color={191,0,0}),
       Line(points={{-40,15},{40,15}}, color={191,0,0}),
       Line(points={{-40,30},{40,30}}, color={191,0,0}),
       Line(points={{0,30},{0,-60}}, color={191,0,0})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>
This model is an element with a fixed volume (fig. 1). The mass in the volume is
assumed quasi-stationary (statically computed with volume and density), and the
fore massflow is coupled to the rear massflow. <strong>Because of this the
ConductionElement cannot be used as a loop breaker.</strong>
The advantage is that multiple ConductionElements can be put behind each other
without worrying about oscillations or fast eigenvalues between their masses.
The ConductionElement implements equations for conservation of mass and energy
for the fluid mass contained within it.
</p>
<p>
Initialization can be done by initial temperature, initial enthalpy or by using
the inlet state.
</p>
<p>
The ConductionElement makes different assumptions:
</p>
<ul>
  <li>
    Quasistationary mass:<br>m_flow_rear = - m_flow_fore &amp; M = rho * V
    (this assumption violates the conservation of mass for changing densities,
    since the mass in the element can change although inflow and outflow are
    the same)
    <br>
    der(H) = der(M*h) = M*der(h) (This assumption violates the conservation of
    energy for changing densities, since then the mass M of fluid in the
    element is no longer constant)
  </li>
  <li>
    Neglection of der(p) in the energy equation<br>V*der(p) = 0 (this assumption
    violates the conservation of energy for changing pressures. For a noticeable
    difference in the testcase the der(p) must be in the order of 1e5 Pa/s).
    <br>
    This assumption can be turned off by setting neglectPressureChanges=false
    (true by default) in the Advanced tab. <strong>This option requires the fore
    and rear input pressures to be smooth.</strong>
  </li>
  <li>
    Due to stability reasons the component exhibits a different behavior for
    negative massflows (see fig. 2). For negative massflows, the ingoing and 
    outgoing massflows get decoupled from the fluid remaining in the component. 
    The fluid exits with the same state as it enters, and the heatport is 
    connected to the fluid left in the volume (which is decoupled to the 
    mass flowing).
  </li>
</ul>
<p>
Due to these assumptions minor violations in the global energy conservation can 
occur. With the flag enforce_global_energy_conservation in the &quot;Advanced&quot; 
tab is set true (Default: false), long-term energy storage in the ConductionElement 
is sacrificed to hold global energy conservation.
</p>
<div>
<img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.ConductionElement_positive.png\"/>
</div>
<p>
fig. 1: positive massflow model
</p>
<div>
<img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.ConductionElement_negative.png\"/>
</div>
<p>
fig. 2: negative massflow model
</p>
</html>"));
end PartialConductionElement;
