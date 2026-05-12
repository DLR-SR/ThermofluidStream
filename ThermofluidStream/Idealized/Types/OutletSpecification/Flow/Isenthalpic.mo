within ThermofluidStream.Idealized.Types.OutletSpecification.Flow;
type Isenthalpic = enumeration(
  PressureLoss,
  RelativePressureLoss,
  OutletPressure) "Options for selecting the independent outlet variable in an isenthalpic steady-flow process"
    annotation(choices(__Dymola_radioButtons=true,
      choice =ThermoFluidStream.Idealized.Types.OutletSpecification.Flow.Isenthalpic.PressureLoss   "Pressure loss",
      choice =ThermoFluidStream.Idealized.Types.OutletSpecification.Flow.Isenthalpic.RelativePressureLoss   "Relative pressure loss",
      choice =ThermoFluidStream.Idealized.Types.OutletSpecification.Flow.Isenthalpic.OutletPressure   "Outlet pressure"));
