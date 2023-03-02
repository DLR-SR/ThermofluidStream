within ThermofluidStream.Topology.Tests;
model TestSplitter
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium;

  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  SplitterN splitterN(
    redeclare package Medium = Medium,
    N=3,
    outlets(m_flow(each start=0, each fixed=true)))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=200000,
    L=0) annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{44,18},{64,38}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{44,-10},{64,10}})));
  Boundaries.Sink sink2(
    redeclare package Medium = Medium,
    L=0,
    p0_par=100000)
    annotation (Placement(transformation(extent={{44,-38},{64,-18}})));
equation
  connect(splitterN.inlet, source.outlet) annotation (Line(
      points={{-10,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, splitterN.outlets[2]) annotation (Line(
      points={{44,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, splitterN.outlets[3]) annotation (Line(
      points={{44,28},{30,28},{30,0.666667},{10,0.666667}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, splitterN.outlets[1]) annotation (Line(
      points={{44,-28},{30,-28},{30,-0.666667},{10,-0.666667}},
      color={28,108,200},
      thickness=0.5));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
             experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
        Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end TestSplitter;
