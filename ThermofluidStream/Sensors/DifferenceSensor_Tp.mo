within ThermofluidStream.Sensors;
model DifferenceSensor_Tp
  "Sensor difference in Temperature and pressure"
  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  replaceable package MediumA = Media.myMedia.Interfaces.PartialMedium
                                                                 "Medium model A"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the positive input of the sensor. Make sure it is the same for the stream the sensors inputs are connected.</p>
        </html>"));
  replaceable package MediumB = Media.myMedia.Interfaces.PartialMedium
                                                                 "Medium model B"
  annotation (choicesAllMatching=true,
    Documentation(info="<html>
    <p>Medium Model for the negative input of the sensor. Make sure it is the same for the stream the sensors inputs are connected.</p>
      </html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter ThermofluidStream.Sensors.Internal.Types.TemperatureUnit temperatureUnit = "K" "Unit for temperature measurement and output"
    annotation(choicesAllMatching = true, Evaluate = true);
  parameter ThermofluidStream.Sensors.Internal.Types.PressureUnit pressureUnit = "Pa" "Unit for pressure measurement and output"
    annotation(choicesAllMatching = true, Evaluate = true);
  parameter Boolean outputTemperature = false "Enable temperature output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean outputPressure = false "Enable pressure output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=(outputTemperature or outputPressure)));
  parameter InitMode init=InitMode.steadyState   "Initialization mode for sensor lowpass"
    annotation(choicesAllMatching=true, Dialog(tab="Initialization", enable=filter_output));
  parameter Real p_0(final quantity="Pressure", final unit=pressureUnit) = 0 "Initial output pressure of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter Real T_0(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = 0 "Initial output Temperature of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=(outputTemperature or outputPressure) and filter_output));

  Interfaces.Inlet inletA(redeclare package Medium=MediumA)
    annotation (Placement(transformation(extent={{-20, -20},{20, 20}}, origin={-100,80})));
  Interfaces.Inlet inletB(redeclare package Medium=MediumB)
    annotation (Placement(transformation(extent={{-20, -20},{20, 20}}, origin={-100,-80})));
  Modelica.Blocks.Interfaces.RealOutput T_out(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = T if outputTemperature "Difference of measured Temperature [variable]"
    annotation (Placement(transformation(extent={{80,20},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput p_out(final quantity="Pressure", final unit=pressureUnit) = p if outputPressure "Difference of measured pressure [variable]"
    annotation (Placement(transformation(extent={{80,-60},{120,-20}})));

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

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
          lineColor={28,108,200},
          textString=DynamicSelect("T", String(
              T,
              format="1."+String(digits)+"f"))),
        Text(
          extent={{-60,-5},{60,-55}},
          lineColor={28,108,200},
          textString=DynamicSelect("p", String(
              p,
              format="1."+String(digits)+"f"))),
        Text(
          extent={{-120,55},{-60,5}},
          lineColor={175,175,175},
          textString="%temperatureUnit"),
        Text(
          extent={{-120,-5},{-60,-55}},
          lineColor={175,175,175},
          textString="%pressureUnit"),
        Line(
          points={{-80,80},{-80,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,-80},{-80,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,80},{-80,80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-70,80},{-50,80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-10,0},{10,0}},
          color={28,108,200},
          thickness=0.5,
          origin={-60,80},
          rotation=90),
        Line(
          points={{-70,-80},{-50,-80}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-72,92},{-48,68}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Ellipse(
          extent={{-72,-68},{-48,-92}},
          lineColor={28,108,200},
          lineThickness=0.5)}),
       Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Sensor for measuring difference in temperature, pressure at once.</p>
<p>This sensor can be connected to two fluid streams without a junction.</p>
</html>"));
end DifferenceSensor_Tp;
