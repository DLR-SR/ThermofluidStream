within ThermofluidStream.Sensors;
model SingleSensorSelect31 "v3.1 of SingleSensorSelect (Display)"
  import ThermofluidStream.Sensors.Internal.Types.Quantities;
  import InitMode = ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor;

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected.</p>
        </html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits";
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimum allowed density"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter Quantities quantity "Quantity the sensor measures";

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

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20, -20},{20, 20}}, origin={-100,0})));
  Real value(unit=Internal.getUnit(quantity)) "Computed value of the selected quantity";

protected
  function getQuantity = Internal.getQuantity(redeclare package Medium=Medium) "Quantity compute function"
    annotation (Documentation(info="<html>
      <p>This function computes the selected quantity from state. r and rho_min are neddet for the quantities r/p_total and v respectively.</p>
      </html>"));

equation
  inlet.m_flow = 0;
  value = getQuantity(inlet.state, inlet.r, quantity, rho_min);


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
          extent={{70,-15},{200,15}},
          textColor={0,0,0},
          textString=quantityString,
          horizontalAlignment=TextAlignment.Left)}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Sensor for measuring a selectable quantity.</p>
<p>This sensor can be connected to a fluid stream without a junction.</p>
</html>"));
end SingleSensorSelect31;
