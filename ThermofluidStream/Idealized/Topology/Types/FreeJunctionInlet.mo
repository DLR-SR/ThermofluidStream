within ThermofluidStream.Idealized.Topology.Types;
type FreeJunctionInlet = enumeration(
  A "A",
  B "B") "Specification for junction inlet (A or B)" annotation(
  choices(__Dymola_radioButtons=true,
    choice = ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.A "A",
    choice = ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.B "B"));
