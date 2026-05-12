within ThermofluidStream.Types;
type ValueSpecification = enumeration(
  Fixed,
  Prescribed) "Specifies how the value of a quantity is defined"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermoFluidStream.Types.ValueSpecification.Fixed "Fixed",
  choice = ThermoFluidStream.Types.ValueSpecification.Prescribed "Prescribed"));
