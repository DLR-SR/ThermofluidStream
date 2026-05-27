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

  <h4>English problem description</h4>

  <p>
    A four-stroke Otto engine can be represented by the following idealized thermodynamic cycle:
  </p>

  <ul>
    <li><code>1 → 2</code>: Isentropic compression (T1 = 300 K, p1 = 1.00 bar, compression ratio phi = 10.0)</li>
    <li><code>2 → 3</code>: Isochoric heat addition (combustion process, T3 = 2200 K)</li>
    <li><code>3 → 4</code>: Isentropic expansion (with V4 = V1)</li>
    <li><code>4 → 1</code>: Isochoric heat rejection (in practice realized via gas exchange of the displaced volume)</li>
  </ul>

  <div>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngineA.svg\">
  </div>

  <div>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngineL1.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngineL2.svg\">
  </div>

</html>"));
end Exercise3OttoEngine;
