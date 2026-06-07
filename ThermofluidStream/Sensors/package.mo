within ThermofluidStream;
package Sensors "Package containing sensors for the thermofluid simulation"
  extends Modelica.Icons.SensorsPackage;

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
<p>This package contains idealized sensor models for the thermofluid simulation. Massflow / Enthalpy flow sensors must be incooperated into the loop. </p>
<p>Others can be connected without a junction. Sensors with two inputs can be used to sense the difference in a signal. </p>
</html>"));
end Sensors;
