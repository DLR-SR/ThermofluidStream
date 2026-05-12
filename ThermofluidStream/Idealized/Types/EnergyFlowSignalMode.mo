within ThermofluidStream.Idealized.Types;
type EnergyFlowSignalMode = enumeration(
  Input,
  Output,
  Disabled) "Options for specifying the energy flow connector signal direction"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input "Input",
  choice = ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output "Output",
  choice = ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Disabled "Disabled"));
