within ThermofluidStream.Undirected;
package Sensors "Sensors package for undirected thermofluid simulation"
  extends Modelica.Icons.SensorsPackage;

  import ThermofluidStream.Sensors.Internal;


  annotation (Documentation(revisions="<html>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
  <tr>
    <td valign=\"middle\">
      <img width=\"72\" src=\"modelica://ThermofluidStream/Resources/dlr_logo.png\" alt=\"Logo DLR\">
    </td>
    <td valign=\"middle\">
      <strong>Copyright &copy; Deutsches Zentrum f&uuml;r Luft- und Raumfahrt e.V. (DLR)</strong>
    </td>
  </tr>
</table>
</html>", info="<html>
<p>
Sensors package for undirected thermofluid simulation. For undirected flow, the massflow
must always be measured, since it determines if the forward or the backward flow is valid.
Therefore the fluid must flow through the sensor.
</p>
</html>"));
end Sensors;
