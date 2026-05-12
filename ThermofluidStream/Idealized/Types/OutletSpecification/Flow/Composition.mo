within ThermofluidStream.Idealized.Types.OutletSpecification.Flow;
type Composition = enumeration(
  MassFractionsDifference,
  OutletMassFractions) "Options for specifying the outlet mass fractions in MassFractionModifier"
    annotation(choices(__Dymola_radioButtons=true,
        choice =ThermoFluidStream.Idealized.Types.OutletSpecification.Flow.Composition.MassFractionsDifference   "Mass fractions difference",
        choice =ThermoFluidStream.Idealized.Types.OutletSpecification.Flow.Composition.OutletMassFractions   "Outlet mass fractions"));
