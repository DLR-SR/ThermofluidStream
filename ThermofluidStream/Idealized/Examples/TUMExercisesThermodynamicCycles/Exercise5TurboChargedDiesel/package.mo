within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise5TurboChargedDiesel "Exercise 8.5: Turbocharged Diesel Engine [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
  <p>
    This package contains examples of a turbocharged diesel engine cycle. The setups of the examples are identical. The examples differ by:
  </p>

  <ul>
    <li>
      The medium model: 
      <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a> medium
      (perfect gas with constant <code>cp</code>) vs. 
      <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.DryAirNasa\">DryAirNasa</a> medium
      (ideal gas with temperature-dependent <code>cp</code>).
    </li>
    <li>
      The solution method: implicit nonlinear equations vs. <code>pseudoInversion<code> \"controllers\".
    </li>
  </ul>
  
  <p>
    See  <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDiesel.SimpleAir\">Exercise5TurboChargedDiesel.SimpleAir</a> 
    for the problem description.
  </p>
</html>"));
end Exercise5TurboChargedDiesel;
