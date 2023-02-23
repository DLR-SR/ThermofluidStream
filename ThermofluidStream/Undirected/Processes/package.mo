within ThermofluidStream.Undirected;
package Processes "Undirected process package"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>This package contains models implementing undirected versions of the processes. Here the thermodynamic state of one ore more fluid streams is chaged by exchanging heat or work with the streams, or by delaying the state.</p>
</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\"/>(c) 2020-2021, DLR, Institute of System Dynamics and Control</p>
</html>"), Icon(graphics={
         Ellipse(
          extent={{-60,54},{60,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-94,0},{94,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-64,60},{56,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end Processes;
