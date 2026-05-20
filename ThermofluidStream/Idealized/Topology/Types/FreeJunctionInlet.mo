within ThermofluidStream.Idealized.Topology.Types;
type FreeJunctionInlet = enumeration(
  A "A",
  B "B") "Specification for junction inlet (A or B)" annotation(
  choices(__Dymola_radioButtons=true,
    choice = ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.A "A",
    choice = ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.B "B"), Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
