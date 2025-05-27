within ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients;
package Wilo "Package with performance data for Wilo pumps"
  extends Modelica.Icons.Package;

annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains coefficients that represent the <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo\">measurements</a> of Wilo pumps.<br>
Only measurements at reference speed <code>w = w_ref</code> are considered and extended based on similarity laws
for <a href=\"modelica://ThermofluidStream.Processes.CentrifugalPump\">CentrifugalPump</a>.<br>
There is no warranty for the data.
</p>
</html>", revisions="<html>
<ul>
<li>
June 17, 2024, by Raphael Gebhart:
<br>
Transferred from <a href=\"https://github.com/lbl-srg/modelica-buildings\">Buildings Library</a> to  <a href=\"https://github.com/DLR-SR/ThermofluidStream\">ThermofluidStream Library</a>.
</li>
</ul>
</html>"));
end Wilo;
