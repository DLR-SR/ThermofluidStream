within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
package Exercise2NuclearReactor "Exercise 8.2: Nuclear Reactor [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
  <p>
    This Test package contains 3 sequences of steps for constructing a nuclear reactor.
  </p>
  
  <ul>
    <li>
      <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Adiabatic\">Exercise2NuclearReactor.Adiabatic</a> uses the 
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> model and the 
      <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model.
    </li>
    <li>
      <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.AdiabaticPseudoInversion\">Exercise2NuclearReactor.AdiabaticPseudoInversion</a> uses the 
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> model and avoids the use of the 
      <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model using <code>pseudoInversion</code> \"controllers\".
    </li>
    <li>
      <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Polytropic\">Exercise2NuclearReactor.Polytropic</a> uses the 
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> model which requires less use of the 
      <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model.
    </li>
  </ul>

  <h4>English problem description</h4>
  
  <p>
    A closed-cycle gas turbine process is used to cool a high-temperature reactor. 
    <a href=\"modelica://ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He\">Helium</a>   
    (ideal gas, <code>R = 2077.3 J/(kg·K)</code>, <code>gamma = 1.66</code>) starting from
    <code>780 K</code>, <code>70.0 bar</code> is heated isobarically by the <code>reactor</code> waste 
    heat of <code>6.00 MW</code> up to a temperature of <code>1180 K</code>.
  </p>

  <p>
    The helium then expands in the adiabatic <code>turbine1</code> (<code>eta_is = 0.94</code>) 
    to <code>1110 K</code>, followed by expansion in the adiabatic <code>turbine2</code> 
    to <code>52.4 bar</code>, <code>1060 K</code>, and finally expansion in the diabatic
    <code>turbine3</code> to <code>844.5 K</code>. 
  </p>

  <p>
   <code>turbine1</code> drives <code>compressor1</code> and <code>turbine2</code> drives <code>compressor2</code> via shafts, 
   while <code>turbine3</code> drives the <code>generator</code> (<code>3015 kW</code>). All three shafts operate with a mechanical efficiency 
   of <code>eta = 0.95</code>.
  </p>

  <p>
    In the isobaric, externally adiabatic heat exchanger (<code>heatExchangerHotSide</code>) and in the isobaric <code>cooler2</code>, the helium is cooled
    to <code>285 K</code>. In the adiabatic <code>compressore2</code> it is first compressored and in the <code>compressor1</code> again compressred to <code>70.0 bar</code>, <code>376 K</code> 
    (<code>eta_is = 0.96</code>) before being heated in <code>heatExchangerColdSide</code>.
  </p>

  <div>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactorA.svg\">
  </div>

  <div>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactorL1.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactorL2.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactorL3.svg\">
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactorL4.svg\">
  </div>

</html>"));
end Exercise2NuclearReactor;
