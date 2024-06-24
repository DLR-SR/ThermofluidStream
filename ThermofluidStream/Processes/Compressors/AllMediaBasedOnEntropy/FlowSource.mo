within ThermofluidStream.Processes.Compressors.AllMediaBasedOnEntropy;
model FlowSource
  "Ideal flow source (fixed mass flow rate or volume flow rate) with fixed isentropic efficiency suitable as both pump (incompressible media) or compressor/blower/fan (compressible media)"

  extends ThermofluidStream.Processes.Compressors.BaseClasses.PartialFlowSource;

  import SetpointMode = ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModeFlow;

  parameter SetpointMode setpoint=ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModeFlow.m_flow "Compressor setpoint (m_flow or V_flow nased on inlet density)"
    annotation (Dialog(group="Setpoint"));
  parameter Boolean setpointFromInput = false "= true, if setpoint input connector is enabled"
    annotation(Dialog(group="Setpoint"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.MassFlowRate m_flow_par=0 "Constant mass flow rate"
    annotation(Dialog(group="Setpoint",enable=not setpointFromInput and setpoint==SetpointMode.m_flow));
  parameter SI.VolumeFlowRate  V_flow_par=0 "Constant volume flow rate"
    annotation(Dialog(group="Setpoint",enable=not setpointFromInput and setpoint==SetpointMode.V_flow));
  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displaySetpoint = true "= true, if setpoint value (either m_flow_par or V_flow_par) is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not volumeFlowRateFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayEfficiency = false "= true, if isentropic efficiency eta_is is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayInertance = false "= true, if inertance L is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter String setpointModeString=
    if setpoint ==ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModeFlow.m_flow then "ṁ"
    elseif setpoint ==ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModeFlow.V_flow then "V"
    else "error";
  final parameter String setpointValueString=
    if setpoint ==ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModeFlow.m_flow then "m_flow = %m_flow_par"
    elseif setpoint ==ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModeFlow.V_flow then "V_flow = %V_flow_par"
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

  Modelica.Blocks.Interfaces.RealInput m_flow_var(unit="kg/s") if setpointFromInput and setpoint == SetpointMode.m_flow  "Mass flow rate input connector [kg/s]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80}),                                            iconTransformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
  Modelica.Blocks.Interfaces.RealInput V_flow_var(unit="m3/s")  if setpointFromInput and setpoint == SetpointMode.V_flow  "Volume flow rate input connector [m3/s]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80}),                                            iconTransformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
protected
  Modelica.Blocks.Interfaces.RealInput m_flow_internal(unit = "kg/s") "Internal connector for mass flow rate [kg/s]";
  Modelica.Blocks.Interfaces.RealInput V_flow_internal(unit = "m3/s") "Internal connector for volume flow rate [m3/s]";
equation
  connect(m_flow_internal, m_flow_var);
  connect(V_flow_internal, V_flow_var);
  if not setpointFromInput then
    if setpoint ==SetpointMode.m_flow then
      m_flow = m_flow_par;
    end if;
    if setpoint ==SetpointMode.V_flow then
      V_flow = V_flow_par;
    end if;
  end if;
  m_flow_internal = m_flow;
  V_flow_internal = V_flow;

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
Ideal flow source usable as both pump (incompressible media) or compressor/blower/fan (compressible media) with fixed isentropic efficiency <code>eta_is</code>. The outlet enthalpy <code>h_out</code> is thereby calculated based on the medium entropy function:  
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
The flow source is comparable to <a href=\"modelica://Modelica.Electrical.Analog.Sources.SignalCurrent\">CurrentSource</a> for <a href=\"modelica://Modelica.Electrical\">Modelica.Electrical</a>. One may either set as parameter or as time varying input signal:
</p>

<ul>
<li>mass flow rate <code>m_flow</code></li>
<li>volume flow rate <code>V_flow = m_flow/rho_in</code></li>
</ul>
</html>"));
end FlowSource;
