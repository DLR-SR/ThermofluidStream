within ThermofluidStream.Sensors;
model TwoPhaseSensorSelect31 "v3.1 of TwoPhaseSensorSelect (Display)"
  import Quantities=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities;
  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialTwoPhaseMedium
    "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
<p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected. </p>
</html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter Quantities quantity "Quantity the sensor measures";

  final parameter String quantityString=
  if quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg then "Vapor quality x in kg_Vapor/kg_total"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K then "T_sat in K"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C then "T_sat in °C"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa then "p_sat in Pa"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar then "p_sat in bar"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K then "T - T_sat in K"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa then "p - p_sat in Pa"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar then "p - p_sat in bar"
  else "error";



  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20, -20},{20, 20}}, origin={-100,0})));

  Real value(unit=Internal.getTwoPhaseUnit(quantity)) "Computed value of the selected quantity [variable]";

protected
  function getQuantity = Internal.getTwoPhaseQuantity(redeclare package Medium=Medium) "Quantity compute function"
    annotation (Documentation(info="<html>
    <p>This function computes the selected two-phase quantity from state.</p>
      </html>"));


equation
  inlet.m_flow = 0;
  value = getQuantity(inlet.state, quantity);

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Rectangle(
          extent={{-54,24},{66,-36}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-60,30},{60,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,30},{60,-30}},
          textColor={28,108,200},
          textString=DynamicSelect("value", String(
              value,
              format="1."+String(digits)+"f"))),
        Text(
          extent={{70,-15},{200,15}},
          textColor={0,0,0},
          textString=quantityString,
          horizontalAlignment=TextAlignment.Left)}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This is an extra sensor for vaporQuantity, because the Medium must be constrained by PartialTwoPhaseMedium instead of TwoPhaseMedium.</p>
<p>This sensor can be connected to a fluid stream without a junction.</p>
</html>"));
end TwoPhaseSensorSelect31;
