within ThermofluidStream.Types;
type MassFractionDifference = Real (
  quantity="MassFractionDifference",
  final unit="kg/kg",
  final min=-1,
  final max=1,
  nominal=0) "Type for difference in mass fraction with medium specific attributes" annotation (Documentation(info="<html>
  <p> 
    Introduced since SI.MassFraction dX &lt; 0 will create a warning.
  </p>
</html>"));
