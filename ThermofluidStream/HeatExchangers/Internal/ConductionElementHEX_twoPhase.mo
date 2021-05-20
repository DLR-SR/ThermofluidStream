within ThermofluidStream.HeatExchangers.Internal;
model ConductionElementHEX_twoPhase "Volume with quasisationary mass and heatport"

  import Modelica.Math;

  extends Interfaces.SISOFlow(redeclare package Medium = twoPhaseMedium, clip_p_out=false);

    replaceable package twoPhaseMedium =
      myMedia.Interfaces.PartialTwoPhaseMedium                                             annotation(choicesAllMatching=true);

  parameter SI.Volume V = 1 "Volume of the Model";
  parameter SI.Area A "Contact area of volume with medium";
  parameter SI.CoefficientOfHeatTransfer U_liq_nom "Nominal coefficient of heat transfer for liquid region";
  parameter SI.CoefficientOfHeatTransfer U_vap_nom "Nominal coefficient of heat transfer for vapour region";
  parameter SI.CoefficientOfHeatTransfer U_tp_nom "Nominal coefficient of heat transfer for two-phase region";
  parameter SI.Density rho_min = dropOfCommons.rho_min "minimal density"
    annotation(Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_nom = 0.5 "Nominal mass-flow rate for heat transfer calculation";
  parameter  SI.MassFraction delta_x = 0.05 "Value for interpolation width";

  constant Real Re_exp_cond(unit="1") = 0.4 "Reynolds-Exponent for heat transfer calculation at condensation (Yan&Lin, 1999)";
  constant Real Re_exp_evap(unit="1") = 0.5 "Reynolds-Exponent for heat transfer calculation at evaporation (Yan&Lin, 1999)";
  constant SI.CoefficientOfHeatTransfer U_min = 1 "Minimum heat transfer coefficient for temperature adaption at zero massflow";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(Q_flow=Q_flow, T=T_heatPort)
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));

  SI.SpecificEnthalpy h(start=Medium.h_default, stateSelect = StateSelect.prefer);
  Medium.ThermodynamicState state = Medium.setState_phX(p_in, h, Xi_in, 0);
  SI.Temperature T = Medium.temperature(state);
  SI.MassFraction x "Vapor quality calculated from enthalpies";

protected
  SI.CoefficientOfHeatTransfer U "Heat transfer coefficient to medium";
  SI.CoefficientOfHeatTransfer U_liq "Coefficient of heat transfer for liquid region";
  SI.CoefficientOfHeatTransfer U_tp "Coefficient of heat transfer for two-phase region";
  SI.CoefficientOfHeatTransfer U_vap "Coefficient of heat transfer for vapour region";

  //for stability reasons the model for reverse flow is different. see documentation/information
  SI.SpecificEnthalpy h_in_norm = if noEvent(inlet.m_flow >= 0) then h_in else h;

  SI.Density rho = max(rho_min, Medium.density(state));

  SI.Mass M;

  SI.Temperature T_heatPort;
  SI.HeatFlowRate Q_flow;

  SI.SpecificEnthalpy h_dew = Medium.dewEnthalpy(Medium.setSat_p(Medium.pressure(state))) "Dew enthalpy at inlet";
  SI.SpecificEnthalpy h_bubble = Medium.bubbleEnthalpy(Medium.setSat_p(Medium.pressure(state))) "Bubble enthalpy at inlet";

initial equation
  h = Medium.specificEnthalpy(inlet.state);

