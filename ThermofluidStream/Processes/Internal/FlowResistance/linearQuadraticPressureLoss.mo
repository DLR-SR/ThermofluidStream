within ThermofluidStream.Processes.Internal.FlowResistance;
function linearQuadraticPressureLoss
  "Linear-quadratic pressure loss function"
  extends Internal.FlowResistance.partialPressureLoss;

  parameter Real k(unit="Pa.s/kg") = 0 "Linear resitance coefficient";
  parameter Real k2(unit="(Pa.s.s)/(kg.kg)") = 0 "Quadratic resitance coefficient";

algorithm
  pressureLoss :=k*m_flow + k2*m_flow*abs(m_flow);

  annotation (Documentation(info="<html>
<p>This pressure loss is linear-quadratic in the massflow with the linear factor k and the quadratic factor k2: </p>
<p><span style=\"font-family: Courier New;\">dp :=k*m_flow&nbsp;+&nbsp;k2*m_flow*<span style=\"color: #ff0000;\">abs</span>(m_flow);</p>
<p><span style=\"font-family: Courier New;\">for a pure linear pressure loss choose k2=0; for a pure quadratic loss choose k=0.</span></p>
</html>"));
end linearQuadraticPressureLoss;
