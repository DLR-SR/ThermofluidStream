within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise4DieselEngine "Exercise 8.4: Diesel Engine [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation(
    Documentation(
      info="<html>
  <p>
    This example package illustrates stationary-flow representations of closed-system Diesel
    (<code>s, p, s, v</code>) engine processes.
    Here, <code>s</code> denotes an isentropic process (or more general an adiabatic process with isentropic efficiency),
    <code>v</code> denotes an isochoric process (constant specific volume/density),
    and <code>p</code> denotes an isobaric process.
  </p>
  
  <p>
    The examples use the <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a> medium
    model (perfect gas with constant <code>cp</code>) and differ with respect to the process model:
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> (<code>systemSpec = Cycle</code> and <code>systemSpec = Flow</code>) and
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a>.
  </p>

 <h4>English problem description</h4>

  <p>
    A four-stroke Diesel engine can be idealized using the following cycle:
  </p>

  <ul>
    <li><code>1 &rarr; 2</code>: Isentropic compression (T1 = 300 K, p1 = 1.00 bar, compression ratio &phi; = 23.0)</li>
    <li><code>2 &rarr; 3</code>: Isobaric heat addition (combustion, T3 = 1700 K)</li>
    <li><code>3 &rarr; 4</code>: Isentropic expansion (V4 = V1)</li>
    <li><code>4 &rarr; 1</code>: Isochoric heat rejection (in reality achieved via gas exchange of the displaced volume)</li>
  </ul>

  <p>
    For the entire cycle, air properties can be used, assuming an ideal gas with 
    <code>R = 287 J/kg·K</code> and <code>&gamma; = 1.40</code>.
  </p>

  <div>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise4DieselEngineA.svg\">
  </div>

  <div>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise4DieselEngineL1.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise4DieselEngineL2.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise4DieselEngineL3.svg\">
  </div>

</html>",
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Exercise4DieselEngine;
