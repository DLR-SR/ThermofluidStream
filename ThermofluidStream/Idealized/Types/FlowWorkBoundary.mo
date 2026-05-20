within ThermofluidStream.Idealized.Types;
type FlowWorkBoundary = enumeration(
  Inlet,
  Outlet) "Selects whether flow work (p*v) of the inlet or outlet flow is considered"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Idealized.Types.FlowWorkBoundary.Inlet "Inlet",
  choice = ThermofluidStream.Idealized.Types.FlowWorkBoundary.Outlet "Outlet"), Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
