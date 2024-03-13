within ThermofluidStream.HeatExchangers;
model CrossFlowNTU "Cross flow heat exchanger using the epsilon-NTU method"
  extends ThermofluidStream.HeatExchangers.Internal.PartialNTU;
  ThermofluidStream.Interfaces.Inlet inletA(redeclare package Medium = MediumA) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        origin={-100,0}),   iconTransformation(extent={{-120,-20},{-80,20}})));
  ThermofluidStream.Interfaces.Outlet outletA(redeclare package Medium = MediumA) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        origin={100,0}),   iconTransformation(extent={{80,-20},{120,20}})));
  ThermofluidStream.Interfaces.Inlet inletB(redeclare package Medium = MediumB) annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        origin={0,100},
        rotation=90),     iconTransformation(extent={{20,20},{-20,-20}},
        rotation=90,
        origin={0,100})));
  ThermofluidStream.Interfaces.Outlet outletB(redeclare package Medium = MediumB) annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        origin={0,-100},
        rotation=90),      iconTransformation(extent={{20,20},{-20,-20}},
        rotation=90,
        origin={0,-100})));


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
  //Calculating heat exchanger effectiveness derived from NTU correlations (see VDI Waermeatlas)
  //it is assumed that both fluids are unmixed
  effectiveness = 1 - exp((1/C_r)*NTU^(0.22)*(exp(-C_r*NTU^(0.78)) - 1));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,120},{150,160}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Line(
          points={{0,60},{0,100}},
          color={28,108,200},
          thickness=0.5),
        Text(
          extent={{-120,60},{-80,20}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{-60,120},{-20,80}},
          textColor={175,175,175},
          textString="B"),
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
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-48,6},{52,6}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-48,-6},{52,-6}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{28,18},{28,42}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-28,18},{-28,44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-25,24},
          rotation=270),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-31,24},
          rotation=270),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={3,24},
          rotation=270),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-3,24},
          rotation=270),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={31,24},
          rotation=270),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={25,24},
          rotation=270),
        Line(
          points={{-28,-50},{-28,-24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-25,-44},
          rotation=270),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-31,-44},
          rotation=270),
        Line(
          points={{0,-50},{0,-12}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-3,-44},
          rotation=270),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={3,-44},
          rotation=270),
        Line(
          points={{28,-50},{28,-26}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={25,-44},
          rotation=270),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={31,-44},
          rotation=270),
        Line(
          points={{42,2},{52,6}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{42,10},{52,6}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{42,-10},{52,-6}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{42,-2},{52,-6}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Basic model of a cross-flow heat exchanger based on the effectiveness-NTU method.</p>
<p>The equations are derived from the generic effectiveness-NTU relations which can be found in the &quot;VDI W&auml;rmeatlas&quot; and noumerous standard literature.</p>
<p>For stream dominated applications the following assumptions are made for mass flow regularization close to zero:</p>
<p>- if the mass flow on both sides of the heat exchanger is zero, no heat is transferred</p>
</html>"));
end CrossFlowNTU;
