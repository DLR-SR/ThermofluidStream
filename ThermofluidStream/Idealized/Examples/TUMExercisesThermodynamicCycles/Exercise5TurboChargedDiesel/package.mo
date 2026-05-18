within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise5TurboChargedDiesel "Exercise 8.5: Turbocharged Diesel Engine [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation(Documentation(info="<html>
  <p>
    This package contains examples of a turbocharged diesel engine cycle.
  </p>

  <p>
    The examples use the <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a> medium
      model (perfect gas with constant <code>cp</code>) and the process model
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a>.
      They differ by the system specification (<code>Cycle</code> and <code>Flow</code>) and by the solution method: implicit nonlinear equations vs. <code>pseudoInversion<code> \"controllers\".
    </li>
  </p>

  <p>
    See <a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDiesel.PolytropicCycle\">Exercise5TurboChargedDiesel.PolytropicCycle</a> 
    for the problem description.
  </p>
</html>"));
end Exercise5TurboChargedDiesel;
