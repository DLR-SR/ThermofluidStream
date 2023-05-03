within ThermofluidStream.Sensors.Internal;
function getTwoPhaseUnit "Returns unit of input two-phase-quantity"
  extends Modelica.Icons.Function;

  input Types.TwoPhaseQuantities quantity;
  output String unit;

algorithm
  if quantity == Types.TwoPhaseQuantities.x_kgpkg then
    unit := "kg/kg";
  elseif quantity == Types.TwoPhaseQuantities.p_sat_Pa then
    unit := "Pa";
  elseif quantity == Types.TwoPhaseQuantities.p_sat_bar then
    unit := "bar";
  elseif quantity == Types.TwoPhaseQuantities.T_sat_K then
    unit := "K";
  elseif quantity == Types.TwoPhaseQuantities.T_sat_C then
    unit := "degC";
  elseif quantity == Types.TwoPhaseQuantities.p_oversat_Pa then
    unit := "Pa";
  elseif quantity == Types.TwoPhaseQuantities.p_oversat_bar then
    unit := "bar";
  elseif quantity == Types.TwoPhaseQuantities.T_oversat_K then
    unit := "K";
  else
    unit := "";
  end if;

  annotation (Documentation(info="<html>
<p>Helper function to get the unit for a quantity.</p>
</html>"));
end getTwoPhaseUnit;
