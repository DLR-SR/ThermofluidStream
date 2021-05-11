within ThermofluidStream.Sensors;
model SingleFlowSensor
  "Sensor for a selectable quantity associated with the massflow"
  import Quantities=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities;

  replaceable package Medium = myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make shure it is the same as for all lines the sensors input is connected.</p>
        </html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter Quantities quantity "Quantitiy the sensor measures"
    annotation(choicesAllMatching=true);
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimum Density"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter Boolean outputValue = false "Enable sensor-value output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=outputValue));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=outputValue and filter_output));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}}),
        iconTransformation(extent={{-120,-80},{-80,-40}})));
  Interfaces.Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-80},{120,-40}}),
        iconTransformation(extent={{80,-80},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput value_out(unit=Internal.getFlowUnit(quantity)) = value if outputValue "Measured quantitiy [variable]"
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));

  output Real value(unit=Internal.getFlowUnit(quantity));

protected
  outer DropOfCommons dropOfCommons;

  Real direct_value(unit=Internal.getFlowUnit(quantity));
  output SI.MassFlowRate m_flow = inlet.m_flow;

  function getQuantity = Internal.getFlowQuantity(redeclare package Medium=Medium) "Quantity compute function"
    annotation (Documentation(info="<html>
      <p>This function computes the selected quantity from state and massflow. rho_min is neddet for the computation of v.</p>
      </html>"));

initial equation
  if filter_output then
    direct_value = value;
  end if;

equation
  inlet.m_flow + outlet.m_flow = 0;
  outlet.r = inlet.r;
  outlet.state = inlet.state;

  direct_value = getQuantity(inlet.state, inlet.m_flow, quantity, rho_min);

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
          points={{-70,-60},{80,-60}},
          color={28,108,200},
          thickness=0.5),
        Line(points={{0,-26},{0,-60}},  color={0,0,0}),
        Ellipse(
          extent={{-6,-54},{6,-66}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-60,30},{60,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,30},{60,-30}},
          lineColor={28,108,200},
          textString=DynamicSelect("value", realString(value, 1, integer(digits)))),
        Text(
          extent={{0,25},{60,75}},
          lineColor={175,175,175},
          textString="%quantity")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>A Sensor measuring a selectable flow quantity associated with the massflow.</p>
<p>This sensor must be included into the fluid stream, since it measures massflow. </p>
</html>"));
end SingleFlowSensor;
