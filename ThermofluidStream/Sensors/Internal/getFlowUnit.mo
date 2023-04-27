within ThermofluidStream.Sensors.Internal;
function getFlowUnit "Returns unit of input flow-quantity"
  extends Modelica.Icons.Function;

  input Types.MassFlowQuantities quantity;
  output String unit;

algorithm
  if quantity == Types.MassFlowQuantities.Cp_flow_JpKs then
    unit :="J/(K.s)";
  elseif quantity == Types.MassFlowQuantities.H_flow_Jps then
    unit :="J/s";
  elseif quantity == Types.MassFlowQuantities.m_flow_kgps then
    unit :="kg/s";
  elseif quantity == Types.MassFlowQuantities.V_flow_m3ps then
    unit :="m3/s";
  elseif quantity == Types.MassFlowQuantities.V_flow_lpMin then
    unit :="l/min";
  elseif quantity == Types.MassFlowQuantities.S_flow_JpKs then
    unit :="J/(K.s)";
  else
    unit :="";
  end if;

  annotation (Documentation(info="<html>
<p>Helper function to get the unit for a quantity.</p>
</html>"));
end getFlowUnit;
