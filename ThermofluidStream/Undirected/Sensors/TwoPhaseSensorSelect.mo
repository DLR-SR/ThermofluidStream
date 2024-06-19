within ThermofluidStream.Undirected.Sensors;
model TwoPhaseSensorSelect "Selectable sensor for two phase medium"

  extends Internal.PartialSensor(redeclare package Medium=Medium2Phase);

  import Quantities=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities;
  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  replaceable package Medium2Phase = Media.myMedia.Interfaces.PartialTwoPhaseMedium "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
<p>Replaceable medium package for the sensor. Medium must be a TwoPase Medium.</p>
</html>"));
  parameter Quantities quantity "Measured quantity"
    annotation(choicesAllMatching=true);
  final parameter String quantityString=
    if quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg then "x in kg/kg"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K then "T_sat in K"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C then "T_sat in °C"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa then "p_sat in Pa"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar then "p_sat in bar"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K then "T - T_sat in K"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa then "p - p_sat in Pa"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar then "p - p_sat in bar"
    else "error";
  parameter Boolean outputValue = false "= true, if sensor output is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean filter_output = false "= true, if sensor output is filtered (to break algebraic loops)"
    annotation(Dialog(group="Output", enable=outputValue),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Time TC = 0.1 "Time constant of sensor output filter (PT1)"
    annotation(Dialog(group="Output", enable=outputValue and filter_output));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor output"
    annotation(Dialog(group="Output", enable=outputValue and filter_output));
  parameter Real value_0(unit=ThermofluidStream.Sensors.Internal.getTwoPhaseUnit(quantity)) = 0 "Start value of sensor output"
    annotation(Dialog(group="Output", enable=outputValue and filter_output and init==InitMode.state));

  Modelica.Blocks.Interfaces.RealOutput value_out(unit=ThermofluidStream.Sensors.Internal.getTwoPhaseUnit(quantity)) = value if outputValue "Sensor output connector"
    annotation (Placement(
        transformation(extent={{70,50},{90,70}}),
          iconTransformation(extent={{70,50},{90,70}})));

  Real value(unit=ThermofluidStream.Sensors.Internal.getTwoPhaseUnit(quantity));

protected
  Real direct_value(unit=ThermofluidStream.Sensors.Internal.getTwoPhaseUnit(quantity));

  function getQuantity = ThermofluidStream.Sensors.Internal.getTwoPhaseQuantity (
    redeclare package Medium = Medium) "Quantity compute function"
    annotation (Documentation(info="<html>
    <p>This function computes the selected two-phase quantity from state.</p>
      </html>"));

initial equation
  if filter_output and init==InitMode.steadyState then
    value= direct_value;
  elseif filter_output then
    value = value_0;
  end if;


equation
  direct_value = getQuantity(state, quantity);

  if filter_output then
    der(value) * TC = direct_value-value;
  else
    value = direct_value;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,-25},{150,-65}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Rectangle(
          extent={{-54,84},{66,24}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{0,34},{0,0}}, color={0,0,0}),
        Rectangle(
          extent={{-60,90},{60,30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,90},{60,30}},
          textColor={28,108,200},
          textString=DynamicSelect("value", String(value, format="1."+String(digits)+"f"))),
        Text(
          extent={{-150,130},{150,100}},
          textColor={0,0,0},
          textString=quantityString),
        Ellipse(
          extent={{-5,5},{5,-5}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(visible=outputValue,
          points={{60,60},{78,60}},
          color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Undirected sensor for a vapor quality. It must be separate from SingleSensorSelect, because it needs a TwoPhaseMedium.</p>
</html>"));
end TwoPhaseSensorSelect;
