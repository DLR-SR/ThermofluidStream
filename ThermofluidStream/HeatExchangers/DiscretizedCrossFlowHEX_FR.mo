within ThermofluidStream.HeatExchangers;
model DiscretizedCrossFlowHEX_FR "Discretized Heat Exchanger for single- or two-phase working fluid with pressure drop"

  extends Internal.PartialDiscretizedHEX(nCellsParallel=nCells);

  parameter Real k1_A=1e2 "Linear flow resistance coefficient at side A"
    annotation (Dialog(group="Flow resistance coefficients"));
  parameter Real k2_A=1e2 "Quadratic flow resistance coefficient at side A"
    annotation (Dialog(group="Flow resistance coefficients"));
  parameter Real k1_B=1e2 "Linear flow resistance coefficient at side B"
    annotation (Dialog(group="Flow resistance coefficients"));
  parameter Real k2_B=1e2 "Quadratic flow resistance coefficient at side B"
    annotation (Dialog(group="Flow resistance coefficients"));

  Interfaces.Inlet inletB(
    redeclare package Medium = MediumB)
    annotation (Placement(
      transformation(extent={{-120,40},{-80,80}}),
      iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-100,0})));

  Interfaces.Outlet outletB(
    redeclare package Medium = MediumB)
    annotation (Placement(
      transformation(extent={{80,40},{120,80}}),
      iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={100,0})));

  Interfaces.Inlet inletA(
    redeclare package Medium = MediumA)
    annotation (Placement(
      transformation(extent={{120,-80},{80,-40}}),
      iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={0,100})));

  Interfaces.Outlet outletA(
    redeclare package Medium = MediumA)
    annotation (Placement(
      transformation(extent={{-80,-80},{-120,-40}}),
      iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={0,-100})));

  Processes.FlowResistance flowResistanceA[nCells](
    redeclare package Medium = MediumA,
    each r=1,
    each l=1,
    each computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      each k=k1_A,
      each k2=k2_A)) annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
  Processes.FlowResistance flowResistanceB[nCells](
    redeclare package Medium = MediumB,
    each r=1,
    each l=1,
    each computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      each k=k1_B,
      each k2=k2_B)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={50,60})));

  Topology.JunctionN junctionN(
    redeclare package Medium = MediumA,
    N=nCells) annotation (Placement(transformation(extent={{-52,-70},{-72,-50}})));
  Topology.SplitterN splitterN(
    redeclare package Medium = MediumA,
    N=nCells) annotation (Placement(transformation(extent={{60,-70},{40,-50}})));

initial equation

  if initializeMassFlow then
    inletB.m_flow = m_flow_0_B;
    flowResistanceA.m_flow = m_flow_0_A/nCells*ones(nCells);
  else
    for i in 1:nCells - 1 loop
      flowResistanceA[i + 1].m_flow = flowResistanceA[1].m_flow;
    end for;
  end if;

equation
  inletA.state = inletA_state;
  inletA.m_flow = inletA_m_flow;
  inletA.r = inletA_r;

  inletB.state = inletB_state;
  inletB.m_flow = inletB_m_flow;
  inletB.r = inletB_r;

  outletA.state = outletA_state;
  outletA.m_flow = outletA_m_flow;
  outletA.r = outletA_r;

  outletB.state = outletB_state;
  outletB.m_flow = outletB_m_flow;
  outletB.r = outletB_r;

  //Connecting equations (to interconnect pipes)
  //Fluid Side B
  connect(inletB, thermalElementB[1].inlet) annotation (Line(
      points={{-100,60},{-10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalElementB.outlet, flowResistanceB.inlet) annotation (Line(
      points={{10,60},{40,60}},
      color={28,108,200},
      thickness=0.5));
  for i in 1:nCells - 1 loop
    connect(flowResistanceB[i].outlet, thermalElementB[i + 1].inlet);
  end for;
  connect(flowResistanceB[nCells].outlet, outletB) annotation (Line(
      points={{60,60},{100,60}},
      color={28,108,200},
      thickness=0.5));

  connect(thermalElementA.heatPort, thermalConductor.port_a) annotation (Line(points={{4.44089e-16,-50},{4.44089e-16,-40},{0,-40},{0,-10}},   color={191,0,0}));
  connect(thermalElementB.heatPort, thermalConductor.port_b) annotation (Line(points={{4.44089e-16,50},{4.44089e-16,40},{0,40},{0,10}},   color={191,0,0}));

  connect(inletA, splitterN.inlet) annotation (Line(
      points={{100,-60},{60,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets, thermalElementA.inlet) annotation (Line(
      points={{40,-60},{10,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalElementA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{-10,-60},{-20,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceA.outlet, junctionN.inlets) annotation (Line(
      points={{-40,-60},{-52,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.outlet, outletA) annotation (Line(
      points={{-72,-60},{-100,-60}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(graphics={
        Text(visible=displayInstanceName,
          extent={{-150,160},{150,120}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(
          extent={{-60,120},{-20,80}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{-80,60},{-120,20}},
          textColor={175,175,175},
          textString="B"),
        Line(
          points={{0,60},{0,100}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-56,54},{64,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{0,0},{0,-100}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,18},{0,56}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-48,6},{52,6}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-48,-6},{52,-6}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{28,18},{28,42}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-28,18},{-28,44}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-25,24},
          rotation=270),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-31,24},
          rotation=270),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={3,24},
          rotation=270),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-3,24},
          rotation=270),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={31,24},
          rotation=270),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={25,24},
          rotation=270),
        Line(
          points={{-28,-50},{-28,-24}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-25,-44},
          rotation=270),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-31,-44},
          rotation=270),
        Line(
          points={{0,-50},{0,-12}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-3,-44},
          rotation=270),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={3,-44},
          rotation=270),
        Line(
          points={{28,-50},{28,-26}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={25,-44},
          rotation=270),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={31,-44},
          rotation=270),
        Line(
          points={{42,2},{52,6}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{42,10},{52,6}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{42,-10},{52,-6}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{42,-2},{52,-6}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B then {238,46,47} else {21,85,157}),
          thickness=0.5)}),  Documentation(info="<html>
<p>
The cross-flow discretized heat exchanger uses a number of conduction elements
(which is set by the parameter nCells) as discrete control volumes to exchange
heat between two fluid streams. This model differs from DiscretizedCrossFlowHEX
by introducing flow-resistances after each control volume, but otherwise is the
same, therefore consider the documentation of DiscretizedCrossFlowHEX.
</p>
<p>
The flowResistances are parametrized by the parameters in the group 
<strong>laminar-turbulent&nbsp;flowRes.</strong>
</p>
</html>"));
end DiscretizedCrossFlowHEX_FR;
