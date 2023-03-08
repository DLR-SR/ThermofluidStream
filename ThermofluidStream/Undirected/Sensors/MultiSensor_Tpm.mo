within ThermofluidStream.Undirected.Sensors;
model MultiSensor_Tpm "Undirected Sensor for Temperature, pressure and mass-flow"
  extends Internal.PartialSensor;

  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  parameter ThermofluidStream.Sensors.Internal.Types.TemperatureUnit temperatureUnit="K" "Unit for the temperature output"
    annotation (
    Dialog(group="Units"),
    choicesAllMatching=true,
    Evaluate=true);
  parameter ThermofluidStream.Sensors.Internal.Types.PressureUnit pressureUnit="Pa" "Unit for the pressure output"
    annotation (
    Dialog(group="Units"),
    choicesAllMatching=true,
    Evaluate=true);
  parameter ThermofluidStream.Sensors.Internal.Types.MassFlowUnit massFlowUnit = "(kg/s)" "Unit for pressure measurement and output"
    annotation(choicesAllMatching = true, Evaluate = true);
  parameter Boolean outputTemperature = false "Enable temperature output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean outputPressure = false "Enable pressure output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean outputMassFlowRate = false "Enable massFlow output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=(outputTemperature or outputPressure or outputMassFlowRate)));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor lowpass"
    annotation(choicesAllMatching=true, Dialog(tab="Initialization", enable=filter_output));
  parameter Real p_0(final quantity="Pressure", final unit=pressureUnit) = 0 "Initial output pressure of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter Real T_0(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = 0 "Initial output Temperature of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter Real m_flow_0(final quantity="MassFlowRate", final unit=massFlowUnit) = 0 "Initial output massflow of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=(outputTemperature or outputPressure or outputMassFlowRate) and filter_output));

  Modelica.Blocks.Interfaces.RealOutput T_out(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = T if outputTemperature "Measured temperature [variable]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={100,60}),
        iconTransformation(extent={{80,60},{120,100}})));
  Modelica.Blocks.Interfaces.RealOutput p_out(final quantity="Pressure", final unit=pressureUnit) = p if outputPressure "Measured pressure [variable]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={100,20}),
        iconTransformation(extent={{80,0},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_out(unit="kg/s") = m_flow if outputMassFlowRate
    "Measured mass-flow [kg/s]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={100,-60}),
        iconTransformation(extent={{80,-60},{120,-20}})));

  output Real p(final quantity="Pressure", final unit=pressureUnit);
  output Real T(final quantity="ThermodynamicTemperature", final unit=temperatureUnit);
  output Real m_flow(final quantity="MassFlowRate", final unit=massFlowUnit);

protected
  Real direct_p; // unit intentionally not set to avoid Warning
  Real direct_T; // unit intentionally not set to avoid Warning
  Real direct_m_flow; // unit intentionally not set to avoid Warning

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
  if temperatureUnit == "K" then
    direct_T =Medium.temperature(state);
  elseif temperatureUnit == "degC" then
    direct_T =Modelica.Units.Conversions.to_degC(Medium.temperature(state));
  end if;

  if pressureUnit == "Pa" then
    direct_p =Medium.pressure(state);
  elseif pressureUnit == "bar" then
    direct_p =Modelica.Units.Conversions.to_bar(Medium.pressure(state));
  end if;

  if massFlowUnit == "(kg/s)" then
      direct_m_flow = rear.m_flow;
  elseif massFlowUnit == "(g/s)" then
      direct_m_flow = rear.m_flow*1000;
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

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-54,94},{66,-66}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-60,100},{60,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-60},{0,-80}}, color={0,0,0}),
        Ellipse(
          extent={{-6,-74},{6,-86}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
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
        Text(
          extent={{-120,100},{-60,48}},
          textColor={175,175,175},
          textString="%temperatureUnit"),
        Text(
          extent={{-120,52},{-60,0}},
          textColor={175,175,175},
          textString="%pressureUnit"),
        Text(
          extent={{-120,0},{-60,-52}},
          textColor={175,175,175},
          textString="%massFlowUnit")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Undirected&nbsp;sensor&nbsp;for&nbsp;temperature,&nbsp;pressure&nbsp;and&nbsp;mass-flow. Units can be selected.</p>
</html>"));
end MultiSensor_Tpm;
