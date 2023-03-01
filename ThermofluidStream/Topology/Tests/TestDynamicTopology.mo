within ThermofluidStream.Topology.Tests;
model TestDynamicTopology
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

  DynamicJunctionNM dynamicJunctionNM(
    redeclare package Medium = Medium,
    N=2,
    M=3,
    assumeConstantDensity=false,
    A_in(each displayUnit="cm2") = {0.0001,0.0002},
    A_out(each displayUnit="cm2") = {0.0001,0.0002,0.0003})
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Boundaries.Source source(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{76,70},{96,90}})));
  Boundaries.Source source1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{76,40},{96,60}})));
  Boundaries.Sink sink2(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{76,10},{96,30}})));
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
  Boundaries.DynamicPressureInflow dynamicPressureInflow(
    redeclare package Medium = Medium,
    A_par(displayUnit="cm2") = 0.0001,
    v_in_par=3) annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow1(
    redeclare package Medium = Medium,
    A_par(displayUnit="cm2") = 0.0002,
    v_in_par=2) annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow(
    redeclare package Medium = Medium,
    A_par(displayUnit="cm2") = 0.0001,
    v_out_par=-1) annotation (Placement(transformation(extent={{50,70},{70,90}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow1(
    redeclare package Medium = Medium,
    A_par(displayUnit="cm2") = 0.0002)
    annotation (Placement(transformation(extent={{50,40},{70,60}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow2(
    redeclare package Medium = Medium,
    A_par(displayUnit="cm2") = 0.0003,
    v_out_par=1) annotation (Placement(transformation(extent={{50,10},{70,30}})));
  DynamicJunctionNM dynamicJunctionNM1(
    redeclare package Medium = Medium,
    N=2,
    M=3,
    assumeConstantDensity=true,
    A_in(each displayUnit="cm2") = {0.0001,0.0002},
    A_out(each displayUnit="cm2") = {0.0001,0.0002,0.0003},
    A_splitter=10)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Boundaries.Source source2(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Boundaries.Sink sink3(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{76,-30},{96,-10}})));
  Boundaries.Source source3(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Boundaries.Sink sink4(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{76,-60},{96,-40}})));
  Boundaries.Sink sink5(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{76,-90},{96,-70}})));
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
  Boundaries.DynamicPressureInflow dynamicPressureInflow2(
    redeclare package Medium = Medium,
    A_par(displayUnit="cm2") = 0.0001,
    v_in_par=3) annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow3(
    redeclare package Medium = Medium,
    A_par(displayUnit="cm2") = 0.0002,
    v_in_par=2) annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow3(
    redeclare package Medium = Medium,
    A_par(displayUnit="cm2") = 0.0001,
    v_out_par=-1) annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow4(
    redeclare package Medium = Medium,
    A_par(displayUnit="cm2") = 0.0002)
    annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow5(
    redeclare package Medium = Medium,
    A_par(displayUnit="cm2") = 0.0003,
    v_out_par=1) annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons annotation (
    Placement(visible = true, transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(flowResistance1.outlet, dynamicJunctionNM.inlets[1])
    annotation (Line(
      points={{-20,30},{-14,30},{-14,49.5},{-10,49.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, dynamicJunctionNM.inlets[2])
    annotation (Line(
      points={{-20,70},{-14,70},{-14,50.5},{-10,50.5}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicJunctionNM.outlets[2], flowResistance2.inlet)
    annotation (Line(
      points={{10,50},{20,50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.inlet, dynamicJunctionNM.outlets[1])
    annotation (Line(
      points={{20,20},{14,20},{14,49.3333},{10,49.3333}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.inlet, dynamicJunctionNM.outlets[3])
    annotation (Line(
      points={{20,80},{14,80},{14,50.6667},{10,50.6667}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, dynamicPressureInflow.outlet)
    annotation (Line(
      points={{-40,70},{-50,70}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, dynamicPressureInflow.inlet) annotation (Line(
      points={{-80,70},{-70,70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet, dynamicPressureInflow1.outlet)
    annotation (Line(
      points={{-40,30},{-50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow1.inlet, source1.outlet) annotation (Line(
      points={{-70,30},{-80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, dynamicPressureOutflow.outlet) annotation (Line(
      points={{76,80},{70,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow.inlet, flowResistance4.outlet)
    annotation (Line(
      points={{50,80},{40,80}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, dynamicPressureOutflow1.outlet) annotation (Line(
      points={{76,50},{70,50}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow1.inlet, flowResistance2.outlet)
    annotation (Line(
      points={{50,50},{40,50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, dynamicPressureOutflow2.inlet)
    annotation (Line(
      points={{40,20},{50,20}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow2.outlet, sink2.inlet) annotation (Line(
      points={{70,20},{76,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.outlet, dynamicJunctionNM1.inlets[1])
    annotation (Line(
      points={{-20,-70},{-14,-70},{-14,-50.5},{-10,-50.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.outlet, dynamicJunctionNM1.inlets[2])
    annotation (Line(
      points={{-20,-30},{-14,-30},{-14,-49.5},{-10,-49.5}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicJunctionNM1.outlets[2], flowResistance7.inlet)
    annotation (Line(
      points={{10,-50},{20,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance8.inlet, dynamicJunctionNM1.outlets[1])
    annotation (Line(
      points={{20,-80},{14,-80},{14,-50.6667},{10,-50.6667}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance9.inlet, dynamicJunctionNM1.outlets[3])
    annotation (Line(
      points={{20,-20},{14,-20},{14,-49.3333},{10,-49.3333}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.inlet, dynamicPressureInflow2.outlet)
    annotation (Line(
      points={{-40,-30},{-50,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, dynamicPressureInflow2.inlet)
    annotation (Line(
      points={{-80,-30},{-70,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.inlet, dynamicPressureInflow3.outlet)
    annotation (Line(
      points={{-40,-70},{-50,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow3.inlet, source3.outlet)
    annotation (Line(
      points={{-70,-70},{-80,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(sink3.inlet, dynamicPressureOutflow3.outlet) annotation (Line(
      points={{76,-20},{70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow3.inlet, flowResistance9.outlet)
    annotation (Line(
      points={{50,-20},{40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sink4.inlet, dynamicPressureOutflow4.outlet) annotation (Line(
      points={{76,-50},{70,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow4.inlet, flowResistance7.outlet)
    annotation (Line(
      points={{50,-50},{40,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance8.outlet, dynamicPressureOutflow5.inlet)
    annotation (Line(
      points={{40,-80},{50,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow5.outlet, sink5.inlet) annotation (Line(
      points={{70,-80},{76,-80}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end TestDynamicTopology;
