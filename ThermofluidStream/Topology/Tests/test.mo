within ThermofluidStream.Topology.Tests;
model test
  inner ThermofluidStream.DropOfCommons dropOfCommons annotation (
    Placement(visible = true, transformation(origin = {12, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermofluidStream.Boundaries.Source source(
    outlet(m_flow(start=0,fixed=true)),redeclare package Medium = Media.myMedia.Air.MoistAir, p0_par(displayUnit = "Pa") = 1.001)  annotation (
    Placement(visible = true, transformation(origin = {-38, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Media.myMedia.Air.MoistAir, p0_par(displayUnit = "Pa") = 1)  annotation (
    Placement(visible = true, transformation(origin = {36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Processes.FlowResistance flowResistance(redeclare package Medium = Media.myMedia.Air.MoistAir, l = 1, redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss,                                                                                                                      r = 0.05) annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(flowResistance.inlet, source.outlet) annotation (
    Line(points = {{-10, 0}, {-28, 0}}, color = {28, 108, 200}));
  connect( sink.inlet,flowResistance.outlet) annotation (
    Line(points = {{26, 0}, {10, 0}}, color = {28, 108, 200}));
annotation (
    Documentation(info = "<html><head></head><body>Test for bug behavior:&nbsp;<br>if used:&nbsp;<pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt; color: rgb(139, 0, 0);\">connect</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">(</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">flowResistance.outlet,</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">sink.inlet)</span></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt;\">model will run </span></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt;\">if used:</span></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt; color: rgb(139, 0, 0);\">connect</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">(sink.inlet, flowResistance.outlet)</span></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt;\">not so.</span></pre></pre></body></html>"));
end test;
