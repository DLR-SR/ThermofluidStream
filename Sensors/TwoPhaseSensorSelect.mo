within ThermofluidStream.Sensors;
model TwoPhaseSensorSelect "Sensor for a selectable quantity of a twoPhaseMedium"
  import Quantities=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities;

  replaceable package Medium = myMedia.Interfaces.PartialTwoPhaseMedium "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
<p>Medium Model for the sensor. Make shure it is the same as for all lines the sensors input is connected. </p>
</html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter Quantities quantity "Quantitiy the sensor measures"
    annotation(choicesAllMatching=true);
  parameter Boolean outputValue = false "Enable sensor-value output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=outputValue));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=outputValue and filter_output));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20, -20},{20, 20}}, origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput value_out(unit=Internal.getTwoPhaseUnit(quantity)) = value if outputValue "Computed value of the selected Quantity [variable]"
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

  output Real value(unit=Internal.getTwoPhaseUnit(quantity)) "Computed value of the selected Quantity [variable]";

protected
  Real direct_value(unit=Internal.getTwoPhaseUnit(quantity));

  function getQuantity = Internal.getTwoPhaseQuantity(redeclare package Medium=Medium) "Quantity compute function"
    annotation (Documentation(info="<html>
    <p>This function computes the selected two-phase quantity from state.</p>
      </html>"));

initial equation
  if filter_output then
    direct_value = value;
  end if;

equation
  inlet.m_flow = 0;
  direct_value = getQuantity(inlet.state, quantity);

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
          lineColor={28,108,200},
          textString=DynamicSelect("value", realString(value, 1, digits))),
        Text(
          extent={{0,21},{60,71}},
          lineColor={175,175,175},
          textString="%quantity")}),
       Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This is an extra sensor for vaporQuantity, because the Medium must be constrained by PartialTwoPhaseMedium instead of TwoPhaseMedium.</p>
<p>This sensor can be connected to a fluid stream without a junction.</p>
</html>"));
end TwoPhaseSensorSelect;
