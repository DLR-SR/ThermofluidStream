within ThermofluidStream.Idealized.Types;
type dTIconType  = enumeration(
  Heating,
  Cooling) "Options for defining the display icon type"
annotation(choices(__Dymola_radioButtons=true,
  choice =ThermofluidStream.Idealized.Types.dTIconType.Heating    "Heating",
  choice =ThermofluidStream.Idealized.Types.dTIconType.Cooling  "Cooling"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
