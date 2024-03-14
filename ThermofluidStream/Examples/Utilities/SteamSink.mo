within ThermofluidStream.Examples.Utilities;
model SteamSink "Sink with fancy steam animation."
  extends Boundaries.Sink(final pressureFromInput=false);

  parameter SI.MassFlowRate m_flow_animate = 1e-4 "Mass flow rate where the animation is at original size.";
  Real x(unit="1");

initial equation
  x = 0;

equation
  der(x)*0.1 = max(0, inlet.m_flow/m_flow_animate) -x;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{20,20},{DynamicSelect(60, 20+x*40),46}},
          color={116,116,116},
          thickness=1),
        Line(
          points={{20,-20},{DynamicSelect(60, 20+x*40),-46}},
          color={116,116,116},
          thickness=1),
        Line(
          points={{25,0},{DynamicSelect(80, 20+x*60),0}},
          color={116,116,116},
          thickness=1),
        Ellipse(
          extent={{DynamicSelect(38, 20+x*18),56},{DynamicSelect(90, 20+x*70),10}},
          lineColor={116,116,116},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          lineThickness=1,
          startAngle=190,
          endAngle=385,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{DynamicSelect(38, 20+x*18),-56},{DynamicSelect(90, 20+x*70),-10}},
          lineColor={116,116,116},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          lineThickness=1,
          startAngle=190,
          endAngle=385,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{DynamicSelect(56, 20+x*36),24},{DynamicSelect(108, 20+x*88),-24}},
          lineColor={116,116,116},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          lineThickness=1,
          startAngle=-80,
          endAngle=80,
          closure=EllipseClosure.None)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Sink with fancy steam animation.
</p>
<p>
x is a nondimensional mass flow. @x=1 the animation is at original size.
It is low-passed to look better at very high flow peaks.
</p>
</html>"));
end SteamSink;
