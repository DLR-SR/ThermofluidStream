within ThermofluidStream.Sensors;
model MultiSensor_Tp_TwoPort3 "v3 of MultiSensor_Tp_TwoPort"
  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected.</p>
        </html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter ThermofluidStream.Sensors.Internal.Types.TemperatureUnit temperatureUnit = "K" "Unit for temperature measurement and output"
    annotation(choicesAllMatching = true, Evaluate = true);
  parameter ThermofluidStream.Sensors.Internal.Types.PressureUnit pressureUnit = "Pa" "Unit for pressure measurement and output"
    annotation(choicesAllMatching = true, Evaluate = true);
  final parameter String temperatureString=
  if temperatureUnit == "K" then " K "
  elseif temperatureUnit == "degC" then " °C "
  else "error";

  final parameter String pressureString= " "+pressureUnit+" ";

  parameter Boolean outputTemperature = false "Enable temperature output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean outputPressure = false "Enable pressure output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=(outputTemperature or outputPressure or outputMassFlowRate)));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor lowpass"
    annotation(Dialog(tab="Initialization", enable=filter_output));
  parameter Real p_0(final quantity="Pressure", final unit=pressureUnit) = 0 "Initial output pressure of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter Real T_0(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = 0 "Initial output temperature of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=(outputTemperature or outputPressure or outputMassFlowRate) and filter_output));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}), iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}), iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealOutput T_out(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = T if outputTemperature "Measured Temperature [variable]"
    annotation (Placement(transformation(extent={{72,20},{92,40}}), iconTransformation(extent={{72,20},{92,40}})));
  Modelica.Blocks.Interfaces.RealOutput p_out(final quantity="Pressure", final unit=pressureUnit) = p if outputPressure "Measured pressure [variable]"
    annotation (Placement(transformation(extent={{70,-40},{90,-20}}),
        iconTransformation(extent={{70,-40},{90,-20}})));
  output Real p(final quantity="Pressure", final unit=pressureUnit);
  output Real T(final quantity="ThermodynamicTemperature", final unit=temperatureUnit);

protected
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
  inlet.m_flow + outlet.m_flow = 0;
  outlet.r = inlet.r;
  outlet.state = inlet.state;

  if temperatureUnit == "K" then
    direct_T =  Medium.temperature(inlet.state);
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

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,110},{150,70}},
          textString="%name",
          textColor={0,0,255}),
         Text(
          extent={{-150,45},{-60,15}},
          textColor={0,0,0},
          textString=temperatureString,
          horizontalAlignment=TextAlignment.Right),
        Text(
          extent={{-150,-20},{-60,-45}},
          textColor={0,0,0},
          textString=pressureString,
          horizontalAlignment=TextAlignment.Right),
        Rectangle(
          extent={{-54,54},{66,-56}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-60,60},{60,-50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,60},{60,10}},
          textColor={28,108,200},
          textString=DynamicSelect("T", String(
              T,
              format="1."+String(digits)+"f"))),
        Text(
          extent={{-60,10},{60,-40}},
          textColor={28,108,200},
          textString=DynamicSelect("p", String(
              p,
              format="1."+String(digits)+"f"))),
        Line(visible=outputTemperature,
          points={{60,30},{78,30}},
          color={0,0,127}),
        Line(visible=outputPressure,
          points={{60,-30},{78,-30}},
          color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Sensor for measuring temperature, pressure and massflow at once.</p>
<p>This sensor must be included into the fluid stream, since it measures massflow. </p>
</html>"));
end MultiSensor_Tp_TwoPort3;
