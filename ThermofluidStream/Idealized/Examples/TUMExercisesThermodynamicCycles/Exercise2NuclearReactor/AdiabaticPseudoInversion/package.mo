within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor;
package AdiabaticPseudoInversion "Exercise 8.2: Nuclear Reactor [TUM2019]"
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
    This example package contains a sequence of steps for constructing a nuclear reactor. The setup of this example is identical to
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Adiabatic\">Exercise2NuclearReactor.Adiabatic</a> (see for problem description).
  </p>
  <p>
    The final example model is provided in <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.AdiabaticPseudoInversion.Step9FinalResults\">Exercise2NuclearReactor.AdiabaticPseudoInversion.Step9FinalResults</a>.
  </p>  
  <p>
    This example package makes extensive use of <code>pseudoInversion</code> \"controllers\" to determine the solution.
  </p>
  <p>
    In contrast, in the package <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Adiabatic\">Exercise2NuclearReactor.Adiabatic</a>
    the same example nuclear reactor is solved with the <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model
    resulting in implicit nonlinear equations. These equations require suitable start values to be solvable.
    Note that also the time integration algorithm requires suitable start values and is also likely to be implicit and will likely solve implicit nonlinear equations aswell.
  </p>
</html>"));
end AdiabaticPseudoInversion;
