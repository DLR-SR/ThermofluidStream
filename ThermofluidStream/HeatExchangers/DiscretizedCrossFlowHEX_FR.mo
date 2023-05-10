within ThermofluidStream.HeatExchangers;
model DiscretizedCrossFlowHEX_FR "Discretized Heat Exchanger for single- or two-phase working fluid with pressure drop"
  extends Internal.PartialDiscretizedHEX(nCellsParallel=nCells,crossFlow=true);

  Processes.FlowResistance flowResistanceA[nCells](
    redeclare package Medium = MediumA,
    each r=1,
    each l=1,
    each computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      each k=k1_A,
      each k2=k2_A)) annotation (Placement(transformation(extent={{-20,-90},{-40,-70}})));
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
        origin={50,80})));

  Topology.JunctionN junctionN(
    redeclare package Medium = MediumA,
    N=nCells) annotation (Placement(transformation(extent={{-60,-90},{-80,-70}})));
  Topology.SplitterN splitterN(
    redeclare package Medium = MediumA,
    N=nCells) annotation (Placement(transformation(extent={{60,-90},{40,-70}})));

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
      points={{-100,80},{-10,80}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalElementB.outlet, flowResistanceB.inlet) annotation (Line(
      points={{10,80},{40,80}},
      color={28,108,200},
      thickness=0.5));
  for i in 1:nCells - 1 loop
    connect(flowResistanceB[i].outlet, thermalElementB[i + 1].inlet);
  end for;
  connect(flowResistanceB[nCells].outlet, outletB) annotation (Line(
      points={{60,80},{100,80}},
      color={28,108,200},
      thickness=0.5));

  connect(thermalElementA.heatPort, thermalConductor.port_a) annotation (Line(points={{4.44089e-16,-70.2},{4.44089e-16,-40},{0,-40},{0,-10}}, color={191,0,0}));
  connect(thermalElementB.heatPort, thermalConductor.port_b) annotation (Line(points={{4.44089e-16,70.2},{4.44089e-16,40},{0,40},{0,10}}, color={191,0,0}));

  connect(inletA, splitterN.inlet) annotation (Line(
      points={{100,-80},{60,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets, thermalElementA.inlet) annotation (Line(
      points={{40,-80},{10,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalElementA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{-10,-80},{-20,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceA.outlet, junctionN.inlets) annotation (Line(
      points={{-40,-80},{-60,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.outlet, outletA) annotation (Line(
      points={{-80,-80},{-100,-80}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(graphics={
        Text(
          extent={{-72,76},{-60,64}},
          textColor={28,108,200},
          textString="N"),
        Text(
          extent={{-42,76},{-30,64}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{-10,76},{2,64}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{20,76},{32,64}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{50,76},{62,64}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{10,134},{50,94}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{80,-94},{120,-134}},
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
end DiscretizedCrossFlowHEX_FR;
