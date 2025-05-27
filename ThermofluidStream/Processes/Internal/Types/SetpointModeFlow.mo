within ThermofluidStream.Processes.Internal.Types;
type SetpointModeFlow = enumeration(
    m_flow "Mass flow rate",
    V_flow "Volume flow rate")
  "Setpoint mode (mass flow rate, volume flow rate)" annotation (Documentation(revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
