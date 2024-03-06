within ThermofluidStream.HeatExchangers;
model DiscretizedCrossFlowHEX_FR2 "v2 of DiscretizedCrossFlowHEX_FR"
  extends Internal.DiscretizedCounterFlowHexIcon;
  extends Internal.PartialDiscretizedHEX(nCellsParallel=nCells,crossFlow=true);

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
    N=nCells) annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
  Topology.SplitterN splitterN(
    redeclare package Medium = MediumA,
    N=nCells) annotation (Placement(transformation(extent={{60,-70},{40,-50}})));

  parameter Real k1_A=1e2 "Linear flowres factor A" annotation (Dialog(group="laminar-turbulent flowRes"));
  parameter Real k2_A=1e2 "Quadratic flowres factor A" annotation (Dialog(group="laminar-turbulent flowRes"));
  parameter Real k1_B=1e2 "Linear flowres factor B" annotation (Dialog(group="laminar-turbulent flowRes"));
  parameter Real k2_B=1e2 "Quadratic flowres factor B" annotation (Dialog(group="laminar-turbulent flowRes"));

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
  //Connecting equations (to interconnect pipes)
  //Fluid Side B
  connect(inletB, thermalElementB[1].inlet) annotation (Line(
      points={{-100,60},{-56,60},{-56,60},{-10,60}},
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

  connect(thermalElementA.heatPort, thermalConductor.port_a) annotation (Line(points={{4.44089e-16,-50.2},{4.44089e-16,-40},{0,-40},{0,-10}}, color={191,0,0}));
  connect(thermalElementB.heatPort, thermalConductor.port_b) annotation (Line(points={{4.44089e-16,50.2},{4.44089e-16,40},{0,40},{0,10}}, color={191,0,0}));

  connect(inletA, splitterN.inlet) annotation (Line(
      points={{100,-60},{80,-60},{80,-60},{60,-60}},
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
      points={{-40,-60},{-60,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.outlet, outletA) annotation (Line(
      points={{-80,-60},{-100,-60}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(graphics={
        Text(visible=displayInstanceName,
          extent={{-150,160},{150,120}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{0,78},{0,100}},
          color={28,108,200},
          thickness=0.5),
        Text(
          extent={{-66,32},{-54,20}},
          textColor={28,108,200},
          textString="N"),
        Text(
          extent={{-40,32},{-28,20}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{-12,32},{0,20}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{16,32},{28,20}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{42,32},{54,20}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-60,120},{-20,80}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{80,0},{120,-40}},
          textColor={175,175,175},
          textString="B")}), Documentation(info="<html>
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
end DiscretizedCrossFlowHEX_FR2;
