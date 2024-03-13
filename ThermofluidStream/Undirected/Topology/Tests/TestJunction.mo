within ThermofluidStream.Undirected.Topology.Tests;
model TestJunction "Test for the undirected junction"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medum model for the Test" annotation (Documentation(info="<html>
<p>This is the replaceable package that determines the medium of the Test. </p>
</html>"));

  replaceable function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
    material=ThermofluidStream.Processes.Internal.Material.wood)
    constrainedby ThermofluidStream.Processes.Internal.FlowResistance.partialPressureLoss
    "Pressure loss function for all Flow resistances"
    annotation(choicesAllMatching = true, Documentation(info="<html>
<p>This is the pressure loss function used for all resistances except the two on the outlets of the right two cases.</p>
</html>"));

  ThermofluidStream.Boundaries.Source source(redeclare package Medium=Medium,
      p0_par=200000)
    annotation (Placement(transformation(extent={{-160,30},{-140,50}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium=Medium,
      p0_par=150000)
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium=Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  ThermofluidStream.Topology.SplitterT1 splitterT1_1(redeclare package Medium=Medium, L=
        2*dropOfCommons.L)
    annotation (Placement(transformation(extent={{-94,30},{-74,50}})));
  inner DropOfCommons dropOfCommons(L=1e2)
    annotation (Placement(transformation(extent={{-134,-8},{-114,12}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss = pLoss)
    annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss = pLoss)
    annotation (Placement(transformation(extent={{-46,10},{-26,30}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium, p0_par=2000000)
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium, p0_par=3500000)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  ThermofluidStream.Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss = pLoss)
    annotation (Placement(transformation(extent={{26,10},{46,30}})));
  ThermofluidStream.Processes.FlowResistance flowResistance5(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss = pLoss)
    annotation (Placement(transformation(extent={{26,50},{46,70}})));
  ThermofluidStream.Topology.JunctionT1 junctionT1_1(redeclare package Medium=Medium,
    assumeConstantDensity=false,
    L=2*dropOfCommons.L)
    annotation (Placement(transformation(extent={{74,30},{94,50}})));
  ThermofluidStream.Boundaries.Sink sink4(
    redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{140,30},{160,50}})));
  ThermofluidStream.Boundaries.Source source6(redeclare package Medium = Medium,
      p0_par=200000)
    annotation (Placement(transformation(extent={{-160,-50},{-140,-30}})));
  ThermofluidStream.Boundaries.Sink sink6(redeclare package Medium = Medium,
      p0_par=150000)
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  ThermofluidStream.Boundaries.Sink sink7(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  ConnectInletFore connectInletFore1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-118,-50},{-98,-30}})));
  ConnectRearOutlet connectRearOutlet2(redeclare package Medium = Medium,
      useDefaultStateAsRear=true)
    annotation (Placement(transformation(extent={{-66,-30},{-46,-10}})));
  ConnectRearOutlet connectRearOutlet3(redeclare package Medium = Medium,
      useDefaultStateAsRear=true)
    annotation (Placement(transformation(extent={{-66,-70},{-46,-50}})));
  ThermofluidStream.Processes.FlowResistance flowResistance8(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss = pLoss)
    annotation (Placement(transformation(extent={{-46,-30},{-26,-10}})));
  ThermofluidStream.Processes.FlowResistance flowResistance9(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss = pLoss)
    annotation (Placement(transformation(extent={{-46,-70},{-26,-50}})));
  ThermofluidStream.Boundaries.Source source7(redeclare package Medium = Medium, p0_par=2000000)
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  ThermofluidStream.Boundaries.Source source8(redeclare package Medium = Medium, p0_par=3500000)
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  ThermofluidStream.Processes.FlowResistance flowResistance10(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss = pLoss)
    annotation (Placement(transformation(extent={{26,-70},{46,-50}})));
  ThermofluidStream.Processes.FlowResistance flowResistance11(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss = pLoss)
    annotation (Placement(transformation(extent={{26,-30},{46,-10}})));
  ThermofluidStream.Boundaries.Sink sink8(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{140,-50},{160,-30}})));
  ConnectInletRear connectInletRear2(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{46,-30},{66,-10}})));
  ConnectInletRear connectInletRear3(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{46,-70},{66,-50}})));
  ConnectForeOutlet connectForeOutlet1(redeclare package Medium = Medium, useDefaultStateAsRear=true)
    annotation (Placement(transformation(extent={{98,-50},{118,-30}})));
  JunctionMN junctionMN(redeclare package Medium = Medium,
    M=2,
    N=1)
    annotation (Placement(transformation(extent={{-94,-50},{-74,-30}})));
  JunctionMN junctionMN1(redeclare package Medium = Medium,
    M=2,
    N=1,
    assumeConstantDensity=false)
    annotation (Placement(transformation(extent={{94,-50},{74,-30}})));
  ThermofluidStream.Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss = pLoss)
    annotation (Placement(transformation(extent={{-136,30},{-116,50}})));
  ThermofluidStream.Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss = pLoss)
    annotation (Placement(transformation(extent={{-136,-50},{-116,-30}})));
  ThermofluidStream.Processes.FlowResistance flowResistance6(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
         k=1000))
    annotation (Placement(transformation(extent={{116,-50},{136,-30}})));
  ThermofluidStream.Processes.FlowResistance flowResistance7(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
         k=1000))
    annotation (Placement(transformation(extent={{116,30},{136,50}})));
