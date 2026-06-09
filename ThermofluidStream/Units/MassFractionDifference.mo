within ThermofluidStream.Units;
type MassFractionDifference = Real(
  quantity="MassFractionDifference",
  final unit="kg/kg",
  final min=-1,
  final max=1,
  nominal=1) "Type for difference in mass fraction with medium specific attributes"
annotation(
Documentation(
  info="<html>
  <p> 
    Introduced since SI.MassFraction dX &lt; 0 will create a warning.
  </p>
</html>",
  revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
