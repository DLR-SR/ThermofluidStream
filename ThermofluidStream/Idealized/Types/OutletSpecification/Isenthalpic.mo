within ThermofluidStream.Idealized.Types.OutletSpecification;
type Isenthalpic = enumeration(
  PressureLoss,
  RelativePressureLoss,
  OutletPressure) "Options for selecting the independent outlet variable in an isenthalpic steady-flow process"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.PressureLoss "Pressure loss",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.RelativePressureLoss "Relative pressure loss",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure "Outlet pressure"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
