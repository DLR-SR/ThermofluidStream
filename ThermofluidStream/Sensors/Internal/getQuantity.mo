within ThermofluidStream.Sensors.Internal;
function getQuantity "Computes selected quantity from state"
  extends Modelica.Icons.Function;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
      <p>Medium Model for the function. Make sure it implements the needed functions.</p>
        </html>"));

  input Medium.ThermodynamicState state;
  input SI.Pressure r;
  input Types.Quantities quantity;
  input SI.Density rho_min;
  output Real value;

algorithm
  if quantity == Types.Quantities.T_K then
    value := Medium.temperature(state);
  elseif quantity == Types.Quantities.T_C then
    value :=Modelica.Units.Conversions.to_degC(Medium.temperature(state));
  elseif quantity == Types.Quantities.p_Pa then
    value := Medium.pressure(state);
  elseif quantity == Types.Quantities.p_bar then
    value :=Modelica.Units.Conversions.to_bar(Medium.pressure(state));
  elseif quantity == Types.Quantities.r_Pa then
    value := r;
  elseif quantity == Types.Quantities.r_bar then
    value :=Modelica.Units.Conversions.to_bar(r);
  elseif quantity == Types.Quantities.p_total_Pa then
    value := Medium.pressure(state)+r;
  elseif quantity == Types.Quantities.p_total_bar then
    value :=Modelica.Units.Conversions.to_bar(Medium.pressure(state) + r);
  elseif quantity == Types.Quantities.h_Jpkg then
    value := Medium.specificEnthalpy(state);
  elseif quantity == Types.Quantities.s_JpkgK then
    value := Medium.specificEntropy(state);
  elseif quantity == Types.Quantities.rho_kgpm3 then
    value := Medium.density(state);
  elseif quantity == Types.Quantities.v_m3pkg then
    value := 1/(max(rho_min, Medium.density(state)));
  elseif quantity == Types.Quantities.a_mps then
    value := Medium.velocityOfSound(state);
  elseif quantity == Types.Quantities.cv_JpkgK then
    value := Medium.specificHeatCapacityCv(state);
  elseif quantity == Types.Quantities.cp_JpkgK then
    value := Medium.specificHeatCapacityCp(state);
  elseif quantity == Types.Quantities.kappa_1 then
    value := Medium.isentropicExponent(state);
  elseif quantity == Types.Quantities.MM_kgpmol then
    value := Medium.molarMass(state);
  else
    value :=0;
  end if;

  annotation (Documentation(info="<html>
<p>Helper function to get a quantity from an Thermofluid state.</p>
</html>"));
end getQuantity;
