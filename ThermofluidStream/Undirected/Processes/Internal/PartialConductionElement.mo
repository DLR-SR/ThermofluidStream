within ThermofluidStream.Undirected.Processes.Internal;
partial model PartialConductionElement "Partial volume with quasisationary mass and heatport and undetermined heat transfer coefficient"
  extends Interfaces.SISOBiFlow(final clip_p_out=false);

  parameter SI.Volume V = 1 "Volume of the element";
  parameter ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement init=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.rear "Initialization method for h"
    annotation (Dialog(tab="Initialization", group="Enthalpy"));
  parameter SI.Temperature T_0 = Medium.T_default "Initial Temperature"
    annotation(Dialog(tab="Initialization", group="Enthalpy", enable=(init == ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.T)));
  parameter SI.SpecificEnthalpy h_0 = Medium.h_default "Initial specific enthalpy"
    annotation(Dialog(tab="Initialization", group="Enthalpy", enable=(init == ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.h)));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimal density"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean neglectPressureChanges = true "Neglect pressure changes in energy equation"
    annotation(Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization massflow to switch between positive- and negative-massflow model"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean enforce_global_energy_conservation = false "If true, exact global energy conservation is enforced by feeding back all energy stored locally back in the system"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Time T_e = 100 "Factor for feeding back energy."
    annotation(Dialog(tab="Advanced", enable = enforce_global_energy_conservation));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(Q_flow=Q_flow, T=T_heatPort)
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));

  SI.SpecificEnthalpy h(start=Medium.h_default, stateSelect = StateSelect.prefer);

  Medium.ThermodynamicState state = Medium.setState_phX(p, h, Xi);
  SI.Temperature T = Medium.temperature(state);
  SI.ThermalConductance k "Thermal conductance heatport->fluid";

  SI.Energy deltaE_system(start=0, fixed=true) "Energy difference between m_flow*(h_in-h_out) and Q_flow";

  SI.Mass M;

protected
  SI.Pressure p = Undirected.Internal.regStep(m_flow, p_rear_in, p_fore_in, m_flow_reg);
  Medium.MassFraction[Medium.nXi] Xi = Undirected.Internal.regStep(m_flow, Xi_rear_in, Xi_fore_in, m_flow_reg);
  //h_in only in rhs of ODE--> h still smooth, better results at low massflow than using regStep
  SI.SpecificEnthalpy h_in = if m_flow >= 0 then h_rear_in else h_fore_in;

  SI.Density rho = max(rho_min, Medium.density(state));
  SI.SpecificEnthalpy h_out = Medium.specificEnthalpy(state);

  SI.Temperature T_heatPort;
  SI.HeatFlowRate Q_flow;

initial equation
  if init == Internal.InitializationMethodsCondElement.T then
     h = Medium.specificEnthalpy(Medium.setState_pTX(p, T_0, Xi));
  elseif init == Internal.InitializationMethodsCondElement.h then
     h = h_0;
  elseif init == InitializationMethodsCondElement.port then
     h = h_in;
  elseif init == Internal.InitializationMethodsCondElement.fore then
     h = h_fore_in;
   else
     h = h_rear_in;
   end if;

