within ThermofluidStream.Idealized.Examples;
package CombinedCycle "Combined Clausius Rankine and Joule cycle"
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
    This example package shows a combined-cycle power plant. The waste heat from the
    Joule cycle is used to drive the Clausius–Rankine cycle by vaporizing the water.
  </p>
</html>"));
end CombinedCycle;
