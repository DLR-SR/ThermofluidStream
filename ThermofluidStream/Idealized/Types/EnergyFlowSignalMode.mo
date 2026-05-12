within ThermofluidStream.Idealized.Types;
type EnergyFlowSignalMode = enumeration(
  Input,
  Output,
  Disabled) "Options for specifying the energy flow connector signal direction"
  annotation(
    choices(__Dymola_radioButtons=true,
      choice=ThermoFluidStreamPlus.Idealized.Types.EnergyFlowSignalMode.Input "Input",
      choice=ThermoFluidStreamPlus.Idealized.Types.EnergyFlowSignalMode.Output "Output",
      choice=ThermoFluidStreamPlus.Idealized.Types.EnergyFlowSignalMode.Disabled "Disabled"));
