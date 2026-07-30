within ThermofluidStream.Undirected.HeatExchangers;
model DiscretizedCounterFlowHEX "Discretized heat exchanger for single- or two-phase working fluids without pressure drop"

  extends Internal.PartialDiscretizedHEX;

  Interfaces.Rear rearA(
    redeclare package Medium = MediumA)
    annotation (Placement(
      transformation(extent={{120,-80},{80,-40}}),
      iconTransformation(extent={{120,-80},{80,-40}})));

  Interfaces.Fore foreA(
    redeclare package Medium = MediumA)
    annotation (Placement(
      transformation(extent={{-80,-80},{-120,-40}}),
      iconTransformation(extent={{-80,-80},{-120,-40}})));

  Interfaces.Rear rearB(
    redeclare package Medium = MediumB)
    annotation (Placement(
      transformation(extent={{-120,40},{-80,80}}),
      iconTransformation(extent={{-120,40},{-80,80}})));

  Interfaces.Fore foreB(
    redeclare package Medium = MediumB)
    annotation (Placement(
      transformation(extent={{80,40},{120,80}}),
      iconTransformation(extent={{80,40},{120,80}})));

initial equation
  if initializeMassFlow then
    rearA.m_flow = m_flow_0_A;
    rearB.m_flow = m_flow_0_B;
  end if;

equation
  m_flow_A = rearA.m_flow;
  m_flow_B = rearB.m_flow;

  stateA_in =
    if noEvent(rearA.m_flow) > 0 then
      rearA.state_forwards
    else
      foreA.state_rearwards;

  stateA_out =
    if noEvent(rearA.m_flow) > 0 then
      foreA.state_forwards
    else
      rearA.state_rearwards;

  stateB_in =
    if noEvent(rearB.m_flow) > 0 then
      rearB.state_forwards
    else
      foreB.state_rearwards;

  stateB_out =
    if noEvent(rearB.m_flow) > 0 then
      foreB.state_forwards
    else
      rearB.state_rearwards;

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
        Rectangle(
          extent={{84,66},{-70,-86}},
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          radius=6),
        Text(
          visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(
          visible=d1A,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString="A = %A"),
        Text(
          visible=d1A,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString="A = %A"),
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
          color={28,108,200}),
        Rectangle(
          extent={{76,78},{-76,-78}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=6),
        Line(
          points={{60,52},{-60,52}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{60,36},{-60,36}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{60,-44},{-60,-44}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{60,-60},{-60,-60}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(true, m_flow_B > 0),
          points={{50,32},{60,36}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(true, m_flow_B > 0),
          points={{50,40},{60,36}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(true, m_flow_A > 0),
          points={{-50,-48},{-60,-44}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(true, m_flow_A > 0),
          points={{-50,-40},{-60,-44}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(true, m_flow_B > 0),
          points={{50,48},{60,52}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(true, m_flow_B > 0),
          points={{50,56},{60,52}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(true, m_flow_A > 0),
          points={{-50,-64},{-60,-60}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(true, m_flow_A > 0),
          points={{-50,-56},{-60,-60}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(false, m_flow_B < 0),
          points={{-50,32},{-60,36}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(false, m_flow_B < 0),
          points={{-50,40},{-60,36}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(false, m_flow_B < 0),
          points={{-50,48},{-60,52}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(false, m_flow_B < 0),
          points={{-50,56},{-60,52}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(false, m_flow_B < 0),
          points={{-50,24},{-60,20}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(false, m_flow_B < 0),
          points={{-50,16},{-60,20}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(false, m_flow_A < 0),
          points={{50,-48},{60,-44}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(false, m_flow_A < 0),
          points={{50,-40},{60,-44}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(false, m_flow_A < 0),
          points={{50,-64},{60,-60}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(false, m_flow_A < 0),
          points={{50,-56},{60,-60}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(false, m_flow_A < 0),
          points={{50,-24},{60,-28}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(false, m_flow_A < 0),
          points={{50,-32},{60,-28}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{60,20},{-60,20}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(true, m_flow_B > 0),
          points={{50,24},{60,20}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(true, m_flow_B > 0),
          points={{50,16},{60,20}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{60,-28},{-60,-28}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(true, m_flow_A > 0),
          points={{-50,-24},{-60,-28}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          visible=DynamicSelect(true, m_flow_A > 0),
          points={{-50,-32},{-60,-28}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Polygon(points={{-70,-52},{62,-52},{62,-20},{-70,-20},{-60,-10},{70,-10},
              {70,-42},{62,-52},{62,-20},{70,-10},{-60,-10},{-70,-20},{-70,-52}},
            lineColor={215,215,215}),
        Polygon(points={{-70,-68},{62,-68},{62,-36},{70,-26},{70,-60},{62,-68},{
              62,-36},{62,-36},{-70,-36},{-70,-68}}, lineColor={215,215,215}),
        Line(points={{-36,-10},{-46,-20},{-46,-68}}, color={215,215,215}),
        Line(points={{4,-10},{-6,-20},{-6,-68}}, color={215,215,215}),
        Line(points={{-16,-10},{-26,-20},{-26,-68}}, color={215,215,215}),
        Line(points={{26,-10},{16,-20},{16,-68}}, color={215,215,215}),
        Line(points={{48,-10},{38,-20},{38,-68}}, color={215,215,215}),
        Polygon(points={{-70,28},{62,28},{62,60},{-70,60},{-60,70},{70,70},{70,38},
              {62,28},{62,60},{70,70},{-60,70},{-70,60},{-70,28}}, lineColor={215,
              215,215}),
        Polygon(points={{-70,12},{62,12},{62,44},{70,54},{70,20},{62,12},{62,44},
              {62,44},{-70,44},{-70,12}}, lineColor={215,215,215}),
        Line(points={{-36,70},{-46,60},{-46,12}}, color={215,215,215}),
        Line(points={{-16,70},{-26,60},{-26,12}}, color={215,215,215}),
        Line(points={{4,70},{-6,60},{-6,12}}, color={215,215,215}),
        Line(points={{26,70},{16,60},{16,12}}, color={215,215,215}),
        Line(points={{48,70},{38,60},{38,12}}, color={215,215,215}),
        Text(
          extent={{-100,-80},{-80,-100}},
          textColor={175,175,175},
          textString="N"),
        Text(
          extent={{-100,100},{-80,80}},
          textColor={175,175,175},
          textString="1"),
        Text(
          extent={{80,100},{100,80}},
          textColor={175,175,175},
          textString="N"),
        Text(
          extent={{80,-80},{100,-100}},
          textColor={175,175,175},
          textString="1")}),
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
