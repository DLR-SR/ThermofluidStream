within ThermofluidStream.Idealized.Types;
type SystemModel = enumeration(
  Flow,
  Cycle) "Options for defining the system type"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermoFluidStream.Idealized.Types.SystemModel.Flow "Open (steady-flow)",
  choice = ThermoFluidStream.Idealized.Types.SystemModel.Cycle "Closed cycle (periodic)"));
