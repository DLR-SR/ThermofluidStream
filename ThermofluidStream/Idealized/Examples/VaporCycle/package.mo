within ThermofluidStream.Idealized.Examples;
package VaporCycle
  extends Modelica.Icons.ExamplesPackage;

  annotation(
    Documentation(
      info="<html>
  <p>
    This example package illustrates, step by step, several configurations of a vapor compression cycle,
    based on the reverse Clausius–Rankine cycle, as commonly used in air conditioning systems.
    The models are constructed using idealized state-change components, specifically 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a>,
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isobaric\">Isobaric</a> and
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isenthalpic\">Isenthalpic</a>
    processes. 
    The cycle comprises four fundamental processes through which the working fluid (refrigerant) passes:
  </p>

  <ul>
    <li>Compression in a <code>compressor</code>: adiabatic process with a specified isentropic efficiency</li>
    <li>Condensation in a heat exchanger: isobaric cooling process</li>
    <li>Expansion in a <code>valve</code>: isenthalpic process</li>
    <li>Evaporation in a heat exchanger: isobaric heating process, closing the thermodynamic loop</li>
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
end VaporCycle;
