within ThermofluidStream.HeatExchangers.Internal;
model DiscretizedCrossFlowHexIcon

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-74,50},{84,-86}},
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          radius=6),
        Rectangle(
          extent={{-80,58},{76,-78}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=6),
        Polygon(
          points={{-60,4},{-52,12},{-44,4},{-44,0},{-52,8},{-60,0},{-60,4}},
          lineColor={28,108,200},
          fillColor={188,36,38},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-10,4},{-2,12},{6,4},{6,0},{-2,8},{-10,0},{-10,4}},
          lineColor={28,108,200},
          fillColor={188,36,38},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{46,4},{54,12},{62,4},{62,0},{54,8},{46,0},{46,4}},
          lineColor={28,108,200},
          fillColor={188,36,38},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(points={{-72,-74},{60,-74},{60,-44},{-72,-44},{-62,-34},{70,-34},{70,-64},{60,-74},{60,-44},{70,-34},{-62,-34},{-72,-44},{-72,-74}}, lineColor={28,108,200}),
        Line(points={{-36,-34},{-46,-44},{-46,-74}}, color={28,108,200}),
        Line(points={{-10,-34},{-20,-44},{-20,-74}}, color={28,108,200}),
        Line(points={{18,-34},{8,-44},{8,-74}},   color={28,108,200}),
        Line(points={{44,-34},{34,-44},{34,-74}}, color={28,108,200}),
        Text(
          extent={{-66,-54},{-54,-66}},
          textColor={28,108,200},
          textString="N"),
        Text(
          extent={{40,-54},{52,-66}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{14,-54},{26,-66}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-12,-54},{0,-66}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{-40,-54},{-28,-66}},
          textColor={28,108,200},
          textString="..."),
        Polygon(points={{-72,12},{62,12},{62,42},{-72,42},{-62,52},{72,52},{72,22},{62,12},{62,42},{72,52},{-62,52},{-72,42},{-72,12}}, lineColor={28,108,200}),
        Line(points={{-36,52},{-46,42},{-46,12}}, color={28,108,200}),
        Line(points={{-8,52},{-18,42},{-18,12}},  color={28,108,200}),
        Line(points={{20,52},{10,42},{10,12}}, color={28,108,200}),
        Line(points={{46,52},{36,42},{36,12}}, color={28,108,200}),
        Polygon(points={{-72,-26},{62,-26},{62,-6},{-72,-6},{-62,4},{72,4},{72,-16},{62,-26},{62,-6},{72,4},{-62,4},{-72,-6},{-72,-26}},lineColor={188,36,38}),
        Line(points={{-36,4},{-46,-6},{-46,-26}}, color={188,36,38}),
        Line(points={{-10,4},{-20,-6},{-20,-26}}, color={188,36,38}),
        Line(points={{16,4},{6,-6},{6,-26}}, color={188,36,38}),
        Line(points={{44,4},{34,-6},{34,-26}}, color={188,36,38}),
        Polygon(
          points={{-8,-2},{0,6},{8,-2},{8,-6},{0,2},{-8,-6},{-8,-2}},
          lineColor={28,108,200},
          fillColor={188,36,38},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={-52,-32},
          rotation=180),
        Polygon(
          points={{-8,-2},{0,6},{8,-2},{8,-6},{0,2},{-8,-6},{-8,-2}},
          lineColor={28,108,200},
          fillColor={188,36,38},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={-2,-32},
          rotation=180),
        Polygon(
          points={{-8,-2},{0,6},{8,-2},{8,-6},{0,2},{-8,-6},{-8,-2}},
          lineColor={28,108,200},
          fillColor={188,36,38},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={54,-32},
          rotation=180)}),                                           Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}})));
end DiscretizedCrossFlowHexIcon;
