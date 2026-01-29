within ThermofluidStream.Processes.Internal.Types;
type SetpointModePressure = enumeration(
    dp "Pressure difference",
    pr "Pressure ratio",
    p_out "Outlet pressure")
  "Setpoint mode (pressure, pressure ratio, pressure difference)" annotation (Documentation(revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
