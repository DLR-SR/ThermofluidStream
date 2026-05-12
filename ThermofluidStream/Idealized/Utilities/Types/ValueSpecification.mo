within ThermofluidStream.Idealized.Utilities.Types;
type ValueSpecification = enumeration(
  Fixed,
  Prescribed) "Specifies how the value of a quantity is defined"
    annotation(choices(__Dymola_radioButtons=true,
        choice =ThermoFluidStream.Idealized.Utilities.Types.ValueSpecification.Fixed
                                                                      "Fixed",
        choice =ThermoFluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed
                                                                           "Prescribed"));
