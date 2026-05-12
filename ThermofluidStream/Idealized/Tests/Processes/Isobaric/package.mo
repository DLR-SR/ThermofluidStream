within ThermofluidStream.Idealized.Tests.Processes;
package Isobaric
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
    These examples demonstrate how the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isobaric\">Isobaric</a> process model
    can be used to model heating/cooling (open system, steady-flow, <code>systemSpec==Flow</code>) 
    or periodic heat transfer in a closed cycle system (<code>systemSpec==Cycle</code>), see section Advanced. 
  </p>
</html>"));
end Isobaric;
