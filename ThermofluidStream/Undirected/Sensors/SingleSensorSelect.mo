within ThermofluidStream.Undirected.Sensors;
model SingleSensorSelect "Sensor with selectable measured quantity"
  extends Internal.PartialSensor;
  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  parameter ThermofluidStream.Sensors.Internal.Types.Quantities quantity "Quantity to be measured";
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimum density"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter Boolean outputValue = false "Enable sensor-value output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=outputValue));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor lowpass"
    annotation(Dialog(tab="Initialization", enable=filter_output));
  parameter Real value_0(unit=ThermofluidStream.Sensors.Internal.getUnit(quantity)) = 0 "Initial output state of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=outputValue and filter_output));

  Modelica.Blocks.Interfaces.RealOutput value_out(unit=ThermofluidStream.Sensors.Internal.getUnit(quantity)) = value if outputValue "Measured quantity [variable]"
    annotation (Placement(
        transformation(extent={{70,50},{90,70}}),
          iconTransformation(extent={{70,50},{90,70}})));

  function getQuantity = ThermofluidStream.Sensors.Internal.getQuantity (
    redeclare package Medium = Medium) "Quantity compute function"
    annotation (Documentation(info="<html>
      <p>This function computes the selected quantity from state. r and rho_min are neddet for the quantities r/p_total and v respectively.</p>
      </html>"));

  Real value(unit=ThermofluidStream.Sensors.Internal.getUnit(quantity));

protected
  Real direct_value(unit=ThermofluidStream.Sensors.Internal.getUnit(quantity));

initial equation
  if filter_output and init==InitMode.steadyState then
    value= direct_value;
  elseif filter_output then
    value = value_0;
  end if;


equation

  direct_value = getQuantity(state, rear.r, quantity, rho_min);

  if filter_output then
    der(value) * TC = direct_value-value;
  else
    value = direct_value;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,-40},{150,-80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Rectangle(
          extent={{-54,84},{66,24}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{0,34},{0,0}},    color={0,0,0}),
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
          extent={{2,77},{62,127}},
          textColor={175,175,175},
          textString="%quantity"),
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
<p>Undirected sensor for a single selectable quantity. For some quatities several units are available.</p>
</html>"));
end SingleSensorSelect;
