within ThermofluidStream.HeatExchangers.Internal;
model ConductionElementHEX "Volume with quasisationary mass and heatport"
  extends Interfaces.SISOFlow(clip_p_out=false);

  parameter SI.Volume V = 1 "Volume of the Model";
  parameter SI.Area A = 1 "Contact area of volume with medium";
  parameter SI.CoefficientOfHeatTransfer U_nom "Nominal coefficient of heat transfer";
  parameter SI.Density rho_min = dropOfCommons.rho_min "minimal density"
    annotation(Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_nom = 0.5 "Nominal mass-flow rate for heat transfer calculation";

  constant Real Re_exp(unit="1") = 0.8 "Reynolds-exponent for heat transfer calculation";
  constant SI.CoefficientOfHeatTransfer U_min = 1 "Minimum heat transfer coefficient for temperature adaption at zero massflow";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(Q_flow=Q_flow, T=T_heatPort)
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));

  SI.SpecificEnthalpy h(start=Medium.h_default, stateSelect = StateSelect.prefer);
  Medium.ThermodynamicState state = Medium.setState_phX(p_in, h, Xi_in);
  SI.Temperature T = Medium.temperature(state);

protected
  SI.CoefficientOfHeatTransfer U "Heat transfer coefficient to medium";

  //for stability reasons the model for reverse flow is different. see documentation/information
  SI.SpecificEnthalpy h_in_norm = if noEvent(inlet.m_flow) >= 0 then h_in else h;

  SI.Density rho = max(rho_min, Medium.density(state));

  SI.Mass M;

  SI.Temperature T_heatPort;
  SI.HeatFlowRate Q_flow;

initial equation
  h = Medium.specificEnthalpy(inlet.state);

equation
  //Estimation of heat transfer coefficient
  U = max(U_min, U_nom*(abs(m_flow/m_flow_nom))^Re_exp);


  //mass is assumed to be quasisationary-> this violates the conservation of mass since m_flow_in = m_flow_out. see documentation/information
  M = V*rho;

  // Mass is assumed to be (quasi-)stationary-> assumption der(M*h) = M*der(h)
  // with that and V=const and der(p) small -> der(U) = der(H - pV) = M*der(h) - V*der(p) = M*der(h) = Q_in + H_in - H_out
  M*der(h) = Q_flow + m_flow*(h_in_norm - h);

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
<p>Bidirectional implementation of the Conduction Element.</p>
<p>This Model is a Element with a fixed volume (fig. 1). The Mass in the volume is assumed quasi-stationary (statically computed with volume and density), and the fore massflow is coupled to the rear massflow. <span style=\"color: #f47d23;\">Because of this the ConductionElement cannot be used as a loop beaker</span><span style=\"color: #b83d00;\">. </span>The advantage is that multiple ConductionElements can be put behind each other without worrying about oscilations between their masses. The Conduction Element implements conservation of mass and energy equations for over the Fluid mass contained within it.</p>
<p>Different to the Unidirectional ConductionElement, the model for forward massflow (see fig. 1) is valid for both flow directions.</p>
<p>The ConductionElement makes different assumptions:</p>
<ul>
<li>Quasistationary Mass:<br>m_flow_rear = - m_flow_fore &amp; M = rho * V (this assumption violates conservation of Mass for changing densities, since the mass in the element can change although inflow and outflow are the same)<br>der(H) = der(M*h) = M*der(h) (This assumption violates the conservation of Energy for changing densities, since then the mass M of fluid in the Element is no longer constant)</li>
<li>Neglection of der(p) in the energy equation<br>V*der(p) = 0 (this assumption violates the conservation of energy for changing pressures. For a noticable difference in the testcase the der(p) must be in the order of 1e5 Pa/s). 
<li>Heat transfer coefficient<br>It is assmued, that the main term influencing the coefficient of heat transfer is the mass flow rate. Therefore a nominal value for the heat transfer coefficient at a nominal mass flow rate can be set.
<br>Furthermore a minimum value U_min for the coefficent of het transfer is set to ensure heat transfer at zero mass flow.
</ul>
<p><img width=\"500\" src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.ConductionElement_positive.png\"/></p>
<p><span style=\"font-size: 12pt;\">fig. 1: positive massflow model</span></p>
<p><img width=\"500\" src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.ConductionElement_negative.png\"/></p>
<p><span style=\"font-size: 12pt;\">fig. 2: negative massflow model</span> </p>
</html>"));
end ConductionElementHEX;
