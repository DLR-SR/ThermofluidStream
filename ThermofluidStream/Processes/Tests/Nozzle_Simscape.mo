within ThermofluidStream.Processes.Tests;

model Nozzle_Simscape
  extends Modelica.Icons.Example;
  replaceable package Medium = Media.myMedia.Air.MoistAir constrainedby Media.myMedia.Interfaces.PartialMedium "Medium Model" annotation(
     choicesAllMatching = true,
     Documentation(info = "<html>
<p><span style=\"font-size: 12pt;\">Medium model for the test. Can be anything. </span></p>
</html>"));
  
  Boundaries.Source source(
  redeclare package Medium = Medium, 
  p0_par = 110000) 
  annotation(
    Placement(transformation(extent = {{-90, 10}, {-70, 30}})));
  
  Boundaries.Sink sink(
  redeclare package Medium = Medium, 
  p0_par = 100000) 
  annotation(
    Placement(transformation(extent = {{70, 10}, {90, 30}})));
  
  inner ThermofluidStream.DropOfCommons dropOfCommons annotation(
    Placement(visible = true, transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  ThermofluidStream.Processes.Nozzle_Simscape nozzle_Simscape1 (
  redeclare package Medium = Medium, 
  A_in = 0.001,
  A_out = 0.001) 
  annotation(
    Placement(visible = true, transformation(origin = {-4, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation

connect(source.outlet, nozzle_Simscape1.inlet);
connect(nozzle_Simscape1.outlet, sink.inlet);
  connect(source.outlet, nozzle_Simscape1.outlet) annotation(
    Line(points = {{-70, 20}, {6, 20}}, color = {28, 108, 200}));
  connect(nozzle_Simscape1.outlet, sink.inlet) annotation(
    Line(points = {{6, 20}, {70, 20}}, color = {28, 108, 200}));
  annotation(
    experiment(StopTime = 10, Tolerance = 1e-6, Interval = 0.01),
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    Documentation(info = "<html>
<p>Test for the nozzle, that can be used to transfer between kinetic enegy and enthalpy of the fluid.</p>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Nozzle_Simscape;
