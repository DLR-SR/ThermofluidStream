within ThermofluidStream.Processes.Internal.Types;
type PumpMode = enumeration(
    flange "Mechanical flange connector",
    flowControlled,
    pressureControlled,
    speedControlled) "Enumeration of pump calculation modes" annotation (Documentation(revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
