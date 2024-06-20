within ThermofluidStream.Processes.Compressors.SimpleCompressors;
model FlowControlledSimpleCompressor "Ideally controlled compressor (mass flow rate, volume flow rate) with fixed isentropic efficiency suitable for compressible media (real gas)"

  extends ThermofluidStream.Processes.Compressors.BaseClasses.PartialFlowControlledSimpleCompressor;

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
          textString=setpointModeString)}));
end FlowControlledSimpleCompressor;
