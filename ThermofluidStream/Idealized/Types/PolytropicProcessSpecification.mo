within ThermofluidStream.Idealized.Types;
type PolytropicProcessSpecification = enumeration(
  PolytropicEfficiency,
  PolytropicExponent,
  IsentropicEfficiency,
  OutletPressure,
  OutletTemperature) "Options for selecting the independent process variable in a polytropic steady-flow process"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicEfficiency "Polytropic efficiency",
  choice = ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent "Polytropic exponent",
  choice = ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency "Isentropic efficiency",
  choice = ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure "Outlet pressure",
  choice = ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature "Outlet temperature"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
