within ThermofluidStream.Idealized.Types;
type mflowIconType
                 = enumeration(
  PositiveMflow,
  NegativeMflow) "Options for defining the display icon type"
annotation(choices(__Dymola_radioButtons=true,
                   choice =ThermofluidStream.Idealized.Types.mflowIconType.PositiveMflow    "Positive mass flow",
                   choice =ThermofluidStream.Idealized.Types.mflowIconType.NegativeMflow  "Negative mass flow"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
