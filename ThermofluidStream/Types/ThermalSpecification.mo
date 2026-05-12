within ThermofluidStream.Types;
type ThermalSpecification = enumeration(
  Temperature,
  SpecificEnthalpy) "Specifies how the thermal state quantity is defined"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Types.ThermalSpecification.Temperature "Temperature",
  choice =ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy "Specific enthalpy"));
