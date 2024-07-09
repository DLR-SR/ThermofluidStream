within ThermofluidStream.Sensors;
model MultiSensor_Tpm "Sensor for temperature, pressure and mass flow rate"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus(displayInstanceName = false);

  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected.</p>
        </html>"));
  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter ThermofluidStream.Sensors.Internal.Types.TemperatureUnit temperatureUnit = "K" "Temperature unit (display and output)"
    annotation(choicesAllMatching = true, Evaluate = true);
  parameter ThermofluidStream.Sensors.Internal.Types.PressureUnit pressureUnit = "Pa" "Pressure unit (display and output)"
    annotation(choicesAllMatching = true, Evaluate = true);
  parameter ThermofluidStream.Sensors.Internal.Types.MassFlowUnit massFlowUnit = "(kg/s)" "Mass flow rate unit (display and output)"
    annotation(choicesAllMatching = true, Evaluate = true);
  final parameter String temperatureString=
    if temperatureUnit == "K" then "K"
    elseif temperatureUnit == "degC" then "°C"
    else "error";
  final parameter String massFlowString=
    if massFlowUnit == "(kg/s)" then "kg/s"
    elseif massFlowUnit == "(g/s)" then "g/s"
    else "error";
  parameter Boolean outputTemperature = false "= true, if temperature output is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean outputPressure = false "= true, if pressure output is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean outputMassFlowRate = false "= true, if mass flow rate output is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean filter_output = false "= true, if sensor output is filtered (to break algebraic loops)"
    annotation(Dialog(group="Output", enable=outputTemperature or outputPressure or outputMassFlowRate),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Time TC = 0.1 "Time constant of sensor output filter (PT1)"
    annotation(Dialog(group="Output", enable=(outputTemperature or outputPressure or outputMassFlowRate) and filter_output));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor output"
    annotation(Dialog(group="Output", enable=(outputTemperature or outputPressure or outputMassFlowRate) and filter_output));
  parameter Real T_0(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = 0 "Start value for temperature output"
    annotation(Dialog(group="Output", enable=outputTemperature and filter_output and init==InitMode.state));
  parameter Real p_0(final quantity="Pressure", final unit=pressureUnit) = 0 "Start value for pressure output"
    annotation(Dialog(group="Output", enable=outputPressure and filter_output and init==InitMode.state));
  parameter Real m_flow_0(final quantity="MassFlowRate", final unit=massFlowUnit) = 0 "Start value for mass flow rate output"
    annotation(Dialog(group="Output", enable=outputMassFlowRate and filter_output and init==InitMode.state));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-120},{-80,-80}})));
  Interfaces.Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-120},{120,-80}})));
  Modelica.Blocks.Interfaces.RealOutput T_out(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = T if outputTemperature "Temperature output connector"
    annotation (Placement(transformation(extent={{72,50},{92,70}})));
  Modelica.Blocks.Interfaces.RealOutput p_out(final quantity="Pressure", final unit=pressureUnit) = p if outputPressure "Pressure output connector"
    annotation (Placement(transformation(extent={{72,-10},{92,10}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_out(unit="kg/s") = m_flow if outputMassFlowRate "Mass flow rate output connector"
    annotation (Placement(transformation(extent={{72,-70},{92,-50}})));

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
          extent={{-150,-160},{150,-120}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
         Text(visible=not outputTemperature,
          extent={{150,70},{68,40}},
          textColor={0,0,0},
          textString=temperatureString,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=not outputPressure,
          extent={{150,20},{68,-10}},
          textColor={0,0,0},
          textString=pressureUnit,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=not outputMassFlowRate,
          extent={{150,-30},{68,-60}},
          textColor={0,0,0},
          textString=massFlowString,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=outputTemperature,
          extent={{150,98},{75,68}},
          textColor={0,0,0},
          textString=temperatureString,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=outputPressure,
          extent={{150,38},{75,8}},
          textColor={0,0,0},
          textString=pressureUnit,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=outputMassFlowRate,
          extent={{150,-20},{75,-50}},
          textColor={0,0,0},
          textString=massFlowString,
          horizontalAlignment=TextAlignment.Left),
        Rectangle(
          extent={{-54,74},{66,-86}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,-100},{100,-100}},
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
          textColor={28,108,200},
          textString=DynamicSelect("T", String(
              T,
              format="1."+String(digits)+"f"))),
        Text(
          extent={{-60,30},{60,-20}},
          textColor={28,108,200},
          textString=DynamicSelect("p", String(
              p,
              format="1."+String(digits)+"f"))),
        Text(
          extent={{-60,-20},{60,-70}},
          textColor={28,108,200},
          textString=DynamicSelect("m", String(
              m_flow,
              format="1."+String(digits)+"f"))),
        Line(visible=outputTemperature,
          points={{60,60},{78,60}},
          color={0,0,127}),
        Line(visible=outputPressure,
          points={{60,0},{78,0}},
          color={0,0,127}),
        Line(visible=outputMassFlowRate,
          points={{60,-60},{78,-60}},
          color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Sensor for measuring temperature, pressure and massflow at once.</p>
<p>This sensor must be included into the fluid stream, since it measures massflow. </p>
</html>"));
end MultiSensor_Tpm;
