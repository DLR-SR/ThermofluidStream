within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise5TurboChargedDieselEngine "Exercise 8.5: Turbocharged Diesel Engine [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation(
    Documentation(
      info="<html>
  <p>
    This package contains examples of a turbocharged diesel engine cycle.
  </p>

  <p>
    The examples use the <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a> medium
    model (perfect gas with constant <code>cp</code>) and the process model
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a>.
    They differ by the system specification (<code>Cycle</code> and <code>Flow</code>) and by the solution method: implicit nonlinear equations vs. <code>pseudoInversion</code> \"controllers\".
  </p>

  <h4>English problem description</h4>
  
  <p>
    A stationary flow process with a diesel engine operating at a rotational speed of 
    <code>n = 2000 rpm</code> is considered. The four-stroke engine with <code>z = 6</code> cylinders 
    is equipped with a turbocharger and intercooler to increase power output.
  </p>
    
  <p>
    Ambient air  at state <code>1</code> 
    (<code>300 K</code>, <code>1.00 bar</code>) is compressed in the reversible adiabatic 
    <code>compressor</code> to <code>1.23 bar</code>, and then cooled isobarically in the 
    <code>cooler</code> to <code>300 K</code>.
  </p>

  <p>
    In the engine block, the air undergoes an idealized Diesel process: starting from the bottom dead 
    center of the piston, it is first compressed isentropically to <code>80.62 bar</code> (<code>engineCompression</code>), 
    then heated isobarically to <code>1700 K</code> (<code>combustion</code>), and finally expanded isentropically back 
    to the bottom dead center (<code>engineExpansion</code>, state <code>6</code>). The maximum volume of a single cylinder at the bottom dead 
    center is <code>2500 cm3</code>.
  </p>

  <p>
    The exhaust gas from the diesel engine is throttled in the adiabatic <code>valve</code> and expanded in the adiabatic, frictional <code>turbine</code> to ambient 
    pressure. The turbine delivers its power completely to 
    the compressor via a lossless shaft.
  </p>

  <div>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDieselA.svg\">
  </div>

  <div>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDieselL1.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDieselL2.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDieselL3.svg\">
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
end Exercise5TurboChargedDieselEngine;
