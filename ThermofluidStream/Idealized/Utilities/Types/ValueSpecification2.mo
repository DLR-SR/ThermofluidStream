within ThermofluidStream.Idealized.Utilities.Types;
type ValueSpecification2 = enumeration(
  State,
  Fixed) "Specifies how the value of a quantity is defined (version 2)"
    annotation(choices(__Dymola_radioButtons=true,
        choice =ThermoFluidStream.Idealized.Utilities.Types.ValueSpecification2.State
                                                                       "State",
        choice =ThermoFluidStream.Idealized.Utilities.Types.ValueSpecification2.Fixed
                                                                       "Fixed"));
