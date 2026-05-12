within ThermofluidStream.Idealized.Utilities.Types;
type ValueSpecification = enumeration(
  Fixed,
  Prescribed) "Specifies how the value of a quantity is defined"
    annotation(choices(__Dymola_radioButtons=true,
        choice =ThermoFluidStreamPlus.Idealized.Utilities.Types.ValueSpecification.Fixed
                                                                      "Fixed",
        choice =ThermoFluidStreamPlus.Idealized.Utilities.Types.ValueSpecification.Prescribed
                                                                           "Prescribed"));
