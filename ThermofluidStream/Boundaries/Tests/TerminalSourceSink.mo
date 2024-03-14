within ThermofluidStream.Boundaries.Tests;
model TerminalSourceSink "Test for Terminal source and sink model"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium package" annotation (Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Sink sink2(redeclare package Medium = Medium,
    pressureFromInput=true,
    p0_par=100000)
    annotation (Placement(transformation(extent={{8,4},{28,24}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=5e4,
    width=35,
    period=2,
    offset=0.8e5,
    startTime=0.2)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  TerminalSource terminalSource(redeclare package Medium = Medium, TC=0.1) annotation (Placement(transformation(extent={{-26,4},{-6,24}})));
  TerminalSink terminalSink(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{8,-26},{28,-6}})));
  Source source(redeclare package Medium = Medium, pressureFromInput=true) annotation (Placement(transformation(extent={{-26,-26},{-6,-6}})));
equation

  connect(pulse.y, sink2.p0_var) annotation (Line(points={{-39,0},{26,0},{26,14},{20,14}}, color={0,0,127}));
  connect(sink2.inlet, terminalSource.outlet) annotation (Line(
      points={{8,14},{-6,14}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, terminalSink.inlet) annotation (Line(
      points={{-6,-16},{8,-16}},
      color={28,108,200},
      thickness=0.5));
  connect(source.p0_var, sink2.p0_var) annotation (Line(points={{-18,-10},{-26,-10},{-26,0},{26,0},{26,14},{20,14}}, color={0,0,127}));
  annotation (experiment(StopTime=10, Tolerance=1e-6, Interval=0.01),
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end TerminalSourceSink;
