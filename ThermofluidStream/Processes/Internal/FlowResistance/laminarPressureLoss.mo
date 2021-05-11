within ThermofluidStream.Processes.Internal.FlowResistance;
function laminarPressureLoss
  "Laminar flow loss function"
  extends Internal.FlowResistance.partialPressureLoss;

  import Modelica.Constants.pi;

algorithm
  pressureLoss := m_flow * (8*mu*l)/(pi*rho*r^4);

  annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">Pressure loss after Hagen-Poiseuille:</span></p>
<p><span style=\"font-family: Courier New;\">pressureLoss&nbsp;:=&nbsp;m_flow&nbsp;*&nbsp;(8*mu*l)/(pi*rho*r^4);</span></p>
</html>"));
end laminarPressureLoss;
