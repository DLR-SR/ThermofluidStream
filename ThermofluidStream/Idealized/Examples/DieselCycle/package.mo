within ThermofluidStream.Idealized.Examples;
package DieselCycle "Exercise 8.4: Diesel Engine [TUM2019]"
  extends Modelica.Icons.ExamplesPackage;

  annotation(Documentation(info="<html>
  <p>
    This example package illustrates stationary-flow representations of closed-system Diesel
    (<code>s, p, s, v</code>) engine processes.
    Here, <code>s</code> denotes an isentropic process (or more general an adiabatic process with isentropic efficiency),
    <code>v</code> denotes an isochoric process (constant specific volume/density),
    and <code>p</code> denotes an isobaric process.
  </p>
  
  <p>
    The examples use the <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a> medium
      model (perfect gas with constant <code>cp</code>) and differ with respect to the process model:
      >a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> (<code>systemSpec = Cycle</code> and <code>systemSpec = Flow</code>) and
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a>.
    </li>
  </p>

</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end DieselCycle;
