within ThermofluidStream.Processes.Internal.FlowResistance;
function zetaPressureLoss "Pressure loss coefficient function"
  extends Internal.FlowResistance.partialPressureLoss;

  input Real zeta( unit = "1") "Pressure loss coefficient (dp = zeta*rho/2*v^2)"
    annotation(Dialog(enable=true));

  input Boolean fromGeometry = true "= true, if cross-sectional area if calculated from geometry"
    annotation(Dialog(enable = true, group="Cross-sectional area"),Evaluate=true, HideResult=true, choices(checkBox=true));
  input SI.Area A = Modelica.Constants.pi*r*r "Cross-sectional area"
    annotation(Dialog(group="Cross-sectional area", enable = not fromGeometry));

protected
  SI.Area A_zeta "Cross-sectional area";

algorithm
  if fromGeometry then
    A_zeta := Modelica.Constants.pi*r*r;
  else
    A_zeta := A;
  end if;

  pressureLoss := zeta/(2*rho)*Modelica.Fluid.Utilities.regSquare(m_flow/A_zeta);

  annotation (Documentation(info="<html>
<p>
For specific components (armatures, fittings, pipe sections, grids, ...),
the pressure loss coefficient is often given in the data sheet.
</p>
<p>
Together with a given (or calculated) reference area&nbsp;A, the pressure
drop can be calculated:
</p>
<blockquote><pre>
dp := zeta * rho/2 * v^2 = zeta/(2*rho) * m_flow^2/A^2
</pre></blockquote>
<p>
The square of the mass-flow is regularized using the
<a href=\"modelica://Modelica.Fluid.Utilities.regSquare\">Modelica.Fluid.Utilities.regSquare</a>
function.
</p>
</html>"));
end zetaPressureLoss;
