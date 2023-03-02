within ThermofluidStream.Topology.Tests;
model TestJunction
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium;

  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{42,-74},{62,-54}})));
  JunctionN junctionN(
    redeclare package Medium = Medium,
    N=3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Boundaries.Source source(redeclare package Medium = Medium,
    p0_par=200000,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-58,18},{-38,38}})));
  Boundaries.Source source1(redeclare package Medium = Medium,
    p0_par=100000,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
  Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=200000,
    L=0,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-58,-38},{-38,-18}})));
  Boundaries.Sink sink(
    redeclare package Medium = Medium,
    L=0,
    p0_par=100000)
    annotation (Placement(transformation(extent={{32,-10},{52,10}})));
equation
  connect(source1.outlet, junctionN.inlets[2]) annotation (Line(
      points={{-38,0},{-24,0},{-24,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, junctionN.inlets[1]) annotation (Line(
      points={{-38,-28},{-24,-28},{-24,-0.666667},{-10,-0.666667}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, junctionN.inlets[3]) annotation (Line(
      points={{-38,28},{-24,28},{-24,0.666667},{-10,0.666667}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, junctionN.outlet) annotation (Line(
      points={{32,0},{10,0}},
      color={28,108,200},
      thickness=0.5));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
             experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
        Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end TestJunction;
