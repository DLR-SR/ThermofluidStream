within ThermofluidStream.FlowControl;
model PCV "Pressure and pressure-drop control valve"
  extends ThermofluidStream.Interfaces.SISOFlow(final clip_p_out=true);

  import Mode = ThermofluidStream.FlowControl.Internal.Types.PressureControlValveMode;


  parameter Mode mode = Mode.drop "Valve mode"
    annotation(Dialog(group="Pressure setpoint"));
  parameter Boolean pressureFromInput = false "= true, if pressure input connector is enabled";
  parameter SI.AbsolutePressure pressure_set_par = 0 "Setpoint for pressure / pressure difference"
    annotation(Dialog(group="Pressure setpoint",enable=not pressureFromInput));

  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization mass flow"
    annotation(Dialog(tab="Advanced"));

  Modelica.Blocks.Interfaces.RealInput pressure_set_var(unit="Pa") if pressureFromInput "Pressure input connector [Pa]"
    annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));

protected
  Modelica.Blocks.Interfaces.RealInput pressure_set(unit="Pa") "Internal pressure connector [Pa]";
  SI.Pressure dp_raw "Not normalized desired dp";

equation
  connect(pressure_set_var, pressure_set);
  if not pressureFromInput then
    pressure_set = pressure_set_par;
  end if;

  // normalize dp: upper limit=0: because valve should not create pressure.
  // if reversed flow condition, dp is set to 0, such that the valve will also not create pressure in this condition.
  // for the flow-direction-normalization regstep is used in a way, that dp=0 for m_flow = 0 (m_flow - m_flow_reg).
  // the motherclass will further normalize dp, such that p_out >= dp_min.
  dp = ThermofluidStream.Undirected.Internal.regStep(m_flow - m_flow_reg, min(0, dp_raw), 0, m_flow_reg);

  if mode ==Mode.drop then
    dp_raw = -pressure_set;
  else
    dp_raw = pressure_set - p_in;
  end if;

  h_out = h_in;
  Xi_out = Xi_in;

    annotation(Dialog(group="Pressure setpoint"),Evaluate=true, HideResult=true, choices(checkBox=true),
    Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,-80},{150,-120}},
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
          points={{0,0},{0,60}},
          color={28,108,200},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This component can be used to emulate a pressure-drop or output-pressure regulated control valve, depending on the chosen valve mode.</p>
<p>Depending on the parameter <code>mode</code>, either the pressure at the outlet <code>p_out</code> or the pressure difference <code>dp</code> between inlet and outlet can be stipulated. This is done either by parameter <code>pressure_set_par</code> or via input connector <code>pressure_set_var</code> when setting <code>pressureFromInput = true</code>. The resulting mass flow will be determined by its usual dynamics.</p>
<p>Setting <code>dp</code> instead of <code>p_out</code> has advantages, when <code>p_out</code> is determined by a volume at the outlet (for instance an accumulator).</p>
<p>The pressure difference <code>dp</code> is normalized, such that it cannot create pressure and it is zero for zero or negative mass flow. </p>
</html>"));
end PCV;
