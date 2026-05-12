within ThermofluidStream.Idealized.Types.OutletSpecification;
type Isochoric = enumeration(
  TemperatureDifference,
  OutletTemperature) "Options for specifying the independent outlet variable of a stationary-flow representation of a isochoric periodic closed-system cycle process"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference "Temperature difference",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature "Outlet temperature"));
