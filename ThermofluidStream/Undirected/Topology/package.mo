within ThermofluidStream.Undirected;
package Topology "Junctions and Connectors for undirected thermofluid simulation"
  extends Modelica.Icons.Package;

annotation (Documentation(info="<html>
<p>This package contains the undirected junctions and necessary connectors between two undirected components, as well as directed-undirected connectors.</p>
<p>Note that in the undirected case it a distinction between junction and splitter is not possible.</p>
</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\"/>(c) 2020-2021, DLR, Institute of System Dynamics and Control</p>
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
