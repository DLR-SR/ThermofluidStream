within ThermofluidStream.Undirected.Sensors;
model SingleSensorSelect "Selectable sensor"

  extends Internal.PartialSensor;

  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  parameter ThermofluidStream.Sensors.Internal.Types.Quantities quantity "Measured quantity";

  final parameter String quantityString=
    if quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.T_K then "T in K"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.T_C then "T in °C"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa then "p in Pa"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar then "p in bar"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3 then "d in kg/m3"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg then "v in m3/kg"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg then "h in J/kg"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK then "s in J/(kg.K)"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps then "Velocity of sound in m/s"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK then "cv in J/(kg.K)"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK then "cp in J/(kg.K)"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1 then "kappa"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol then  "M in kg/mol"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa then "r in Pa"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar then "r in bar"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa then "(p+r) in Pa"
    elseif quantity == ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar then "(p+r) in bar"
    else "error";

  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimum density"
    annotation(Dialog(tab="Advanced", group="Regularization"));

  parameter Boolean outputValue = false "= true, if sensor output is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean filter_output = false "= true, if sensor output is filtered (to break algebraic loops)"
    annotation(Dialog(group="Output", enable=outputValue),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Time TC = 0.1 "Time constant of sensor output filter (PT1)"
    annotation(Dialog(group="Output", enable=outputValue and filter_output));
  parameter InitMode init=InitMode.steadyState "Initialization mode for sensor output"
    annotation(Dialog(group="Output", enable=outputValue and filter_output));
  parameter Real value_0(unit=ThermofluidStream.Sensors.Internal.getUnit(quantity)) = 0 "Start value of sensor output"
    annotation(Dialog(group="Output", enable=outputValue and filter_output and init==InitMode.state));



  Modelica.Blocks.Interfaces.RealOutput value_out(unit=ThermofluidStream.Sensors.Internal.getUnit(quantity)) = value if outputValue "Sensor output connector"
    annotation (Placement(
        transformation(extent={{70,50},{90,70}}),
          iconTransformation(extent={{70,50},{90,70}})));

  function getQuantity = ThermofluidStream.Sensors.Internal.getQuantity (
    redeclare package Medium = Medium) "Quantity compute function"
    annotation (Documentation(info="<html>
      <p>This function computes the selected quantity from state. r and rho_min are neddet for the quantities r/p_total and v respectively.</p>
      </html>"));

  Real value(unit=ThermofluidStream.Sensors.Internal.getUnit(quantity));

protected
  Real direct_value(unit=ThermofluidStream.Sensors.Internal.getUnit(quantity));

initial equation
  if filter_output and init==InitMode.steadyState then
    value= direct_value;
  elseif filter_output then
    value = value_0;
  end if;


equation

  direct_value = getQuantity(state, rear.r, quantity, rho_min);

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
        Line(points={{0,34},{0,0}},    color={0,0,0}),
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
        Ellipse(
          extent={{-5,5},{5,-5}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(visible=outputValue,
          points={{60,60},{78,60}},
          color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Undirected sensor for a single selectable quantity. For some quatities several units are available.</p>
</html>"));
end SingleSensorSelect;
