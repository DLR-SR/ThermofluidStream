within ThermofluidStream.Processes;
model CentrifugalPump "Model of a centrifugal pump"
  import ThermofluidStream.Processes.Internal.Types.PumpMode;
  import ThermofluidStream.Processes.Internal.Types.SetpointModeFlow;
  import ThermofluidStream.Processes.Internal.Types.SetpointModePressure;

  extends ThermofluidStream.Processes.Internal.SISOFlowAdvanced(
    final setFlow=if pumpMode == PumpMode.flowControlled then true else false,
    final clip_p_out=if pumpMode == PumpMode.pressureControlled and (setpointPressure == SetpointModePressure.p_out or setpointPressure == SetpointModePressure.pr) then false else true,
    dp(final start=0, final fixed=if pumpMode == PumpMode.flowControlled then true else false));

  // Data
  parameter Boolean dataFromMeasurements = true "= true, if measurement data shall be given, (=false, if coefficients shall be set)"
    annotation(Dialog(group="Data"),Evaluate=true, HideResult=true, choices(checkBox=true));
  replaceable parameter ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump coefficients "Pump coefficients"
    annotation (Dialog(group="Data", enable=not dataFromMeasurements), choicesAllMatching=true);
  replaceable parameter ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump measurements "Pump measurement data"
    annotation (Dialog(group="Data", enable=dataFromMeasurements), choicesAllMatching=true);
  final parameter ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.InternalCoefficients coeff=if dataFromMeasurements then ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.internalCoefficientsFromMeasurements(measurements) else ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.internalCoefficientsFromCoefficients(coefficients);

  parameter PumpMode pumpMode=ThermofluidStream.Processes.Internal.Types.PumpMode.flowControlled "Pump mode"
    annotation (Dialog(group="Mode"));

  parameter Boolean setpointFromInput = false "= true, if setpoint input connector is enabled"
    annotation(Dialog(group="Mode", enable= not pumpMode == PumpMode.flange), Evaluate=true, HideResult=true, choices(checkBox=true));

  parameter SetpointModeFlow setpointFlow=ThermofluidStream.Processes.Internal.Types.SetpointModeFlow.m_flow "Flow setpoint (m_flow or V_flow)"
    annotation (Dialog(group="Flow setpoint", enable=pumpMode == PumpMode.flowControlled));
  parameter SI.MassFlowRate m_flow_par = 0 "Constant mass flow rate"
    annotation(Dialog(group="Flow setpoint", enable = pumpMode == PumpMode.flowControlled and not setpointFromInput and setpointFlow==SetpointModeFlow.m_flow));
  parameter SI.VolumeFlowRate  V_flow_par = 0 "Constant volume flow rate"
    annotation(Dialog(group="Flow setpoint", enable= pumpMode == PumpMode.flowControlled and not setpointFromInput and setpointFlow==SetpointModeFlow.V_flow));
  parameter SetpointModePressure setpointPressure=ThermofluidStream.Processes.Internal.Types.SetpointModePressure.dp "Pressure setpoint (dp, pr or p_out)"
    annotation (Dialog(group="Pressure setpoint", enable=pumpMode == PumpMode.pressureControlled));
  parameter SI.PressureDifference dp_par = 0 "Constant pressure difference p_out - p_in"
    annotation(Dialog(group="Pressure setpoint", enable = pumpMode == PumpMode.pressureControlled and not setpointFromInput and setpointPressure==SetpointModePressure.dp));
  parameter Real pr_par = 1 "Constant pressure ratio p_out/p_in"
    annotation(Dialog(group="Pressure setpoint", enable = pumpMode == PumpMode.pressureControlled and not setpointFromInput and setpointPressure==SetpointModePressure.pr));
  parameter SI.PressureDifference p_out_par = 1e5 "Constant outlet pressure"
    annotation(Dialog(group="Pressure setpoint", enable = pumpMode == PumpMode.pressureControlled and not setpointFromInput and setpointPressure==SetpointModePressure.p_out));
  parameter SI.AngularVelocity w_par(displayUnit="rpm") = measurements.w_ref "Constant speed"
    annotation(Dialog(group="Speed setpoint", enable = pumpMode == PumpMode.speedControlled and not setpointFromInput));

  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Mass flow rate for regularization"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Power P_reg = 1 "Power for regularization (eta = 0 for P < P_reg)"
    annotation(Dialog(tab="Advanced"));

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displaySetpoint = true "= true, if setpoint value is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable= displayParameters and not setpointFromInput and not pumpMode == PumpMode.flange),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter String setpointModeString=
    if pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.flowControlled then
      if setpointFlow == ThermofluidStream.Processes.Internal.Types.SetpointModeFlow.m_flow then "ṁ"
      elseif setpointFlow  == ThermofluidStream.Processes.Internal.Types.SetpointModeFlow.V_flow then "V"
      else "error"
    elseif pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.pressureControlled then
      if setpointPressure == ThermofluidStream.Processes.Internal.Types.SetpointModePressure.dp then "Δp"
      elseif setpointPressure == ThermofluidStream.Processes.Internal.Types.SetpointModePressure.pr then "pr"
      elseif setpointPressure == ThermofluidStream.Processes.Internal.Types.SetpointModePressure.p_out then "p"
      else "error"
    elseif pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.speedControlled then "w"
    elseif pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.flange then ""
    else "error";

  final parameter String setpointValueString =
    if pumpMode ==ThermofluidStream.Processes.Internal.Types.PumpMode.flowControlled then
      if setpointFlow == ThermofluidStream.Processes.Internal.Types.SetpointModeFlow.m_flow then "m_flow = %m_flow_par"
      elseif setpointFlow == ThermofluidStream.Processes.Internal.Types.SetpointModeFlow.V_flow then "V_flow = %V_flow_par"
      else "error"
    elseif pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.pressureControlled then
      if setpointPressure == ThermofluidStream.Processes.Internal.Types.SetpointModePressure.dp then "dp = %dp_par"
      elseif setpointPressure == ThermofluidStream.Processes.Internal.Types.SetpointModePressure.pr then "pr = %pr_par"
      elseif setpointPressure == ThermofluidStream.Processes.Internal.Types.SetpointModePressure.p_out then "p_out = %p_out_par"
      else "error"
    elseif pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.speedControlled then "w = %w_par"
    elseif pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.flange then ""
    else "error";

  final parameter String displayPos1 =
    if displaySetpoint  then setpointValueString
    else "";
  //-----------------------------------------------------------------

