within ThermofluidStream.Processes.Compressors.Internal.Types;
type CompressorSetpointModePressure = enumeration(
    dp "Pressure difference",
    pr "Pressure ratio",
    p_out "Outlet pressure") "Setpoint mode (pressure, pressure ratio, pressure difference) for controlled compressor";
