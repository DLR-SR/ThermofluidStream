within ThermofluidStream.Processes.Sources.IncompressibleFluid;
model VolumePerRevolutionSimplePump "Most simple pump with V_flow = k*f"
  extends ThermofluidStream.Processes.Sources.BaseClasses.PartialPressureSourceIncompressibleFluid(
                                                                          final clip_p_out=true);
  parameter Boolean displayVolume = true "= true, if pump volume V is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not pressureFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Volume V "Pump volume (per revolution) i.e. Volume flow rate = eta_vol * V * Frequency";
  parameter Real eta_vol(min=0,max=1) = 1 "Fixed volumetric efficiency";
  parameter SI.Time TC = 1e-5 "Time constant for coupling Mechanics - ThermofluidStream to avoid nonlinear equation";

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  SI.Torque tau = flange.tau "Torque";
  SI.Angle phi = flange.phi "Angle";
  SI.AngularVelocity w "Angular velocity";
  SI.VolumeFlowRate V_flow_hat;
equation
  w = der(phi);
  tau*w = V_flow_hat*dp;
  V_flow_hat = V/(2*Modelica.Constants.pi)*eta_vol*w;
  TC*der(V_flow_hat) + V_flow_hat = V_flow;
  annotation (Icon(graphics={
        Text(visible=displayParameters and displayVolume,
          extent={{-150,-62},{150,-92}},
          textColor={0,0,0},
          textString= "V = %V"),
        Rectangle(
          extent={{-12,-10},{8,10}},
          lineColor={28,108,200},
          lineThickness=0.5)}));
end VolumePerRevolutionSimplePump;
