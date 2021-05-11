within ThermofluidStream.Sensors;
model MultiSensor_Tpm "Sensor for Temperature, pressure and mass-flow"

  replaceable package Medium = myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make shure it is the same as for all lines the sensors input is connected.</p>
        </html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter ThermofluidStream.Sensors.Internal.Types.TemperatureUnit temperatureUnit = "K" "Unit for temperaure measurement and output"
    annotation(choicesAllMatching = true, Evaluate = true);
  parameter ThermofluidStream.Sensors.Internal.Types.PressureUnit pressureUnit = "Pa" "Unit for pressure measurement and output"
    annotation(choicesAllMatching = true, Evaluate = true);
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
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=(outputTemperature or outputPressure or outputMassFlowRate) and filter_output));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-120},{-80,-80}})));
  Interfaces.Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-120},{120,-80}})));
  Modelica.Blocks.Interfaces.RealOutput T_out(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = T if outputTemperature "Measured Temperature [variable]"
    annotation (Placement(transformation(extent={{80,40},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput p_out(final quantity="Pressure", final unit=pressureUnit) = p if outputPressure "Measured pressure [variable]"
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_out(unit="kg/s") = m_flow if outputMassFlowRate "Measured massflow [kg/s]"
    annotation (Placement(transformation(extent={{80,-80},{120,-40}})));

  output Real p(final quantity="Pressure", final unit=pressureUnit);
  output Real T(final quantity="ThermodynamicTemperature", final unit=temperatureUnit);
  output Real m_flow(final quantity="MassFlowRate", final unit=massFlowUnit);

protected
  Real direct_p; //unit intentional not given to avoid warning
  Real direct_T; //unit intentional not given to avoid warning
  Real direct_m_flow; //unit intentional not given to avoid warning

initial equation
  if filter_output then
    direct_p = p;
    direct_T = T;
    direct_m_flow = m_flow;
  end if;

equation
  inlet.m_flow + outlet.m_flow = 0;
  outlet.r = inlet.r;
  outlet.state = inlet.state;

  if temperatureUnit == "K" then
    direct_T =  Medium.temperature(inlet.state);
  elseif temperatureUnit == "degC" then
    direct_T = SI.Conversions.to_degC(Medium.temperature(inlet.state));
  end if;

  if pressureUnit == "Pa" then
    direct_p = Medium.pressure(inlet.state);
  elseif pressureUnit == "bar" then
    direct_p = SI.Conversions.to_bar(Medium.pressure(inlet.state));
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

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-54,74},{66,-86}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-70,-100},{80,-100}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{0,-100}}, color={0,0,0}),
        Ellipse(
          extent={{-6,-94},{6,-106}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-60,80},{60,30}},
          lineColor={28,108,200},
          textString=DynamicSelect("T", realString(
                  T,
                  1,
                  integer(digits)))),
        Text(
          extent={{-60,30},{60,-20}},
          lineColor={28,108,200},
          textString=DynamicSelect("p", realString(
                  p,
                  1,
                  integer(digits)))),
        Text(
          extent={{-60,-20},{60,-70}},
          lineColor={28,108,200},
          textString=DynamicSelect("m", realString(
                  m_flow,
                  2,
                  integer(digits)))),
        Text(
          extent={{-120,80},{-60,28}},
          lineColor={175,175,175},
          textString="%temperatureUnit"),
        Text(
          extent={{-120,32},{-60,-20}},
          lineColor={175,175,175},
          textString="%pressureUnit"),
        Text(
          extent={{-120,-20},{-60,-72}},
          lineColor={175,175,175},
          textString="%massFlowUnit")}),            Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(info="<html>
<p>Sensor for measuring temperature, pressure and massflow at once.</p>
<p>This sensor must be included into the fluid stream, since it measures massflow. </p>
</html>"));
end MultiSensor_Tpm;
