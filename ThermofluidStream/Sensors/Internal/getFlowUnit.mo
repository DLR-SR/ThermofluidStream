within ThermofluidStream.Sensors.Internal;
function getFlowUnit "Returns unit of input flow-quantity"
  extends Modelica.Icons.Function;

  input Types.MassFlowQuantities quantity;
  output String unit;

algorithm
  if quantity == Types.MassFlowQuantities.Cp_flow_JpKs then
    unit :="W/K";
  elseif quantity == Types.MassFlowQuantities.H_flow_Jps then
    unit :="W";
  elseif quantity == Types.MassFlowQuantities.H_flow_kW then
    unit :="kW";
  elseif quantity == Types.MassFlowQuantities.H_flow_MW then
    unit :="MW";
  elseif quantity == Types.MassFlowQuantities.m_flow_kgps then
    unit :="kg/s";
  elseif quantity == Types.MassFlowQuantities.V_flow_m3ps then
    unit :="m3/s";
  elseif quantity == Types.MassFlowQuantities.V_flow_lpMin then
    unit :="l/min";
  elseif quantity == Types.MassFlowQuantities.S_flow_JpKs then
    unit := "W/K";
  elseif quantity == Types.MassFlowQuantities.S_flow_kWpK then
    unit :="kW/K";
  elseif quantity == Types.MassFlowQuantities.S_flow_MWpK then
    unit :="MW/K";
  else
    unit :="";
  end if;

  annotation (Documentation(info="<html>
<p>Helper function to get the unit for a quantity.</p>
</html>"));
end getFlowUnit;
