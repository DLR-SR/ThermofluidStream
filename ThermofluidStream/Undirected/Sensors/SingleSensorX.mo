within ThermofluidStream.Undirected.Sensors;
model SingleSensorX "Sensor for mass fraction of mixture"
  extends Internal.PartialSensor;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
                                                                "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected.</p>
        </html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter Boolean outputValue = false "Enable sensor-value output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=outputValue));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=outputValue and filter_output));
  parameter Integer row(min=1, max=Medium.nX) = 1 "Row of mass fraction vector to display";

  Modelica.Blocks.Interfaces.RealOutput value_out[Medium.nX](each unit="kg/kg") = value if outputValue "Measured value [variable]"
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

  output Real value[Medium.nX](each unit="kg/kg") "Computed value of the selected Quantity";
  output Real display_value(unit="kg/kg") = value[row] "Row of the value vector to display";

protected
  outer DropOfCommons dropOfCommons;

  Real direct_value[Medium.nX](each unit="kg/kg");

  function mfk = Utilities.Functions.massFractionK(redeclare package Medium = Medium);

initial equation
  if filter_output then
    direct_value = value;
  end if;

equation
  //OM fix
  //direct_value[1:Medium.nXi] = Medium.massFraction(state);

  for i in 1:Medium.nXi loop
    direct_value[i] = mfk(state, i);
  end for;

  if Medium.reducedX then
    direct_value[end] = 1-sum(direct_value[1:Medium.nXi]);
  end if;

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
          points={{0,0},{0,-80}},
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
          textString=DynamicSelect("value", String(display_value, format="1."+String(digits)+"f"))),
        Text(
          extent={{-26,22},{60,69}},
          lineColor={175,175,175},
          textString="%row. mass-fraction"),
        Ellipse(
          extent={{-5,-75},{5,-85}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
       Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Sensor for measuring mass fraction X. Which row from X to display can be selected by the row parameter.</p>
<p>This sensor can be connected to a fluid stream without a junction.</p>
</html>"));
end SingleSensorX;
