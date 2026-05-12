within ThermofluidStream.Idealized.Types;
type FlowWorkBoundary = enumeration(
  Inlet,
  Outlet) "Selects whether flow work (p*v) of the inlet or outlet flow is considered"
  annotation(
    choices(__Dymola_radioButtons=true,
      choice=ThermoFluidStream.Idealized.Types.FlowWorkBoundary.Inlet "Inlet",
      choice=ThermoFluidStream.Idealized.Types.FlowWorkBoundary.Outlet "Outlet"));
