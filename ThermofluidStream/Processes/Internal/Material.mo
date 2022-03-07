within ThermofluidStream.Processes.Internal;
type Material = enumeration(
    other,
    concrete,
    wood,
    castIron,
    galvanizedIron,
    steel,
    drawnPipe) "Material list with known roughnesses: todo make record of it" annotation (
    Documentation(info="<html>
<p>Enumeration of materials where the roughness is approximatly known. Used for a dropdown of selectable materials.</p>
</html>"));
