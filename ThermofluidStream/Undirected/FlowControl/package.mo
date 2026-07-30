within ThermofluidStream.Undirected;
package FlowControl "Package for undirected flow control components"
  extends Modelica.Icons.Package;

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
<p>Undirected implementation of the flow control components. </p><p>These include physical Valves, as well as fow-control valves, that are not physical models, but rather numerical boundaries on the flow.</p>
</html>"), Icon(graphics={
        Line(
          points={{-94,0},{-40,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,0},{-40,0}},
          color={28,108,200},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{40,0},{94,0}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points={{-20,40},{0,0},{20,40},{-20,40}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,20},{0,-20},{20,20},{-20,20}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,-20},
          rotation=180)}));
end FlowControl;
