within ThermofluidStream.FlowControl;
model PCV "Pressure and pressure-drop control valve"
  extends ThermofluidStream.Interfaces.SISOFlow(final clip_p_out=true);

  import Mode = ThermofluidStream.FlowControl.Internal.Types.PressureControlValveMode;

  Modelica.Blocks.Interfaces.RealInput pressure_set_var(unit="Pa") = pressure_set if pressureFromInput "Output pressure [Pa]"
    annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80}),                           iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));

  parameter Mode mode=Mode.drop   "Valve mode";
  parameter Boolean pressureFromInput = false "Enable pressure difference input";
  parameter SI.AbsolutePressure pressure_set_par = 0 "Setpoint for pressure difference"
    annotation(Dialog(enable=not pressureFromInput));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization mass flow"
    annotation(Dialog(tab="Advanced"));

protected
  SI.AbsolutePressure pressure_set;
  SI.Pressure dp_unnorm;

equation
  if not pressureFromInput then
    pressure_set = pressure_set_par;
  end if;

  dp = ThermofluidStream.Undirected.Internal.regStep(m_flow - m_flow_reg,  min(0, dp_unnorm), 0, m_flow_reg);

  if mode ==Mode.drop then
    dp_unnorm = -pressure_set;
  else
    dp_unnorm = pressure_set - p_in;
  end if;

  h_out = h_in;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-56,54},{64,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-70,0},{80,0}},
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
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This component can be used to emulate a pressure-drop or output-pressure regulated control valve, depending on its mode.</p>
<p>dp or p_out can be set directly, depending on the valve mode. mass-flow will be determined by its usual dynamic.</p>
<p>Setting dp instead of p_out has advantages, when p_out is determined by a volume at the outlet (as say an accumulator).</p>
<p>dp is normalized, such that it cannot create pressure and it is zero for zero or negative massflow. </p>
</html>"));
end PCV;
