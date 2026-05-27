within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise7MixingPreheater "Exercise 8.7: Steam Power Plant with Feedwater Mixing Preheater [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation(Documentation(info="<html>
  <p>
    This package extend the steam power plant in <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise6SteamPowerPlant\">Exercise6SteamPowerPlant</a> 
    by a mixing preheater. The examples differ by:
    <ul>
      <li>
        The solution method: implicit nonlinear equations (<code>Inversion</code>) vs. <code>pseudoInversion<code> \"controllers\".
      </li>
    </ul>
  </p>
  <p>
    See  <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise7MixingPreheater.Inversion\">Exercise7MixingPreheater.Inversion</a> 
    for the problem description.
  </p>
</html>"));
end Exercise7MixingPreheater;
