within ThermofluidStream.Idealized.Types;
type PolytropicProcessSpecification = enumeration(
  PolytropicEfficiency,
  PolytropicExponent,
  IsentropicEfficiency,
  OutletPressure,
  OutletTemperature) "Options for selecting the independent process variable in a polytropic steady-flow process"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermoFluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicEfficiency "Polytropic efficiency",
  choice = ThermoFluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent "Polytropic exponent",
  choice = ThermoFluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency "Isentropic efficiency",
  choice = ThermoFluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure "Outlet pressure",
  choice = ThermoFluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature "Outlet temperature"));
