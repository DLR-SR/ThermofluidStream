within ThermofluidStream.Processes.Internal.FlowResistance;
function linearQuadraticPressureLoss "Linear-quadratic pressure loss function"
  extends Internal.FlowResistance.partialPressureLoss;

  input Real k(unit="Pa.s/kg") = 0 "Linear resistance coefficient"
    annotation(Dialog(enable=true));
  input Real k2(unit="(Pa.s.s)/(kg.kg)") = 0 "Quadratic resistance coefficient"
    annotation(Dialog(enable=true));

algorithm
  pressureLoss :=k*m_flow + k2*m_flow*abs(m_flow);

  annotation (Documentation(info="<html>
<p>
This pressure loss is linear-quadratic in the massflow with the linear factor k 
and the quadratic factor k2: 
</p>
<blockquote><pre>
dp := k*m_flow + k2*m_flow*abs(m_flow);
</pre></blockquote>
<p>
For a pure linear pressure loss choose k2&nbsp;=&nbsp;0;
for a pure quadratic loss choose k=0.
</p>
</html>"));
end linearQuadraticPressureLoss;