equation
  //Estimation of heat transfer coefficient
  x = (h - h_bubble)/(h_dew - h_bubble);

  //Heat transfer coefficients for each zone dependent on mass-flow rate
  U_liq = max(U_min, U_liq_nom*(abs(inlet.m_flow)/m_flow_nom)^Re_exp_cond);
  U_vap = max(U_min, U_vap_nom*(abs(inlet.m_flow)/m_flow_nom)^Re_exp_evap);
  U_tp = max(U_min, U_tp_nom);

  //Coefficient of heat transfer dependent on vapor quality (interpolation in phase-transition regions)
  U = smooth(1, noEvent(
      if x < -delta_x then U_liq
      elseif x < delta_x then U_liq + 0.5*(U_tp - U_liq)*(1 + Math.sin(x*Modelica.Constants.pi/(2*delta_x)))
      elseif x < 1 - delta_x then U_tp
      elseif x < 1 + delta_x then U_tp + 0.5*(U_vap - U_tp)*(1 + Math.sin((x - 1)*Modelica.Constants.pi/(2*delta_x)))
      else U_vap));

  //mass is assumed to be quasisationary-> this violates the conservation of mass since m_flow_in = m_flow_out. see documentation/information
  M = V*rho;

  // Mass is assumed to be (quasi-)stationary-> assumption der(M*h) = M*der(h)
  // with that and V=const and der(p) small -> der(U) = der(H - pV) = M*der(h) - V*der(p) = M*der(h) = Q_in + H_in - H_out
  M*der(h) = Q_flow + m_flow*(h_in_norm - h); // + V*der(p); // U = H - pV

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
         fillColor={5,188,158},
         fillPattern=FillPattern.Solid,
         pattern=LinePattern.Solid,
          startAngle=45,
          endAngle=225),
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
         color={238,46,47}),
       Ellipse(
         extent={{70,70},{-70,-70}},
         lineColor={28,108,200},
         lineThickness=0.5,
         pattern=LinePattern.Solid,
          startAngle=45,
          endAngle=225),
        Ellipse(
          extent={{-16,-54},{-6,-64}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,-36},{16,-46}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,-44},{-32,-54}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-18,-20},{-8,-30}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,6},{16,-4}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{54,0},{64,-10}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{38,34},{48,24}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{24,16},{34,6}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{20,-22},{30,-32}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{46,-16},{56,-26}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{34,2},{44,-8}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{2,-10},{12,-20}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{54,24},{64,14}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{14,-54},{24,-64}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{32,-38},{42,-48}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-26,-36},{-16,-46}},
          lineColor={28,108,200},
          fillColor={5,188,158},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Implementation of the Conduction Element for the DiscritizedHex.</p>
<p>This Model is a Element with a fixed volume (fig. 1). The Mass in the volume is assumed quasi-stationary (statically computed with volume and density), and the fore massflow is coupled to the rear massflow. <span style=\"color: #f47d23;\">Because of this the ConductionElement cannot be used as a loop beaker</span><span style=\"color: #b83d00;\">. </span>The advantage is that multiple ConductionElements can be put behind each other without worrying about oscilations between their masses. The Conduction Element implements conservation of mass and energy equations for over the Fluid mass contained within it.</p>
<p>Different to the Unidirectional ConductionElement, the model for forward massflow (see fig. 1) is valid for both flow directions.</p>
<p>The ConductionElement makes different assumptions:</p>
<ul>
<li>Quasistationary Mass:<br>m_flow_rear = - m_flow_fore &amp; M = rho * V (this assumption violates conservation of Mass for changing densities, since the mass in the element can change although inflow and outflow are the same)<br>der(H) = der(M*h) = M*der(h) (This assumption violates the conservation of Energy for changing densities, since then the mass M of fluid in the Element is no longer constant)</li>
<li>Neglection of der(p) in the energy equation<br>V*der(p) = 0 (this assumption violates the conservation of energy for changing pressures. For a noticable difference in the testcase the der(p) bist be in the order of 1e5 Pa/s). </li>
<li>Heat transfer coefficient<br>It is assmued, that the main term influencing the coefficient of heat transfer is the mass flow rate. Therefore a nominal value for the heat transfer coefficient at a nominal mass flow rate can be set. <br>The reynolds exponents for normalisation of the heat transfer coefficient for evaporation and condensation are taken from <br>Yan, Yi-Yie, &amp; Lin, T.-F. (1999). Condensation heat transfer and pressure drop of refrigerant R-134a in a small pipe. International Journal of Heat and Mass Transfer, 42(4) and <br>Yan, Y.-Y., &amp; Lin, T.-F. (1999). Evaporation Heat Transfer and Pressure Drop of Refrigerant R-134a in a Plate Heat Exchanger. Journal of Heat Transfer, 121(1) <br>Furthermore a minimum value U_min for the coefficent of het transfer is set to ensure heat transfer at zero mass flow. </li>
</ul>
<p><img width=\"500\" src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.ConductionElement_positive.png\"/></p>
<p><span style=\"font-size: 12pt;\">fig. 1: positive massflow model</span></p>
<p><img width=\"500\" src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.ConductionElement_negative.png\"/></p>
<p><span style=\"font-size: 12pt;\">fig. 2: negative massflow model</span> </p>
</html>"));
end ConductionElementHEX_twoPhase;
