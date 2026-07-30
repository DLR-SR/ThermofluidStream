within ThermofluidStream;
package Idealized "Package with idealized components"
  extends Modelica.Icons.Package;

  annotation(
    Icon(
      graphics={
        Bitmap(
          extent={{-94,-92},{92,92}},
          fileName="modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Idealized.png")}),
    Documentation(
      info="<html>
  <p>
    This package includes:
  </p>
  <ul>
    <li>
      Idealized <a href=\"modelica://ThermofluidStream.Idealized.Processes\">Processes</a>, e.g. adiabatic, isobaric, isenthalpic, isochoric
    </li>
    <li>
      Idealized mass flow rate <a href=\"modelica://ThermofluidStream.Idealized.Boundaries\">Sources</a>
    </li>
    <li>
      Idealized heat and power transfer, see <a href=\"modelica://ThermofluidStream.Idealized.EnergyFlow\">EnergyFlow</a>
    </li>
    <li>
      <a href=\"modelica://ThermofluidStream.Idealized.Examples\">Examples</a> of thermodynamic cycles:  
      Clausius-Rankine (CR), Joule-Brayton (JB), vapor cycle (inverse CR), air cycle (inverse JB), closed cycles (otto, diesel), combi cycles;  
      both simple and advanced configurations (multi-stage, etc.)
    </li>
  </ul>
</html>",
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
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
</html>
"));
end Idealized;
