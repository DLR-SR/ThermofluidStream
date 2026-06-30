within ThermofluidStream.Undirected;
package Topology "Junctions and Connectors for undirected thermofluid simulation"
  extends Modelica.Icons.Package;

annotation (Documentation(info="<html>
<p>This package contains the undirected junctions and necessary connectors between two undirected components, as well as directed-undirected connectors.</p>
<p>Note that in the undirected case it a distinction between junction and splitter is not possible.</p>
</html>", revisions="<html>
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
</html>"), Icon(graphics={
        Line(
          points={{-80,2},{12,2}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{12,2},{80,-78}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{12,2},{80,82}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{6,8},{18,-4}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5)}));
end Topology;
