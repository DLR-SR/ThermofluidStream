within ThermofluidStream.HeatExchangers;
model DiscretizedCounterFlowHEX_FR "Discretized Heat Exchanger for single- or two-phase working fluid with pressure drop"
  extends Internal.PartialDiscretizedHEX;

  Processes.FlowResistance flowResistanceB[nCells](
    redeclare package Medium = MediumB,
    each r=1,
    each l=1,
    each computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      each k=k1_B,
      each k2=k2_B)) annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Processes.FlowResistance flowResistanceA[nCells](
    redeclare package Medium = MediumA,
    each r=1,
    each l=1,
    each computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      each k=k1_A,
      each k2=k2_A)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,-80})));

  parameter Real k1_A=1e2 "Linear flowres factor A" annotation (Dialog(group="laminar-turbulent flowRes"));
  parameter Real k2_A=1e2 "Quadratic flowres factor A" annotation (Dialog(group="laminar-turbulent flowRes"));
  parameter Real k1_B=1e2 "Linear flowres factor B" annotation (Dialog(group="laminar-turbulent flowRes"));
  parameter Real k2_B=1e2 "Quadratic flowres factor B" annotation (Dialog(group="laminar-turbulent flowRes"));

initial equation

  if initializeMassFlow then
    inletA.m_flow = m_flow_0_A;
    inletB.m_flow = m_flow_0_B;
  end if;

equation
  //Connecting equations (to interconnect pipes)
  //Fluid Side B
  connect(inletB, thermalElementB[1].inlet) annotation (Line(points={{-100,80},{-10,80}}, color={28,108,200}));
  connect(flowResistanceB.inlet, thermalElementB.outlet) annotation (Line(
      points={{20,80},{10,80}},
      color={28,108,200},
      thickness=0.5));
  for i in 1:nCells - 1 loop
    connect(flowResistanceB[i].outlet, thermalElementB[i + 1].inlet);
  end for;
  connect(flowResistanceB[nCells].outlet, outletB) annotation (Line(
      points={{40,80},{100,80}},
      color={28,108,200},
      thickness=0.5));

  //Fluid Side A
  connect(inletA, thermalElementA[1].inlet) annotation (Line(points={{100,-80},{10,-80}}, color={28,108,200}));
  connect(flowResistanceA.inlet, thermalElementA.outlet) annotation (Line(
      points={{-40,-80},{-10,-80}},
      color={28,108,200},
      thickness=0.5));
  for i in 1:nCells - 1 loop
    connect(flowResistanceA[i].outlet, thermalElementA[i + 1].inlet);
  end for;
  connect(flowResistanceA[nCells].outlet, outletA) annotation (Line(
      points={{-60,-80},{-100,-80}},
      color={28,108,200},
      thickness=0.5));

  //Thermal connection
  connect(thermalElementB.heatPort, thermalConductor.port_b) annotation (Line(points={{4.44089e-16,70.2},{4.44089e-16,40},{0,40},{0,10}}, color={191,0,0}));
  for i in 1:nCells loop
    connect(thermalElementA[i].heatPort, thermalConductor[nCells + 1 - i].port_a) annotation (Line(points={{-6.66134e-16,-70.2},{-6.66134e-16,-10},{0,-10}}, color={191,0,0}));
  end for;

  annotation (Icon(graphics={
        Text(
          extent={{-70,76},{-58,64}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-40,76},{-28,64}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-8,76},{4,64}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{22,76},{34,64}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{50,76},{62,64}},
          textColor={28,108,200},
          textString="N"),
        Text(
          extent={{-120,132},{-80,92}},
          textColor={175,175,175},
          textString="B"),
        Text(
          extent={{80,-94},{120,-134}},
          textColor={175,175,175},
          textString="A")}), Documentation(info="<html>
<p>The counter-flow discretized heat exchanger uses a number of conduction elements (which is set by the parameter nCells) as discrete control volumes to exchange heat between two fluid streams. This model differs from DiscretizedCounterFlowHEX by introducing flow-resistances after each control volume, but otherwise is the same, therefore consider the documentation of DiscretizedCounterFlowHEX. </p>
<p>The flowResistances are parametrized by the parameters in the group laminar-turbulent flowRes.</p>
</html>"));
end DiscretizedCounterFlowHEX_FR;
