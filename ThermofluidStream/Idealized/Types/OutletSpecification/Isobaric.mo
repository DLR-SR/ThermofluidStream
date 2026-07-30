within ThermofluidStream.Idealized.Types.OutletSpecification;
type Isobaric = enumeration(
  TemperatureDifference,
  OutletTemperature,
  SpecificEnthalpyDifference,
  OutletSpecificEnthalpy) "Options for selecting the independent outlet variable in an isobaric steady-flow process"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference "Temperature difference",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature "Outlet temperature",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference "Specific enthalpy difference",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy "Outlet specific enthalpy"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
