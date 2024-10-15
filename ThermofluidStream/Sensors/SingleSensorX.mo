within ThermofluidStream.Sensors;
model SingleSensorX "Sensor for mass fraction"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus(displayInstanceName = false, displayParameters=true);

  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected.</p>
        </html>"));
  parameter Integer digits(final min=0) = 3 "Number of significant digits to be displayed";
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

  parameter Integer row(min=1, max=Medium.nX) = 1 "Row of meassured mass fraction";

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput value_out[Medium.nX](each unit="kg/kg") = value if outputValue "Mass fraction output connector"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  output Real value[Medium.nX](each unit="kg/kg") "Computed value of the selected quantity";
  output Real display_value(unit="kg/kg") = value[row] "Row of the value vector to display";

  function mfk = ThermofluidStream.Utilities.Functions.massFractionK (
    redeclare package Medium = Medium);

protected
  Real direct_value[Medium.nX](each unit="kg/kg");

initial equation
  if filter_output and init==InitMode.steadyState then
    value= direct_value;
  elseif filter_output then
    value = value_0;
  end if;

equation
  inlet.m_flow = 0;
  for i in 1:Medium.nXi loop
    direct_value[i] = mfk(inlet.state, i);
  end for;
  //direct_value[1:Medium.nXi] = Medium.massFraction(inlet.state);
  if Medium.reducedX then
    direct_value[end] = 1-sum(direct_value[1:Medium.nXi]);
  end if;

  if filter_output then
    der(value) * TC = direct_value-value;
  else
    value = direct_value;
  end if;

  annotation (defaultComponentName ="massFractionSensor",Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Rectangle(
          extent={{-74,24},{86,-36}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-80,30},{60,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,26},{60,-26}},
          textColor={0,0,0},
          textString=DynamicSelect(" 0.0 ", " "+String(display_value,significantDigits=digits)+" ")),
        Text(visible = displayParameters,
          extent={{-150,-70},{150,-40}},
          textColor={0,0,0},
          textString="X[%row] in kg/kg"),
        Line(visible=outputValue,
          points={{60,0},{100,0}},
          color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Sensor for measuring mass fraction X. Which row from X to display can be selected by the row parameter.</p>
<p>This sensor can be connected to a fluid stream without a junction.</p>
</html>"));
end SingleSensorX;
