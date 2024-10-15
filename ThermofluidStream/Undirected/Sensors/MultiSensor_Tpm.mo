within ThermofluidStream.Undirected.Sensors;
model MultiSensor_Tpm "Undirected sensor for Temperature, pressure and mass flow rate"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus(displayInstanceName = false);

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(
        info="<html>
<p>Replaceable medium package for the sensor.</p>
</html>"));

  parameter Integer digits(final min=0) = 3 "Number of significant digits to be displayed"
    annotation(Dialog(group="Sensor display"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold of mass flow rate"
    annotation(Dialog(tab="Advanced", group="Regularization"));

  Interfaces.Rear rear(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-100,-100}),iconTransformation(extent={{-120,-120},{-80,-80}})));
  Interfaces.Fore fore(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={100,-100}),iconTransformation(extent={{80,-120},{120,-80}})));

/*  function regStepSt = Undirected.Internal.regStepState (
    redeclare package Medium = Medium) "RegStep function for a state"
    annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">RegStep function for a state. The medium of the sensor is used and given to the function.</span></p>
</html>"));
*/
  Medium.ThermodynamicState state = Medium.setState_phX(p_reg, h_reg, Xi_reg); //= regStepSt(rear.m_flow, rear.state_forwards, rear.state_rearwards, m_flow_reg);

protected
   SI.Pressure p_reg= Undirected.Internal.regStep(rear.m_flow, Medium.pressure(rear.state_forwards), Medium.pressure(rear.state_rearwards), m_flow_reg);
  SI.SpecificEnthalpy h_reg = Undirected.Internal.regStep(rear.m_flow, Medium.specificEnthalpy(rear.state_forwards), Medium.specificEnthalpy(rear.state_rearwards), m_flow_reg);
  Medium.MassFraction Xi_reg[Medium.nXi];

  Medium.MassFraction Xi_forwards[Medium.nXi] = Medium.massFraction(rear.state_forwards);
  Medium.MassFraction Xi_rearwards[Medium.nXi] = Medium.massFraction(rear.state_rearwards);

  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

public
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


  Modelica.Blocks.Interfaces.RealOutput T_out(final quantity="ThermodynamicTemperature", final unit=temperatureUnit) = T if outputTemperature "Temperature output connector"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput p_out(final quantity="Pressure", final unit=pressureUnit) = p if outputPressure "Pressure output connector"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_out(unit="kg/s") = m_flow if outputMassFlowRate "Mass flow rate output connector"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

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
  for i in 1:Medium.nXi loop
    Xi_reg[i] = Undirected.Internal.regStep(rear.m_flow, Xi_forwards[i], Xi_rearwards[i], m_flow_reg);
  end for;

  fore.state_forwards = rear.state_forwards;
  rear.state_rearwards = fore.state_rearwards;
  fore.r = rear.r;
  fore.m_flow + rear.m_flow = 0;


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

  annotation (defaultComponentName ="sensorTpm",Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,-160},{150,-120}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
         Text(visible=not outputTemperature,
          extent={{150,77},{90,47}},
          textColor={0,0,0},
          textString=temperatureString,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=not outputPressure,
          extent={{150,25},{90,-5}},
          textColor={0,0,0},
          textString=pressureUnit,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=not outputMassFlowRate,
          extent={{150,-27},{90,-57}},
          textColor={0,0,0},
          textString=massFlowString,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=outputTemperature,
          extent={{155,98},{95,68}},
          textColor={0,0,0},
          textString=temperatureString,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=outputPressure,
          extent={{155,38},{95,8}},
          textColor={0,0,0},
          textString=pressureUnit,
          horizontalAlignment=TextAlignment.Left),
        Text(visible=outputMassFlowRate,
          extent={{155,-22},{95,-52}},
          textColor={0,0,0},
          textString=massFlowString,
          horizontalAlignment=TextAlignment.Left),
        Rectangle(
          extent={{-74,84},{86,-76}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-80,90},{80,-70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-70},{0,-100}},color={0,0,0}),
        Text(
          extent={{-80,86},{80,38}},
          textColor={0,0,0},
          textString=DynamicSelect(" T ", " "+String(T,significantDigits=digits)+" ")),
        Text(
          extent={{-80,34},{80,-14}},
          textColor={0,0,0},
          textString=DynamicSelect(" p ", " "+String(p,significantDigits=digits)+" ")),
        Text(
          extent={{-80,-18},{80,-66}},
          textColor={0,0,0},
          textString=DynamicSelect(" m ", " "+String(m_flow,significantDigits=digits)+" ")),
        Line(
          points={{-100,-100},{100,-100}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,-94},{6,-106}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(visible=outputTemperature,
          points={{80,60},{100,60}},
          color={0,0,127}),
        Line(visible=outputPressure,
          points={{80,0},{100,0}},
          color={0,0,127}),
        Line(visible=outputMassFlowRate,
          points={{80,-60},{100,-60}},
          color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Undirected&nbsp;sensor&nbsp;for&nbsp;temperature,&nbsp;pressure&nbsp;and&nbsp;mass-flow. Units can be selected.</p>
</html>"));
end MultiSensor_Tpm;
