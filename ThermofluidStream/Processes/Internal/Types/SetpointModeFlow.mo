within ThermofluidStream.Processes.Internal.Types;
type SetpointModeFlow = enumeration(
    m_flow "Mass flow rate",
    V_flow "Volume flow rate")
  "Setpoint mode (mass flow rate, volume flow rate) for a pump (incompressible fluid) or compressor/blower/fan (compressible media)";
