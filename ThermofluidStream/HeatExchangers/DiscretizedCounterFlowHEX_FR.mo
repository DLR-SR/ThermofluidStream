within ThermofluidStream.HeatExchangers;
model DiscretizedCounterFlowHEX_FR "Discretized Heat Exchanger for single- or two-phase working fluid with pressure drop"

  extends Internal.PartialDiscretizedHEX;

  parameter Real k1_A=1e2 "Linear flow resistance coefficient at side A"
    annotation (Dialog(group="Flow resistance coefficients"));
  parameter Real k2_A=1e2 "Quadratic flow resistance coefficient at side B"
    annotation (Dialog(group="Flow resistance coefficients"));
  parameter Real k1_B=1e2 "Linear flow resistance coefficient at side B"
    annotation (Dialog(group="Flow resistance coefficients"));
  parameter Real k2_B=1e2 "Quadratic flow resistance coefficient at side B"
    annotation (Dialog(group="Flow resistance coefficients"));

  Processes.FlowResistance flowResistanceB[nCells](
    redeclare package Medium = MediumB,
    each r=1,
    each l=1,
    each computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      each k=k1_B,
      each k2=k2_B)) annotation (Placement(transformation(extent={{40,50},{60,70}})));
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
        origin={-50,-60})));

initial equation
  if initializeMassFlow then
    inletA.m_flow = m_flow_0_A;
    inletB.m_flow = m_flow_0_B;
  end if;

equation
  //Connecting equations (to interconnect pipes)
  //Fluid Side B
  connect(inletB, thermalElementB[1].inlet) annotation (Line(points={{-100,60},{-56,60},{-56,60},{-10,60}},
                                                                                          color={28,108,200}));
  connect(flowResistanceB.inlet, thermalElementB.outlet) annotation (Line(
      points={{40,60},{10,60}},
      color={28,108,200},
      thickness=0.5));
  for i in 1:nCells - 1 loop
    connect(flowResistanceB[i].outlet, thermalElementB[i + 1].inlet);
  end for;
  connect(flowResistanceB[nCells].outlet, outletB) annotation (Line(
      points={{60,60},{100,60}},
      color={28,108,200},
      thickness=0.5));

  //Fluid Side A
  connect(inletA, thermalElementA[1].inlet) annotation (Line(points={{100,-60},{56,-60},{56,-60},{10,-60}},
                                                                                          color={28,108,200}));
  connect(flowResistanceA.inlet, thermalElementA.outlet) annotation (Line(
      points={{-40,-60},{-10,-60}},
      color={28,108,200},
      thickness=0.5));
  for i in 1:nCells - 1 loop
    connect(flowResistanceA[i].outlet, thermalElementA[i + 1].inlet);
  end for;
  connect(flowResistanceA[nCells].outlet, outletA) annotation (Line(
      points={{-60,-60},{-100,-60}},
      color={28,108,200},
      thickness=0.5));

  //Thermal connection
  connect(thermalElementB.heatPort, thermalConductor.port_b) annotation (Line(points={{4.44089e-16,50},{4.44089e-16,40},{0,40},{0,10}},   color={191,0,0}));
  for i in 1:nCells loop
    connect(thermalElementA[i].heatPort, thermalConductor[nCells + 1 - i].port_a) annotation (Line(points={{-6.66134e-16,-50},{-6.66134e-16,-10},{0,-10}},   color={191,0,0}));
  end for;

  annotation (Icon(graphics={
        Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible=d1A,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString="A = %A"),
        Text(
          extent={{-66,54},{-54,42}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-40,54},{-28,42}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-12,54},{0,42}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{16,54},{28,42}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{42,54},{54,42}},
          textColor={28,108,200},
          textString="N"),
        Text(
          extent={{-120,40},{-80,0}},
          textColor={175,175,175},
          textString="B"),
        Text(
          extent={{80,0},{120,-40}},
          textColor={175,175,175},
          textString="A")}), Documentation(info="<html>
<p>The counter-flow discretized heat exchanger uses a number of conduction elements (which is set by the parameter nCells) as discrete control volumes to exchange heat between two fluid streams. This model differs from DiscretizedCounterFlowHEX by introducing flow-resistances after each control volume, but otherwise is the same, therefore consider the documentation of DiscretizedCounterFlowHEX. </p>
<p>The flowResistances are parametrized by the parameters in the group laminar-turbulent flowRes.</p>
</html>"));
end DiscretizedCounterFlowHEX_FR;
