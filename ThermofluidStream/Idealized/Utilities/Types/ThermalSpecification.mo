within ThermofluidStream.Idealized.Utilities.Types;
type ThermalSpecification = enumeration(
  Temperature,
  SpecificEnthalpy) "Specifies how the thermal state quantity is defined"
    annotation(choices(__Dymola_radioButtons=true,
        choice =ThermoFluidStreamPlus.Idealized.Utilities.Types.ThermalSpecification.Temperature
                                                                              "Temperature",
        choice =ThermoFluidStreamPlus.Idealized.Utilities.Types.ThermalSpecification.SpecificEnthalpy
                                                                                   "Specific enthalpy"));
