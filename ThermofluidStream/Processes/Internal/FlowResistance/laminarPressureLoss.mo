within ThermofluidStream.Processes.Internal.FlowResistance;
function laminarPressureLoss "Laminar pressure loss function (Hagen-Poiseuille)"
  extends Internal.FlowResistance.partialPressureLoss;

  import Modelica.Constants.pi;

algorithm
  pressureLoss := m_flow * (8*mu*l)/(pi*rho*r^4);

  annotation (Documentation(info="<html>
<p>
Pressure loss after Hagen-Poiseuille:
</p>
<blockquote><pre>
pressureLoss := m_flow * (8*mu*l)/(pi*rho*r^4);
</pre></blockquote>
</html>"));
end laminarPressureLoss;
