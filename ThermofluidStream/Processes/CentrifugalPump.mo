within ThermofluidStream.Processes;
model CentrifugalPump "Model of a centrifugal pump"

  import ThermofluidStream.Processes.Internal.Types.PumpMode;
  import ThermofluidStream.Processes.Internal.Types.SetpointModeFlow;
  import ThermofluidStream.Processes.Internal.Types.SetpointModePressure;

  extends ThermofluidStream.Processes.Internal.SISOFlowAdvanced(
  final setFlow = if pumpMode == PumpMode.flowControlled then true else false,
  final clip_p_out = if pumpMode == PumpMode.pressureControlled and (setpointPressure == SetpointModePressure.p_out or setpointPressure == SetpointModePressure.pr) then false else true,
  dp(final start=0, final fixed = if pumpMode == PumpMode.flowControlled then true else false));

  // Data
  parameter Boolean dataFromMeasurements = true "= true, if measurement data shall be given, (=false, if coefficients shall be set)"
    annotation(Dialog(group="Data"),Evaluate=true, HideResult=true, choices(checkBox=true));
  replaceable parameter ThermofluidStream.Processes.Internal.CentrifugalPump.CoefficientsData.GenericPumpCoefficients
    coefficients "Pump coefficients"
    annotation (Dialog(group="Data", enable=not dataFromMeasurements), choicesAllMatching=true);
  replaceable parameter ThermofluidStream.Processes.Internal.CentrifugalPump.MeasurementData.GenericPump measurements
    "Pump measurement data" annotation (Dialog(group="Data", enable=dataFromMeasurements), choicesAllMatching=true);
  final parameter ThermofluidStream.Processes.Internal.CentrifugalPump.InternalCoefficients coefficients2=if
      dataFromMeasurements then ThermofluidStream.Processes.Internal.CentrifugalPump.pumpCoefficientsFromMeasurements(
      measurements) else ThermofluidStream.Processes.Internal.CentrifugalPump.pumpCoefficientsFromCoefficients(
      coefficients);

  parameter PumpMode pumpMode = ThermofluidStream.Processes.Internal.Types.PumpMode.flowControlled "Pump mode"
    annotation(Dialog(group="Mode"));

  parameter Boolean setpointFromInput = false "= true, if setpoint input connector is enabled"
    annotation(Dialog(group="Mode", enable= not pumpMode == PumpMode.flange), Evaluate=true, HideResult=true, choices(checkBox=true));

  parameter SetpointModeFlow setpointFlow = ThermofluidStream.Processes.Internal.Types.SetpointModeFlow.m_flow "Flow setpoint (m_flow or V_flow)"
    annotation (Dialog(group="Flow setpoint",enable = pumpMode == PumpMode.flowControlled));
  parameter SI.MassFlowRate m_flow_par=0 "Constant mass flow rate"
    annotation(Dialog(group="Flow setpoint", enable = pumpMode == PumpMode.flowControlled and not setpointFromInput and setpointFlow==SetpointModeFlow.m_flow));
  parameter SI.VolumeFlowRate  V_flow_par=0 "Constant volume flow rate"
    annotation(Dialog(group="Flow setpoint", enable= pumpMode == PumpMode.flowControlled and not setpointFromInput and setpointFlow==SetpointModeFlow.V_flow));
  parameter SetpointModePressure setpointPressure = ThermofluidStream.Processes.Internal.Types.SetpointModePressure.dp "Pressure setpoint (dp, pr or p_out)"
    annotation (Dialog(group="Pressure setpoint",enable = pumpMode == PumpMode.pressureControlled));
  parameter SI.PressureDifference dp_par=0 "Constant pressure difference"
    annotation(Dialog(group="Pressure setpoint", enable = pumpMode == PumpMode.pressureControlled and not setpointFromInput and setpointPressure==SetpointModePressure.dp));
  parameter Real pr_par=0 "Constant pressure ratio p_out/p_in"
    annotation(Dialog(group="Pressure setpoint", enable = pumpMode == PumpMode.pressureControlled and not setpointFromInput and setpointPressure==SetpointModePressure.pr));
  parameter SI.PressureDifference p_out_par=0 "Constant outlet pressure"
    annotation(Dialog(group="Pressure setpoint", enable = pumpMode == PumpMode.pressureControlled and not setpointFromInput and setpointPressure==SetpointModePressure.p_out));
  parameter SI.AngularVelocity w_par(displayUnit="rpm") = measurements.w_ref "Constant angular velocity"
    annotation(Dialog(group="Speed setpoint", enable = pumpMode == PumpMode.speedControlled and not setpointFromInput));

  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Mass flow rate for regularization"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Power P_reg = dropOfCommons.m_flow_reg/1000*1e5 "Power for regularization (eta = 0 for P < eps_P"
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
    if pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.flowControlled then
      if setpointFlow  == ThermofluidStream.Processes.Internal.Types.SetpointModeFlow.m_flow then "m_flow = %m_flow_par"
      elseif setpointFlow  == ThermofluidStream.Processes.Internal.Types.SetpointModeFlow.V_flow then "V_flow = %V_flow_par"
      else "error"
    elseif pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.pressureControlled then
      if setpointPressure == ThermofluidStream.Processes.Internal.Types.SetpointModePressure.dp then "dp = %dp_par"
      elseif setpointPressure == ThermofluidStream.Processes.Internal.Types.SetpointModePressure.pr then "pr = %pr_par"
      elseif setpointPressure == ThermofluidStream.Processes.Internal.Types.SetpointModePressure.p_out then "p_out = %p_out_par"
      else "error"
    elseif pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.speedControlled then "w = %w_par"
    elseif pumpMode == ThermofluidStream.Processes.Internal.Types.PumpMode.flange then ""
    else "error";

  final parameter String displayPos1=
    if displaySetpoint  then setpointValueString
    else "";
  //-----------------------------------------------------------------

protected
  final parameter SI.AngularVelocity w_ref = coefficients2.w_ref "Reference angular velocity";
  final parameter SI.Density rho_ref = coefficients2.rho_ref "Reference density";
  final parameter Real head_ref = coefficients2.head_ref "Reference for head, preferably (V_flow = 0,w_ref)";
  final parameter Real V_flow_ref = coefficients2.V_flow_ref "Reference for volume flow rate, preferably V_flow(head=0,w_ref)";
  final parameter Real eta_ref = coefficients2.eta_ref "Reference for efficiency, preferably max eta(V_flow)";
  final parameter Real c_head[3] = coefficients2.c_head "Coefficients of second order head approximation polynomial, preferably c_head = {1, c2, -(1+c2)}";
  final parameter Real c_power[3] = coefficients2.c_power "Coefficients fof 2nd order torque approximation polynomial (P=tau*w)";
  final parameter SI.Power P_ref = coefficients2.P_ref "Reference power";
  final parameter SI.Torque tau_ref = coefficients2.tau_ref "Reference torque";

public
  Modelica.Blocks.Interfaces.RealInput m_flow_var(unit="kg/s") if pumpMode == PumpMode.flowControlled and setpointFromInput and setpointFlow == SetpointModeFlow.m_flow  "Mass flow rate input connector [kg/s]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
  Modelica.Blocks.Interfaces.RealInput V_flow_var(unit="m3/s") if pumpMode == PumpMode.flowControlled and setpointFromInput and setpointFlow == SetpointModeFlow.V_flow  "Volume flow rate input connector [m3/s]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
  Modelica.Blocks.Interfaces.RealInput dp_var(unit="Pa") if pumpMode == PumpMode.pressureControlled and setpointFromInput and setpointPressure ==SetpointModePressure.dp  "Pressure difference input connector [Pa]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
  Modelica.Blocks.Interfaces.RealInput pr_var(unit="1") if pumpMode == PumpMode.pressureControlled and setpointFromInput and setpointPressure ==SetpointModePressure.pr  "Pressure ratio input connector [-]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
  Modelica.Blocks.Interfaces.RealInput p_out_var(unit="Pa") if pumpMode == PumpMode.pressureControlled and setpointFromInput and setpointPressure ==SetpointModePressure.p_out  "Outlet pressure input connector [Pa]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
  Modelica.Blocks.Interfaces.RealInput w_var(unit="rad/s") if pumpMode == PumpMode.speedControlled and setpointFromInput "Angular velocity input connector [rad/s]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange(phi=phi, tau=tau) if pumpMode == PumpMode.flange
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  SI.Angle phi(start=0) "Angle";
protected
  Modelica.Blocks.Interfaces.RealInput m_flow_internal(unit = "kg/s") "Internal connector for mass flow rate [kg/s]";
  Modelica.Blocks.Interfaces.RealInput V_flow_internal(unit = "m3/s") "Internal connector for volume flow rate [m3/s]";
  Modelica.Blocks.Interfaces.RealInput dp_internal(unit = "Pa") "Internal connector for pressure difference [Pa]";
  Modelica.Blocks.Interfaces.RealInput pr_internal(unit = "1") "Internal connector for pressure ratio [-]";
  Modelica.Blocks.Interfaces.RealInput p_out_internal(unit = "Pa") "Internal connector for outlet pressure [Pa]";
  Modelica.Blocks.Interfaces.RealInput w_internal(unit = "rad/s") "Internal connector for angular velocity [rad/s]";
protected
  Real pr = p_out/p_in "Pressure ratio";
  SI.Density rho_in = Medium.density(inlet.state) "Inlet density";
  SI.Density rho = rho_in "Density";
  SI.VolumeFlowRate V_flow = m_flow/rho "Volume flow rate";
public
  SI.AngularVelocity w(start=w_ref) "Angular velocity";
  SI.Torque tau "Torque";
  SI.Height head "Head";
  SI.SpecificEnthalpy w_t "Specific technical work";
  SI.Power P "Power (technichal work flow rate)";
  Real eta_is "Isentropic efficiency";
protected
  Real w_r(start=1) = w/w_ref "Angular velocity ratio";
  Real V_r = V_flow/V_flow_ref "Volume flow rate ratio";
  Real head_r = head/head_ref "Head ratio";
  Real tau_r(start=1) = tau/tau_ref "Torque ratio";
  Real rho_r = rho/rho_ref "Density ratio";
equation
  connect(m_flow_internal, m_flow_var);
  connect(V_flow_internal, V_flow_var);
  connect(dp_internal, dp_var);
  connect(pr_internal, pr_var);
  connect(p_out_internal, p_out_var);
  connect(w_internal, w_var);

  if not setpointFromInput then
    if pumpMode == PumpMode.flowControlled then
      if setpointFlow ==SetpointModeFlow.m_flow then
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
      if setpointPressure ==SetpointModePressure.p_out then
        p_out = p_out_par;
      end if;
    elseif pumpMode == PumpMode.speedControlled then
      w = w_par;
    end if;
  end if;
  m_flow_internal = m_flow;
  V_flow_internal = V_flow;
  dp_internal = dp;
  pr_internal = pr;
  p_out_internal = p_out;
  w_internal = w;

  w = der(phi);
  if pumpMode == PumpMode.flowControlled or pumpMode == PumpMode.pressureControlled then
    // To avoid systems of nonlinear equations the quadratic equation head_r = f(w_r) is already solved for head_r
    w_r = 1/(2*c_head[1])*(-c_head[2]*V_r + sqrt(c_head[2]^2*V_r^2 - 4*c_head[1]*(c_head[3]*V_r^2 - head_r)));
  elseif pumpMode == PumpMode.speedControlled or pumpMode == PumpMode.flange then
    head_r =  c_head[1]*w_r^2 + c_head[2]*w_r*V_r + c_head[3]*V_r^2; // c_head[1] = 1, c_head[3] = - (1 + c_head[2])
  end if;
  tau_r =  rho_r/eta_ref*(c_power[1]*w_r^2 + c_power[2]*w_r*V_r + c_power[3]*V_r^2);
  dp = head*rho*Modelica.Constants.g_n;
  P = tau*w;
  h_out = h_in + w_t;
  eta_is = dp*V_flow/max(P,P_reg);
  w_t = P/max(m_flow,m_flow_reg); //P*m_flow/(m_flow^2 + m_flow_reg^2);
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
Model of a centrifugal pump using similarity laws: volume flow rate <code>V_flow &sim; w</code>, head/pressure difference <code>head &sim; w^2</code>, power <code>P &sim; rho*w^3</code>, 
with density <code>rho</code> and angular velocity <code>w</code>.<br> 
The model assumes incompressible fluid <code>rho = constant</code>, which implies that the hydraulic work <code>P_hyd = dp*V_flow</code>.
</p>

<p>
Head/pressure difference is a quadratic polynomial of angular velocity <code>w</code> and volume flow rate <code>V_flow</code>:
</p>

<blockquote><pre>
head_r =  c_head[1]*w_r^2 + c_head[2]*w_r*V_r + c_head[3]*V_r^2
</pre></blockquote>

<p>
with:
</p>

<ul>
<li> relative head <code>head_r = head/head_ref</code>, relative angular velocity <code>w_r = w/w_ref</code> and relative volume flow rate <code>V_r = V_flow/V_flow_ref</code></li> 
<li> reference angular velocity <code>w_ref</code>, reference head <code>head_ref = head(w=w_ref,V_flow = V_flow_ref)</code> and reference volume flow rate <code>V_flow_ref = V_flow(w=w_ref,head = 0)</code></li>
<li> coefficients <code>c_head[1] = 1</code>, <code>c_head[2]</code> and <code>c_head[3] = 1 - c_head[2]</code></li>
</ul>

<p>
Power <code>P = tau*w</code> (torque <code>tau</code>) is a quadratic polynomial of angular velocity <code>w</code> and volume flow rate <code>V_flow</code>:
</p>

<blockquote><pre>
tau_r =  rho_r/eta_ref*(c_power[1]*w_r^2 + c_power[2]*w_r*V_r + c_power[3]*V_r^2)
</pre></blockquote>

<p>
with:
</p>

<ul>
<li> relative torque <code>tau_r = tau/tau_ref</code> and relative density <code>rho_r = rho/rho_ref</code></li> 
<li> reference torque <code>tau_ref = head_ref*g*rho_ref*V_flow_ref/w_ref</code> and reference efficiency <code>eta_ref = max head*V_flow/P</code></li>
<li> coefficients <code>c_power[1]</code>, <code>c_power[2]</code> and <code>c_power[3]</code></li>
</ul>

<p>
The centrifugal pump can be parameterized either with a <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.MeasurementData.GenericPump\">measurements record</a> 
or with a <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.CoefficientsData.GenericPumpCoefficients\">coefficients record</a>. 
There are already <code>measurements records</code> and <code>coefficients records</code> for some examplary centrifugal pumps. User specific pumps can be added by creating a new <code>measurements</code> record,
whereas <code>coefficients</code> records enable the user to generate a reasonable pump curve by scaling, e.g. by applying similarity laws.
</p>

<p>
The centrifugal pump can be used in different <a href=\"modelica://ThermofluidStream.Processes.Internal.Types.PumpMode\">modes</a>:
</p>

<ul>
<li> <code>flange</code> enables a mechanical connector</li>
<li> <code>flowControlled</code> enables to set mass or volume flow rate by parameter or from input signal</li>
<li> <code>pressureControlled</code> enables to set outlet pressure, pressure ratio or pressure difference by parameter or from input signal.</li>
<li> <code>speedControlled</code> enables to set angular velocity by parameter or from input signal.</li>
</ul>

<p>
The pump mode is displayed on icon level by <code>ṁ</code> for mass flow rate, <code>V</code> for volume flow rate, <code>dp</code> for pressure difference, <code>pr</code> for pressure ratio, 
<code>p</code> for outlet pressure and <code>w</code> for angular velocity.
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
<li> difference of kinetic and potential energy of the fluid is negleted, i.e. <code>g*z + 1/2*c^2 = const.</code></li>
<li> no change in mass fractions <code>X_in = X_out</code></li>
</ul>

</html>"));
end CentrifugalPump;
