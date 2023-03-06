within ThermofluidStream.Topology.Tests;
model TestJunctionNM
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.MoistAir
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium Model"
    annotation (choicesAllMatching=
       true, Documentation(info="<html>
<p>
Medium model for the test. Can be anything.
</p>
</html>"));

  JunctionNM junctionNM(
    redeclare package Medium = Medium,
    N=2,
    M=3,
    assumeConstantDensity=false)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Boundaries.Source source(redeclare package Medium = Medium, p0_par=120000)
    annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
  Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,70},{70,90}})));
  Boundaries.Source source1(redeclare package Medium = Medium, p0_par=110000)
    annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=90000)
    annotation (Placement(transformation(extent={{50,40},{70,60}})));
  Boundaries.Sink sink2(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,10},{70,30}})));

  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.005,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.005,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.005,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss) annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.005,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss) annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.005,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss) annotation (Placement(transformation(extent={{20,70},{40,90}})));
  JunctionNM junctionNM1(
    redeclare package Medium = Medium,
    N=2,
    M=3,
    assumeConstantDensity=true)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Boundaries.Source source2(redeclare package Medium = Medium, p0_par=120000)
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Boundaries.Sink sink3(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Boundaries.Source source3(redeclare package Medium = Medium, p0_par=110000)
    annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
  Boundaries.Sink sink4(redeclare package Medium = Medium, p0_par=90000)
    annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
  Boundaries.Sink sink5(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Processes.FlowResistance flowResistance5(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.005,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Processes.FlowResistance flowResistance6(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.005,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Processes.FlowResistance flowResistance7(
    redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.005,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Processes.FlowResistance flowResistance8(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.005,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Processes.FlowResistance flowResistance9(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.005,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  inner DropOfCommons dropOfCommons annotation (
    Placement(visible = true, transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-50,70},{-40,70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet, source1.outlet) annotation (Line(
      points={{-40,30},{-50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, junctionNM.inlets[1])
    annotation (Line(
      points={{-20,30},{-14,30},{-14,49.5},{-10,49.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, junctionNM.inlets[2])
    annotation (Line(
      points={{-20,70},{-14,70},{-14,50.5},{-10,50.5}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionNM.outlets[2], flowResistance2.inlet) annotation (Line(
      points={{10,50},{20,50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.inlet, junctionNM.outlets[1])
    annotation (Line(
      points={{20,20},{14,20},{14,49.3333},{10,49.3333}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.inlet, junctionNM.outlets[3])
    annotation (Line(
      points={{20,80},{14,80},{14,50.6667},{10,50.6667}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, sink2.inlet) annotation (Line(
      points={{40,20},{50,20}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance2.outlet) annotation (Line(
      points={{50,50},{40,50}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance4.outlet) annotation (Line(
      points={{50,80},{40,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, flowResistance5.inlet) annotation (Line(
      points={{-50,-30},{-40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.inlet, source3.outlet) annotation (Line(
      points={{-40,-70},{-50,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.outlet, junctionNM1.inlets[1])
    annotation (Line(
      points={{-20,-70},{-14,-70},{-14,-50.5},{-10,-50.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.outlet, junctionNM1.inlets[2])
    annotation (Line(
      points={{-20,-30},{-14,-30},{-14,-49.5},{-10,-49.5}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionNM1.outlets[2], flowResistance7.inlet)
    annotation (Line(
      points={{10,-50},{20,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance8.inlet, junctionNM1.outlets[1])
    annotation (Line(
      points={{20,-80},{14,-80},{14,-50.6667},{10,-50.6667}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance9.inlet, junctionNM1.outlets[3])
    annotation (Line(
      points={{20,-20},{14,-20},{14,-49.3333},{10,-49.3333}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance8.outlet, sink5.inlet) annotation (Line(
      points={{40,-80},{50,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(sink4.inlet, flowResistance7.outlet) annotation (Line(
      points={{50,-50},{40,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(sink3.inlet, flowResistance9.outlet) annotation (Line(
      points={{50,-20},{40,-20}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end TestJunctionNM;
