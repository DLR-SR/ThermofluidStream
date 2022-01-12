within ThermofluidStream.Processes.Tests;

model Nozzle_Simscape
  extends Modelica.Icons.Example;
  replaceable package Medium = Media.XRGMedia.NH3_ph constrainedby Media.myMedia.Interfaces.PartialMedium "Medium package" annotation(
     Documentation(info = "<html>
<p><span style=\"font-family: Courier New;\">Medium package used in the Test.</span></p>
</html>"));

// Source
  ThermofluidStream.Boundaries.Source source(
  redeclare package Medium = Medium, 
  p0_par (displayUnit = "Pa") = 350000, 
  pressureFromInput = true) 
  annotation(
    Placement(visible = true, transformation(extent = {{-84, 10}, {-64, 30}}, rotation = 0)));
  
  // Sink
  Boundaries.Sink sink(
  redeclare package Medium = Medium,
  p0_par (displayUnit = "Pa") = 373000) 
  annotation(
    Placement(transformation(extent = {{70, 10}, {90, 30}})));
  
  inner ThermofluidStream.DropOfCommons dropOfCommons annotation(
    Placement(visible = true, transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

// dynamicPressureInflow
  ThermofluidStream.Boundaries.DynamicPressureInflow dynamicPressureInflow (
  redeclare package Medium = Medium, 
  L = 10 / (Modelica.Constants.pi * 4.25 ^ 2 / 4 * 4) * 1e3, 
  A_par = Modelica.Constants.pi * 4.25 ^ 2 / 4 * 4e-6)
  annotation(
    Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

// Flow Resistance
  ThermofluidStream.Processes.FlowResistance flowResistance (
  redeclare package Medium = Medium, 
  redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss(material = ThermofluidStream.Processes.Internal.Material.steel), 
  initM_flow = ThermofluidStream.Utilities.Types.InitializationMethods.state, 
  l = 10, 
  r = sqrt(4.25 ^ 2 / 4 * 4e-6))
  annotation(
    Placement(visible = true, transformation(origin = {-12, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
// Nozzle
  ThermofluidStream.Processes.Nozzle_Simscape nozzle_Simscape1 (
  redeclare package Medium = Medium, 
  L_value = 10 / (Modelica.Constants.pi * 4.25 ^ 2 / 4 * 4) * 1e3, 
  A_in = Modelica.Constants.pi * 4.25 ^ 2 / 4 * 4e-6, 
  A_out = Modelica.Constants.pi * (15.312 ^ 2 - 15.30 ^ 2) * 1e-6) 
  annotation(
    Placement(visible = true, transformation(origin = {20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

// dynamicPressureOutflow
  ThermofluidStream.Boundaries.DynamicPressureOutflow dynamicPressureOutflow (
  redeclare package Medium = Medium, 
  L = 10 / (Modelica.Constants.pi * 4.25 ^ 2 / 4 * 4) * 1e3, 
  A_par = Modelica.Constants.pi * (15.312 ^ 2 - 15.30 ^ 2) * 1e-6)
  annotation(
    Placement(visible = true, transformation(origin = {50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Blocks.Math.Gain gain(k = 0.1e5)  annotation(
    Placement(visible = true, transformation(origin = {-146, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {-104, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Clock clock annotation(
    Placement(visible = true, transformation(origin = {-182, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 3.4e5)  annotation(
    Placement(visible = true, transformation(origin = {-186, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  connect(dynamicPressureOutflow.outlet, sink.inlet) annotation(
    Line(points = {{60, 20}, {70, 20}}, color = {28, 108, 200}));
  connect(source.outlet, dynamicPressureInflow.inlet) annotation(
    Line(points = {{-64, 20}, {-56, 20}}, color = {28, 108, 200}));
  connect(dynamicPressureInflow.outlet, flowResistance.inlet) annotation(
    Line(points = {{-36, 20}, {-22, 20}}, color = {28, 108, 200}));
  connect(flowResistance.outlet, nozzle_Simscape1.inlet) annotation(
    Line(points = {{-2, 20}, {10, 20}}, color = {28, 108, 200}));
  connect(nozzle_Simscape1.outlet, dynamicPressureOutflow.inlet) annotation(
    Line(points = {{30, 20}, {40, 20}}, color = {28, 108, 200}));
  connect(clock.y, gain.u) annotation(
    Line(points = {{-171, 42}, {-159, 42}}, color = {0, 0, 127}));
  connect(gain.y, sum1.u[1]) annotation(
    Line(points = {{-135, 42}, {-117, 42}, {-117, 22}}, color = {0, 0, 127}));
  connect(const.y, sum1.u[2]) annotation(
    Line(points = {{-175, 0}, {-117, 0}, {-117, 22}}, color = {0, 0, 127}));
  connect(sum1.y, source.p0_var) annotation(
    Line(points = {{-92, 22}, {-82, 22}, {-82, 26}, {-76, 26}}, color = {0, 0, 127}));
  annotation(
    experiment(StopTime = 10, Tolerance = 1e-6, Interval = 0.01),
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    Documentation(info = "<html>
<p>Test for the nozzle, that can be used to transfer between kinetic enegy and enthalpy of the fluid.</p>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Nozzle_Simscape;
