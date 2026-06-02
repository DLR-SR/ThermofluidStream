within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise7MixingPreheater "Exercise 8.7: Steam Power Plant with Feedwater Mixing Preheater [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation(Documentation(info="<html>
  <p>
    This package extend the steam power plant in <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise6SteamPowerPlant\">Exercise6SteamPowerPlant</a> 
    by a mixing preheater. The examples differ by:
  </p>

  <ul>
    <li>
      The solution method: implicit nonlinear equations (<code>Inversion</code>) vs. <code>pseudoInversion</code> \"controllers\".
    </li>
  </ul>
  
  <h4>English problem description</h4>

  <p>
    A small increase in the efficiency of a stationary steam power plant (compared to example 6) is achieved by installing a 
    mixing preheater. Saturated liquid water at state 1 (<code>50.0 mbar</code>, <code>32.90 °C</code>) 
    is pumped by the reversible adiabatic feedwater <code>lowPressurePump</code> to <code>10.0 bar</code>.
  </p>

  <p>
    In the isobaric, externally adiabatic <code>mixingPreheater</code>, a portion of the mass flow (state <code>7</code>)
    from the process steam extracted from the turbine is mixed with the water 
    from state <code>2</code>. This results in a feedwater temperature of <code>T3 = 130 degC</code>. The reversible adiabatic 
    feedwater <code>highPressurePump</code> then raises the water pressure to <code>20.0 bar</code>.
  </p>

  <p>
    In the isobaric <code>heater</code>, the water is heated, vaporized and superheated (<code>288 MW</code>) to <code>540 degC</code>.
  </p>

  <p>
    In the steam turbine (isentropic efficiency <code>eta_is = 0.889</code>), after the first turbine stage 
    (<code>highPressureTurbineStage</code>, <code>10.0 bar</code>), a portion of the steam (state <code>7</code>) is extracted and fed to the 
    <code>mixingPreheater</code>. The remaining steam in the turbine is further expanded 
    (<code>lowPressureTurbineStage</code>, <code>50.0 mbar</code>), condensed in the isobaric <code>condenser</code> and returned to the <code>lowPressurePump</code>, closing the cycle.
  </p>

  <div>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise7MixingPreheaterA.svg\">
  </div>

  <div>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise7MixingPreheaterL1.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise7MixingPreheaterL2.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise7MixingPreheaterL3.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise7MixingPreheaterL4.svg\">
  </div>

</html>"));
end Exercise7MixingPreheater;
