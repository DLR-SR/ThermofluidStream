within ThermofluidStream.HeatExchangers;
model CounterFlowNTU "Counter flow heat exchanger using the epsilon-NTU method"

  extends ThermofluidStream.HeatExchangers.Internal.PartialNTU;

equation
  //Calculating heat exchanger effectiveness derived from NTU correlations (see VDI Waermeatlas)
  effectiveness = if noEvent(C_r < 1) then (1 - exp(-NTU*(1 - C_r)))/(1 - C_r*exp(-NTU*(1 - C_r))) else NTU/(1 + NTU);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible=d1A,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString="A = %A"),
        Text(visible=d1kNTU,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString="k_NTU = %k_NTU"),
        Text(visible=d2kNTU,
          extent={{-150,-130},{150,-160}},
          textColor={0,0,0},
          textString="k_NTU = %k_NTU"),
        Rectangle(
          extent={{-70,66},{84,-86}},
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          radius=6),
        Rectangle(
          extent={{-76,78},{76,-78}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=6),
        Line(
          points={{-60,64},{60,64}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-60,44},{60,44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Text(
          extent={{-120,0},{-80,-40}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{80,40},{120,0}},
          textColor={175,175,175},
          textString="B"),
        Line(
          points={{-60,-44},{60,-44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-60,24},{60,24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-60,-64},{60,-64}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,40},{-60,44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,48},{-60,44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,-48},{60,-44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,-40},{60,-44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,60},{-60,64}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,68},{-60,64}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,20},{-60,24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,28},{-60,24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,-68},{60,-64}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,-60},{60,-64}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-60,-24},{60,-24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,-20},{60,-24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,-28},{60,-24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Basic model of a counter-flow heat exchanger based on the effectiveness-NTU method.</p>
<p>The equations are derived from the generic effectiveness-NTU relations which can be found in the &quot;VDI W&auml;rmeatlas&quot; and noumerous standard literature.</p>
<p>For stream dominated applications the following assumptions are made for mass flow regularization close to zero:</p>
<p>- if the mass flow on both sides of the heat exchanger is zero, no heat is transferred</p>
</html>"));
end CounterFlowNTU;
