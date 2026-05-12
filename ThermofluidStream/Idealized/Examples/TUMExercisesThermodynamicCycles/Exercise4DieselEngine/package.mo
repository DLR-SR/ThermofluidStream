within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise4DieselEngine "Exercise 8.4: Diesel Engine [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
  <p>
    This example package illustrates stationary-flow representations of closed-system Diesel
    (<code>s, p, s, v</code>) engine processes.
    Here, <code>s</code> denotes an isentropic process (or more general an adiabatic process with isentropic efficiency),
    <code>v</code> denotes an isochoric process (constant specific volume/density),
    and <code>p</code> denotes an isobaric process.
    <br>
    The examples differ with respect to the following aspects:
  </p>

  <ul>
    <li>
      The medium model:
      the
      <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a> medium
      (perfect gas with constant <code>cp</code>) versus the
      <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.DryAirNasa\">DryAirNasa</a> medium
      (ideal gas with temperature-dependent <code>cp</code>).
      For <code>SimpleAir</code>, the
      <a href=\"modelica://ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas\">PerfectGas</a>
      or
      <a href=\"modelica://ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IdealGasConstantGamma\">IdealGas</a>
      <code>ThermodynamicModel</code> have to be used.
      For <code>DryAirNasa</code>, the
      <a href=\"modelica://ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium\">Universal</a>
      <code>ThermodynamicModel</code> is recommended.
    </li>

  </ul>

  <p>
    See  <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise4DieselEngine.SimpleAir\">Exercise4DieselEngine.SimpleAir</a> 
    for the problem description.
  </p>
</html>"));
end Exercise4DieselEngine;