equation
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
  // therefore energy that is accumulated with system border around the component (deltaE_system) is slowly fed back into the sytem when enforce_global_energy_conservation is true
  //(then energy stored in the system e.g. by evaproation/condension, while still being visible short-term, neglegted in logterm)
  if not neglectPressureChanges then
    M*der(h) = Q_flow + abs(m_flow)*(h_in - h_out) + V*der(p) + (if enforce_global_energy_conservation then deltaE_system/T_e else 0);
  else
    //neglegt V*der(p), since p might not be smooth -> to notice a difference der(p) must be about 1e7 Pa/s. see documentation/information
    M*der(h) = Q_flow + abs(m_flow)*(h_in - h_out) + (if enforce_global_energy_conservation then deltaE_system/T_e else 0);
  end if;
  if enforce_global_energy_conservation then
    der(deltaE_system) = Q_flow + abs(m_flow)*(h_in - h_out);
  else
    deltaE_system = 0;
  end if;

  Q_flow = k*(T_heatPort - T);

  //forwards model
  dp_fore = 0;
  h_fore_out = h;
  Xi_fore_out = Xi_rear_in;

  //rearwards model
  dp_rear = 0;
  h_rear_out = h;
  Xi_rear_out = Xi_fore_in;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
       Line(
         points={{-100,0},{100,0}},
         thickness=0.5,
         color={28,108,200}),
       Ellipse(
         extent={{-70,-70},{70,70}},
         lineColor={28,108,200},
         lineThickness=0.5,
         fillColor={170,213,255},
         fillPattern=FillPattern.Solid,
         pattern=LinePattern.Solid),
       Line(
         points={{-50,-30},{50,-30}},
         color={238,46,47}),
       Line(
         points={{-50,-15},{50,-15}},
         color={238,46,47}),
       Line(
         points={{-50,0},{50,0}},
         color={238,46,47}),
       Line(
         points={{-50,15},{50,15}},
         color={238,46,47}),
       Line(
         points={{-50,30},{50,30}},
         color={238,46,47}),
       Line(
         points={{0,100},{0,-30}},
         color={238,46,47})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Undirected implementation of the Conduction Element.
</p>
<p>
This model is an element with a fixed volume (fig. 1). The mass in the volume is 
assumed quasi-stationary (statically computed with volume and density), and the 
fore massflow is coupled to the rear massflow. <strong>Because of this the 
ConductionElement cannot be used as a loop breaker</strong>.
The advantage is that multiple ConductionElements can be put behind each other 
without worrying about oscillations or fast eigenvalues between their masses. 
The ConductionElement implements equations for conservation of mass and energy 
for the fluid mass contained within it.
</p>
<p>
Different to the unidirectional ConductionElement, the model for forward massflow
(see fig. 1) is valid for both flow directions.
</p>
<p>
Additionally the undirected Conduction Element offers more initialization methods 
for h. Additionally to initialize T or h by a parameter, one can choose to 
initialize with the incoming enthalpy from either one of the two ports, or use the 
correct one, depending on the massflow (option &apos;port&apos;). The last option 
can lead to large nonlinear initialization problems, we advice to choose the port 
to initialize h from if known in advance (options &apos;rear&apos; or &apos;fore&apos;).
</p>
<p>
The ConductionElement makes different assumptions:
</p>
<ul>
  <li>
    Quasistationary Mass:
    <br>
    m_flow_rear = - m_flow_fore &amp; M = rho * V
    (this assumption violates the conservation of mass for changing densities,
    since the mass in the element can change although inflow and outflow are the
    same)
    <br>
    der(H) = der(M*h) = M*der(h)
    (This assumption violates the conservation of energy for changing densities,
    since then the mass M of fluid in the element is no longer constant)
  </li>
  <li>
    Neglection of der(p) in the energy equation
    <br>
    V*der(p) = 0
    (this assumption violates the conservation of energy for changing pressures.
    For a noticable difference in the testcase the der(p) must be in the
    order of 1e5 Pa/s).
    <br>
    This assumption can be turned off by setting neglectPressureChanges=false
    (true by default) in the Advanced tab. <strong>This option requires the 
    fore and rear input pressures to be smooth.</strong>
  </li>
</ul>
<p>
Due to these assumptions minor violations in the global energy conservation can 
occur.
With the flag enforce_global_energy_conservation in the &quot;Advanced&quot; tab 
is set true (Default: false), long-term energy storage in the ConductionElement 
is sacrificed to hold global energy conservation.
</p>
<div>
<img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.ConductionElement_positive.png\"/>
</div>
<p>
fig. 1: positive massflow model
</p>
</html>"));
end PartialConductionElement;
