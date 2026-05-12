within ThermofluidStream.Idealized.Types.OutletSpecification;
type Isenthalpic = enumeration(
  PressureLoss,
  RelativePressureLoss,
  OutletPressure) "Options for selecting the independent outlet variable in an isenthalpic steady-flow process"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermoFluidStream.Idealized.Types.OutletSpecification.Isenthalpic.PressureLoss "Pressure loss",
  choice = ThermoFluidStream.Idealized.Types.OutletSpecification.Isenthalpic.RelativePressureLoss "Relative pressure loss",
  choice = ThermoFluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure "Outlet pressure"));
