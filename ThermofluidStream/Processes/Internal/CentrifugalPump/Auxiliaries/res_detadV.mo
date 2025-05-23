within ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries;
function res_detadV "Residuum of derivative of efficiency with respect to volume flow rate"
  extends Modelica.Icons.Function;
  input Real ch[3] "Coefficients of head polynomial";
  input Real cp[3] "Coefficients of power polynomial";
  input Real Vn "Normalized volume flow rate";
  output Real res "Residuum";
protected
  Real N = (ch[1] + ch[2]*Vn + ch[3]*Vn^2)*Vn "Numerator";
  Real dN = ch[1] + 2*ch[2]*Vn + 3*ch[3]*Vn^2 "Derivative of numerator with respect to Vn (normalized flow)";
  Real D = cp[1] + cp[2]*Vn + cp[3]*Vn^2 "Denominator";
  Real dD = cp[2] + 2*cp[3]*Vn "Derivative of denominator with respect to Vn (normalized flow)";
algorithm
  res := D*dN - N*dD;
  // eta = rho*g*h*V/P = eta_ref*(ch[1] + ch[2]*Vn + ch[3]*Vn^2)*Vn/(cp[1] + cp[2]*Vn + cp[3]*Vn^2) (@ w = w_ref, rho = rho_ref)
  // eta = N/D (numerator/denominator)
  // -> deta/dVn = 0 -> D*dN - N*dD = 0
  annotation (Documentation(info="<html>
<p>
Used to determine the normalized flow rate <code>V_n</code> at peak efficiency <code>eta</code>.<br>
It is used in the function <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.internalCoefficientsFromMeasurements\">internalCoefficientsFromMeasurements</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
end res_detadV;
