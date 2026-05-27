within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise2NuclearReactor "Exercise 8.2: Nuclear Reactor [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
  <p>
    This Test package contains 3 sequences of steps for constructing a nuclear reactor.
  </p>
  
  <ul>
    <li>
      <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Adiabatic\">Exercise2NuclearReactor.Adiabatic</a> uses the 
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> model and the 
      <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model.
    </li>
    <li>
      <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.AdiabaticPseudoInversion\">Exercise2NuclearReactor.AdiabaticPseudoInversion</a> uses the 
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> model and avoids the use of the 
      <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model using <code>pseudoInversion</code> \"controllers\".
    </li>
    <li>
      <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Polytropic\">Exercise2NuclearReactor.Polytropic</a> uses the 
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> model which requires less use of the 
      <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model.
    </li>
  </ul>

  <p>
    See <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Adiabatic\">Exercise2NuclearReactor.Adiabatic</a> for the problem description.
  </p>
</html>"));
end Exercise2NuclearReactor;
