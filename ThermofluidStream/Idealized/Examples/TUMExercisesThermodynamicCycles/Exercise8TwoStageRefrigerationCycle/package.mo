within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise8TwoStageRefrigerationCycle "Exercise 8.8: Two-Stage Refrigeration Cycle [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;


  annotation(Documentation(info="<html>
  <p>
    This package contains examples of a two stage vapor cycle. The examples differ by:
  </p>
  <ul>
    <li>
      The solution method: Inversion vs. pseudo inversion \"controllers\".
    </li>
  </ul>
  

 <h4>English problem description</h4>

  <p>
    A refrigeration system with two-stage compression operates as follows: The adiabatic <code>lowPressureCompressor</code>
    draws dry saturated vapor (<a href=\"modelica://ThermofluidStream.Media.myMedia.R134a.R134a_ph\">R134a</a>) from the 
    <code>evaporator</code> at <code>1.00 bar</code> and compresses it with an isentropic efficiency 
    of <code>eta_is = 0.900</code> to <code>6.00 bar</code>.
  </p>

  <p>
    The superheated vapor at state <code>2</code> is fed to the intermediate pressure <code>flashChamber</code>. 
    Saturated vapor (state <code>5</code>) is drawn from the <code>flashChamber</code> and compressed in the <code>highPressureCompressor</code> to <code>14.0 bar</code>, 
    reaching a superheated temperature of <code>335 K</code>.
  </p>

  <p>
    After isobaric condensation and subsequent isobaric subcooling to <code>T7 = 300 K</code> in the 
    <code>condenser</code>, the refrigerant is expanded adiabatically in the <code>highPressureValve</code> 
    to the intermediate pressure and returned to the <code>flashChamber</code>.
  </p>

  <p>
    Saturated liquid (state <code>3</code>) is withdrawn from the <code>flashChamber</code>, throttled adiabatically in the <code>lowPressureValve</code> to 
    the evaporator pressure and completely evaporated in the <code>evaporator</code>, closing the loop. 
  </p>
  <p>
    The system is sized to cool <code>75.0 kg</code> (specific heat capacity <code>2 kJ/(kg.K)</code>) in <code>15 min</code> by <code>40 K</code>.
  </p>
  <p>
    The mechanic efficiencies of the compressors are <code>0.95</code>.
  </p>

  <div>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise8TwoStageRefrigerationCycleA.svg\">
  </div>

  <div>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise8TwoStageRefrigerationCycleL1.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise8TwoStageRefrigerationCycleL2.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise8TwoStageRefrigerationCycleL3.svg\">
  </div>
</html>"));
end Exercise8TwoStageRefrigerationCycle;
