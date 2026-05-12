within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise8TwoStageRefrigerationCycle "Exercise 8.8: Two-Stage Refrigeration Cycle [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation(Documentation(info="<html>
  <p>
    This package contains examples of a two stage vapor cycle.
    The setups of the examples are identical. The examples differ by:
    <ul>
      <li>
        The solution method: implicit equation for mass flow rate, requiring (<code>NeglectInertance</code>) vs. pseudo \"controllers\" also working with <code>Inertance</code>.
      </li>
    </ul>
  </p>
  <p>
    See  <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise8TwoStageRefrigerationCycle.NeglectInertance\">Exercise8TwoStageRefrigerationCycle.NeglectInertance</a> 
    for the problem description.
  </p>
</html>"));
end Exercise8TwoStageRefrigerationCycle;
