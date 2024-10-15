within ThermofluidStream.Sensors;
model MultiSensor_Tp "Temperature and pressure sensor"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus(displayInstanceName = false, displayParameters=true);

  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected.</p>
        </html>"));
  parameter Integer digits(final min=0) = 3 "Number of significant digits to be displayed";
  parameter ThermofluidStream.Sensors.Internal.Types.TemperatureUnit temperatureUnit = "K" "Temperature unit (display and output)"
    annotation(choicesAllMatching = true, Evaluate = true);
  parameter ThermofluidStream.Sensors.Internal.Types.PressureUnit pressureUnit = "Pa" "Pressure unit (display and output)"
    annotation(choicesAllMatching = true, Evaluate = true);
  final parameter String temperatureString=
    if temperatureUnit == "K" then "K"
    elseif temperatureUnit == "degC" then "°C"
    else "error";
  parameter Boolean outputTemperature = false "= true, if temperature output is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean outputPressure = false "= true, if pressure output is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean filter_output = false "= true, if sensor output is filtered (to break algebraic loops)"
    annotation(Dialog(group="Output", enable=outputTemperature or outputPressure),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Time TC = 0.1 "Time constant of sensor output filter (PT1)"
    annotation(Dialog(group="Output", enable= (outputTemperature or outputPressure) and filter_output));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor output"
    annotation(Dialog(group="Output", enable= (outputTemperature or outputPressure) and filter_output));
  parameter Real T_0(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = 0 "Start value for temperature output"
    annotation(Dialog(group="Output", enable=outputTemperature and filter_output and init==InitMode.state));
  parameter Real p_0(final quantity="Pressure", final unit=pressureUnit) = 0 "Start value for pressure output"
    annotation(Dialog(group="Output", enable=outputPressure and filter_output and init==InitMode.state));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput T_out(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = T if outputTemperature "Temperature output connector"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput p_out(final quantity="Pressure", final unit=pressureUnit) = p if outputPressure "Pressure output connector"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));

  output Real p(final quantity="Pressure", final unit=pressureUnit);
  output Real T(final quantity="ThermodynamicTemperature", final unit=temperatureUnit);
  Real direct_p; //unit intentional not given to avoid warning
  Real direct_T; //unit intentional not given to avoid warning

initial equation
  if filter_output and init==InitMode.steadyState then
    p=direct_p;
    T=direct_T;
  elseif filter_output then
    p=p_0;
    T=T_0;
  end if;

equation
  inlet.m_flow = 0;

  if temperatureUnit == "K" then
    direct_T = Medium.temperature(inlet.state);
  elseif temperatureUnit == "degC" then
    direct_T =Modelica.Units.Conversions.to_degC(Medium.temperature(inlet.state));
  end if;

  if pressureUnit == "Pa" then
    direct_p = Medium.pressure(inlet.state);
  elseif pressureUnit == "bar" then
    direct_p =Modelica.Units.Conversions.to_bar(Medium.pressure(inlet.state));
  end if;

  if filter_output then
    der(p) * TC = direct_p-p;
    der(T) * TC = direct_T-T;
  else
    p = direct_p;
    T = direct_T;
  end if;

  annotation (defaultComponentName ="sensorTp",Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Rectangle(
          extent={{-74,54},{86,-66}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-80,60},{80,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,56},{80,6}},
          textColor={0,0,0},
          textString=DynamicSelect(" T ", " "+String(T,significantDigits=digits)+" ")),
        Text(
          extent={{-80,-6},{80,-56}},
          textColor={0,0,0},
          textString=DynamicSelect(" p ", " "+String(p,significantDigits=digits)+" ")),
         Text(visible=displayParameters and not outputTemperature,
          extent={{90,46},{150,16}},
          textColor={0,0,0},
          textString=temperatureString,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=displayParameters and not outputPressure,
          extent={{90,-16},{150,-46}},
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="%pressureUnit"),
        Text(visible= displayParameters and outputTemperature,
          extent={{95,78},{155,48}},
          textColor={0,0,0},
          textString=temperatureString,
          horizontalAlignment=TextAlignment.Left),
        Text(visible= displayParameters and outputPressure,
          extent={{95,-2},{155,-32}},
          textColor={0,0,0},
          textString="%pressureUnit",
          horizontalAlignment=TextAlignment.Left),
        Line(visible=outputTemperature,
          points={{80,40},{100,40}},
          color={0,0,127}),
        Line(visible=outputPressure,
          points={{80,-40},{100,-40}},
          color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Sensor for measuring temperature and pressure at once.</p>
<p>This sensor can be connected to a fluid stream without a junction.</p>
</html>"));
end MultiSensor_Tp;
