within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor;
package Adiabatic "Exercise 8.2: Nuclear Reactor [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation(Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    This test package contains a sequence of steps for constructing a nuclear reactor.
  </p>
  
  <p>
    The final test model is provided in <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Adiabatic.Step9FinalResults\">Exercise2NuclearReactor.Adiabatic.Step9FinalResults</a>.
  </p>
   
  <p>
    This test package makes extensive use of the 
    <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model
    resulting in implicit nonlinear equations. These equations require suitable start values to be solvable.
  </p>

  <p>
    In <code>Dymola 2026x Refresh 1</code> the nonlinear solver always converges. In older Dymola versions (and potentially in OpenModelica) the nonlinear solver may only converge for <code>considerInertance = false</code> .
  </p>
  
  <p>
    In contrast, in the package <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.AdiabaticPseudoInversion\">Exercise2NuclearReactor.AdiabaticPseudoInversion</a>
    the same example nuclear reactor is solved with <code>pseudoInversion</code> \"controllers\". With this the implicit nonlinear equations can be \"avoided\". 
    Note that the introducted states also require suitable start values. Furthermore the time integration algorithm is also likely to be implicit and will likely solve implicit nonlinear equations aswell.
  </p>
  
  <h4>Problem description</h4>
  
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
</html>"));
end Adiabatic;
