within ThermofluidStream.Idealized.Examples;
package AirCycle
  extends Modelica.Icons.ExamplesPackage;

  annotation(
    Documentation(
      info="<html>
  <p>
    This example package illustrates, step by step, several configurations of an air-cycle refrigeration system
    based on the reverse Joule–Brayton cycle, as commonly used in aircraft Environmental Control Systems (ECS).
    The models are built using idealized state-change components, in particular <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a>
    and <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isobaric\">Isobaric</a> processes. The cycle consists of four fundamental processes through which the working fluid (air) passes:
  </p>

  <ul>
    <li>Compression in a <code>compressor</code>: adiabatic process with a specified isentropic efficiency</li>
    <li>Heat rejection in a heat exchanger: isobaric cooling process</li>
    <li>Expansion in a <code>turbine</code> to produce work: adiabatic process with a specified isentropic efficiency</li>
    <li>Heat supply from the environment: isobaric heating process, artificially closing the thermodynamic loop</li>
  </ul>
</html>",
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end AirCycle;
