within ThermofluidStream.Undirected.Topology.Tests;
model TestConnectors "Test for the connectors"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium "Medum model for the Test"
    annotation (Documentation(info="<html>
<p>This is the replaceable package that determines the medium of the Test. </p>
</html>"));

  ConnectRearRear connectRearRear(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  ConnectForeFore connectForeFore(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Boundaries.BoundaryRear boundary_rear(redeclare package Medium = Medium,
    p0_par=100000,
    fore(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Boundaries.BoundaryFore boundary_fore(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-20,40},{-40,60}})));
  ThermofluidStream.Boundaries.Source source(redeclare package Medium=Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  ConnectInletFore connectInletFore(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  ConnectRearOutlet connectRearOutlet(redeclare package Medium=Medium, rear(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium=Medium,
      pressureFromInput=true)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Boundaries.BoundaryRear boundary_rear1(redeclare package Medium = Medium, pressureFromInput=true)
    annotation (Placement(transformation(extent={{40,60},{20,80}})));
  Boundaries.BoundaryFore boundary_fore1(redeclare package Medium = Medium, pressureFromInput=true,
    rear(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Boundaries.BoundaryFore boundary_fore2(redeclare package Medium = Medium, pressureFromInput=true,
    rear(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Boundaries.BoundaryRear boundary_rear2(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  ThermofluidStream.Boundaries.Source source1(redeclare package Medium = Medium,
    p0_par=100000,
    L=1.5*dropOfCommons.L,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-40,100},{-20,120}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = Medium,
    pressureFromInput=true,
    L=1.5*dropOfCommons.L)
    annotation (Placement(transformation(extent={{20,100},{40,120}})));
  Boundaries.BoundaryRear boundary_rear3(
    redeclare package Medium = Medium,
    p0_par=100000,
    L=1.5*dropOfCommons.L) annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Boundaries.BoundaryFore boundary_fore3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    L=1.5*dropOfCommons.L,
    rear(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-88,80},{-68,100}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=1e5,
    period=5,
    offset=0.5e5,
    startTime=1)
    annotation (Placement(transformation(extent={{82,50},{62,70}})));
  ThermofluidStream.Boundaries.Source source2(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  ConnectInletFore connectInletFore1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  ConnectRearOutlet connectRearOutlet1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{10,-20},{30,-40}})));
  ThermofluidStream.Boundaries.Sink sink2(redeclare package Medium = Medium,
      pressureFromInput=true)
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    computeL=false,
    r=0.01,
    l=1,
    redeclare function pLoss =
        .ThermofluidStream.Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    computeL=false,
    r=0.01,
    l=1,
    redeclare function pLoss =
        .ThermofluidStream.Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Boundaries.BoundaryRear boundary_rear4(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
  Boundaries.BoundaryFore boundary_fore4(redeclare package Medium = Medium, pressureFromInput=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={40,-50})));
  ThermofluidStream.Boundaries.CreateState createState(
    redeclare package Medium = Medium,
    PFromInput=true)
    annotation (Placement(transformation(extent={{38,-12},{32,-4}})));
  ConnectorInletOutletFore connectorInletOutletFore(redeclare package Medium = Medium)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-68})));
  Boundaries.BoundaryFore boundary_fore5(redeclare package Medium = Medium, pressureFromInput=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={64,-90})));
  ThermofluidStream.Boundaries.Source source3(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{-80,-78},{-60,-58}})));
  ThermofluidStream.Boundaries.Sink sink3(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=100000)
    annotation (Placement(transformation(extent={{54,-78},{74,-58}})));
  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.005,
    l=5,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{-40,-78},{-20,-58}})));
  ThermofluidStream.Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium, initM_flow = ThermofluidStream.Utilities.Types.InitializationMethods.state,
    l=5,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss,
    r(displayUnit="mm") = 0.005)
    annotation (Placement(transformation(extent={{20,-78},{40,-58}})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium, initM_flow = ThermofluidStream.Utilities.Types.InitializationMethods.state,
    l=5,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss,
  r(displayUnit="mm") = 0.005)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,-90})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1.4e5,
    duration=1,
    offset=0.8e5,
    startTime=4.5) annotation (Placement(transformation(extent={{100,-100},{80,-80}})));
