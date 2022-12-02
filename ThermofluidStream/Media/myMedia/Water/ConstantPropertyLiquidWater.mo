within ThermofluidStream.Media.myMedia.Water;
package ConstantPropertyLiquidWater
  "Water: Simple liquid water medium (incompressible, constant data)"

  //   redeclare record extends FluidConstants
  //   end FluidConstants;

  constant
    ThermofluidStream.Media.myMedia.Interfaces.Types.Basic.FluidConstants[1] simpleWaterConstants(
    each chemicalFormula="H2O",
    each structureFormula="H2O",
    each casRegistryNumber="7732-18-5",
    each iupacName="oxidane",
    each molarMass=0.018015268);

  extends Interfaces.PartialSimpleMedium(
    mediumName="SimpleLiquidWater",
    cp_const=4184,
    cv_const=4184,
    d_const=995.586,
    eta_const=1.e-3,
    lambda_const=0.598,
    a_const=1484,
    T_min=Cv.from_degC(-1),
    T_max=Cv.from_degC(130),
    T0=273.15,
    MM_const=0.018015268,
    fluidConstants=simpleWaterConstants);

  annotation (Documentation(info="<html>

</html>"));
end ConstantPropertyLiquidWater;
