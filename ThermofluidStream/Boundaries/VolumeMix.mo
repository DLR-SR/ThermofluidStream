within ThermofluidStream.Boundaries;
model VolumeMix "Volume with N inlets that allows mixing"
  extends Internal.PartialVolumeN;

  parameter SI.Volume V_par(displayUnit="l") = 0.001 "Volume of the Model";
  parameter Boolean density_derp_h_from_media = false "EXPERIMENTAL: get density_derp_h from media model. The function is only implemented for some Media."
    annotation(Dialog(tab="Advanced", group="Damping", enable=(k_volume_damping > 0)));
  parameter SI.DerDensityByPressure density_derp_h_set = 1e-6 "Derivative of density by pressure estimation; Approx. 1e-5 for air, 1e-7 for water"
    annotation(Dialog(enable = ((k_volume_damping > 0) and not density_derp_h_from_media), tab="Advanced", group="Damping"));

equation
  if density_derp_h_from_media then
    density_derp_h = Medium.density_derp_h(medium.state);
  else
    density_derp_h = density_derp_h_set;
  end if;

  V = V_par;
  W_v = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                            Text(
          extent={{-60,8},{60,-52}},
          lineColor={28,108,200},
          textString="Mix")}),                                   Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>A volume with N inlets.</p>
<p>Conceptually a Volume is a Sink and a Source. It therefore defines the Level of inertial pressure r in a closed loop and acts as a Loop breaker. </p>
<p>This mixing volume doesnt approximate mixing like a junction, but rather does it without approximation.</p>
</html>"));
end VolumeMix;
