within ThermofluidStream.Undirected.HeatExchangers;
model DiscretizedCounterFlowHEX "Discretized heat exchanger for single- or two-phase working fluids without pressure drop"

  extends Internal.PartialDiscretizedHEX;

initial equation
  if initializeMassFlow then
    rearA.m_flow = m_flow_0_A;
    rearB.m_flow = m_flow_0_B;
  end if;

equation
  //Connecting equations (to interconnect pipes)
  //Fluid side B
  connect(rearB, thermalElementB[1].rear) annotation (Line(points={{-100,60},{-10,60}}, color={28,108,200}));
  for i in 1:nCells - 1 loop
    connect(thermalElementB[i].fore, thermalElementB[i + 1].rear);
  end for;
  connect(thermalElementB[nCells].fore, foreB) annotation (Line(points={{10,60},{100,60}}, color={28,108,200}));

  //Fluid side A
  connect(rearA, thermalElementA[1].rear) annotation (Line(points={{100,-60},{10,-60}}, color={28,108,200}));
  for i in 1:nCells - 1 loop
    connect(thermalElementA[i].fore, thermalElementA[i + 1].rear);
  end for;
  connect(thermalElementA[nCells].fore, foreA) annotation (Line(points={{-10,-60},{-100,-60}}, color={28,108,200}));

  connect(thermalElementB.heatPort, thermalConductor.port_b) annotation (Line(points={{0,50.2},{0,10}}, color={191,0,0}));

  for i in 1:nCells loop
    connect(thermalElementA[i].heatPort, thermalConductor[nCells + 1 - i].port_a) annotation (Line(points={{-6.66134e-16,-50.2},{-6.66134e-16,-10},{0,-10}}, color={191,0,0}));
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
          textString="A"),
       Line(
         points={{76,60},{100,60}},
         thickness=0.5,
         color={28,108,200}),
       Line(
         points={{-100,60},{-76,60}},
         thickness=0.5,
         color={28,108,200}),
       Line(
         points={{-100,-60},{-76,-60}},
         thickness=0.5,
         color={28,108,200}),
       Line(
         points={{76,-60},{100,-60}},
         thickness=0.5,
         color={28,108,200})}),
                             Documentation(info="<html>
<p>The undirected counter-flow discretized heat exchanger uses a number of conduction elements (which is set by the parameter nCells) as discrete control volumes to exchange heat between two fluid streams. </p>
<p>For each side the elements are numbered 1 to nCells from rear to fore and the elements&apos; heatports are connected via a thermal conductor that models the wall. The connections are ordered to result in a counter-flow configuration. </p>
<p>The conduction elements are computing a heat transfer coefficient between their heatport and the fluid contained. They are replaceable with a choice between a single-phase and a two-phase version, both can be further parametrized. Although the single-phase version works for two-phase media (not the other way around), using the two-phase one for two-phase media enables to set different heat transfer coefficients depending on the phase (liquid/gaseous/2-phase) state of the medium. </p>
<p>Note that since the model uses conductionElements as discrete control volumes that in turn assume quasi-stationary mass and therefore are part of a fluid stream rather than break it into two (like a full volume would), the same holds for both sides of the heat exchanger; they are part of a fluid stream and don&apos;t break it. The quasi-stationary mass assumption also implies that for (fast) changing masses/densities in any of the conduction elements the heat exchanger will (slightly) violate the conservation of energy.</p>
<p>The parameters A (heat transferring area), k_wall (heat transfer coefficient of the wall between the streams) and the heat transfer coefficients in the conduction elements scale the transferred heat (the middle only if the wall and the latter only of the heat transfer into a fluid is the choke of the heatflow). </p>
<p>The parameter V determines the amount of fluid in the heat exchanger and therefore the dynamic for non-steady states. </p>
<p>The initialization tab allows for a mass flow initialization for both paths, as well as to determine from which direction the enthalpy in the control volumes should be initialized (fore/rear), or if it should start with a given enthalpy. The other option is to initialize the enthalpy with a given value.</p>
<p>The Advanced tab allows to influence the mass flow regularization for near zero mass flow and has an option to enforce global conservation of energy. The latter is done by feeding back any energy the conduction elements accumulated over time, basically making it impossible to store energy in their fluid long-term. While this enforces long-term conservation of energy it changes the medium-/short-term dynamics of the system and is therefore disabled by default. </p>
</html>"));
end DiscretizedCounterFlowHEX;
