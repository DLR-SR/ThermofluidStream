within ThermofluidStream.Examples.Utilities;
model WaterSink "Sink with fancy water animation."
  extends Boundaries.Sink(final pressureFromInput=false);

  parameter SI.MassFlowRate m_flow_animate = 1e-4 "Mass flow rate where the animation is at original size.";
  Real x(unit="1");

initial equation
  x = 0;

equation
  der(x)*0.1 = max(0, inlet.m_flow/m_flow_animate) -x;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{0,100},{16,DynamicSelect(36,100-x*64)},{80,DynamicSelect(-30,100-x*130)},{0,DynamicSelect(-100,100-x*200)},
          {-80,DynamicSelect(-30,100-x*130)},{-16,DynamicSelect(36,100-x*64)},{0,100}},
          lineColor={170,213,255},
          smooth=Smooth.Bezier,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          origin={100,0},
          rotation=90)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Sink with fancy water animation.
</p>
<p>
x is a nondimensional mass flow. @x=1 the animation looks best.
</p>
</html>"));
end WaterSink;
