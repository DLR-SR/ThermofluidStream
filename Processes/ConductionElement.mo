within ThermofluidStream.Processes;
model ConductionElement "Element with quasi-stationary mass and heatport"
  extends Interfaces.SISOFlow(final clip_p_out=false);

  parameter SI.Volume V(displayUnit="l")=0.001 "Volume of the element";
  parameter SI.Area A = 1 "Contact area of element with medium";
  parameter SI.CoefficientOfHeatTransfer U = 200 "Heat transfer coefficient to medium";
  parameter Internal.InitializationMethodsCondElement init=Internal.InitializationMethodsCondElement.inlet "Initialization method for h"
    annotation (Dialog(tab="Initialization", group="Enthalpy"));
  parameter Medium.Temperature T_0 = Medium.T_default "Initial Temperature"
    annotation(Dialog(tab="Initialization", group="Enthalpy", enable=(init == Internal.InitializationMethodsCondElement.T)));
  parameter SI.SpecificEnthalpy h_0 = Medium.h_default "Initial specific enthalpy"
    annotation(Dialog(tab="Initialization", group="Enthalpy", enable=(init == Internal.InitializationMethodsCondElement.h)));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimal density"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean neglectPressureChanges = true "Neglect pressure changes in energy equation"
    annotation(Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_assert(max=0) = -dropOfCommons.m_flow_reg "Assertion threshold for negative massflows"
    annotation(Dialog(tab="Advanced"));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(Q_flow=Q_flow, T=T_heatPort)
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));

  SI.SpecificEnthalpy h(start=Medium.h_default, stateSelect = StateSelect.prefer);

  Medium.ThermodynamicState state = Medium.setState_phX(p_in, h, Xi_in);
  SI.Temperature T = Medium.temperature(state);

protected
  SI.Density rho = max(rho_min, Medium.density(state));

  //for stability reasons the model for reverse flow is different. see documentation/information
  SI.SpecificEnthalpy h_in_norm = if noEvent(inlet.m_flow >= 0) then h_in else h;

  SI.Mass M;

  SI.Temperature T_heatPort;
  SI.HeatFlowRate Q_flow;

initial equation
  if init == Internal.InitializationMethodsCondElement.T then
    h = Medium.specificEnthalpy(Medium.setState_pTX(p_in, T_0, Xi_in));
  elseif init == Internal.InitializationMethodsCondElement.h then
    h = h_0;
  else
    h = Medium.specificEnthalpy(inlet.state);
  end if;

equation
  assert(noEvent(inlet.m_flow > m_flow_assert), "Negative massflow at Element", dropOfCommons.assertionLevel);


  //mass is assumed to be quasisationary-> this violates the conservation of mass since m_flow_in = m_flow_out. see documentation/information
  M = V*rho;

  // in both equations Mass is assumed to be (quasi-)stationary-> assumption der(M*h) = M*der(h)
  // with that and V=const -> der(U) = der(H - pV) = M*der(h)- V*der(p) = Q_in + H_in - H_out
  if not neglectPressureChanges then
    M*der(h) = Q_flow + m_flow*(h_in_norm - h) + V*der(p_in);
  else
    //neglegt V*der(p), since p might not be smooth -> to notice a difference der(p) must be about 1e7 Pa/s. see documentation/information
    M*der(h) = Q_flow + m_flow*(h_in_norm - h);
  end if;

  Q_flow = U*A*(T_heatPort - T);

  dp = 0;
  h_out = h;
  Xi_out = Xi_in;

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
<p>This Model is a Element with a fixed volume (fig. 1). The Mass in the volume is assumed quasi-stationary (statically computed with volume and density), and the inlet massflow is coupled to the outlet massflow. <span style=\"color: #f47d23;\">Because of this the ConductionElement cannot be used as a loop beaker</span><span style=\"color: #b83d00;\">. </span>The advantage is that multiple ConductionElements can be put behind each other without worrying about oscilations or fast eigenvalues between their masses. The Conduction Element implements conservation of mass and energy equations for over the Fluid mass contained within it.</p>
<p>The ConductionElement makes different assumptions:</p>
<ul>
<li>Quasistationary Mass:<br>m_flow_in = - m_flow_out &amp; M = rho * V (this assumption violates conservation of Mass for changing densities, since the mass in the element can change although inflow and outflow are the same)<br>der(H) = der(M*h) = M*der(h) (This assumption violates the conservation of Energy for changing densities, since then the mass M of fluid in the Element is no longer constant)</li>
<li>Neglection of der(p) in the energy equation<br>V*der(p) = 0 (this assumption violates the conservation of energy for changing pressures. For a noticable difference in the testcase the der(p) bist be in the order of 1e5 Pa/s). <br>This assumption can be turned off by setting neglectPressureChanges=false (true by default) in the Advanced tab. <span style=\"color: #f47d23;\">This option requires the inlet pressure to be smooth.</span></li>
<li>Due to stability reasons the component exibits a different behavior for negative massflows (see fig. 2). For negative massflows, the ingoing and outgoing massflows get decoupled from the fluid remaining in the component. The fluid exits with the same state as it enters, and the heatport is connected to the fluid left in the volume (which is decoupled to the mass flowing).<br></li>
</ul>
<p><img width=\"500\" src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.ConductionElement_positive.png\"/></p>
<p><span style=\"font-size: 12pt;\">fig. 1: positive massflow model</span></p>
<p><img width=\"500\" src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.ConductionElement_negative.png\"/></p>
<p><span style=\"font-size: 12pt;\">fig. 2: negative massflow model</span> </p>
</html>"));
end ConductionElement;
