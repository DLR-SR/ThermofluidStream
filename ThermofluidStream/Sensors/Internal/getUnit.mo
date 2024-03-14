within ThermofluidStream.Sensors.Internal;
function getUnit "Returns unit of input quantity"
  extends Modelica.Icons.Function;

  input Types.Quantities quantity;
  output String unit;

algorithm
  if quantity == Types.Quantities.T_K then
    unit :="K";
  elseif quantity == Types.Quantities.T_C then
    unit :="degC";
  elseif quantity == Types.Quantities.p_Pa then
    unit :="Pa";
  elseif quantity == Types.Quantities.p_bar then
    unit :="bar";
  elseif quantity == Types.Quantities.r_Pa then
    unit :="Pa";
  elseif quantity == Types.Quantities.r_bar then
    unit :="bar";
  elseif quantity == Types.Quantities.p_total_Pa then
    unit :="Pa";
  elseif quantity == Types.Quantities.p_total_bar then
    unit :="bar";
  elseif quantity == Types.Quantities.h_Jpkg then
    unit :="J/kg";
  elseif quantity == Types.Quantities.s_JpkgK then
    unit :="J/(kg.K)";
  elseif quantity == Types.Quantities.rho_kgpm3 then
    unit :="kg/m3";
  elseif quantity == Types.Quantities.v_m3pkg then
    unit :="m3/kg";
  elseif quantity == Types.Quantities.a_mps then
    unit := "(m/s)";
  elseif quantity == Types.Quantities.cv_JpkgK then
    unit :="J/(kg.K)";
  elseif quantity == Types.Quantities.cp_JpkgK then
    unit :="J/(kg.K)";
  elseif quantity == Types.Quantities.kappa_1 then
    unit :="1";
  elseif quantity == Types.Quantities.MM_kgpmol then
    unit := "(kg/mol)";
  else
    unit :="";
  end if;

  annotation (Documentation(info="<html>
<p>Helper function to get the unit for a quantity.</p>
</html>"));
end getUnit;
