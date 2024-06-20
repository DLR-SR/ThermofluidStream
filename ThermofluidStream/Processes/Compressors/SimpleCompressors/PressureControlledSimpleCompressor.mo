﻿within ThermofluidStream.Processes.Compressors.SimpleCompressors;
model PressureControlledSimpleCompressor "Ideally controlled compressor (outlet pressure or pressure difference) with fixed isentropic efficiency  suitable for compressible media (real gas)"

  extends ThermofluidStream.Processes.Compressors.BaseClasses.PartialSimpleCompressor(final clip_p_out=if setpoint == SetpointMode.dp then true else false);

  import SetpointMode = ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModePressure;

  parameter SetpointMode setpoint=ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModePressure.dp "Compressor setpoint (dp or p_out)"
    annotation (Dialog(group="Setpoint"));
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
    if setpoint ==ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModePressure.dp then "Δp"
    elseif setpoint ==ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModePressure.pr then "pr"
    elseif setpoint ==ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModePressure.p_out then "p"
    else "error";
  final parameter String setpointValueString=
    if setpoint ==ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModePressure.dp then  "dp = %dp_par"
    elseif setpoint ==ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModePressure.pr then  "pr = %pr_par"
    elseif setpoint ==ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModePressure.p_out then  "p_out = %p_out_par"
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
        origin={0,-80}),                                            iconTransformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
  Modelica.Blocks.Interfaces.RealInput pr_var(unit="1") if setpointFromInput and setpoint == SetpointMode.pr  "Pressure ratio input connector [1]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80}),                                            iconTransformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));

  Modelica.Blocks.Interfaces.RealInput p_out_var(unit="Pa") if setpointFromInput and setpoint ==SetpointMode.p_out  "Outlet pressure input connector [Pa]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80}),                                            iconTransformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
protected
  Real pr = p_out/p_in "Pressure ratio p_out/p_in";
  Modelica.Blocks.Interfaces.RealInput dp_internal(unit = "Pa") "Internal connector for pressure difference [Pa]";
  Modelica.Blocks.Interfaces.RealInput pr_internal(unit = "1") "Internal connector for pressure ratio [1]";
  Modelica.Blocks.Interfaces.RealInput p_out_internal(unit = "Pa") "Internal connector for outlet pressure [Pa]";
equation
  connect(dp_internal, dp_var);
  connect(pr_internal, pr_var);
  connect(p_out_internal, p_out_var);
  if not setpointFromInput then
    if setpoint == SetpointMode.dp then
      dp = dp_par;
    end if;
    if setpoint == SetpointMode.pr then
      pr = pr_par;
    end if;
    if setpoint == SetpointMode.p_out then
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
          textString=setpointModeString)}));
end PressureControlledSimpleCompressor;
