within ThermofluidStream.Processes.Internal;
type Material = enumeration(
    other "Other",
    concrete "Concrete, ks = 5 mm",
    wood "Wood, ks = 0.5 mm",
    castIron "Cast iron, ks = 0.25 mm",
    galvanizedIron "Galvanized iron, ks = 0.15 mm",
    steel "Steel, ks = 0.059 mm",
    drawnPipe "Drawn pipe ks = 0.0015 mm") "Material list with known roughnesses: todo make record of it" annotation (
    Documentation(info="<html>
<p>Enumeration of materials where the roughness is approximately known. Used for a dropdown of selectable materials.</p>
</html>"));
