within ThermofluidStream.Undirected.Processes.Tests;
model TestFlowResistance "Test for the undirected flow resistance"
  extends Modelica.Icons.Example;

  Processes.FlowResistance flowResistance(
    redeclare package Medium = Media.myMedia.Air.SimpleAir,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=1,
    redeclare function pLoss =
        .ThermofluidStream.Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Boundaries.BoundaryRear boundary_rear(
    redeclare package Medium = Media.myMedia.Air.SimpleAir,
    T0_par=293.15,
    p0_par=100000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,0})));
  Boundaries.BoundaryFore boundary_fore(
    redeclare package Medium = Media.myMedia.Air.SimpleAir,
    pressureFromInput=true,
    T0_par=303.15,
    p0_par=110000) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  inner DropOfCommons dropOfCommons(m_flow_reg=0.01)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.Step step(
    height=-80000,
    offset=140000,
    startTime=5)
    annotation (Placement(transformation(extent={{60,-6},{48,6}})));
  FlowResistance flowResistance1(
    redeclare package Medium = Media.myMedia.Air.SimpleAir,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Boundaries.BoundaryRear boundary_rear1(
    redeclare package Medium = Media.myMedia.Air.SimpleAir,
    pressureFromInput=true,
    T0_par=303.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,-40})));
  Boundaries.BoundaryFore boundary_fore1(
    redeclare package Medium = Media.myMedia.Air.SimpleAir,
    pressureFromInput=false,
    T0_par=303.15,
    p0_par=100000) annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
equation
  connect(boundary_rear.fore, flowResistance.rear) annotation (Line(
      points={{-20,-1.33227e-15},{-18,-1.33227e-15},{-18,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.fore, boundary_fore.rear) annotation (Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(step.y, boundary_fore.p0_var)
    annotation (Line(points={{47.4,0},{40,0},{40,6},{32,6}},
                                                   color={0,0,127}));
  connect(boundary_rear1.fore, flowResistance1.rear) annotation (Line(
      points={{-20,-40},{-10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.fore, boundary_fore1.rear) annotation (Line(
      points={{10,-40},{20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear1.p0_var, boundary_fore.p0_var)
    annotation (Line(points={{-32,-46},{-40,-46},{-40,-20},{40,-20},{40,6},{32,6}}, color={0,0,127}));
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10, Tolerance=1e-6, Interval=0.01),
    Documentation(info="<html>
<p>Test for the undirected flow resistance.</p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end TestFlowResistance;
