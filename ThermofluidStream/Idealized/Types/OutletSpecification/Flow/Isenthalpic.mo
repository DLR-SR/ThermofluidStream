within ThermofluidStream.Idealized.Types.OutletSpecification.Flow;
type Isenthalpic = enumeration(
  PressureLoss,
  RelativePressureLoss,
  OutletPressure) "Options for selecting the independent outlet variable in an isenthalpic steady-flow process"
    annotation(choices(__Dymola_radioButtons=true,
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Flow.Isenthalpic.PressureLoss   "Pressure loss",
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Flow.Isenthalpic.RelativePressureLoss   "Relative pressure loss",
      choice =ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Flow.Isenthalpic.OutletPressure   "Outlet pressure"));
