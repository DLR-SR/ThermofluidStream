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
      The medium model:
      the
      <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a> medium
      (perfect gas with constant <code>cp</code>) versus the
      <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.DryAirNasa\">DryAirNasa</a> medium
      (ideal gas with temperature-dependent <code>cp</code>).
      For <code>SimpleAir</code>, the
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas\">PerfectGas</a>
      or
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IdealGasConstantGamma\">IdealGas</a>
      <code>ThermodynamicModel</code> have to be used.
      For <code>DryAirNasa</code>, the
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium\">Universal</a>
      <code>ThermodynamicModel</code> is recommended.
    </li>

    <li>
      The process model:
      the
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a>
      model uses the outlet pressure as the setpoint, whereas the
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticCycle\">AdiabaticCycle</a>
      model uses the outlet specific volume/density as the setpoint.
      The latter introduces one implicit nonlinear equation and therefore requires suitable start values,
      since the medium function <code>Medium.setState_dsX</code> is not available, in contrast to the medium function <code>Medium.setState_psX</code>.
      Note that the <code>AdiabaticCycle</code> model is, in principle, equivalent to the
      <code>Adiabatic</code> model when using the
      <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a>
      block.
    </li>
  </ul>

  <p>
    See  <a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine.PerfectGasAdiabaticFlow\">Exercise3OttoEngine.SimpleAir1</a> 
    for the problem description.
  </p>
</html>"));
end Exercise3OttoEngine;
