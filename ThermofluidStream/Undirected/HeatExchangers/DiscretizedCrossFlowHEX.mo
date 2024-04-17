within ThermofluidStream.Undirected.HeatExchangers;
model DiscretizedCrossFlowHEX "Discretized heat exchanger for single- or two-phase working fluid without pressure drop"

  extends Internal.PartialDiscretizedHEX(nCellsParallel=nCells,final crossFlow=true);

  Processes.FlowResistance flowResistanceA[nCells](
    redeclare package Medium = MediumA,
    each r(each displayUnit="mm") = 0.025,
    each l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (each k=50)) annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
  Topology.JunctionMN junctionMN(
    redeclare package Medium = MediumA,
    N=1,
    M=nCells) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,-60})));
  Topology.JunctionMN junctionMN1(redeclare package Medium = MediumA, N=nCells) annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));

initial equation

  if initializeMassFlow then
    rearB.m_flow = m_flow_0_B;
    flowResistanceA.m_flow = m_flow_0_A/nCells*ones(nCells);
  else
    for i in 1:nCells - 1 loop
      flowResistanceA[i + 1].m_flow = flowResistanceA[1].m_flow;
    end for;
  end if;

equation
  //Connecting equations (to interconnect pipes)

  //Fluid side B
  connect(rearB, thermalElementB[1].rear) annotation (Line(points={{-100,60},{-62,60},{-62,60},{-10,60}},
                                                                                        color={28,108,200}));
  for i in 1:nCells - 1 loop
    connect(thermalElementB[i].fore, thermalElementB[i + 1].rear);
  end for;
  connect(thermalElementB[nCells].fore, foreB) annotation (Line(points={{10,60},{62,60},{62,60},{100,60}},
                                                                                               color={28,108,200}));

  connect(thermalElementA.heatPort, thermalConductor.port_a) annotation (Line(points={{4.44089e-16,-50.2},{4.44089e-16,-40},{0,-40},{0,-10}}, color={191,0,0}));
  connect(thermalElementB.heatPort, thermalConductor.port_b) annotation (Line(points={{4.44089e-16,50.2},{4.44089e-16,40},{0,40},{0,10}}, color={191,0,0}));

  //Fluid side A
  connect(junctionMN1.fores[1], foreA) annotation (Line(
      points={{-80,-60},{-100,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionMN.rears[1], rearA) annotation (Line(
      points={{60,-60},{100,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionMN.fores, thermalElementA.rear) annotation (Line(
      points={{40,-60},{10,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceA.rear, thermalElementA.fore) annotation (Line(
      points={{-20,-60},{-10,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceA.fore, junctionMN1.rears) annotation (Line(
      points={{-40,-60},{-60,-60}},
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
          extent={{-12,34},{0,22}},
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
          textString="B"),
       Line(
         points={{-12,0},{10,4.89858e-16}},
         thickness=0.5,
         color={28,108,200},
          origin={0,-88},
          rotation=90),
       Line(
         points={{-100,-60},{-76,-60}},
         thickness=0.5,
         color={28,108,200}),
       Line(
         points={{76,-60},{100,-60}},
         thickness=0.5,
         color={28,108,200})}),
                             Documentation(info="<html>
<p>The undirected cross-flow discretized heat exchanger uses a number of conduction elements (which is set by the parameter nCells) as discrete control volumes to exchange heat between two fluid streams. </p>
<p>Side A splits the fluid stream into nCells substreams that are parallel. The flow-resistance is chosen to be very small and only ensures numerical stability of the parallel streams. By default, it is a linear-quadratic flow resistance, so the mass flow through each of the parallel streams is the same. If exchanged for flow-resistance that depends on media properties (e.g. a laminar-turbulent) the mass flow on the paths will be different. For side B the elements are serial and numbered 1 to nCells in the flow direction. The elements&apos; heatports are connected via a thermal conductor that models the wall. The connections are ordered to result in a cross-flow configuration. </p>
<p>The conduction elements are computing a heat transfer coefficient between their heatport and the fluid contained. They are replaceable with a choice between a single-phase and a two-phase version, both can be further parametrized. Although the single-phase version works for two-phase media (not the other way around), using the two-phase one for two-phase media enables to set different heat transfer coefficients depending on the phase (liquid/gaseous/2-phase) state of the medium. </p>
<p>Note that since the model uses conductionElements as discrete control volumes that in turn assume quasi-stationary mass and therefore are part of a fluid stream rather than break it into two (like a full volume would), the same holds for both sides of the heat exchanger - they are part of a fluid stream and don&apos;t break it. The quasi-stationary mass assumption also implies that for (fast) changing masses/densities in any of the conduction elements the heat exchanger will (slightly) violate the conservation of energy. Furthermore, the conduction elements change their behavior for reversed mass flow, therefore this model asserts for negative mass flow with the level dropOfCommons.assertionLevel. </p>
<p>The parameters A (heat transferring area), k_wall (heat transfer coefficient of the wall between the streams) and the heat transfer coefficients in the conduction elements scale the transferred heat (the middle only if the wall and the latter only of the heat transfer into a fluid is the choke of the heatflow). </p>
<p>The parameter V determines the amount of fluid in the heat exchanger and therefore the dynamic for non-steady states. </p>
<p>The initialization tab allows for a mass flow initialization for both paths, as well as to determine from which direction the enthalpy in the control volumes should be initialized (fore/rear), or if it should start with a given enthalpy. The other option is to initialize the enthalpy with a given value. </p>
<p>The Advanced tab allows to modify the mass flow that triggers the reverse-mass-flow-assertion and has an option to enforce global conservation of energy. The latter is done by feeding back any energy the conduction elements accumulated over time, basically making it impossible to store energy in their fluid long-term. While this enforces long-term conservation of energy it changes the medium-/short-term dynamics of the system and is therefore disabled by default. </p>
</html>"));
end DiscretizedCrossFlowHEX;
