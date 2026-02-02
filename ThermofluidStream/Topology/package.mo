within ThermofluidStream;
package Topology
  extends Modelica.Icons.Package;

annotation (Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\"/>(c) 2020-2021, DLR, Institute of System Dynamics and Control</p>

</html>", info="<html>
<p>This package provides dedicated splitter and junction models for building directed ThermoFluidStream network topologies. </p>
<p>The library explicitly recommends composing branches and merges using these elements rather than splitting flows purely via connector equations (except for sensor-only use cases). </p><p>Using dedicated topology components is also a key structural difference compared to the Modelica Standard Library approach, improving robustness and clarity of network formulation.</p><p>(Reference: <a href=\"https://doi.org/10.3390/electronics11223790\">https://doi.org/10.3390/electronics11223790</a>)</p>
<p>All models rely on a consistent medium definition across connected ports. Ensure the selected <strong>Medium</strong> matches that of all connected components.</p>
</html>"), Icon(graphics={
        Line(
          points={{-80,0},{12,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{12,0},{80,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{12,0},{80,80}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{6,6},{18,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5)}));
end Topology;
