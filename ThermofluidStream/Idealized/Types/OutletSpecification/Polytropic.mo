within ThermofluidStream.Idealized.Types.OutletSpecification;
type Polytropic = enumeration(
  PressureDifference,
  PressureRatio,
  OutletPressure,
  OutletTemperature,
  CompressionRatio,
  OutletDensity,
  OutletSpecificVolume,
  Unspecified) "Options for selecting the independent outlet variable in a polytropic process"
    annotation(choices(__Dymola_radioButtons=true,
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Polytropic.PressureDifference "Pressure difference",
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Polytropic.PressureRatio "Pressure ratio",
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Polytropic.OutletPressure "Outlet pressure",
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature "Outlet temperature",
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio "Compression ratio",
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Polytropic.OutletDensity "Outlet density",
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume "Outlet specific volume",
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Polytropic.Unspecified "Unspecified"));
