within ThermofluidStream.HeatExchangers.Internal;
model ConductionElementHEX_twoPhase "ConductionElement for two-phase fluids"
  extends PartialConductionElementHEX(redeclare replaceable package Medium = Media.myMedia.Interfaces.PartialTwoPhaseMedium);

  import Modelica.Math;

  parameter SI.CoefficientOfHeatTransfer U_liq_nom = 700 "Nominal coefficient of heat transfer for liquid flow";
  parameter SI.CoefficientOfHeatTransfer U_vap_nom = 500 "Nominal coefficient of heat transfer for vapour flow";
  parameter SI.CoefficientOfHeatTransfer U_tp_nom = 1000 "Nominal coefficient of heat transfer for condensation/evaporation";

  parameter SI.MassFlowRate m_flow_nom = 0.3 "Nominal mass flow rate for heat transfer calculation";
  parameter SI.MassFraction delta_x = 0.05 "Value for interpolation width";

  constant Real Re_exp_cond(unit="1") = 0.4 "Reynolds-Exponent for heat transfer calculation at condensation (Yan&Lin, 1999)";
  constant Real Re_exp_evap(unit="1") = 0.5 "Reynolds-Exponent for heat transfer calculation at evaporation (Yan&Lin, 1999)";

  Real x "Vapor quality calculated from specific enthalpies";

protected
  SI.CoefficientOfHeatTransfer U_liq "Coefficient of heat transfer for liquid flow";
  SI.CoefficientOfHeatTransfer U_tp "Coefficient of heat transfer for condensation/evaporation";
  SI.CoefficientOfHeatTransfer U_vap "Coefficient of heat transfer for vapour flow";

  SI.SpecificEnthalpy h_dew = Medium.dewEnthalpy(Medium.setSat_p(Medium.pressure(state))) "Dew enthalpy at inlet";
  SI.SpecificEnthalpy h_bubble = Medium.bubbleEnthalpy(Medium.setSat_p(Medium.pressure(state))) "Bubble enthalpy at inlet";

equation
  //Estimation of heat transfer coefficient
  x = (h - h_bubble)/(h_dew - h_bubble);

  //Heat transfer coefficients for each zone dependent on mass-flow rate
  U_liq = max(U_min, U_liq_nom*(abs(inlet.m_flow)/(m_flow_nom/nCellsParallel))^
    Re_exp_cond);
  U_vap = max(U_min, U_vap_nom*(abs(inlet.m_flow)/(m_flow_nom/nCellsParallel))^
    Re_exp_evap);
  U_tp = max(U_min, U_tp_nom);

  //Coefficient of heat transfer dependent on vapor quality (interpolation in phase-transition regions)
  U = smooth(1, noEvent(
      if x < -delta_x then U_liq
      elseif x < delta_x then U_liq + 0.5*(U_tp - U_liq)*(1 + Math.sin(x*Modelica.Constants.pi/(2*delta_x)))
      elseif x < 1 - delta_x then U_tp
      elseif x < 1 + delta_x then U_tp + 0.5*(U_vap - U_tp)*(1 + Math.sin((x - 1)*Modelica.Constants.pi/(2*delta_x)))
      else U_vap));

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
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
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Implementation of the Conduction Element for the DiscritizedHex.</p>
<p>Concerning the heat transfer coefficient it is assumed, that the main term influencing the coefficient of heat transfer is the mass flow rate. Therefore a nominal value for the heat transfer coefficient at a nominal mass flow rate can be set. The reynolds exponents for normalization of the heat transfer coefficient for evaporation and condensation are taken from Yan, Yi-Yie, &amp; Lin, T.-F. (1999). Condensation heat transfer and pressure drop of refrigerant R-134a in a small pipe. International Journal of Heat and Mass Transfer, 42(4) and Yan, Y.-Y., &amp; Lin, T.-F. (1999). Evaporation Heat Transfer and Pressure Drop of Refrigerant R-134a in a Plate Heat Exchanger. Journal of Heat Transfer, 121(1). Furthermore a minimum value U_min for the coefficient of heat transfer is set to ensure heat transfer at zero mass flow.</p>
<p>For further documentation see the documentation of the motherclass.</p>
</html>"));
end ConductionElementHEX_twoPhase;
