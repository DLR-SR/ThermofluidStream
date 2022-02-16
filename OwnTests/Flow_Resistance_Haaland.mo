within ThermofluidStream.Processes.Tests;

model Flow_Resistance "Test for flow resistance"
  extends Modelica.Icons.Example;
  import tf = ThermofluidStream;
  replaceable package Medium = tf.Media.myMedia.Air.SimpleAir "Medium model" annotation(
    Documentation(info = "<html>
<p><span style=\"font-family: Courier New;\">Medium model for the test. Can be anything. </span></p>
</html>"));

  ThermofluidStream.Boundaries.Source source(
  redeclare package Medium = Medium,
  T0_par(displayUnit = "K") = 300,
  pressureFromInput = true)
  annotation(
    Placement(visible = true, transformation(extent = {{-10, 4}, {10, 24}}, rotation = 0)));

  ThermofluidStream.Boundaries.Source source2(
  redeclare package Medium = Medium,
  T0_par(displayUnit = "K") = 300,
  pressureFromInput = true)
  annotation(
    Placement(visible = true, transformation(extent = {{-12, -42}, {8, -22}}, rotation = 0)));

  ThermofluidStream.Boundaries.Sink sink(
  redeclare package Medium = Medium,
  p0_par(displayUnit = "Pa") = 100000)
  annotation(
    Placement(visible = true, transformation(extent = {{84, -12}, {104, 8}}, rotation = 0)));

  ThermofluidStream.Boundaries.Sink sink2(
  redeclare package Medium = Medium,
  p0_par(displayUnit = "Pa") = 100000)
  annotation(
    Placement(visible = true, transformation(extent = {{86, -40}, {106, -20}}, rotation = 0)));

  inner tf.DropOfCommons dropOfCommons(L = 1, assertionLevel = AssertionLevel.warning) annotation(
    Placement(transformation(extent = {{60, 60}, {80, 80}})));

  ThermofluidStream.Processes.FlowResistance flowResistance(
  redeclare package Medium = Medium,
  redeclare function pLoss = tf.Processes.Internal.FlowResistance.laminarTurbulentPressureLossHaaland(Re_laminar = 200, Re_turbulent = 4000, shape_factor = 64, es = 15e-6), 
  computeL = false,
  initM_flow = ThermofluidStream.Utilities.Types.InitializationMethods.state,
  l = 100,
  r = 0.01)
  annotation(
    Placement(visible = true, transformation(extent = {{26, 4}, {46, 24}}, rotation = 0)));

  ThermofluidStream.Processes.FlowResistance flowResistance2(
  redeclare package Medium = Medium,
  redeclare function pLoss =
    Internal.FlowResistance.laminarTurbulentPressureLoss (material=ThermofluidStream.Processes.Internal.Material.steel),
  computeL = false,
  initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
  l = 100,
  r = 0.1)
  annotation(
  Placement(visible = true, transformation(extent = {{28, -40}, {48, -20}}, rotation = 0)));



  Modelica.Blocks.Sources.Clock clock annotation(
    Placement(visible = true, transformation(origin = {-122, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Modelica.Blocks.Math.Gain gain(k = 0.1e5)  annotation(
    Placement(visible = true, transformation(origin = {-88, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Modelica.Blocks.Math.Sum sum1(nin = 2) annotation(
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Modelica.Blocks.Sources.Constant const(k = 0.7e5) annotation(
    Placement(visible = true, transformation(origin = {-92, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));




equation
  connect(source.outlet, flowResistance.inlet) annotation(
    Line(points = {{10, 14}, {10, 7}, {26, 7}, {26, 14}}, color = {28, 108, 200}));
  connect(flowResistance.outlet, sink.inlet) annotation(
    Line(points = {{46, 14}, {62, 14}, {62, -2}, {84, -2}}, color = {28, 108, 200}));
  connect(clock.y, gain.u) annotation(
    Line(points = {{-110, 0}, {-100, 0}}, color = {0, 0, 127}));
  connect(gain.y, sum1.u[1]) annotation(
    Line(points = {{-76, 0}, {-72, 0}}, color = {0, 0, 127}));
  connect(const.y, sum1.u[2]) annotation(
    Line(points = {{-80, -50}, {-72, -50}, {-72, 0}}, color = {0, 0, 127}));
  connect(sum1.y, source.p0_var) annotation(
    Line(points = {{-48, 0}, {-29, 0}, {-29, 20}, {-28, 20}, {-28, 21}, {-2, 21}, {-2, 20}}, color = {0, 0, 127}));
 connect(flowResistance2.outlet, sink2.inlet) annotation(
    Line(points = {{48, -30}, {86, -30}}, color = {28, 108, 200}));
 connect(source2.outlet, flowResistance2.inlet) annotation(
    Line(points = {{8, -32}, {14, -32}, {14, -30}, {28, -30}}, color = {28, 108, 200}));
 connect(sum1.y, source2.p0_var) annotation(
    Line(points = {{-48, 0}, {-25, 0}, {-25, -24}, {-24, -24}, {-24, -25}, {-4, -25}, {-4, -26}}, color = {0, 0, 127}));
  annotation(
    experiment(StopTime = 10, Tolerance = 1e-06, Interval = 0.01, StartTime = 0),
    Documentation(info = "<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Flow_Resistance;
