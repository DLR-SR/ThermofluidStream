within ThermofluidStream.Processes.Internal.Types;
type SetpointModePressure = enumeration(
    dp "Pressure difference",
    pr "Pressure ratio",
    p_out "Outlet pressure")
  "Setpoint mode (pressure, pressure ratio, pressure difference) for a pump (incompressible fluid) or compressor/blower/fan (compressible media)";
