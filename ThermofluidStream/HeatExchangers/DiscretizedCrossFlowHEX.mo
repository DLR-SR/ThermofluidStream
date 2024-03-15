within ThermofluidStream.HeatExchangers;
model DiscretizedCrossFlowHEX "Discretized heat exchanger for single- or two-phase working fluid without pressure drop"

  extends Internal.PartialDiscretizedHEX(nCellsParallel=nCells,crossFlow=true);

  Processes.FlowResistance flowResistanceA[nCells](
    redeclare package Medium = MediumA,
    each r(each displayUnit="mm") = 0.025,
    each l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      each k=50)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,-60})));
  Topology.JunctionN junctionN(
    redeclare package Medium = MediumA,
    N=nCells) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,-60})));
  Topology.SplitterN splitterN(
    redeclare package Medium = MediumA,
    N=nCells) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,-60})));

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
  connect(inletB, thermalElementB[1].inlet) annotation (Line(points={{-100,60},{-10,60}}, color={28,108,200}));
  for i in 1:nCells - 1 loop
    connect(thermalElementB[i].outlet, thermalElementB[i + 1].inlet);
  end for;
  connect(thermalElementB[nCells].outlet, outletB) annotation (Line(points={{10,60},{100,60}}, color={28,108,200}));
  connect(thermalElementB.heatPort, thermalConductor.port_b) annotation (Line(points={{0,50},{0,14},{-1.77636e-15,14},{-1.77636e-15,10},{0,10}},   color={191,0,0}));
  connect(thermalElementA.heatPort, thermalConductor.port_a) annotation (Line(points={{0,-50},{0,-42},{0,-42},{0,-10},{0,-10}},   color={191,0,0}));
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
          textColor=dropOfCommons.instanceNameColor),
        Line(
          points={{0,78},{0,100}},
          color={28,108,200},
          thickness=0.5),
        Text(
          extent={{-66,54},{-54,42}},
          textColor={28,108,200},
          textString="N"),
        Text(
          extent={{-40,54},{-28,42}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{-12,54},{0,42}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{16,54},{28,42}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{42,54},{54,42}},
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
<p>The cross-flow discretized heat exchanger uses a number of conduction elements (which is set by the parameter nCells) as discrete control volumes to exchange heat between two fluid streams. </p>
<p>Side A splits the fluid stream into nCells substreams that are parallel. The flow-resistance is chosen to be very small and only ensures numerical stability of the parallel streams. By default, it is a linear-quadratic flow resistance, so the massflows through each of the parallel streams is the same. If exchanged for flow-resistance that depends on media properties (e.g. a laminar-turbulent) the mass-flow on the paths will be different. For side B the elements are serial and numbered 1 to nCells in the flow direction. The elements&apos; heatports are connected via a thermal conductor that models the wall. The connections are ordered to result in a cross-flow configuration. </p>
<p>The conduction elements are computing a heat transfer coefficient between their heatport and the fluid contained. They are replaceable with a choice between a single-phase and a two-phase version, both can be further parametrized. Although the single-phase version works for two-phase media (not the other way around), using the two-phase one for two-phase media enables to set different heat transfer coefficients depending on the phase (liquid/gaseous/2-phase) state of the medium. </p>
<p>Note that since the model uses conductionElements as discrete control volumes that in turn assume quasi-stationary mass and therefore are part of a fluid stream rather than break it into two (like a full volume would), the same holds for both sides of the heat exchanger - they are part of a fluid stream and don&apos;t break it. The quasi-stationary mass assumption also implies that for (fast) changing masses/densities in any of the conduction elements the heat exchanger will (slightly) violate the conservation of energy. Furthermore, the conduction elements change their behavior for reversed mass-flow, therefore this model asserts for negative mass-flow with the level dropOfCommons.assertionLevel, see <a href=\"modelica://ThermofluidStream.UsersGuide.Rules\">composition rules</a> for more detail. </p>
<p>The parameters A (heat transferring area), k_wall (heat transfer coefficient of the wall between the streams) and the heat transfer coefficients in the conduction elements scale the transferred heat (the middle only if the wall and the latter only of the heat transfer into a fluid is the choke of the heatflow). </p>
<p>The parameter V determines the amount of fluid in the heat exchanger and therefore the dynamic for non-steady states. </p>
<p>The initialization tab allows for a mass-flow initialization for both paths. </p>
<p>The Advanced tab allows to modify the massflow that triggers the reverse-massflow-assertion and has an option to enforce global conservation of energy. The latter is done by feeding back any energy the conduction elements accumulated over time, basically making it impossible to store energy in their fluid long-term. While this enforces long-term conservation of energy it changes the medium-/short-term dynamics of the system and is therefore disabled by default. </p>
</html>"));
end DiscretizedCrossFlowHEX;
