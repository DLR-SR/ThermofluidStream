within ThermofluidStream.Idealized.Types.OutletSpecification;
type Adiabatic = enumeration(
  PressureDifference,
  PressureRatio,
  OutletPressure) "Options for selecting the independent outlet variable in an adiabatic steady-flow process"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference "Pressure difference",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio "Pressure ratio",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure "Outlet pressure"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
