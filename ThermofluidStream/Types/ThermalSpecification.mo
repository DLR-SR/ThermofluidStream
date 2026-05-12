within ThermofluidStream.Types;
type ThermalSpecification = enumeration(
  Temperature,
  SpecificEnthalpy) "Specifies how the thermal state quantity is defined"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermoFluidStream.Types.ThermalSpecification.Temperature "Temperature",
  choice =ThermoFluidStream.Types.ThermalSpecification.SpecificEnthalpy "Specific enthalpy"));
