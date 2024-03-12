within ThermofluidStream.Sensors;
model MultiSensor_Tpm5 "v5 of MultiSensor_Tpm"
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
  parameter ThermofluidStream.Sensors.Internal.Types.MassFlowUnit massFlowUnit = "(kg/s)" "Unit for mass-flow measurement and output"
    annotation(choicesAllMatching = true, Evaluate = true);

  final parameter String temperatureString=
  if temperatureUnit == "K" then " K "
  elseif temperatureUnit == "degC" then " °C "
  else "error";

  final parameter String pressureString= " "+pressureUnit+" ";

  final parameter String massFlowString=
  if massFlowUnit == "(kg/s)" then " kg/s "
  elseif massFlowUnit == "(g/s)" then " g/s "
  else "error";



  parameter Boolean outputTemperature = false "Enable temperature output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean outputPressure = false "Enable pressure output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean outputMassFlowRate = false "Enable massFlow output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=(outputTemperature or outputPressure or outputMassFlowRate)));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor lowpass"
    annotation(Dialog(tab="Initialization", enable=filter_output));
  parameter Real p_0(final quantity="Pressure", final unit=pressureUnit) = 0 "Initial output pressure of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter Real T_0(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = 0 "Initial output temperature of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter Real m_flow_0(final quantity="MassFlowRate", final unit=massFlowUnit) = 0 "Initial output massflow of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=(outputTemperature or outputPressure or outputMassFlowRate) and filter_output));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}), iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}), iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealOutput T_out(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = T if outputTemperature "Measured Temperature [variable]"
    annotation (Placement(transformation(extent={{72,70},{92,90}}), iconTransformation(extent={{72,70},{92,90}})));
  Modelica.Blocks.Interfaces.RealOutput p_out(final quantity="Pressure", final unit=pressureUnit) = p if outputPressure "Measured pressure [variable]"
    annotation (Placement(transformation(extent={{72,30},{92,50}}),
        iconTransformation(extent={{72,30},{92,50}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_out(unit="kg/s") = m_flow if outputMassFlowRate "Measured massflow [kg/s]"
    annotation (Placement(transformation(extent={{72,-50},{92,-30}}), iconTransformation(extent={{72,-50},{92,-30}})));

  output Real p(final quantity="Pressure", final unit=pressureUnit);
  output Real T(final quantity="ThermodynamicTemperature", final unit=temperatureUnit);
  output Real m_flow(final quantity="MassFlowRate", final unit=massFlowUnit);

protected
  Real direct_p; //unit intentional not given to avoid warning
  Real direct_T; //unit intentional not given to avoid warning
  Real direct_m_flow; //unit intentional not given to avoid warning

initial equation
  if filter_output and init==InitMode.steadyState then
    p=direct_p;
    T=direct_T;
    m_flow=direct_m_flow;
  elseif filter_output then
    p=p_0;
    T=T_0;
    m_flow=m_flow_0;
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

  if massFlowUnit == "(kg/s)" then
      direct_m_flow = inlet.m_flow;
  elseif massFlowUnit == "(g/s)" then
      direct_m_flow = inlet.m_flow*1000;
  end if;

  if filter_output then
    der(p) * TC = direct_p-p;
    der(T) * TC = direct_T-T;
    der(m_flow) * TC = direct_m_flow-m_flow;
  else
    p = direct_p;
    T = direct_T;
    m_flow = direct_m_flow;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(
          extent={{-150,90},{-60,60}},
          textColor={0,0,0},
          textString=temperatureString,
          horizontalAlignment=TextAlignment.Right),
        Text(
          extent={{-150,50},{-60,20}},
          textColor={0,0,0},
          textString=pressureString,
          horizontalAlignment=TextAlignment.Right),
        Text(
          extent={{-150,-20},{-60,-50}},
          textColor={0,0,0},
          textString=massFlowString,
          horizontalAlignment=TextAlignment.Right),
        Rectangle(
          extent={{-54,94},{66,-66}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-60,100},{60,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,100},{60,50}},
          textColor={28,108,200},
          textString=DynamicSelect("T", String(
              T,
              format="1."+String(digits)+"f"))),
        Text(
          extent={{-60,50},{60,0}},
          textColor={28,108,200},
          textString=DynamicSelect("p", String(
              p,
              format="1."+String(digits)+"f"))),
        Text(
          extent={{-60,0},{60,-50}},
          textColor={28,108,200},
          textString=DynamicSelect("m", String(
              m_flow,
              format="1."+String(digits)+"f"))),
        Line(visible=outputTemperature,
          points={{60,80},{78,80}},
          color={0,0,127}),
        Line(visible=outputPressure,
          points={{60,40},{78,40}},
          color={0,0,127}),
        Line(visible=outputMassFlowRate,
          points={{60,-40},{78,-40}},
          color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Sensor for measuring temperature, pressure and massflow at once.</p>
<p>This sensor must be included into the fluid stream, since it measures massflow. </p>
</html>"));
end MultiSensor_Tpm5;