equation
  connect(boundary_rear.fore, connectRearRear.rear_a) annotation (Line(
      points={{-20,70},{-3,70}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore.rear, connectForeFore.fore_a) annotation (Line(
      points={{-20,50},{-3,50}},
      color={28,108,200},
      thickness=0.5));
  connect(connectInletFore.inlet, source.outlet) annotation (Line(
      points={{-3,30},{-20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, connectRearOutlet.outlet) annotation (Line(
      points={{20,10},{3,10}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear1.fore, connectRearRear.rear_b) annotation (Line(
      points={{20,70},{3,70}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore1.rear, connectForeFore.fore_b) annotation (Line(
      points={{20,50},{3,50}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore2.rear, connectInletFore.fore) annotation (Line(
      points={{20,30},{3,30}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear2.fore, connectRearOutlet.rear) annotation (Line(
      points={{-20,10},{-3,10}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear3.fore, boundary_fore3.rear) annotation (Line(
      points={{-20,90},{20,90}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, source1.outlet) annotation (Line(
      points={{20,110},{-20,110}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse.y, sink1.p0_var) annotation (Line(points={{61,60},{46,60},{46,110},{32,110}},
                                                                                          color={0,0,127}));
  connect(pulse.y, boundary_fore3.p0_var) annotation (Line(points={{61,60},{46,60},{46,96},{32,96}},
                                                                                                   color={0,0,127}));
  connect(pulse.y, boundary_rear1.p0_var) annotation (Line(points={{61,60},{46,60},{46,76},{32,76}},
                                                                                                 color={0,0,127}));
  connect(pulse.y, boundary_fore1.p0_var) annotation (Line(points={{61,60},{46,60},{46,56},{32,56}}, color={0,0,127}));
  connect(pulse.y, boundary_fore2.p0_var) annotation (Line(points={{61,60},{46,60},{46,36},{32,36}}, color={0,0,127}));
  connect(pulse.y, sink.p0_var) annotation (Line(points={{61,60},{46,60},{46,10},{32,10}}, color={0,0,127}));
  connect(connectInletFore1.inlet, source2.outlet) annotation (Line(
      points={{-23,-30},{-30,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, connectRearOutlet1.outlet) annotation (Line(
      points={{30,-30},{23,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(connectInletFore1.fore, flowResistance.rear) annotation (Line(
      points={{-17,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearOutlet1.rear, flowResistance.fore) annotation (Line(
      points={{17,-30},{10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.p0_var, sink.p0_var) annotation (Line(points={{42,-30},{46,-30},{46,10},{32,10}},
                              color={0,0,127}));
  connect(flowResistance2.rear, boundary_rear4.fore) annotation (Line(
      points={{-10,-50},{-30,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.fore, boundary_fore4.rear) annotation (Line(
      points={{10,-50},{30,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore4.p0_var, sink.p0_var) annotation (Line(points={{42,-44},{46,-44},{46,10},{32,10}},
                                        color={0,0,127}));
  connect(createState.y, connectRearOutlet.state_rear) annotation (Line(points={{32,-8},{0,-8},{0,6}},
                                                                        color={
          162,29,33}));
  connect(createState.p_inp, sink.p0_var) annotation (Line(points={{38,-5.6},{46,-5.6},{46,10},{32,10}},
                                   color={0,0,127}));
  connect(connectRearOutlet1.state_rear, connectRearOutlet.state_rear)
    annotation (Line(points={{20,-26},{20,-8},{0,-8},{0,6}},
        color={162,29,33}));
  connect(source3.outlet, flowResistance1.inlet) annotation (Line(
      points={{-60,-68},{-40,-68}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, connectorInletOutletFore.inlet)
    annotation (Line(
      points={{-20,-68},{-10,-68}},
      color={28,108,200},
      thickness=0.5));
  connect(sink3.inlet, flowResistance3.outlet) annotation (Line(
      points={{54,-68},{40,-68}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.inlet, connectorInletOutletFore.outlet)
    annotation (Line(
      points={{20,-68},{10,-68}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore5.rear, flowResistance4.fore) annotation (Line(
      points={{54,-90},{40,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.rear, connectorInletOutletFore.fore)
    annotation (Line(
      points={{20,-90},{0,-90},{0,-78}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp.y, boundary_fore5.p0_var) annotation (Line(points={{79,-90},{72,-90},{72,-84},{66,-84}},
                                                                                      color={0,0,127}));
  annotation (
  experiment(StopTime=10, Tolerance=1e-6, Interval=0.01),
  Documentation(info="<html>
<p>This model tests the connectors against the case when source is directly connected to sink. All massflows are expected to be the same, when the sources and sinks have the same settings. </p>
<p>Note that the sources and sinks without a connector have 1.5 times the inertance, since the additional connector adds inertance to each other path.</p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-140},{100,120}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end TestConnectors;
