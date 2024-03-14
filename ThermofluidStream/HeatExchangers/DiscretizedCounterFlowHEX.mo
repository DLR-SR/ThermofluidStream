within ThermofluidStream.HeatExchangers;
model DiscretizedCounterFlowHEX "Discretized heat exchanger for single- or two-phase working fluids without pressure drop"
  extends Internal.PartialDiscretizedHEX;

initial equation

  if initializeMassFlow then
    inletA.m_flow = m_flow_0_A;
    inletB.m_flow = m_flow_0_B;
  end if;

equation
  //Connecting equations (to interconnect pipes)
  //Fluid Side B
  connect(inletB, thermalElementB[1].inlet) annotation (Line(points={{-100,80},{-10,80}}, color={28,108,200}));
  for i in 1:nCells - 1 loop
    connect(thermalElementB[i].outlet, thermalElementB[i + 1].inlet);
  end for;
  connect(thermalElementB[nCells].outlet, outletB) annotation (Line(points={{10,80},{100,80}}, color={28,108,200}));

  //Fluid Side A
  connect(inletA, thermalElementA[1].inlet) annotation (Line(points={{100,-80},{10,-80}}, color={28,108,200}));
  for i in 1:nCells - 1 loop
    connect(thermalElementA[i].outlet, thermalElementA[i + 1].inlet);
  end for;
  connect(thermalElementA[nCells].outlet, outletA) annotation (Line(points={{-10,-80},{-100,-80}}, color={28,108,200}));

  connect(thermalElementB.heatPort, thermalConductor.port_b) annotation (Line(points={{0,70.2},{0,10}}, color={191,0,0}));

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
          extent={{80,-94},{120,-134}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{-120,132},{-80,92}},
          textColor={175,175,175},
          textString="B")}), Documentation(info="<html>
<p>The counter-flow discretized heat exchanger uses a number of conduction elements (which is set by the parameter nCells) as discrete control volumes to exchange heat between two fluid streams. </p>
<p>For each side the elements are numbered 1 to nCells in the flow direction and the elements&apos; heatports are connected via a thermal conductor that models the wall. The connections are ordered to result in a counter-flow configuration. </p>
<p>The conduction elements are computing a heat transfer coefficient between their heatport and the fluid contained. They are replaceable with a choice between a single-phase and a two-phase version, both can be further parametrized. Although the single-phase version works for two-phase media (not the other way around), using the two-phase one for two-phase media enables to set different heat transfer coefficients depending on the phase (liquid/gaseous/2-phase) state of the medium. </p>
<p>Note that since the model uses conductionElements as discrete control volumes that in turn assume quasi-stationary mass and therefore are part of a fluid stream rather than break it into two (like a full volume would), the same holds for both sides of the heat exchanger; they are part of a fluid stream and don&apos;t break it. The quasi-stationary mass assumption also implies that for (fast) changing masses/densities in any of the conduction elements the heat exchanger will (slightly) violate the conservation of energy. Furthermore, the conduction elements change their behavior for reversed mass-flow, therefore this model asserts for negative mass-flow with the level dropOfCommons.assertionLevel, see <a href=\"modelica://ThermofluidStream.UsersGuide.Rules\">composition rules</a> for more detail. </p>
<p>The parameters A (heat transferring area), k_wall (heat transfer coefficient of the wall between the streams) and the heat transfer coefficients in the conduction elements scale the transferred heat (the middle only if the wall and the latter only of the heat transfer into a fluid is the choke of the heatflow). </p>
<p>The parameter V determines the amount of fluid in the heat exchanger and therefore the dynamic for non-steady states. </p>
<p>The initialization tab allows for a mass-flow initialization for both paths. </p>
<p>The Advanced tab allows to modify the massflow that triggers the reverse-massflow-assertion and has an option to enforce global conservation of energy. The latter is done by feeding back any energy the conduction elements accumulated over time, basically making it impossible to store energy in their fluid long-term. While this enforces long-term conservation of energy it changes the medium-/short-term dynamics of the system and is therefore disabled by default. </p>
</html>"));
end DiscretizedCounterFlowHEX;
