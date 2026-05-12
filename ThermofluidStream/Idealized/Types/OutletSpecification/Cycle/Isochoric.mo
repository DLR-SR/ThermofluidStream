within ThermofluidStream.Idealized.Types.OutletSpecification.Cycle;
type Isochoric = enumeration(
  TemperatureDifference,
  OutletTemperature) "Options for specifying the independent outlet variable of a stationary-flow representation of a isochoric periodic closed-system cycle process"
    annotation(choices(__Dymola_radioButtons=true,
        choice =ThermoFluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.TemperatureDifference   "Temperature difference",
        choice =ThermoFluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.OutletTemperature   "Outlet temperature"));
