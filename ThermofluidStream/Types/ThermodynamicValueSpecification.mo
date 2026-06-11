within ThermofluidStream.Types;
type ThermodynamicValueSpecification = enumeration(
  State,
  Fixed) "Specifies how the value of a quantity is defined"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Types.ThermodynamicValueSpecification.State "State",
  choice = ThermofluidStream.Types.ThermodynamicValueSpecification.Fixed "Fixed"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
