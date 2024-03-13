within ThermofluidStream.Sensors.AdditionalSensors.SingleFlowSensors;
model SingleFlowSensor22 "v2.2 of SingleFlowSensor"
  import Quantities=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities;
  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected.</p>
        </html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter Quantities quantity "Quantity the sensor measures";

  final parameter String quantityString=
  if quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps then "Mass flow rate (kg/s)"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps then "Mass flow rate (g/s)"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps then "Volume flow rate (m3/s)"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin then "Volume flow rate (l/min)"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps then "Enthalpy flow rate (J/s)"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_JpKs then "Entropy flow rate (J/(K.s))"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs then "Heat capacity flow rate (J/(K.s))"
  else "error";

  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimum density"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter Boolean outputValue = false "Enable sensor-value output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=outputValue));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor lowpass"
    annotation(Dialog(tab="Initialization", enable=filter_output));
  parameter Real value_0(unit=Internal.getFlowUnit(quantity)) = 0 "Initial output state of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=outputValue and filter_output));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealOutput value_out(unit=Internal.getFlowUnit(quantity)) = value if outputValue "Measured quantity [variable]"
    annotation (Placement(transformation(extent={{70,50},{90,70}}),
        iconTransformation(extent={{70,50},{90,70}})));

  output Real value(unit=Internal.getFlowUnit(quantity));

protected
  Real direct_value(unit=Internal.getFlowUnit(quantity));
  output SI.MassFlowRate m_flow = inlet.m_flow;

  function getQuantity = Internal.getFlowQuantity(redeclare package Medium=Medium) "Quantity compute function"
    annotation (Documentation(info="<html>
      <p>This function computes the selected quantity from state and massflow. rho_min is neddet for the computation of v.</p>
      </html>"));

initial equation
  if filter_output and init==InitMode.steadyState then
    value= direct_value;
  elseif filter_output then
    value = value_0;
  end if;

equation
  inlet.m_flow + outlet.m_flow = 0;
  outlet.r = inlet.r;
  outlet.state = inlet.state;

  direct_value = getQuantity(inlet.state, inlet.m_flow, quantity, rho_min);

  if filter_output then
    der(value) * TC = direct_value-value;
  else
    value = direct_value;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,100},{150,140}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Rectangle(
          extent={{-54,84},{66,24}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Line(points={{0,34},{0,0}},    color={0,0,0}),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-60,90},{60,30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,90},{60,30}},
          textColor={28,108,200},
          textString=DynamicSelect("value", String(
              value,
              format="1."+String(digits)+"f"))),
        Text(
          extent={{-150,-55},{150,-25}},
          textColor={0,0,0},
          textString=quantityString),
        Line(visible=outputValue,
          points={{60,60},{78,60}},
          color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>A sensor measuring a selectable flow quantity associated with the massflow.</p>
<p>This sensor must be included into the fluid stream, since it measures massflow. </p>
</html>"));
end SingleFlowSensor22;
