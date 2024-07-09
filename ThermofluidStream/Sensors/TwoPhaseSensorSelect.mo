within ThermofluidStream.Sensors;
model TwoPhaseSensorSelect "Selectable Sensor for two phase medium"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus(displayInstanceName = false);

  import Quantities = ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities;
  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  replaceable package Medium = Media.myMedia.Interfaces.PartialTwoPhaseMedium "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
<p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected. </p>
</html>"));
  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter Quantities quantity "Measured quantity";

  final parameter String quantityString=
    if quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg then "x in kg/kg"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K then "T_sat in K"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C then "T_sat in °C"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa then "p_sat in Pa"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar then "p_sat in bar"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K then "T - T_sat in K"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa then "p - p_sat in Pa"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar then "p - p_sat in bar"
    else "error";

  parameter Boolean outputValue = false "= true, if sensor output is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean filter_output = false "= true, if sensor output is filtered (to break algebraic loops)"
    annotation(Dialog(group="Output", enable=outputValue),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Time TC = 0.1 "Time constant of sensor output filter (PT1)"
    annotation(Dialog(group="Output", enable=outputValue and filter_output));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor output"
    annotation(Dialog(group="Output", enable=outputValue and filter_output));
  parameter Real value_0(unit=Internal.getTwoPhaseUnit(quantity)) = 0 "Start value of sensor output"
    annotation(Dialog(group="Output", enable=outputValue and filter_output and init==InitMode.state));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20, -20},{20, 20}}, origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput value_out(unit=Internal.getTwoPhaseUnit(quantity)) = value if outputValue "Sensor output connector"
    annotation (Placement(transformation(extent={{70,-10},{90,10}}), iconTransformation(extent={{70,-10},{90,10}})));

  output Real value(unit=Internal.getTwoPhaseUnit(quantity)) "Computed value of the selected quantity [variable]";

protected
  Real direct_value(unit=Internal.getTwoPhaseUnit(quantity));

  function getQuantity = Internal.getTwoPhaseQuantity(redeclare package Medium=Medium) "Quantity compute function"
    annotation (Documentation(info="<html>
    <p>This function computes the selected two-phase quantity from state.</p>
      </html>"));

initial equation
  if filter_output and init==InitMode.steadyState then
    value= direct_value;
  elseif filter_output then
    value = value_0;
  end if;

equation
  inlet.m_flow = 0;
  direct_value = getQuantity(inlet.state, quantity);

  if filter_output then
    der(value) * TC = direct_value-value;
  else
    value = direct_value;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Rectangle(
          extent={{-54,24},{66,-36}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-60,30},{60,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,30},{60,-30}},
          textColor={28,108,200},
          textString=DynamicSelect("value", String(
              value,
              format="1."+String(digits)+"f"))),
        Text(
          extent={{-150,-70},{150,-40}},
          textColor={0,0,0},
          textString=quantityString),
        Line(visible=outputValue,
          points={{60,0},{78,0}},
          color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This is an extra sensor for vaporQuantity, because the Medium must be constrained by PartialTwoPhaseMedium instead of TwoPhaseMedium.</p>
<p>This sensor can be connected to a fluid stream without a junction.</p>
</html>"));
end TwoPhaseSensorSelect;
