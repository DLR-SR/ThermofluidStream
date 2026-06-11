within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor;
package Adiabatic "Exercise 8.2: Nuclear Reactor [TUM2019]"
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
    This example package contains a sequence of steps for constructing a nuclear reactor. See <a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor\">TUMExercisesThermodynamicCycles.Exercise2NuclearReactor</a> 
    for the problem description.
  </p>

  <p>
    The final example model is provided in <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Adiabatic.Step9FinalResults\">Exercise2NuclearReactor.Adiabatic.Step9FinalResults</a>.
  </p>
   
  <p>
    This example package makes extensive use of the 
    <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model
    resulting in implicit nonlinear equations. These equations require suitable start values to be solvable.
  </p>

  <p>
    In <code>Dymola 2026x Refresh 1</code> the nonlinear solver always converges. In older Dymola versions (and potentially in OpenModelica) the nonlinear solver may only converge for <code>considerInertance = false</code> .
  </p>
  
  <p>
    In contrast, in the package <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.AdiabaticPseudoInversion\">Exercise2NuclearReactor.AdiabaticPseudoInversion</a>
    the same example nuclear reactor is solved with <code>pseudoInversion</code> \"controllers\". With this the implicit nonlinear equations can be \"avoided\". 
    Note that the introducted states also require suitable start values. Furthermore the time integration algorithm is also likely to be implicit and will likely solve implicit nonlinear equations aswell.
  </p>
  
  
</html>"));
end Adiabatic;
