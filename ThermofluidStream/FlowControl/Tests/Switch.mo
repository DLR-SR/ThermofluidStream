within ThermofluidStream.FlowControl.Tests;
model Switch "Test for Switches"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium "Medium package"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{52,-82},{72,-62}})));
  Boundaries.Source source(redeclare package Medium=Medium,
    pressureFromInput=false,T0_par(displayUnit="K") = 300,
    p0_par=200000)
    annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
  Boundaries.Sink sink(redeclare package Medium=Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{46,60},{66,80}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-42,60},{-22,80}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{46,80},{66,100}})));
  ThermofluidStream.FlowControl.Switch switch(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Sources.Pulse pulse(period=1)
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  FourWaySwitch fourWaySwitch(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=150000)
    annotation (Placement(transformation(extent={{-76,-24},{-56,-4}})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-44,-24},{-24,-4}})));
  Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=300000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={46,-26})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={16,-26})));
  Boundaries.Sink sink2(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{46,-24},{66,-4}})));
  Processes.FlowResistance flowResistance5(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{18,-24},{38,-4}})));
  Boundaries.Sink sink3(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-80,-26})));
  Processes.FlowResistance flowResistance6(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-48,-26})));
  Modelica.Blocks.Sources.Pulse pulse1(period=1)
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
equation
  connect(flowResistance.outlet, switch.inlet) annotation (Line(
      points={{-22,70},{-10,70}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance1.outlet) annotation (Line(
      points={{46,90},{40,90}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance2.outlet) annotation (Line(
      points={{46,70},{40,70}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-50,70},{-42,70}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.outletB, flowResistance1.inlet)
    annotation (Line(
      points={{0,80},{0,90},{20,90}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.outletA, flowResistance2.inlet) annotation (Line(
      points={{10,70},{20,70}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse.y, switch.u) annotation (Line(points={{-9,40},{0,40},{0,58}}, color={0,0,127}));
  connect(flowResistance6.outlet, sink3.inlet) annotation (Line(
      points={{-58,-26},{-70,-26}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, fourWaySwitch.inletA)
    annotation (Line(
      points={{-24,-14},{-20,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance3.inlet) annotation (Line(
      points={{-56,-14},{-44,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(fourWaySwitch.outletA, flowResistance5.inlet)
    annotation (Line(
      points={{0,-14},{18,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.outlet, sink2.inlet) annotation (Line(
      points={{38,-14},{46,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.outlet, fourWaySwitch.inletB)
    annotation (Line(
      points={{6,-26},{0,-26}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, flowResistance4.inlet) annotation (Line(
      points={{36,-26},{26,-26}},
      color={28,108,200},
      thickness=0.5));
  connect(fourWaySwitch.outletB, flowResistance6.inlet)
    annotation (Line(
      points={{-20,-26},{-38,-26}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse1.y, fourWaySwitch.u) annotation (Line(points={{-19,-60},{-10,-60},{-10,-30}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-120,-100},{100,100}})),
    experiment(StopTime=10, Tolerance=1e-6, Interval=0.01, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Test for the switches.</p>
<p>Owner: Michael Mei&szlig;ner</p>
</html>"));
end Switch;
