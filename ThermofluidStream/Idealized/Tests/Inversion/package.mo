within ThermofluidStream.Idealized.Tests;
package Inversion
  extends Modelica.Icons.ExamplesPackage;

  annotation(Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    This package contains examples of model inversion problems, i.e., determining the appropriate value of an input variable <code>X</code>
    such that a desired output <code>Y</code> is obtained.
  </p>

  <ul>
    <li>
      <a href=\"modelica://ThermofluidStream.Idealized.Tests.Inversion.Inversion1\">Inversion1</a> and
      <a href=\"modelica://ThermofluidStream.Idealized.Tests.Inversion.PseudoInversion1\">PseudoInversion1</a>
      demonstrate two alternative solution strategies:
      a full inversion approach, which relies on a nonlinear equation solver to iteratively solve the system equations,
      and a pseudo-inversion approach, which exploits the time integrator together with a feedback loop to resolve the nonlinear relation.
      Both approaches are illustrated using a simple mixing problem.
    </li>

    <li>
      <a href=\"modelica://ThermofluidStream.Idealized.Tests.Inversion.Inversion2\">Inversion2</a>
      applies the same methodology as <code>Inversion1</code>, but uses a different iteration variable.
    </li>

    <li>
      <a href=\"modelica://ThermofluidStream.Idealized.Tests.Inversion.MediumInversion\">MediumInversion</a>
      uses Modelica’s equation-based formulation to determine temperature and pressure from a given specific entropy
      and specific enthalpy. This results in two nonlinear equation systems of size one, which are solved by Dymola
      using a nonlinear solver.
    </li>
  </ul>

  <p>
    The models
    <a href=\"modelica://ThermofluidStream.Idealized.Tests.Inversion.Inversion1\">Inversion1</a>,
    <a href=\"modelica://ThermofluidStream.Idealized.Tests.Inversion.Inversion2\">Inversion2</a>, and
    <a href=\"modelica://ThermofluidStream.Idealized.Tests.Inversion.PseudoInversion1\">PseudoInversion1</a>
    all extend the common base model
    <a href=\"modelica://ThermofluidStream.Idealized.Tests.Inversion.BaseClasses.PartialInverse\">PartialInverse</a>
    located in the <code>BaseClasses</code> subpackage, which defines the underlying mixing problem.
  </p>
</html>"));
end Inversion;
