within ThermofluidStream.FlowControl;
model MCV "Massflow and volume control valve"
  extends ThermofluidStream.Interfaces.SISOFlow(final clip_p_out=false, final L = 100, final p_min=p_min_par);
  //the component implements its own clip_p_out and requires a minimum L value for numeric reasons (otherwise dr_set will get very small)

  import Mode = ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode;

  Modelica.Blocks.Interfaces.RealInput setpoint_var = setpoint if setpointFromInput "Desired mass-flow [kg/s or m3/s]"
    annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));

  Modelica.Blocks.Interfaces.RealOutput clippingOutput = (dp - dp_int) if enableClippingOutput ""
    annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,-80}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,-80})));


  parameter Mode mode = Mode.mass_flow "Valve mode";
  parameter Boolean setpointFromInput = false "Enable desired massFlow input";
  parameter SI.MassFlowRate massFlow_set_par = 0 "Mass flow variable to set"
    annotation(Dialog(enable=(not setpointFromInput) and mode == Mode.mass_flow));
  parameter SI.VolumeFlowRate volumeFlow_set_par = 0 "Mass flow variable to set"
    annotation(Dialog(enable=(not setpointFromInput) and mode == Mode.volume_flow));
  parameter SI.Time TC = 0.1 "Time constant of setpoint dynamic";
  parameter Real k1(unit="1") = 100 "Timeconstant factor"
    annotation(Dialog(tab="Advanced"));
  parameter Real k2(unit="1") = 100 "Integrator windup factor"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Pressure p_min_par = dropOfCommons.p_min "Minimal steady-state output pressure"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean enableClippingOutput = false;

  SI.Density rho_in = Medium.density(inlet.state);
  SI.VolumeFlowRate V_flow = m_flow/rho_in;

  constant SI.Pressure eps = 1;

protected
  outer ThermofluidStream.DropOfCommons dropOfCommons;

  SI.MassFlowRate m_flow_set;
  SI.VolumeFlowRate V_flow_set;
  Real setpoint;

  SI.Pressure dr = outlet.r - inlet.r;
  SI.Pressure dr_set;
public
  SI.Pressure dp_int(start=-1e5);
  // dp corr for anti windup "back calculation" compensation after "Integrator windup and how to avoid it" 1989 Astrom
  SI.Pressure dp_corr = k2*(dp - dp_int);

initial equation
  dp_int = 0;

equation
  if setpointFromInput then
    m_flow_set = setpoint;
    V_flow_set = setpoint;
  else
    setpoint = 0;
    m_flow_set = massFlow_set_par;
    V_flow_set = volumeFlow_set_par;
  end if;

  // compute dr_set required for desired mass-flow or Volume-flow dynamic
  if mode==Mode.mass_flow then
    dr_set = - L/TC * (m_flow_set - m_flow);
  else
    dr_set = - L/TC*(V_flow_set*rho_in - m_flow);
  end if;

  // compute pressure drop dynamic very fast, so dr tracks dr_set.
  // dr is limited, since it can be very high for non-smooth systms (e.g. a jump in input pressure)
  TC/k1 * der(dp_int) = max(-1e8, min(1e8,dr)) - dr_set +  dp_corr;

  // limit dp to a so that p_out > p_min and no pressure is created
  dp = max(p_min - p_in, min(0, dp_int));

  h_out = h_in;
  Xi_out = Xi_in;

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
          thickness=0.5),
        Ellipse(
          extent={{40,-60},{60,-80}},
          lineColor={0,0,0},
          fillColor = DynamicSelect({255,255,255}, if abs(dp - dp_int) <= eps then {0,140,72} else {238,46,47}),
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This component can be used to emulate a mass- or volume-flow regulated valve, depending on its mode. </p>
<p>The mass- or volume-flow-setpoint can be set or given by a real input signal, and the valve tries to enforce a PT1- dynamic on this setpoint, within its pressure limits. The valve will not create pressure, or let the outlet pressure drop below p_min. To avoid this, the internally integrated pressure-drop is clipped. If it is clipped and hence the setpoint cannot be reached, an optional output leaves its &quot;zero&quot; value and a visual wanring is shown (circle becomes red). </p>
<p>Documentation of the used equations:</p>
<p><img src=\"modelica://ThermoFluidStream/Resources/Doku/ThermofluidStream.FlowControl.MCV.PNG\"/></p>
</html>"));
end MCV;
