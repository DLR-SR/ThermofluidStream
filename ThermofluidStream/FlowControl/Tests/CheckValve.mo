within ThermofluidStream.FlowControl.Tests;
model CheckValve "Test for CheckValve"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium package"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{52,-82},{72,-62}})));
  Boundaries.Source source(redeclare package Medium=Medium,
    pressureFromInput=true, T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Boundaries.Sink sink(redeclare package Medium=Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  ThermofluidStream.FlowControl.CheckValve checkValve(redeclare package Medium=Medium, L=
        1e-4,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state)
    annotation (Placement(transformation(extent={{-22,-10},{-2,10}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=2e5,
    period=0.5,
    offset=1e5)
    annotation (Placement(transformation(extent={{-96,-4},{-76,16}})));
  Processes.FlowResistance flowResistance(redeclare package Medium=Medium,
    r=0.1,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{14,-10},{34,10}})));
equation
  connect(checkValve.inlet, source.outlet) annotation (Line(
      points={{-22,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse.y, source.p0_var) annotation (Line(points={{-75,6},{-42,6}},
                         color={0,0,127}));
  connect(sink.inlet, flowResistance.outlet) annotation (Line(
      points={{52,0},{34,0}},
      color={28,108,200},
      thickness=0.5));
  connect(checkValve.outlet, flowResistance.inlet) annotation (Line(
      points={{-2,0},{14,0}},
      color={28,108,200},
      thickness=0.5));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
             experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
        Documentation(info="<html>
<p>Test for the CheckValve.</p>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end CheckValve;
