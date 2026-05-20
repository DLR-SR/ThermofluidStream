within ThermofluidStream.Types;
type ValueSpecification = enumeration(
  Fixed,
  Prescribed) "Specifies how the value of a quantity is defined"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Types.ValueSpecification.Fixed "Fixed",
  choice = ThermofluidStream.Types.ValueSpecification.Prescribed "Prescribed"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
