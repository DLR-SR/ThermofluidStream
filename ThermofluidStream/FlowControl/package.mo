within ThermofluidStream;
package FlowControl "Package for flow control components"
  extends Modelica.Icons.Package;

annotation (Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\"/>(c) 2020-2021, DLR, Institute of System Dynamics and Control</p>
</html>", info="<html>
<p>The package includes physical valves, as well as flow-control valves, that are not physical models, but rather numerical boundaries on the flow.</p>
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
