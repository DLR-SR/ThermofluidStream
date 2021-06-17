within ThermofluidStream.Sensors;
model MultiSensor_Tp "Sensor for Temperature and pressure"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
                                                                "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make shure it is the same as for all lines the sensors input is connected.</p>
        </html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter ThermofluidStream.Sensors.Internal.Types.TemperatureUnit temperatureUnit = "K" "Unit for temperaure measurement and output"
    annotation(choicesAllMatching = true, Evaluate = true);
  parameter ThermofluidStream.Sensors.Internal.Types.PressureUnit pressureUnit = "Pa" "Unit for pressure measurement and output"
    annotation(choicesAllMatching = true, Evaluate = true);
  parameter Boolean outputTemperature = false "Enable temperature output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean outputPressure = false "Enable pressure output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=(outputTemperature or outputPressure)));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=(outputTemperature or outputPressure) and filter_output));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20, -20},{20, 20}}, origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput T_out(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = T if outputTemperature "Measured Temperature [variable]"
    annotation (Placement(transformation(extent={{80,20},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput p_out(final quantity="Pressure", final unit=pressureUnit) = p if outputPressure "Measured Pressure [variable]"
    annotation (Placement(transformation(extent={{80,-60},{120,-20}})));

  output Real p(final quantity="Pressure", final unit=pressureUnit);
  output Real T(final quantity="ThermodynamicTemperature", final unit=temperatureUnit);
  Real direct_p; //unit intentional not given to avoid warning
  Real direct_T; //unit intentional not given to avoid warning

initial equation
  if filter_output then
    direct_p = p;
    direct_T = T;
  end if;

equation
  inlet.m_flow = 0;

  if temperatureUnit == "K" then
    direct_T = Medium.temperature(inlet.state);
  elseif temperatureUnit == "degC" then
    direct_T = SI.Conversions.to_degC(Medium.temperature(inlet.state));
  end if;

  if pressureUnit == "Pa" then
    direct_p = Medium.pressure(inlet.state);
  elseif pressureUnit == "bar" then
    direct_p = SI.Conversions.to_bar(Medium.pressure(inlet.state));
  end if;

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
          points={{-100,0},{0,0}},
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
          textString=DynamicSelect("T", realString(
                  T,
                  1,
                  integer(digits)))),
        Text(
          extent={{-60,-5},{60,-55}},
          lineColor={28,108,200},
          textString=DynamicSelect("p", realString(
                  p,
                  1,
                  integer(digits)))),
        Text(
          extent={{-120,55},{-60,5}},
          lineColor={175,175,175},
          textString="%temperatureUnit"),
        Text(
          extent={{-120,-5},{-60,-55}},
          lineColor={175,175,175},
          textString="%pressureUnit")}),
       Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Sensor for measuring temperature, pressure at once.</p>
<p>This sensor can be connected to a fluid stream without a junction.</p>
</html>"));
end MultiSensor_Tp;
