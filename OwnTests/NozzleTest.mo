within ThermofluidStream.Processes.Tests;
model NozzleTest
  extends Modelica.Icons.Example;
   replaceable package Medium = Media.myMedia.Air.DryAirNasa
                                                       constrainedby Media.myMedia.Interfaces.PartialMedium
                                                                                                     "Medium Model"
    annotation (choicesAllMatching=true,Documentation(info="<html>
<p><span style=\"font-size: 12pt;\">Medium model for the test. Can be anything. </span></p>
</html>"));

  ThermofluidStream.Processes.Nozzle nozzle(
    redeclare package Medium = Medium,
    A_in= 10e-6,
    A_out=0.5 ^ 2 * 3.14 * 2e-6,  
    assumeConstantDensity = true) 
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
  
  ThermofluidStream.Boundaries.Source source(
  redeclare package Medium = Medium, 
  T0_par(displayUnit = "K") = 299, 
  p0_par(displayUnit = "Pa") = 90000)
  annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  
  ThermofluidStream.Boundaries.Sink sink(
  redeclare package Medium = Medium, 
  p0_par(displayUnit = "Pa") =100000)
  annotation (Placement(transformation(extent={{70,10},{90,30}})));
  
  ThermofluidStream.Boundaries.DynamicPressureInflow dynamicPressureInflow(
  redeclare package Medium = Medium, 
  A_par = 10e-6, 
  assumeConstantDensity = true)
  annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  
  ThermofluidStream.Boundaries.DynamicPressureOutflow dynamicPressureOutflow(
  redeclare package Medium = Medium, 
  A_par = 10e-6,  
  assumeConstantDensity = true)
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  
  inner ThermofluidStream.DropOfCommons dropOfCommons annotation (
    Placement(visible = true, transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    redeclare function pLoss = Internal.FlowResistance.laminarTurbulentPressureLoss ( material=ThermofluidStream.Processes.Internal.Material.steel),
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    l=10,
    r(displayUnit="mm") = 0.01) annotation(
    Placement(visible = true, transformation(extent = {{-30, 10}, {-10, 30}}, rotation = 0)));

equation
  connect(dynamicPressureInflow.inlet, source.outlet) annotation(
    Line(points = {{-60, 20}, {-70, 20}}, color = {28, 108, 200}, thickness = 0.5));
  connect(nozzle.outlet, dynamicPressureOutflow.inlet) annotation(
    Line(points = {{30, 20}, {40, 20}}, color = {28, 108, 200}, thickness = 0.5));
  connect(dynamicPressureOutflow.outlet, sink.inlet) annotation(
    Line(points = {{60, 20}, {70, 20}}, color = {28, 108, 200}, thickness = 0.5));
  connect(flowResistance.inlet, dynamicPressureInflow.outlet) annotation(
    Line(points = {{-30, 20}, {-40, 20}}, color = {28, 108, 200}, thickness = 0.5));
  connect(nozzle.inlet, flowResistance.outlet) annotation(
    Line(points = {{10, 20}, {-10, 20}}, color = {28, 108, 200}, thickness = 0.5));
  annotation (experiment(StopTime=10, Tolerance=1e-6, Interval=0.01),
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Test for the nozzle, that can be used to transfer between kinetic enegy and enthalpy of the fluid.</p>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end NozzleTest;
