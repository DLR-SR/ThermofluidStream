within ThermofluidStream.Processes.Sources.AllMediaBasedOnEntropy;
model PressureSource "Ideal pressure source (fixed pressure difference, pressure ratio or outlet pressure) with fixed isentropic efficiency suitable as both pump (incompressible media) or compressor/blower/fan (compressible media)"
  extends ThermofluidStream.Processes.Sources.BaseClasses.PartialPressureSource(      final clip_p_out=if setpoint ==
        SetpointMode.dp                                                                                                               then true else false);

  import SetpointMode = ThermofluidStream.Processes.Internal.Types.SetpointModePressure;

  parameter SetpointMode setpoint=ThermofluidStream.Processes.Internal.Types.SetpointModePressure.dp
    "Compressor setpoint (dp or p_out)" annotation (Dialog(group="Setpoint"));
  parameter Boolean setpointFromInput = false "= true, if setpoint input connector is enabled"
    annotation(Dialog(group="Setpoint"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.PressureDifference  dp_par = 0 "Constant pressure difference"
    annotation(Dialog(group="Setpoint",enable=not setpointFromInput and setpoint==SetpointMode.dp));
  parameter Real  pr_par = 1 "Constant pressure ratio"
    annotation(Dialog(group="Setpoint",enable=not setpointFromInput and setpoint==SetpointMode.pr));
  parameter SI.PressureDifference  p_out_par = Medium.p_default "Constant outlet pressure"
    annotation(Dialog(group="Setpoint",enable=not setpointFromInput and setpoint==SetpointMode.p_out));

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displaySetpoint = true "= true, if setpoint value (either dp_par, pr_par or p_out_par) is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not volumeFlowRateFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayEfficiency = false "= true, if isentropic efficiency eta_is is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayInertance = false "= true, if inertance L is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter String setpointModeString=
    if setpoint ==ThermofluidStream.Processes.Internal.Types.SetpointModePressure.dp then "Δp"
    elseif setpoint ==ThermofluidStream.Processes.Internal.Types.SetpointModePressure.pr then "pr"
    elseif setpoint ==ThermofluidStream.Processes.Internal.Types.SetpointModePressure.p_out then "p"
    else "error";
  final parameter String setpointValueString=
    if setpoint ==ThermofluidStream.Processes.Internal.Types.SetpointModePressure.dp then  "dp = %dp_par"
    elseif setpoint ==ThermofluidStream.Processes.Internal.Types.SetpointModePressure.pr then  "pr = %pr_par"
    elseif setpoint ==ThermofluidStream.Processes.Internal.Types.SetpointModePressure.p_out then  "p_out = %p_out_par"
    else "error";
  final parameter String displayPos1=
    if displaySetpoint then setpointValueString
    elseif displayEfficiency then "η = %eta_is"
    elseif displayInertance then "L = %L"
    else "";
  final parameter String displayPos2=
    if displayEfficiency and displaySetpoint  then "η = %eta_is"
    elseif displayInertance and (displaySetpoint or displayEfficiency)  then "L = %L"
    else "";
  final parameter String displayPos3=
    if displayInertance and displaySetpoint and displayEfficiency then "L = %L"
    else "";
  final parameter String displayPos4=
    if displayEfficiency then "η = %eta_is"
    elseif displayInertance then "L = %L"
    else "";
  final parameter String displayPos5=
    if displayInertance and displayEfficiency then "L = %L"
    else "";
  //-----------------------------------------------------------------

  Modelica.Blocks.Interfaces.RealInput dp_var(unit="Pa") if setpointFromInput and setpoint ==SetpointMode.dp  "Pressure difference input connector [Pa]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
  Modelica.Blocks.Interfaces.RealInput pr_var(unit="1") if setpointFromInput and setpoint ==SetpointMode.pr   "Pressure ratio input connector [1]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));

  Modelica.Blocks.Interfaces.RealInput p_out_var(unit="Pa") if setpointFromInput and setpoint ==SetpointMode.p_out  "Outlet pressure input connector [Pa]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
protected
  Modelica.Blocks.Interfaces.RealInput dp_internal(unit = "Pa") "Internal connector for pressure difference [Pa]";
  Modelica.Blocks.Interfaces.RealInput pr_internal(unit = "1") "Internal connector for pressure ratio [1]";
  Modelica.Blocks.Interfaces.RealInput p_out_internal(unit = "Pa") "Internal connector for outlet pressure [Pa]";
equation
  connect(dp_internal, dp_var);
  connect(pr_internal, pr_var);
  connect(p_out_internal, p_out_var);
  if not setpointFromInput then
    if setpoint ==SetpointMode.dp then
      dp = dp_par;
    end if;
    if setpoint ==SetpointMode.pr then
      pr = pr_par;
    end if;
    if setpoint ==SetpointMode.p_out then
      p_out = p_out_par;
    end if;
  end if;
  dp_internal = dp;
  p_out_internal = p_out;
  pr_internal = pr;

  annotation (Icon(graphics={
        Text(visible=displayParameters and not setpointFromInput,
          extent={{-150,-70},{150,-100}},
          textColor={0,0,0},
          textString=displayPos1),
        Text(visible=displayParameters and not setpointFromInput,
          extent={{-150,-110},{150,-140}},
          textColor={0,0,0},
          textString=displayPos2),
        Text(visible=displayParameters and not setpointFromInput,
          extent={{-150,-150},{150,-180}},
          textColor={0,0,0},
          textString=displayPos3),
         Text(visible=displayParameters and setpointFromInput,
          extent={{30,-64},{150,-94}},
          textColor={0,0,0},
          textString=displayPos4,
          horizontalAlignment=TextAlignment.Left),
         Text(visible=displayParameters and setpointFromInput,
          extent={{30,-104},{150,-134}},
          textColor={0,0,0},
          textString=displayPos5,
          horizontalAlignment=TextAlignment.Left),
        Text(
          extent={{-30,-20},{30,20}},
          textColor={28,108,200},
          textString=setpointModeString)}), Documentation(info="<html>
<p>
Ideal pressure source usable as both pump (incompressible media) or compressor/blower/fan (compressible media) with fixed isentropic efficiency <code>eta_is</code>. The outlet enthalpy <code>h_out</code> is thereby calculated based on the medium entropy function:  
</p>
<p>
<code>
 h_out = h_in + w_t;<br>
 w_t = w_t_is/eta_is;<br>
 w_t_is = h_out_is - h_in;<br>
 h_out_is = Medium.specificEnthalpy_psX(p_out, s_out = s_in, Xi_out = Xi_in); 
</code>
</p>

<p>
with:
</p>

<ul>
<li> inlet specific enthalpy <code>h_in</code></li>
<li> specific technical work <code>w_t</code></li>
<li>fixed isentropic efficiency <code>eta_is</code></li>
<li>specific technical work of the isentropic process <code>w_t_is</code></li>
<li>outlet specific enthalpy of the isentropic process <code>h_out_is</code></li>
<li>outlet pressure <code>p_out</code></li>
<li>specific entropy <code>s</code></li>
<li>mass fractions <code>Xi</code></li>
</ul>

<p>
For incompressible fluid, e.g. <a href=\"modelica://ThermofluidStream.Media.myMedia.Incompressible.Examples.Essotherm650\">Essotherm650</a>, <code>s_out = s_in</code> is equivalent with <code>T_out = T_in</code>.<br>
For ideal gas with constant isentropic exponent <code>kappa</code>, e.g. <a href=\"modelica://ThermofluidStream.Media.myMedia.IdealGases.SingleGases.Ar\">Argon</a>, <code>s_out = s_in</code> is equivalent with <code>T_out = T_in*(p_out/p_in)^((kappa-1)/kappa)</code>. 
</p>

<p>
<strong>Assumptions:</strong>
</p>

<ul>
<li> stationary, i.e. <code>dEsys/dt = 0, dmsys/dt = 0</code></li>
<li> no heat transfer, i.e. <code>q=0</code></li>
<li> losses are considered by isentropic efficiency <code>eta_is = wt_is/wt</code>, with specific technical work <code>wt = h_out - h_in</code> and specific isentropic technical work <code>wt_is = h_out_is - h_in</code>, where <code>h_out_is = h(s_out=s_in,p_out,X_out)</code> is the specific enthalpy of the isentropic process</li>
<li> no external Force or Momentum accelerating the Compressor as a ridig body, i.e. <code>Wdot_external = 0</code></li>
<li> ridig boundary, i.e. <code>Wdot_v = 0</code> (no work due to change of volume)</li>
<li> difference of kinetic and potential energy of the fluid is negleted, i.e. <code>g*z_2 + 1/2*c_2^2 = g*z_1 + 1/2*c_1^2</code></li>
<li> no change in mass fractions X_in = X_out </li>
</ul>

<p>
The pressure source is comparable to <a href=\"modelica://Modelica.Electrical.Analog.Sources.SignalVoltage\">VoltageSource</a> for <a href=\"modelica://Modelica.Electrical\">Modelica.Electrical</a>. One may either set as parameter or as time varying input signal:
</p>

<ul>
<li>pressure difference <code>dp = p_out - p_in</code></li>
<li>pressure ratio <code>pr = p_out/p_in</code></li>
<li>outlet pressure <code>p_out</code></li>
</ul>
</html>"));
end PressureSource;