protected
  final parameter SI.AngularVelocity w_ref = coeff.w_ref "Reference speed";
  final parameter SI.Density rho_ref = coeff.rho_ref "Reference density";
  final parameter Real head_ref = coeff.head_ref "Reference for head, preferably (V_flow = 0,w_ref)";
  final parameter Real V_flow_ref = coeff.V_flow_ref "Reference for volume flow rate, preferably V_flow(head=0,w_ref)";
  final parameter Real eta_ref = coeff.eta_ref "Reference for efficiency, preferably max eta(V_flow)";
  final parameter Real c_head[3] = coeff.c_head "Coefficients of second order head approximation polynomial, preferably c_head = {1, c2, -(1+c2)}";
  final parameter Real c_power[3] = coeff.c_power "Coefficients fof 2nd order torque approximation polynomial (P=tau*w)";
  final parameter SI.Power P_ref = coeff.P_ref "Reference power";
  final parameter SI.Torque tau_ref = coeff.tau_ref "Reference torque";

public
  Modelica.Blocks.Interfaces.RealInput setpoint_var if not pumpMode == PumpMode.flange and setpointFromInput  "Setpoint input connector [SI-units]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange(phi=phi, tau=tau) if pumpMode == PumpMode.flange
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  SI.Angle phi(start=0) "Angle";
protected
  Modelica.Blocks.Interfaces.RealInput setpoint_internal "Internal connector for setpoint [SI-units]";
  Real pr = p_out/p_in "Pressure ratio";
  SI.Density rho_in = Medium.density(inlet.state) "Inlet density";
  SI.Density rho = rho_in "Density";

public
  SI.VolumeFlowRate V_flow = m_flow/rho "Volume flow rate";
  SI.AngularVelocity w(start=w_ref) "Speed";
  SI.Torque tau "Torque";
  SI.Height head "Head";
  SI.SpecificEnthalpy w_t "Specific technical work";
  SI.Power P "Power (technichal work flow rate)";
  Real eta_is "Isentropic efficiency";
protected
  Real w_n(start=1) = w/w_ref "Normalized speed";
  Real V_n = V_flow/V_flow_ref "Normalized volume flow rate";
  Real h_n = head/head_ref "Normalized head";
  Real tau_n(start=1) = tau/tau_ref "Normalized torque";
  Real rho_n = rho/rho_ref "Normalized density";
