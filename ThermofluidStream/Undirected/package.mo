within ThermofluidStream;
package Undirected "Components for undirected flow"
  extends Modelica.Icons.Package;

  annotation (
    Documentation(info="<html>
<p>This package contains models to implement undirected parts of the models, where the flow direction is not known in advance. </p>
<p>Note that an unidirectional component should be taken if possible, since undirected components always require a bigger equation system and are conceptionally more complex.</p>
</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\"/>(c) 2020-2021, DLR, Institute of System Dynamics and Control</p>
</html>"),
    Icon(graphics={
        Ellipse(
          extent={{-96,32},{-30,-34}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-76,12},{-50,-14}},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{32,32},{98,-34}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{52,12},{78,-14}},
          lineColor={170,213,255},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-64,42},{8,42},{-64,42}},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-70,48},{-64,48},{-70,48}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-74,46},{-66,46},{76,46},{42,86},{42,62},{-74,62},{-74,46}},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-76,-20},{-66,-20},{74,-20},{42,20},{42,-4},{-76,-4},{-76,-20}},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={-2,-66},
          rotation=180)}));
end Undirected;
