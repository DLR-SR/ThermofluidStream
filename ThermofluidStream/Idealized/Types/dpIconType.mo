within ThermofluidStream.Idealized.Types;
type dpIconType  = enumeration(
  Compression,
  Expansion) "Options for defining the display icon type"
annotation(choices(__Dymola_radioButtons=true,
  choice =ThermofluidStream.Idealized.Types.dpIconType.Compression
                                                                  "Compression",
  choice =ThermofluidStream.Idealized.Types.dpIconType.Expansion
                                                                "Expansion"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
