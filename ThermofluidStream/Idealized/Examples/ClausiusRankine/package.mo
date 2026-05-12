within ThermofluidStream.Idealized.Examples;
package ClausiusRankine "Clausius Rancine Cycle using idealized state change components"
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
    This example illustrates, step by step, how the Clausius–Rankine cycle can be modeled using idealized state-change components, 
    specifically <code>adiabatic</code> and </code>isobaric</code> processes.
  </p>

  <p>
    The Clausius–Rankine cycle is a fundamental thermodynamic cycle that represents the operation of steam power plants. 
    It is widely applied in thermal power generation due to its efficiency, reliability, and suitability for large-scale energy production. 
    The cycle converts heat into mechanical work using a working fluid, typically water or steam, which undergoes four principal processes:
  </p>

  <ul>
    <li>Compression in a <code>pump</code>: adiabatic process with isentropic efficiency</li>
    <li>Heating and vaporization in a <code>steamGenerator</code> (<code>preheater</code>, <code>boiler</code>, <code>superheater</code>): isobaric process</li>
    <li>Expansion through a <code>turbine</code> to generate work: adiabatic process with isentropic efficiency</li>
    <li>Condensation in a <code>condenser</code>: isobaric process</li>
  </ul>

  <p>
    If the mass flow rate setpoint is non differentiable <code>considerInertance = false</code> is required, see 
    <a href=\"modelica://ThermofluidStream.Idealized.UsersGuide.InertanceNeglect\">UsersGuide.InertanceNeglect</a>.
  </p>
</html>"));
end ClausiusRankine;
