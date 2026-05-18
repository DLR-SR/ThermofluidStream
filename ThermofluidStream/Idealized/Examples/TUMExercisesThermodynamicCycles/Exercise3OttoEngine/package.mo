within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise3OttoEngine "Exercise 8.3: Otto Engine [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation(Documentation(info="<html>
  <p>
    This example package illustrates stationary-flow representations of closed-system Otto
    (<code>s, v, s, v</code>) engine processes.
    Here, <code>s</code> denotes an isentropic process (or more general an adiabatic process with isentropic efficiency) and
    <code>v</code> denotes an isochoric process (constant specific volume/density).<br>
    The examples differ with respect to the following aspects:
  </p>

  <ul>
    <li>
      The process model:
      the <a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> process model allows to set the outlet density, while the
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> process model only allows to set the outlet pressure.
    </li>

    <li>
      The medium model:
      the
      <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a> medium
      (perfect gas with constant <code>cp</code>) versus the
      <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.DryAirNasa\">DryAirNasa</a> medium
      (ideal gas with temperature-dependent <code>cp</code>).
    </li>
  </ul>

  <p>
    See <a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine.PolytropicCycle\">Exercise3OttoEngine.PolytropicCycle</a> 
    for the problem description.
  </p>
</html>"));
end Exercise3OttoEngine;
