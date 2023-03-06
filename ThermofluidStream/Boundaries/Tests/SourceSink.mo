within ThermofluidStream.Boundaries.Tests;
model SourceSink "Test for source and sink model"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium package"
    annotation (Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{58,-74},{78,-54}})));
  Source source(redeclare package Medium=Medium,
    p0_par=200000, L=0,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-32,10},{-12,30}})));
  Sink sink(redeclare package Medium=Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{14,10},{34,30}})));
  Source source1(redeclare package Medium = Medium,
    p0_par=200000,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-32,-30},{-12,-10}})));
  Sink sink1(
    redeclare package Medium = Medium,
    L=0,
    p0_par=100000)
    annotation (Placement(transformation(extent={{14,-30},{34,-10}})));
equation
  connect(sink.inlet, source.outlet) annotation (Line(
      points={{14,20},{-12,20}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, source1.outlet) annotation (Line(
      points={{14,-20},{-12,-20}},
      color={28,108,200},
      thickness=0.5));

  annotation (experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end SourceSink;
