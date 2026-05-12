within ThermofluidStream.Types;
type ValueSpecification2 = enumeration(
  State,
  Fixed) "Specifies how the value of a quantity is defined (version 2)"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Types.ValueSpecification2.State "State",
  choice = ThermofluidStream.Types.ValueSpecification2.Fixed "Fixed"));
