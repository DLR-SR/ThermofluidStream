within ThermofluidStream.Idealized.Examples;
package VaporCycle
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
    This example package illustrates, step by step, several configurations of a vapor compression cycle,
    based on the reverse Clausius–Rankine cycle, as commonly used in air conditioning systems.
    The models are constructed using idealized state-change components, specifically 
    <code>adiabatic</code>, <code>isobaric</code>, and <code>isenthalpic</code> processes. 
    The cycle comprises four fundamental processes through which the working fluid (refrigerant) passes:
  </p>

  <ul>
    <li>Compression in a <code>compressor</code>: adiabatic process with a specified isentropic efficiency</li>
    <li>Condensation in a heat exchanger: isobaric cooling process</li>
    <li>Expansion in a <code>valve</code>: isenthalpic process</li>
    <li>Evaporation in a heat exchanger: isobaric heating process, closing the thermodynamic loop</li>
  </ul>
</html>"));
end VaporCycle;
