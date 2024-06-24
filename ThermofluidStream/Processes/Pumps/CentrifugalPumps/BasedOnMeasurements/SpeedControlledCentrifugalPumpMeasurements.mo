within ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnMeasurements;
model SpeedControlledCentrifugalPumpMeasurements "Ideal controlled (angular velocity) centrifugal pump based on measurement data at reference speed"
  extends ThermofluidStream.Processes.Pumps.BaseClasses.PartialCentrifugalPumpMeasurements;

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displaySetpoint = true "= true, if setpoint angular velocity w_par is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not volumeFlowRateFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayInertance = false "= true, if inertance L is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter String setpointModeString = "w";
  final parameter String setpointValueString = "w = %w_par";
  final parameter String displayPos1=
    if displaySetpoint  then setpointValueString
    elseif displayInertance then "L = %L"
    else "";
  final parameter String displayPos2=
    if displayInertance and displaySetpoint  then "L = %L"
    else "";
  //-----------------------------------------------------------------

  parameter Boolean setpointFromInput = false "= true, if setpoint angular velocity input connector is enabled"
    annotation(Dialog(group="Setpoint"), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.AngularVelocity w_par=data.w_ref "Constant angular velocity"
    annotation(Dialog(group="Setpoint", enable=not setpointFromInput));

  Modelica.Blocks.Interfaces.RealInput w_var(unit="rad/s") if setpointFromInput "Angular velocity input connector [rad/s]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-80})));
protected
  Modelica.Blocks.Interfaces.RealInput w_internal(unit = "rad/s") "Internal connector for angular velocity [rad/s]";
equation
  connect(w_internal, w_var);
  if not setpointFromInput then
    w = w_par;
  end if;
  w_internal = w;
  annotation (Icon(graphics={
        Text(visible=displayParameters and not setpointFromInput,
          extent={{-150,-70},{150,-100}},
          textColor={0,0,0},
          textString=displayPos1),
        Text(visible=displayParameters and not setpointFromInput,
          extent={{-150,-110},{150,-140}},
          textColor={0,0,0},
          textString=displayPos2),
         Text(visible=displayInertance and displayParameters and setpointFromInput,
          extent={{30,-64},{150,-94}},
          textColor={0,0,0},
          textString="L=%L",
          horizontalAlignment=TextAlignment.Left),
        Rectangle(
          extent={{-30,20},{30,-20}},
          lineColor={28,108,200},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-30,20},{30,-20}},
          textColor={28,108,200},
          textString=setpointModeString)}));
end SpeedControlledCentrifugalPumpMeasurements;
