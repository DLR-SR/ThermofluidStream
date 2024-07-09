within ThermofluidStream.Undirected.Sensors;
model SingleSensorX "Mass fractions sensor"
  extends Internal.PartialSensor;

  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected.</p>
        </html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";

  parameter Boolean outputValue = false "= true, if sensor output is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean filter_output = false "= true, if sensor output is filtered (to break algebraic loops)"
    annotation(Dialog(group="Output", enable=outputValue),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Time TC = 0.1 "Time constant of sensor output filter (PT1)"
    annotation(Dialog(group="Output", enable=outputValue and filter_output));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor output"
    annotation(Dialog(group="Output", enable=outputValue and filter_output));
  parameter Real[Medium.nX] value_0(each unit="kg/kg") = Medium.X_default "Start value of mass fraction output"
    annotation(Dialog(group="Output", enable=outputValue and filter_output and init==InitMode.state));

  parameter Integer row(min=1, max=Medium.nX) = 1 "Row of mass fraction vector to display";

  Modelica.Blocks.Interfaces.RealOutput value_out[Medium.nX](each unit="kg/kg") = value if outputValue "Measured value [variable]"
    annotation (Placement(transformation(extent={{72,50},{92,70}}), iconTransformation(extent={{72,50},{92,70}})));

  output Real value[Medium.nX](each unit="kg/kg") "Computed value of the selected Quantity";
  output Real display_value(unit="kg/kg") = value[row] "Row of the value vector to display";

protected
  outer DropOfCommons dropOfCommons;

  Real direct_value[Medium.nX](each unit="kg/kg");

  function mfk = Utilities.Functions.massFractionK(redeclare package Medium = Medium);

initial equation
  if filter_output and init==InitMode.steadyState then
    value= direct_value;
  elseif filter_output then
    value = value_0;
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
          textString=DynamicSelect("value", String(display_value, format="1."+String(digits)+"f"))),
        Text(
          extent={{-150,130},{150,100}},
          textColor={0,0,0},
          textString="X[%row] in kg/kg"),
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
<p>Sensor for measuring mass fraction X. Which row from X to display can be selected by the row parameter.</p>
<p>This sensor can be connected to a fluid stream without a junction.</p>
</html>"));
end SingleSensorX;
