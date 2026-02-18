within ThermofluidStream.FlowControl.Tests;
model ThreeWayValve "Test for the three way valve"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium "Medium package"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Boundaries.Source source(redeclare package Medium=Medium,
    pressureFromInput=false,T0_par(displayUnit="K") = 300,
    p0_par=200000)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Boundaries.Sink sink(redeclare package Medium=Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{46,30},{66,50}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-42,30},{-22,50}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{46,50},{66,70}})));
  ThermofluidStream.FlowControl.ThreeWayValve
                                       threeWayValve(
    redeclare package Medium = Medium,
    m_flow_ref=10,
    p_ref=1000,
    relativeLeakiness=0.9,
    basicControlValve(k_min=1e-3),
    basicControlValve1(k_min=1e-3))
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Blocks.Sources.Sine  sine(
    amplitude=0.5,
    f=0.5,
    offset=0.5,
    startTime=1)
    annotation (Placement(transformation(extent={{-52,-2},{-32,18}})));
  Modelica.Blocks.Sources.Pulse pulse(period=1)
    annotation (Placement(transformation(extent={{-72,-40},{-52,-20}})));
equation
  connect(flowResistance.outlet, threeWayValve.inlet) annotation (Line(
      points={{-22,40},{-10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance1.outlet) annotation (Line(
      points={{46,60},{40,60}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance2.outlet) annotation (Line(
      points={{46,40},{40,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-50,40},{-42,40}},
      color={28,108,200},
      thickness=0.5));
  connect(threeWayValve.outletB, flowResistance1.inlet) annotation (Line(
      points={{0,50},{0,60},{20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(threeWayValve.outletA, flowResistance2.inlet) annotation (Line(
      points={{10,40},{20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse.y, threeWayValve.u) annotation (Line(points={{-51,-30},{0,-30},{0,28}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-120,-100},{100,100}})),
    experiment(StopTime=10, Tolerance=1e-6, Interval=0.01, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Test for the switches.</p>
<p>Owner: Michael Mei&szlig;ner</p>
</html>"));
end ThreeWayValve;
