within ThermofluidStream.Idealized.Examples;
package JouleBrayton "Joule Brayton Cycle using idealized state change components"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    This example package illustrates, step by step, several configurations of the Joule cycle that can be modeled using idealized
    state-change components, in particular <code>adiabatic</code> and <code>isobaric</code> processes.
  </p>

  <p>
    The Joule (Brayton) cycle is a thermodynamic cycle describing the operation of gas-turbine systems.
    It is widely applied in jet engines and modern gas-turbine power plants due to its high power-to-weight
    ratio and continuous combustion process. The cycle employs a working fluid, typically air, which passes
    through four fundamental processes:
  </p>

  <ul>
    <li>Compression in a <code>compressor</code>: adiabatic process with isentropic efficiency</li>
    <li>Heat addition at elevated pressure in a combustor or heat exchanger: isobaric process</li>
    <li>Expansion in a <code>turbine</code> to generate work: adiabatic process with isentropic efficiency</li>
    <li>Heat rejection to the surroundings: isobaric process, artificially closing the loop through the environment</li>
  </ul>
</html>"));
end JouleBrayton;
