within ThermofluidStream.Processes.Internal.FlowResistance;
function zetaPressureLoss "Pressure loss function based on zeta value"
  extends Internal.FlowResistance.partialPressureLoss;

  input Real zeta( unit = "1") "Zeta value of component"
    annotation(Dialog(enable=true));

  input Boolean fromGeometry = true "Calculate reference area from geometry inputs?" annotation(Dialog(enable = true));
  input SI.Area A = Modelica.Constants.pi*r*r "Custom reference area for dp calculation" annotation(Dialog(enable = not fromGeometry));

protected
  SI.Area A_zeta "Reference area either from radius or set by parameter";

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
the zeta value is often given in the data sheet.
</p>
<p>
Together with a given (or calculated) reference area&nbsp;A, the pressure
drop can be calculated:
</p>
<blockquote><pre>
dp := zeta/(2*rho) * m_flow^2/A^2
</pre></blockquote>
<p>
The square of the mass-flow is regularized using the
<a href=\"Modelica.Fluid.Utilities.regSquare\">Modelica.Fluid.Utilities.regSquare</a>
function.
</p>
</html>"));
end zetaPressureLoss;
