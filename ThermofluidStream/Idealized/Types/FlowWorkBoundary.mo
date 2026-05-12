within ThermofluidStream.Idealized.Types;
type FlowWorkBoundary = enumeration(
  Inlet,
  Outlet) "Selects whether flow work (p*v) of the inlet or outlet flow is considered"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Idealized.Types.FlowWorkBoundary.Inlet "Inlet",
  choice = ThermofluidStream.Idealized.Types.FlowWorkBoundary.Outlet "Outlet"));
