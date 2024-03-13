within ThermofluidStream.Examples.Utilities;
model CupSink "Sink with fancy cup animation"

  replaceable package Medium=Media.myMedia.Interfaces.PartialMedium
    "Medium Model"
    annotation(choicesAllMatching=true, Documentation(info="<html>
<p>
Medium model in cup.
</p>
</html>"));

  parameter SI.Mass M = 3.448e-2 "Mass of medium that fits in the cup";

  Real x(unit="1", start=0, fixed=true);

  Boundaries.Sink sink(redeclare package Medium=Medium,
    final pressureFromInput=false,
    final p0_par=100000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-2})));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));

  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    r(displayUnit="cm") = 0.05,
    l(displayUnit="cm") = 0.01,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=10))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,42})));
equation
  der(x) = inlet.m_flow/M;

  connect(flowResistance.outlet, sink.inlet)
    annotation (Line(
      points={{-1.77636e-15,32},{0,32},{0,8}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, inlet) annotation (Line(
      points={{0,52},{0,100},{0,100}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-80,140},{80,20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1,
          startAngle=0,
          endAngle=180),
        Ellipse(
          extent={{34,72},{112,32}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          lineThickness=1,
          startAngle=-80,
          endAngle=120,
          closure=EllipseClosure.None),
        Line(
          points={{0,100},{0,80}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-74,132},{74,26}},
          fillColor={162,29,33},
          fillPattern=FillPattern.Solid,
          lineThickness=1,
          startAngle=DynamicSelect(0, 90-x*90),
          endAngle=DynamicSelect(180, 90+x*90),
          pattern=LinePattern.None)}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Sink with fancy cup animation.
</p>
<p>
x is the level of medium in the cup for the animation.
</p>
</html>"));
end CupSink;
