within ThermofluidStream.Idealized.Types.OutletSpecification.Flow;
type Adiabatic = enumeration(
  PressureDifference,
  PressureRatio,
  OutletPressure) "Options for selecting the independent outlet variable in an adiabatic steady-flow process"
    annotation(choices(__Dymola_radioButtons=true,
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Flow.Adiabatic.PressureDifference   "Pressure difference",
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Flow.Adiabatic.PressureRatio   "Pressure ratio",
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure   "Outlet pressure"));
