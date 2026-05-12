within ThermofluidStream.Idealized.Types;
type PolytropicProcessSpecification = enumeration(
  PolytropicEfficiency,
  PolytropicExponent,
  IsentropicEfficiency,
  OutletPressure,
  OutletTemperature) "Options for selecting the independent process variable in a polytropic steady-flow process"
    annotation(choices(__Dymola_radioButtons=true,
      choice = ThermoFluidStreamPlus.Idealized.Types.PolytropicProcessSpecification.PolytropicEfficiency "Polytropic efficiency",
      choice = ThermoFluidStreamPlus.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent "Polytropic exponent",
      choice = ThermoFluidStreamPlus.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency "Isentropic efficiency",
      choice = ThermoFluidStreamPlus.Idealized.Types.PolytropicProcessSpecification.OutletPressure "Outlet pressure",
      choice = ThermoFluidStreamPlus.Idealized.Types.PolytropicProcessSpecification.OutletTemperature "Outlet temperature"));
