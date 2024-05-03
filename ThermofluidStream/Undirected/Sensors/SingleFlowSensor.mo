within ThermofluidStream.Undirected.Sensors;
model SingleFlowSensor "Flow sensor"

  extends Internal.PartialSensor;

  import Quantities=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities;
  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  parameter Quantities quantity "Meassured quantity";

  final parameter String quantityString=
    if quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps then "m_flow in kg/s"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps then "m_flow in g/s"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps then "V_flow in m3/s"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin then "V_flow in l/min"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps then "H_flow in J/s"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_JpKs then "S_flow in J/(K.s)"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs then "Cp_flow in J/(K.s)"
    else "error";

  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimum Density"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter Boolean outputValue = false "= true, if sensor output is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean filter_output = false "= true, if sensor output is filtered (to break algebraic loops)"
    annotation(Dialog(group="Output", enable=outputValue),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Time TC = 0.1 "Time constant of sensor output filter (PT1)"
    annotation(Dialog(group="Output", enable=outputValue and filter_output));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor output"
    annotation(Dialog(group="Output", enable=outputValue and filter_output));
  parameter Real value_0(unit=ThermofluidStream.Sensors.Internal.getFlowUnit(quantity)) = 0 "Start value of sensor output"
    annotation(Dialog(group="Output", enable=outputValue and filter_output and init==InitMode.state));

  Modelica.Blocks.Interfaces.RealOutput value_out(unit=ThermofluidStream.Sensors.Internal.getFlowUnit(quantity)) = value if outputValue "Sensor output connector"
    annotation (Placement(transformation(extent={{70,50},{90,70}}),
        iconTransformation(extent={{70,50},{90,70}})));

  output Real value(unit=ThermofluidStream.Sensors.Internal.getFlowUnit(quantity));

protected
  Real direct_value(unit=ThermofluidStream.Sensors.Internal.getFlowUnit(quantity));

  function getQuantity = ThermofluidStream.Sensors.Internal.getFlowQuantity (
    redeclare package Medium = Medium) "Quantity compute function"
    annotation (Documentation(info="<html>
        <p>This function computes the selected quantity from state and massflow. rho_min is neddet for the computation of v. </p>
        </html>"));

initial equation
  if filter_output and init==InitMode.steadyState then
    value= direct_value;
  elseif filter_output then
    value = value_0;
  end if;

equation
  direct_value = getQuantity(state, rear.m_flow, quantity, rho_min);

  if filter_output then
    der(value) * TC = direct_value-value;
  else
    value = direct_value;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,-25},{150,-65}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Rectangle(
          extent={{-54,84},{66,24}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-60,90},{60,30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,90},{60,30}},
          textColor={28,108,200},
          textString=DynamicSelect("value", String(value, format="1."+String(digits)+"f"))),
        Text(
          extent={{-150,130},{150,100}},
          textColor={0,0,0},
          textString=quantityString),
        Line(points={{0,30},{0,0}},    color={0,0,0}),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(visible=outputValue,
          points={{60,60},{78,60}},
          color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>A undirected sensor measuring a selectable flow quantity associated with the massflow. For some quatities several units are available.</p>
</html>"));
end SingleFlowSensor;
