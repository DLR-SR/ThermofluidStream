within ThermofluidStream.Idealized.Types.Icons;
type HeatTransfer= enumeration(
  Heating,
  Cooling) "Options for defining the display icon type"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Heating "Heating",
  choice = ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Cooling "Cooling"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      08.2026, by Silvan.Keim (silvan.keim@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