equation
  connect(sink.inlet, flowResistance.outlet) annotation (Line(
      points={{-20,60},{-26,60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, splitterT1_1.outletA) annotation (Line(
      points={{-46,60},{-84,60},{-84,50}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance1.outlet) annotation (Line(
      points={{-20,20},{-26,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet, splitterT1_1.outletB) annotation (Line(
      points={{-46,20},{-84,20},{-84,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, flowResistance5.inlet) annotation (Line(
      points={{20,60},{26,60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.inlet, source3.outlet) annotation (Line(
      points={{26,20},{20,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.outlet, junctionT1_1.inletB) annotation (Line(
      points={{46,20},{84,20},{84,30}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT1_1.inletA, flowResistance5.outlet) annotation (Line(
      points={{84,50},{84,60},{46,60}},
      color={28,108,200},
      thickness=0.5));
  connect(sink6.inlet,flowResistance8. outlet) annotation (Line(
      points={{-20,-20},{-26,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance8.inlet, connectRearOutlet2.outlet) annotation (Line(
      points={{-46,-20},{-53,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance9.inlet,connectRearOutlet3. outlet) annotation (Line(
      points={{-46,-60},{-53,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(sink7.inlet,flowResistance9. outlet) annotation (Line(
      points={{-20,-60},{-26,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance10.inlet, source8.outlet) annotation (Line(
      points={{26,-60},{20,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, flowResistance11.inlet) annotation (Line(
      points={{20,-20},{26,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(connectInletRear2.inlet, flowResistance11.outlet) annotation (Line(
      points={{53,-20},{46,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(connectInletRear3.inlet, flowResistance10.outlet) annotation (Line(
      points={{53,-60},{46,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearOutlet2.rear, junctionMN.fores[2]) annotation (Line(
      points={{-59,-20},{-66,-20},{-66,-39.5},{-74,-39.5}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearOutlet3.rear, junctionMN.fores[1]) annotation (Line(
      points={{-59,-60},{-66,-60},{-66,-40.5},{-74,-40.5}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionMN.rears[1], connectInletFore1.fore) annotation (Line(
      points={{-94,-40},{-100,-40},{-100,-40},{-105,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionMN1.rears[1], connectForeOutlet1.fore) annotation (Line(
      points={{94,-40},{100,-40},{100,-40},{105,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(connectInletRear2.rear, junctionMN1.fores[2]) annotation (Line(
      points={{59,-20},{66,-20},{66,-39.5},{74,-39.5}},
      color={28,108,200},
      thickness=0.5));
  connect(connectInletRear3.rear, junctionMN1.fores[1]) annotation (Line(
      points={{59,-60},{66,-60},{66,-40.5},{74,-40.5}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance2.inlet) annotation (Line(
      points={{-140,40},{-136,40}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.inlet, flowResistance2.outlet) annotation (Line(
      points={{-94,40},{-116,40}},
      color={28,108,200},
      thickness=0.5));
  connect(connectInletFore1.inlet, flowResistance3.outlet) annotation (Line(
      points={{-111,-40},{-116,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, flowResistance3.inlet) annotation (Line(
      points={{-140,-40},{-136,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(connectForeOutlet1.outlet, flowResistance6.inlet) annotation (Line(
      points={{111,-40},{116,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink8.inlet, flowResistance6.outlet) annotation (Line(
      points={{140,-40},{136,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink4.inlet, flowResistance7.outlet) annotation (Line(
      points={{140,40},{136,40}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT1_1.outlet, flowResistance7.inlet) annotation (Line(
      points={{94,40},{116,40}},
      color={28,108,200},
      thickness=0.5));
  annotation (
  experiment(StopTime=10, Tolerance=1e-6, Interval=0.01),
  Documentation(info="<html>
<p>This model tests the undirected junction against the unidirectional junction. The states of the left two and the right two systems are expected to be the same, when the junctions have the same settings. </p>
<p>Note that the unidirectional junctions have two times the inertance, since the undirected junction comes with a additional connector, which in turn adds inertance to each outlet.</p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"),
    Diagram(coordinateSystem(extent={{-160,-80},{160,80}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end TestJunction;