equation
  connect(setpoint_internal, setpoint_var);
  if pumpMode == PumpMode.flange then
    setpoint_internal = 0;
  end if;
  if not setpointFromInput then
    if pumpMode == PumpMode.flowControlled then
      if setpointFlow == SetpointModeFlow.m_flow then
        m_flow = m_flow_par;
      end if;
      if setpointFlow == SetpointModeFlow.V_flow then
        V_flow = V_flow_par;
      end if;
    elseif pumpMode == PumpMode.pressureControlled then
      if setpointPressure == SetpointModePressure.dp then
        dp = dp_par;
      end if;
      if setpointPressure == SetpointModePressure.pr then
        pr = pr_par;
      end if;
      if setpointPressure == SetpointModePressure.p_out then
        p_out = p_out_par;
      end if;
    elseif pumpMode == PumpMode.speedControlled then
      w = w_par;
    end if;
  end if;
  if pumpMode == PumpMode.flowControlled then
    if setpointFlow == SetpointModeFlow.m_flow then
      m_flow = setpoint_internal;
    end if;
    if setpointFlow == SetpointModeFlow.V_flow then
      V_flow = setpoint_internal;
    end if;
  elseif pumpMode == PumpMode.pressureControlled then
    if setpointPressure == SetpointModePressure.dp then
      dp = setpoint_internal;
    end if;
    if setpointPressure == SetpointModePressure.pr then
      pr = setpoint_internal;
    end if;
    if setpointPressure == SetpointModePressure.p_out then
      p_out = setpoint_internal;
    end if;
  elseif pumpMode == PumpMode.speedControlled then
    w = setpoint_internal;
  end if;

  w = der(phi);
  if pumpMode == PumpMode.flowControlled or pumpMode == PumpMode.pressureControlled then
    w_n = 1/(2*c_head[1])*(-c_head[2]*V_n + sqrt(c_head[2]^2*V_n^2 - 4*c_head[1]*(c_head[3]*V_n^2 - h_n))); // To avoid systems of nonlinear equations the quadratic equation head_n = f(w_n) is solved for w_n explicitly
  elseif pumpMode == PumpMode.speedControlled or pumpMode == PumpMode.flange then
    h_n =  c_head[1]*w_n^2 + c_head[2]*abs(w_n)*V_n + c_head[3]*V_n*abs(V_n); // Simple extension for negative flow
  end if;
  tau_n =  smooth(0, if noEvent(V_n > 0) then rho_n*(c_power[1]*w_n^2 + c_power[2]*abs(w_n)*V_n + c_power[3]*V_n^2) else rho_n*c_power[1]*w_n^2); // Simple extension for negative flow
  dp = head*rho*Modelica.Constants.g_n;
  P = tau*w;
  h_out = h_in + w_t;
  Xi_out = Xi_in;
  eta_is = if noEvent(P >= P_reg) then dp*V_flow/P else 0;
  w_t = P/max(m_flow,m_flow_reg);
  annotation (Icon(graphics={
        Text(visible=displayInstanceName,
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible=displayParameters and not setpointFromInput,
          extent={{-150,-70},{150,-100}},
          textColor={0,0,0},
          textString=displayPos1),
         Ellipse(
          extent={{-58,54},{62,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
         Rectangle(visible = pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.flange,
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-28,-18.3334},{28,1.66664}},
          rotation=270,
          origin={8.333,-74}),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,60},{60,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,-60},{60,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(visible = not pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.flange,
          extent={{-30,20},{30,-20}},
          lineColor={28,108,200},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-30,20},{30,-20}},
          textColor={28,108,200},
          textString=setpointModeString)}), Documentation(info="<html>
<p>
Model of a centrifugal pump based on similarity laws: volume flow rate <code>V_flow &sim; w</code>, head/pressure difference <code>head &sim; w^2</code>, power <code>P &sim; rho*w^3</code>, 
where <code>rho</code> is the density  and <code>w</code> is the pump speed.<br> 
The model assumes incompressible fluid <code>rho = constant</code>, which implies that the hydraulic work <code>P_hyd = dp*V_flow</code>.
</p>

<p>
Additionally quadratic polynomials are used to approximate head/pressure difference and power/torque depending on volume flow rate <code>V_flow</code>:
</p>

<blockquote><pre>
head_n =  c_head[1]*w_n^2 + c_head[2]*w_n*V_n + c_head[3]*V_n^2<br> 
P_n/w_n = tau_n =  rho_n*(c_power[1]*w_n^2 + c_power[2]*w_n*V_n + c_power[3]*V_n^2)
</pre></blockquote>

<p>
where:
</p>

<ul>
<li> <code>head_n = head/head_ref</code>, <code>w_n = w/w_ref</code>, <code>V_n = V_flow/V_flow_ref</code>, <code>P_n = P/P_ref</code>
<code>tau_n = tau/tau_ref</code> and <code>rho_n = rho/rho_ref</code> are normalized head, speed, volume flow rate, power, torque and density</li> 
<li> <code>head_ref</code>, <code>w_ref</code>, <code>V_flow_ref</code>, <code>P_ref</code>, <code>tau_ref</code> and <code>rho_ref</code> are 
reference head, speed, volume flow rate, power, torque and density</li> 
<li><code>c_head[1:3]</code> and <code>c_power[1:3]</code> are coefficients</li>
</ul>

<p>
The centrifugal pump can be parameterized either with a <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump\">measurement record</a> 
or with a <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump\">coefficient record</a>. 
There are already <code>measurements records</code> and <code>coefficient records</code> for some exemplary centrifugal pumps.<br>
User specific pumps can be added by creating a new <code>measurement record</code> or by calculating the <code>coefficient record</code> using the example 
<a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.CalculateCoefficientsFromMeasurements\">CalculateCoefficientsFromMeasurements</a>.<br>
Furthermore <code>coefficient records</code> are designed to enable the user to generate a reasonable pump curve by scaling, e.g. by applying similarity laws.
</p>

<p>
The centrifugal pump can be used in different <a href=\"modelica://ThermofluidStream.Processes.Internal.Types.PumpMode\">modes</a>:
</p>

<ul>
<li> <code>flange</code> enables a mechanical connector</li>
<li> <code>flowControlled</code> enables to set mass or volume flow rate by parameter or by input signal</li>
<li> <code>pressureControlled</code> enables to set outlet pressure, pressure ratio or pressure difference by parameter or by input signal.</li>
<li> <code>speedControlled</code> enables to set angular velocity by parameter or by input signal.</li>
</ul>

<p>
The pump mode is displayed on icon level in terms of <code>ṁ</code> for mass flow rate, <code>V</code> for volume flow rate, <code>dp</code> for pressure difference, <code>pr</code> for pressure ratio, 
<code>p</code> for outlet pressure and <code>w</code> for speed.
</p>

<p>
The parameter <code>setpointFromInput</code> enables switching between setpoint by parameter or from input signal.
</p>

<p>
Further assumptions:
</p>

<ul>
<li> stationary, i.e. <code>dEsys/dt = 0, dmsys/dt = 0</code></li>
<li> no heat transfer, i.e. <code>q=0</code></li>
<li> no external force or momentum acting on the pump as a rigid body, i.e. <code>Wdot_external = 0</code></li>
<li> ridig boundary, i.e. <code>Wdot_v = 0</code> (no work due to change of volume)</li>
<li> difference of kinetic and potential energy of the fluid are negleted, i.e. <code>g*z + 1/2*c^2 = const.</code></li>
<li> no change in mass fractions <code>X_in = X_out</code></li>
</ul>

<p>
The model is supposed to be used for non negative speed <code>w >= 0</code> and non negative volume flow rate <code>V_flow >= 0</code>, but the implemented modification:
</p>

<blockquote><pre>
head_n =  c_head[1]*w_n^2 + c_head[2]*w_n*V_n + c_head[3]*V_n*abs(V_n)<br> 
P_n/w_n = tau_n =  if noEvent(V_n > 0) then rho_n*(c_power[1]*w_n^2 + c_power[2]*w_n*V_n + c_power[3]*V_n^2) else rho_n*c_power[1]*w_n^2
</pre></blockquote>

<p>
yields at least qualitative reasonable results for <code>head</code> at negative volume flow rates <code>V_flow &lt; 0</code>. For quantitative results or for negative speeds <code>w &lt; 0</code> 
further modifications are necessary.
</p>

</html>", revisions="<html>
  <ul>
    <li>
      May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end CentrifugalPump;
