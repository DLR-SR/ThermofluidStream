within ThermofluidStream.Sensors;
model TwoPhaseSensorSelect2 "v2 of TwoPhaseSensorSelect"
  import Quantities=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities;
  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialTwoPhaseMedium
    "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
<p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected. </p>
</html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter Quantities quantity "Quantity the sensor measures";

  final parameter String quantityString=
  if quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg then "Vapor quality (kg_Vapor/kg_total)"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K then "Saturation temperature (K)"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C then "Saturation temperature (°C)"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa then "Saturation pressure (Pa)"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar then "Saturation pressure (bar)"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K then "Temperature above saturation (K)"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa then "Pressure above saturation (Pa)"
  elseif quantity == ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar then "Pressure above saturation (bar)"
  else "error";






  parameter Boolean outputValue = false "Enable sensor-value output"
    annotation(Dialog(group="Output Value"));
  parameter Boolean filter_output = false "Filter sensor-value to break algebraic loops"
    annotation(Dialog(group="Output Value", enable=outputValue));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor lowpass"
    annotation(Dialog(tab="Initialization", enable=filter_output));
  parameter Real value_0(unit=Internal.getTwoPhaseUnit(quantity)) = 0 "Initial output state of sensor"
    annotation(Dialog(tab="Initialization", enable=filter_output and init==InitMode.state));
  parameter SI.Time TC = 0.1 "PT1 time constant"
    annotation(Dialog(tab="Advanced", enable=outputValue and filter_output));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20, -20},{20, 20}}, origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput value_out(unit=Internal.getTwoPhaseUnit(quantity)) = value if outputValue "Computed value of the selected Quantity [variable]"
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
          textColor={0,0,255}),
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
end TwoPhaseSensorSelect2;
