within ThermofluidStream.Idealized.Types.OutletSpecification;
type Isobaric = enumeration(
  TemperatureDifference,
  OutletTemperature,
  SpecificEnthalpyDifference,
  OutletSpecificEnthalpy) "Options for selecting the independent outlet variable in an isobaric steady-flow process"
    annotation (choices(__Dymola_radioButtons=true,
      choice =ThermoFluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.TemperatureDifference   "Temperature difference",
      choice =ThermoFluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature   "Outlet temperature",
      choice =ThermoFluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.SpecificEnthalpyDifference   "Specific enthalpy difference",
      choice =ThermoFluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletSpecificEnthalpy   "Outlet specific enthalpy"));
