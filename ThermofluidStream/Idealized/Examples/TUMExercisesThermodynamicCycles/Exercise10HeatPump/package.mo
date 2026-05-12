within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise10HeatPump "Exercise 8.10: Heat pump [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
  <p>
    This package contains examples of a two-stage vapor-compression heat pump with an intermediate-pressure flash chamber to heat a residential building.
    The setups of the examples are identical. The examples differ by:
    <ul>
      <li>
        The solution method: implicit equation for mass flow rate <code>Inversion</code>, requiring (<code>neglectInertance = true</code>) vs. <code>pseudoInversion</code> 
        \"controllers\".
      </li>
    </ul>
  </p>
  <p>
    See  <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise10HeatPump.Inversion\">Exercise10HeatPump.Inversion</a> 
    for the problem description.
  </p>
</html>"));
end Exercise10HeatPump;
