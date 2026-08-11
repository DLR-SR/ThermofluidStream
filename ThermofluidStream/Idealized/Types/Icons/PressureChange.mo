within ThermofluidStream.Idealized.Types.Icons;
type PressureChange = enumeration(
  Compression,
  Expansion) "Options for defining the display icon type"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Idealized.Types.Icons.PressureChange.Compression "Compression",
  choice = ThermofluidStream.Idealized.Types.Icons.PressureChange.Expansion "Expansion"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      08.2026, by Silvan Keim (silvan.keim@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
