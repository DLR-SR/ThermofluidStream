within ThermofluidStream.FlowControl;
model MCV "Flow rate control valve"
  extends ThermofluidStream.Interfaces.SISOFlow(final clip_p_out=false, final L = 100, final p_min=p_min_par);
  //the component implements its own clip_p_out and requires a minimum L value for numeric reasons (otherwise dr_set will get very small)

  import Mode = ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode;

  parameter Mode mode = Mode.mass_flow "Valve mode"
    annotation(Dialog(group="Flow rate setpoint"));
  parameter Boolean setpointFromInput = false "= true, if flow rate input connector is enabled"
    annotation(Dialog(group="Flow rate setpoint"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.MassFlowRate massFlow_set_par = 0 "Mass flow rate set value"
    annotation(Dialog(group="Flow rate setpoint",enable=(not setpointFromInput) and mode == Mode.mass_flow));
  parameter SI.VolumeFlowRate volumeFlow_set_par = 0 "Volume flow rate set value"
    annotation(Dialog(group="Flow rate setpoint",enable=(not setpointFromInput) and mode == Mode.volume_flow));

  parameter SI.Time TC = 0.1 "Time constant of setpoint dynamic";
  parameter Real k1(unit="1") = 100 "Time constant factor"
    annotation(Dialog(tab="Advanced"));
  parameter Real k2(unit="1") = 100 "Integrator windup factor"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Pressure p_min_par = dropOfCommons.p_min "Minimal steady-state output pressure"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean enableClippingOutput = false "= true, if clippingOutput is enabled";

  Modelica.Blocks.Interfaces.RealInput setpoint_var if setpointFromInput "Flow rate input connector"
    annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));
  Modelica.Blocks.Interfaces.RealOutput clippingOutput = (dp - dp_int) if enableClippingOutput ""
    annotation (Placement(
        transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-120}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));

  SI.Density rho_in = Medium.density(inlet.state) "Inlet density";
  SI.VolumeFlowRate V_flow = m_flow/rho_in "Inlet volume flow rate";

  constant SI.Pressure eps = 1;

protected
  SI.MassFlowRate m_flow_set "Setpoint mass flow rate";
  SI.VolumeFlowRate V_flow_set "Setpoint volume flow rate";
  Modelica.Blocks.Interfaces.RealInput setpoint "Internal setpoint connector";

  SI.Pressure dr = outlet.r - inlet.r "Inertial pressure difference";
  SI.Pressure dr_set;

public
  SI.Pressure dp_int(start=-1e5) "Initial pressure difference";
  // dp corr for anti windup "back calculation" compensation after "Integrator windup and how to avoid it" 1989 Astrom
  SI.Pressure dp_corr = k2*(dp - dp_int) "Corrected pressure difference";

initial equation
  dp_int = 0;

equation
  connect(setpoint_var, setpoint);
  if setpointFromInput then
    m_flow_set = setpoint;
    V_flow_set = setpoint;
  else
    setpoint = 0;
    m_flow_set = massFlow_set_par;
    V_flow_set = volumeFlow_set_par;
  end if;

  // Compute dr_set required for desired mass-flow or Volume-flow dynamic
  if mode==Mode.mass_flow then
    dr_set = - L/TC * (m_flow_set - m_flow);
  else
    dr_set = - L/TC*(V_flow_set*rho_in - m_flow);
  end if;

  // compute pressure drop dynamic very fast, so dr tracks dr_set.
  // dr is limited, since it can be very high for non-smooth systems (e.g. a jump in input pressure)
  TC/k1 * der(dp_int) = max(-1e8, min(1e8,dr)) - dr_set +  dp_corr;

  // limit dp to a so that p_out > p_min and no pressure is created
  dp = max(p_min - p_in, min(0, dp_int));

  h_out = h_in;
  Xi_out = Xi_in;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible= displayInstanceName and not enableClippingOutput,
          extent={{-150,-80},{150,-120}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible= displayInstanceName and enableClippingOutput,
          extent={{-150,-60},{150,-100}},
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
          thickness=0.5),
        Ellipse(
          extent={{40,60},{60,80}},
          lineColor={0,0,0},
          fillColor = DynamicSelect({255,255,255}, if abs(dp - dp_int) <= eps then {0,140,72} else {238,46,47}),
          fillPattern=FillPattern.Solid),
        Line(visible=enableClippingOutput and not displayInstanceName,
          points={{0,-110},{0,-60}},
          color={0,0,127},
          thickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This component can be used to emulate a mass- or volume-flow regulated valve, depending on its mode. </p>
<p>The mass- or volume-flow-setpoint can be set or given by a real input signal, and the valve tries to enforce a PT1- dynamic on this setpoint, within its pressure limits. The valve will not create pressure, or let the outlet pressure drop below p_min. To avoid this, the internally integrated pressure-drop is clipped. If it is clipped and hence the setpoint cannot be reached, an optional output leaves its &quot;zero&quot; value and a visual wanring is shown (circle becomes red). </p>
<p>Documentation of the used equations:</p>
<p><img src=\"modelica://ThermoFluidStream/Resources/Doku/ThermofluidStream.FlowControl.MCV.PNG\"/></p>
</html>"));
end MCV;
