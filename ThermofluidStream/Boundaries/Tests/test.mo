within ThermofluidStream.Boundaries.Tests;
model test
  package Medium = Media.myMedia.Water.StandardWater;
  Modelica.Blocks.Sources.TimeTable timeTable( offset = 1500e3, startTime = 0,table = [0.0, 0; 24.9, 1500e3; 25.1, 2000e3; 49.9, 2000e3; 50.1, 0; 74.9, 0; 75.1, -1090e3; 99.9, -1090e3; 100.1, 0; 124.9, 0; 1e10, 0]) annotation (
    Placement(transformation(extent = {{-120, -16}, {-100, 4}})));
  ThermofluidStream.Boundaries.Source source1(redeclare package Medium = Medium, enthalpyFromInput = true, h0_par = 2000, p0_par( displayUnit = "Pa") = 120000, setEnthalpy = true) annotation (
    Placement(visible = true, transformation(extent = {{-76, -16}, {-56, 4}}, rotation = 0)));
  inner DropOfCommons dropOfCommons(stopOnFailedAssert = false) annotation (
    Placement(transformation(extent = {{-86, -72}, {-66, -52}})));
  ThermofluidStream.Boundaries.TerminalSink terminalSink(redeclare package Medium = Medium)  annotation (
    Placement(visible = true, transformation(origin = {-28, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(source1.h0_var, timeTable.y) annotation (
    Line(points = {{-68, -6}, {-99, -6}}, color = {0, 0, 127}));
  connect(terminalSink.inlet, source1.outlet) annotation (
    Line(points = {{-38, -6}, {-56, -6}}, color = {28, 108, 200}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -100}, {120, 100}})),
    experiment(StopTime = 125, __Dymola_Algorithm = "Dassl"),
    Documentation(info = "<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end test;
