within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor;
package Polytropic "Exercise 8.2: Nuclear Reactor [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(revisions="<html>
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
    The final example model is provided in <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Polytropic.Step9FinalResults\">Exercise2NuclearReactor.Polytropic.Step9FinalResults</a>.
  </p> 
 
  <p>
    This package uses the <a href=\"modelica://ThermoFluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> instead of the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a>. This helps to avoid implicit nonlinear equations, as long as the inlet state is known.
    Since the inlet state of <code>compressor1</code> is unknown, the <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> block is still required.
  </p>

  <p>
    Theoretically <code>neglectInertance = true</code> is not required, in practice the nonlinear solver only converges for <code>neglectInertance = true</code>, see
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Polytropic.Step6Compressor1\">Exercise2NuclearReactor.Polytropic.Step6Compressor1</a>.
  </p>

  <p>
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Polytropic.Step9FinalResultsReversed\">Polytropic.Step9FinalResultsReversed</a>
    shows, that theoretically, the nonlinear equations can be avoided if the flow through <code>compressor1</code> is reversed.
    This however requires to calculate a modified isentropic efficiency, which is impractical, unless <code>eta_is = 1</code>.
  </p>
</html>"));
end Polytropic;
