within ThermofluidStream.Idealized.Types;
type SystemModel = enumeration(
  Flow,
  Cycle) "Options for defining the system type"
    annotation(choices(__Dymola_radioButtons=true,
      choice = ThermoFluidStreamPlus.Idealized.Types.SystemModel.Flow  "Open (steady-flow)",
      choice = ThermoFluidStreamPlus.Idealized.Types.SystemModel.Cycle "Closed cycle (periodic)"));
