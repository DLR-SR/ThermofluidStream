within ThermofluidStream.Examples.Utilities.Tests;
model Piston "Test for Piston model"
  extends Modelica.Icons.Example;

  package Medium = Media.myMedia.Water.StandardWater
    "Medium Model"
    annotation (Documentation(info="<html>
<p>Typically some sort of water.</p>
</html>"));

  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{66,48},{86,68}})));
  ThermofluidStream.Examples.Utilities.Piston piston2_1(
    redeclare package Medium = Medium,
    A=1,
    l_stroke=1,
    V_dead=0.2,
    outputX=true,
    p0_left=900000,
    p0_right=300000,
    m0_left=3,
    m0_right=0.75,
    x0=0.5) annotation (Placement(transformation(extent={{-6,-60},{14,-40}})));

  Modelica.Mechanics.Translational.Sources.LinearSpeedDependentForce
    linearSpeedDependentForce(
    f_nominal=-1e6,
    ForceDirection=false,
    v_nominal=1)
    annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
  Boundaries.Source source(redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 500,
    p0_par=1000000)
    annotation (Placement(transformation(extent={{-106,0},{-86,20}})));
  SteamSink steamSink(
    redeclare package Medium = Medium,
    p0_par=200000,
    m_flow_animate=1.3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={124,36})));
  Modelica.Blocks.Sources.Pulse pulse(
    period=4,
    offset=0,
    startTime=1)
    annotation (Placement(transformation(extent={{-64,46},{-44,66}})));
  ThermofluidStream.Utilities.showRealValue showRealValue annotation (Placement(transformation(extent={{32,-82},{52,-62}})));
  Undirected.Topology.ConnectorInletOutletFore switchConnector(
    redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,-20})));
  Undirected.Topology.ConnectorInletOutletFore switchConnector1(
    redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,10})));
  FlowControl.Switch switch(redeclare package Medium = Medium, initializeOneMassflowSplit=true)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-66,10})));
  Topology.JunctionT2 junctionT2_1(redeclare package Medium = Medium)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={104,10})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.1, initType=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-20,56})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    computeL=false,
    L_value=1e-3,
    r=0.1,
    l=0.01,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=10))
    annotation (Placement(transformation(extent={{-46,0},{-26,20}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    computeL=false,
    L_value=1e-3,
    r=0.1,
    l=0.01,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=10))
    annotation (Placement(transformation(extent={{-46,-30},{-26,-10}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    computeL=false,
    L_value=1e-3,
    r=0.1,
    l=0.01,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=10))
    annotation (Placement(transformation(extent={{34,0},{54,20}})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    computeL=false,
    L_value=1e-3,
    r=0.1,
    l=0.01,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=10))
    annotation (Placement(transformation(extent={{34,-30},{54,-10}})));
  FlowControl.TanValve tanValve(redeclare package Medium = Medium, invertInput=false) annotation (Placement(transformation(extent={{64,20},{84,0}})));
  FlowControl.TanValve tanValve1(redeclare package Medium = Medium, invertInput=true) annotation (Placement(transformation(extent={{64,-30},{84,-10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-6e5,
    duration=5,
    offset=10e5,
    startTime=5) annotation (Placement(transformation(extent={{-134,0},{-114,20}})));
initial equation
 // flowResistance.m_flow = 0;
 // flowResistance1.m_flow = 0;

equation

  connect(linearSpeedDependentForce.flange, piston2_1.flange) annotation (Line(points={{40,-50},{40,-50.2},{14,-50.2}},      color={0,127,0}));

  connect(piston2_1.x_out, showRealValue.numberPort) annotation (Line(points={{10,-55},{10,-72},{30.5,-72}},     color={0,0,127}));
  connect(switchConnector.fore, piston2_1.port_left)
    annotation (Line(
      points={{-10,-30},{-10,-46},{-6,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(switchConnector1.fore, piston2_1.port_right)
    annotation (Line(
      points={{10,0},{10,-10},{20,-10},{20,-46},{14,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse.y, firstOrder.u) annotation (Line(points={{-43,56},{-32,56}}, color={0,0,127}));
  connect(flowResistance.outlet, switchConnector1.inlet) annotation (Line(
      points={{-26,10},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, switchConnector.inlet)
    annotation (Line(
      points={{-26,-20},{-20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.inlet, source.outlet) annotation (Line(
      points={{-76,10},{-86,10}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet, switchConnector1.outlet) annotation (Line(
      points={{34,10},{20,10}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.inlet, switchConnector.outlet) annotation (Line(
      points={{34,-20},{0,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_1.outlet, steamSink.inlet) annotation (Line(
      points={{94,10},{124,10},{124,26}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve.inlet, flowResistance1.outlet) annotation (Line(
      points={{64,10},{54,10}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve1.inlet, flowResistance3.outlet) annotation (Line(
      points={{64,-20},{54,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve1.u, tanValve.u) annotation (Line(points={{74,-12},{74,2}}, color={0,0,127}));
  connect(junctionT2_1.inletB, tanValve.outlet) annotation (Line(
      points={{114,10},{84,10}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve1.outlet, junctionT2_1.inletA) annotation (Line(
      points={{84,-20},{104,-20},{104,0}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp.y, source.p0_var) annotation (Line(points={{-113,10},{-106,10},{-106,16},{-98,16}},
                                                                                color={0,0,127}));
  connect(firstOrder.y, tanValve.u) annotation (Line(points={{-9,56},{16,56},{16,28},{58,28},{58,-4},{74,-4},{74,2}}, color={0,0,127}));
  connect(switch.outletA, flowResistance.inlet) annotation (Line(
      points={{-56,10},{-46,10}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.outletB, flowResistance2.inlet) annotation (Line(
      points={{-66,0},{-66,-20},{-46,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.u, tanValve.u) annotation (Line(points={{-66,22},{-66,28},{58,28},{58,-4},{74,-4},{74,2}}, color={0,0,127}));
    annotation (
      experiment(StopTime=15, Tolerance=1e-6, Interval=0.015),
        Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"),
    Diagram(coordinateSystem(extent={{-140,-80},{140,80}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end Piston;
