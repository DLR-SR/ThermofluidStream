within ThermofluidStream.Sensors;
model DifferenceTwoPhaseSensorSensorSelect "Sensor to compute difference in vapor quality"
  import Quantities=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities;
  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  replaceable package MediumA = Media.myMedia.Interfaces.PartialTwoPhaseMedium
    "Medium model A"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the positive input of the sensor. Make sure it is the same for the stream the sensors inputs are connected.</p>
        </html>"));
  replaceable package MediumB = Media.myMedia.Interfaces.PartialTwoPhaseMedium
    "Medium model B"
    annotation (choicesAllMatching=true,
    Documentation(info="<html>
    <p>Medium Model for the negative input of the sensor. Make sure it is the same for the stream the sensors inputs are connected.</p>
      </html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter Quantities quantity "Quantity the sensor measures"
    annotation(choicesAllMatching=true);
  parameter Boolean outputValue = false "Enable sensor-value output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=outputValue));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor lowpass"
    annotation(choicesAllMatching=true, Dialog(tab="Initialization", enable=filter_output));
  parameter Real value_0(unit=Internal.getTwoPhaseUnit(quantity)) = 0 "Initial output state of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=outputValue and filter_output));

  Interfaces.Inlet inletA(redeclare package Medium=MediumA)
    annotation (Placement(transformation(extent={{-20, -20},{20, 20}}, origin={-100,80}),
        iconTransformation(extent={{-120,20},{-80,60}})));
  Interfaces.Inlet inletB(redeclare package Medium=MediumB)
    annotation (Placement(transformation(extent={{-20, -20},{20, 20}}, origin={-100,-80}),
        iconTransformation(extent={{-120,-60},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealOutput value_out(unit=Internal.getTwoPhaseUnit(quantity)) = value if outputValue "Difference of measured quantity [variable]"
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

  output Real value(unit=Internal.getTwoPhaseUnit(quantity)) "Computed difference in the selected quantity";

  Real valueA(unit=Internal.getTwoPhaseUnit(quantity));
  Real valueB(unit=Internal.getTwoPhaseUnit(quantity));

protected
  outer DropOfCommons dropOfCommons;

  Real direct_value(unit=Internal.getTwoPhaseUnit(quantity));

  function getQuantityA = Internal.getTwoPhaseQuantity(redeclare package Medium=MediumA) "Quantity compute function"
    annotation (Documentation(info="<html>
    <p>This function computes the selected two-phase quantity from state.</p>
      </html>"));
  function getQuantityB = Internal.getTwoPhaseQuantity(redeclare package Medium=MediumB) "Quantity compute function"
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

  inletA.m_flow = 0;
  inletB.m_flow = 0;

  valueA = getQuantityA(inletA.state, quantity);
  valueB = getQuantityB(inletB.state, quantity);

  direct_value = valueA-valueB;

  if filter_output then
    der(value) * TC = direct_value-value;
  else
    value = direct_value;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-54,24},{66,-36}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-80,0},{0,0}},
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
          extent={{0,25},{60,75}},
          textColor={175,175,175},
          textString="%quantity"),
        Line(
          points={{-80,40},{-80,-40}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,-40},{-80,-40}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,40},{-80,40}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-70,50},{-50,50}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-10,0},{10,0}},
          color={28,108,200},
          thickness=0.5,
          origin={-60,50},
          rotation=90),
        Line(
          points={{-70,-50},{-50,-50}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-72,62},{-48,38}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Ellipse(
          extent={{-72,-38},{-48,-62}},
          lineColor={28,108,200},
          lineThickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Sensor for measuring the difference of the vapor quality between two fluid streams.</p>
<p>This sensor can be connected totwo fluid streams without a junction.</p>
</html>"));
end DifferenceTwoPhaseSensorSensorSelect;
