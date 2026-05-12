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
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureDifference "Pressure difference",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio "Pressure ratio",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure "Outlet pressure",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature "Outlet temperature",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio "Compression ratio",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity "Outlet density",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume "Outlet specific volume",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified "Unspecified"));
