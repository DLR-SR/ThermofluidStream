within ThermofluidStream.Types;
type ThermalSpecification = enumeration(
  Temperature,
  SpecificEnthalpy) "Specifies how the thermal state quantity is defined"
    annotation(choices(__Dymola_radioButtons=true,
        choice =ThermoFluidStream.Idealized.Utilities.Types.ThermalSpecification.Temperature
                                                                              "Temperature",
        choice =ThermoFluidStream.Idealized.Utilities.Types.ThermalSpecification.SpecificEnthalpy
                                                                                   "Specific enthalpy"));
