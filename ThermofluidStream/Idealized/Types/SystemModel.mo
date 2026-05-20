within ThermofluidStream.Idealized.Types;
type SystemModel = enumeration(
  Flow,
  Cycle) "Options for defining the system type"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Idealized.Types.SystemModel.Flow "Open (steady-flow)",
  choice = ThermofluidStream.Idealized.Types.SystemModel.Cycle "Closed cycle (periodic)"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
