within ThermofluidStream.Processes.Internal;
type ShapeOfResistance = enumeration(
    circular "Circular",
    rectangle "Rectangular",
    other "Other") "Provides the choice of different shapes for cross section"
  annotation (
    Documentation(info="<html>
<p>Shape of cross sectional area of flow resistance.</p>
</html>"));
