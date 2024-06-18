within ThermofluidStream.Sensors;
model DifferenceSensor_Tp "Sensor for Temperature and pressure difference"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus(displayInstanceName = false);

  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  replaceable package MediumA = Media.myMedia.Interfaces.PartialMedium "Medium model A"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the positive input of the sensor. Make sure it is the same for the stream the sensors inputs are connected.</p>
        </html>"));
  replaceable package MediumB = Media.myMedia.Interfaces.PartialMedium "Medium model B"
    annotation (choicesAllMatching=true,
    Documentation(info="<html>
    <p>Medium Model for the negative input of the sensor. Make sure it is the same for the stream the sensors inputs are connected.</p>
      </html>"));
  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter ThermofluidStream.Sensors.Internal.Types.TemperatureUnit temperatureUnit = "K" "Temperature unit (display and output)"
    annotation(choicesAllMatching = true, Evaluate = true);
  parameter ThermofluidStream.Sensors.Internal.Types.PressureUnit pressureUnit = "Pa" "Pressure unit (display and output)"
    annotation(choicesAllMatching = true, Evaluate = true);

  final parameter String temperatureString=
    if temperatureUnit == "K" then "K"
    elseif temperatureUnit == "degC" then "°C"
    else "error";

  parameter Boolean outputTemperature = false "=true, if temperature difference output is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean outputPressure = false "=true, if pressure difference output is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean filter_output = false "= true, if sensor output is filtered (to break algebraic loops)"
    annotation(Dialog(group="Output", enable=outputTemperature or outputPressure),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Time TC = 0.1 "Time constant of sensor output filter (PT1)"
    annotation(Dialog(group="Output", enable=(outputTemperature or outputPressure) and filter_output));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor output"
    annotation(Dialog(group="Output", enable=(outputTemperature or outputPressure) and filter_output));
  parameter Real T_0(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = 0 "Start value for temperature difference output"
    annotation(Dialog(group="Output", enable=outputTemperature and filter_output and init==InitMode.state));
  parameter Real p_0(final quantity="Pressure", final unit=pressureUnit) = 0 "Start value for pressure difference output"
    annotation(Dialog(group="Output", enable=outputPressure and filter_output and init==InitMode.state));

  Interfaces.Inlet inletA(redeclare package Medium=MediumA)
    annotation (Placement(transformation(extent={{-20, -20},{20, 20}}, origin={-100,80}), iconTransformation(extent={{-120,40},{-80,80}})));
  Interfaces.Inlet inletB(redeclare package Medium=MediumB)
    annotation (Placement(transformation(extent={{-20, -20},{20, 20}}, origin={-100,-80}), iconTransformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealOutput T_out(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = T if outputTemperature "Temperature difference output connector"
    annotation (Placement(transformation(extent={{70,30},{90,50}}), iconTransformation(extent={{70,30},{90,50}})));
  Modelica.Blocks.Interfaces.RealOutput p_out(final quantity="Pressure", final unit=pressureUnit) = p if outputPressure "Pressure difference output connector"
    annotation (Placement(transformation(extent={{70,-50},{90,-30}}), iconTransformation(extent={{70,-50},{90,-30}})));

  output Real p(final quantity="Pressure", final unit=pressureUnit);
  output Real T(final quantity="ThermodynamicTemperature", final unit=temperatureUnit);

protected
  Real direct_p; //unit intentional not given to avoid warning
  Real direct_T; //unit intentional not given to avoid warning

  Real pA; //unit intentional not given to avoid warning
  Real TA; //unit intentional not given to avoid warning
  Real pB; //unit intentional not given to avoid warning
  Real TB; //unit intentional not given to avoid warning

initial equation
  if filter_output and init==InitMode.steadyState then
    p=direct_p;
    T=direct_T;
  elseif filter_output then
    p=p_0;
    T=T_0;
  end if;

equation
  inletA.m_flow = 0;
  inletB.m_flow = 0;

  if temperatureUnit == "K" then
    TA =  MediumA.temperature(inletA.state);
    TB =  MediumB.temperature(inletB.state);
  elseif temperatureUnit == "degC" then
    TA =Modelica.Units.Conversions.to_degC(MediumA.temperature(inletA.state));
    TB =Modelica.Units.Conversions.to_degC(MediumB.temperature(inletB.state));
  end if;

  if pressureUnit == "Pa" then
    pA = MediumA.pressure(inletA.state);
    pB = MediumB.pressure(inletB.state);
  elseif pressureUnit == "bar" then
    pA =Modelica.Units.Conversions.to_bar(MediumA.pressure(inletA.state));
    pB =Modelica.Units.Conversions.to_bar(MediumB.pressure(inletB.state));
  end if;

  direct_T = TA - TB;
  direct_p = pA - pB;

  if filter_output then
    der(p) * TC = direct_p-p;
    der(T) * TC = direct_T-T;
  else
    p = direct_p;
    T = direct_T;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Rectangle(
          extent={{-54,54},{66,-66}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-80,0},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,55},{60,5}},
          textColor={28,108,200},
          textString=DynamicSelect("T", String(
              T,
              format="1."+String(digits)+"f"))),
        Text(
          extent={{-60,-5},{60,-55}},
          textColor={28,108,200},
          textString=DynamicSelect("p", String(
              p,
              format="1."+String(digits)+"f"))),
        Text(visible=not outputTemperature,
          extent={{70,45},{130,15}},
          textColor={0,0,0},
          textString=temperatureString,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=not outputPressure,
          extent={{70,-15},{130,-45}},
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="%pressureUnit"),
        Text(visible= outputTemperature,
          extent={{75,78},{135,48}},
          textColor={0,0,0},
          textString=temperatureString,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=outputPressure,
          extent={{75,-2},{135,-32}},
          textColor={0,0,0},
          textString="%pressureUnit",
          horizontalAlignment=TextAlignment.Left),
        Line(
          points={{-80,60},{-80,-60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,-60},{-80,-60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,60},{-80,60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-108,-30},{-92,-30}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-110,100},{-90,80}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Line(visible=outputTemperature,
          points={{60,40},{78,40}},
          color={0,0,127}),
        Line(visible=outputPressure,
          points={{60,-40},{78,-40}},
          color={0,0,127}),
        Line(
          points={{-108,90},{-92,90}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-8,0},{8,0}},
          color={28,108,200},
          thickness=0.5,
          origin={-100,90},
          rotation=90),
        Ellipse(
          extent={{-110,-20},{-90,-40}},
          lineColor={28,108,200},
          lineThickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Sensor for measuring difference in temperature and pressure at once.</p>
<p>This sensor can be connected to two fluid streams without a junction.</p>
</html>"));
end DifferenceSensor_Tp;
