within ThermofluidStream.FlowControl;
model CheckValve "Valve to enforce non negative mass flow rates"

  extends Interfaces.SISOFlow(final clip_p_out=false);

  parameter SI.MassFlowRate m_flow_ref = dropOfCommons.m_flow_reg "Reference mass flow rate for regularization"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Pressure p_ref = 1e5 "Reference pressure for regularization"
    annotation(Dialog(tab="Advanced"));

equation
  dp = if noEvent(m_flow < 0) then p_ref*((m_flow/m_flow_ref)^2) else 0;
  h_out = h_in;
  Xi_out = Xi_in;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Ellipse(
          extent={{-56,54},{64,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
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
          points={{40,0},{-48,0}},
          color={28,108,200},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{-52,-30},{52,-30}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-52,30},{52,30}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,30},{20,10}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,-30},{20,-10}},
          color={28,108,200},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Valve that allows positive mass_flow and builds up a large pressure difference against negative mass_flow.</p>
</html>"));
end CheckValve;
