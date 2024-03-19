within ThermofluidStream.Boundaries;
model Volume "Volume of fixed size, closed to the ambient"

  extends Internal.PartialVolume;

  parameter SI.Volume V_par(displayUnit="l") = 0.001 "Volume";
  parameter Boolean density_derp_h_from_media=false "= true, if the derivative of density by pressure at const specific enthalpy is calculated from media model (only available for some media models)"
    annotation(Dialog(tab="Advanced", group="Damping", enable=(k_volume_damping > 0)),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.DerDensityByPressure density_derp_h_set = 1e-6 "Derivative of density by pressure at const specific enthalpy set value (e.g approx. 1e-5 for air, 1e-7 for water)"
    annotation(Dialog(enable = ((k_volume_damping > 0) and not density_derp_h_from_media), tab="Advanced", group="Damping"));

equation
  assert(abs(density_derp_h) > 1e-12, "The simple Volume model should not be used with (nearly) incompressible media. Consider using the FlexVolume instead.", dropOfCommons.assertionLevel);

  if density_derp_h_from_media then
    density_derp_h = Medium.density_derp_h(medium.state);
  else
    density_derp_h = density_derp_h_set;
  end if;

  V = V_par;
  W_v = 0;

  state_out = medium.state;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true),graphics={
       Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor)}), Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Conceptually a Volume is a Sink and a Source. It therefore defines the level of inertial pressure r in a closed loop and serves as a loop breaker.</p>
<p>This simple volume will become singular for incompressible fluids and close to singular for fluids with very low compressibility. For both cases we advise to use VolumeFlex or a Reservoir instead.</p>
<p>Since there is no formula to compute density_derp_h for this volume, an upper bound has to be set in the parameter density_derp_h_set. Alternativeley the derivative can be taken from the media model for all the media that implement the corresponding formula by setting density_derp_h_from_media=true (default:false).</p>
</html>"));
end Volume;
