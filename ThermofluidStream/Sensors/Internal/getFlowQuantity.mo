within ThermofluidStream.Sensors.Internal;
function getFlowQuantity "Computes selected quantity from state and massflow"
  extends Modelica.Icons.Function;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
      <p>Medium Model for the function. Make sure it implements the needed functions.</p>
        </html>"));

  input Medium.ThermodynamicState state;
  input SI.MassFlowRate m_flow;
  input Types.MassFlowQuantities quantity;
  input SI.Density rho_min;
  output Real value;

protected
  Real m3ps_to_lpMin(unit="(l.s)/(m3.min)") = 60000;

algorithm
  if quantity == Types.MassFlowQuantities.Cp_flow_JpKs then
    value := m_flow * Medium.specificHeatCapacityCp(state);
  elseif quantity == Types.MassFlowQuantities.H_flow_Jps then
    value := m_flow * Medium.specificEnthalpy(state);
  elseif quantity == Types.MassFlowQuantities.m_flow_kgps then
    value := m_flow;
  elseif quantity == Types.MassFlowQuantities.m_flow_gps then
    value := m_flow*1000;
  elseif quantity == Types.MassFlowQuantities.V_flow_m3ps then
    value := m_flow / max(rho_min, Medium.density(state));
  elseif quantity == Types.MassFlowQuantities.V_flow_lpMin then
    value := m_flow / max(rho_min, Medium.density(state))*m3ps_to_lpMin;
  elseif quantity == Types.MassFlowQuantities.S_flow_JpKs then
    value := m_flow * Medium.specificEntropy(state);
  else
    value :=0;
  end if;

  annotation (Documentation(info="<html>
<p>Helper function to get a quantity from an Thermofluid state.</p>
</html>"));
end getFlowQuantity;
