within ThermofluidStream.Undirected.Sensors;
model TwoPhaseSensorSelect "Sensor for a selectable quantity of a twoPhaseMedium"
  extends Internal.PartialSensor(redeclare package Medium=Medium2Phase);

  import Quantities=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities;
  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  replaceable package Medium2Phase =
      Media.myMedia.Interfaces.PartialTwoPhaseMedium "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
<p>Replaceable medium package for the sensor. Medium must be a TwoPase Medium.</p>
</html>"));

  parameter Quantities quantity "Quantity the sensor measures"
    annotation(choicesAllMatching=true);
  parameter Boolean outputValue = false "Enable sensor-value output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=outputValue));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor lowpass"
    annotation(choicesAllMatching=true, Dialog(tab="Initialization", enable=filter_output));
  parameter Real value_0(unit=ThermofluidStream.Sensors.Internal.getTwoPhaseUnit(quantity)) = 0 "Initial output state of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=outputValue and filter_output));

  Modelica.Blocks.Interfaces.RealOutput value_out(unit=ThermofluidStream.Sensors.Internal.getTwoPhaseUnit(quantity)) = value if outputValue "Measured quantity [variable]"
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

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
          extent={{0,79},{60,129}},
          textColor={175,175,175},
          textString="%quantity"),
        Ellipse(
          extent={{-5,5},{5,-5}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Undirected sensor for a vapor quality. It must be separate from SingleSensorSelect, because it needs a TwoPhaseMedium.</p>
</html>"));
end TwoPhaseSensorSelect;
