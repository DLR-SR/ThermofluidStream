within ThermofluidStream.FlowControl.Internal.Types;
type FlowCoefficientTypesBasic = enumeration(
    Kvs "Kvs (metric)",
    Cvs_US "Cvs (US)",
    Cvs_UK "Cvs (UK, deprecated; use Kvs or Cvs_US instead; scheduled for removal in TFS 2.0)",
    m_flow_set "Reference mass flow");
