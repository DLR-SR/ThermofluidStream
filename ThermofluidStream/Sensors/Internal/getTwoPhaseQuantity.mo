within ThermofluidStream.Sensors.Internal;
function getTwoPhaseQuantity
  "Computes selected two-phase quantity from state"
  extends Modelica.Icons.Function;

  replaceable package Medium = Media.myMedia.Interfaces.PartialTwoPhaseMedium
    "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
      <p>Medium Model for the function. Make sure it implements the needed functions.</p>
        </html>"));

  input Medium.ThermodynamicState state;
  input Types.TwoPhaseQuantities quantity;
  output Real value;

algorithm
  if quantity == Types.TwoPhaseQuantities.x_kgpkg then
    value := Medium.vapourQuality(state);
  elseif quantity == Types.TwoPhaseQuantities.p_sat_Pa then
    value := Medium.saturationPressure(Medium.temperature(state));
  elseif quantity == Types.TwoPhaseQuantities.p_sat_bar then
    value :=Modelica.Units.Conversions.to_bar(Medium.saturationPressure(
      Medium.temperature(state)));
  elseif quantity == Types.TwoPhaseQuantities.T_sat_K then
    value := Medium.saturationTemperature(Medium.pressure(state));
  elseif quantity == Types.TwoPhaseQuantities.T_sat_C then
    value :=Modelica.Units.Conversions.to_degC(Medium.saturationTemperature(
      Medium.pressure(state)));
  elseif quantity == Types.TwoPhaseQuantities.p_oversat_Pa then
    value := Medium.pressure(state) - Medium.saturationPressure(Medium.temperature(state));
  elseif quantity == Types.TwoPhaseQuantities.p_oversat_bar then
    value :=Modelica.Units.Conversions.to_bar(Medium.pressure(state) -
      Medium.saturationPressure(Medium.temperature(state)));
  elseif quantity == Types.TwoPhaseQuantities.T_oversat_K then
    value :=  Medium.temperature(state) - Medium.saturationTemperature(Medium.pressure(state));
  else
    value :=0;
  end if;

  annotation (Documentation(info="<html>
<p>Helper function to get a quantity from an Thermofluid state.</p>
</html>"));
end getTwoPhaseQuantity;
