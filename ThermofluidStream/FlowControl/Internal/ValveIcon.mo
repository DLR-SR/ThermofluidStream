within ThermofluidStream.FlowControl.Internal;
partial model ValveIcon

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Rectangle(
          extent=DynamicSelect({{-80,0},{80,0}},{{-80,u*30},{80,-u*30}}),
          lineColor={255,255,255},
          pattern=LinePattern.None,
          lineThickness=1,
          fillColor={220,239,255},
          fillPattern=FillPattern.VerticalCylinder),
        Line(
          points={{-100,0},{-40,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,0},{-40,0}},
          color={28,108,200},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{0,50},{0,80}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{40,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points=DynamicSelect({{-30,50},{0,0},{30,50},{-30,50}},{{-30,50},{0,u*30},{30,50},{-30,50}}),
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor=DynamicSelect({255,255,255}, if invertInput == true then
                  {28,108,200} else {255,255,255}),
          fillPattern=FillPattern.Solid),
        Polygon(
          points=DynamicSelect({{-30,-50},{0,0},{30,-50},{-30,-50}},{{-30,-50},{0,-u*30},{30,-50},{-30,-50}}),
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor=DynamicSelect({255,255,255}, if invertInput == true then
                  {28,108,200} else {255,255,255}),
          fillPattern=FillPattern.Solid),
        Text(
          extent={{40,100},{100,70}},
          textColor={0,0,0},
          textString=DynamicSelect("u", String(u, format="1.2f")))}),
               Diagram(coordinateSystem(preserveAspectRatio=true)));
end ValveIcon;
