within ThermofluidStream.Boundaries;
model Volume "Model of a vessel with fixed volume"
  extends Internal.PartialVolume;

  parameter SI.Volume V_par(displayUnit="l") = 0.001                    "Volume of the Model";
//  parameter Boolean density_derp_h_from_media=false   "EXPERIMENTAL: get density_derp_h from media model. The function is only implemented for some Media."
//    annotation(Dialog(tab="Advanced", group="Damping", enable=(k_volume_damping > 0)));
//  parameter SI.DerDensityByPressure density_derp_h_set = 1e-6 "Derivative of density by pressure estimation; Approx. 1e-5 for air, 1e-7 for water"
//    annotation(Dialog(enable = ((k_volume_damping > 0) and not density_derp_h_from_media), tab="Advanced", group="Damping"));
//
// protected
//   Modelica.Blocks.Interfaces.RealInput tmp_dddp(unit="s2/m2") = Medium.density_derp_h(medium.state) if density_derp_h_from_media;
//  Modelica.Blocks.Interfaces.RealOutput tmp2_dddp(unit="s2/m2");
equation
  //this workaround is necessary, because the method density_derp_h is not implemented in all media, and therefore has to be removed conditionally when not implemented"
    density_derp_h = Medium.density_derp_h(medium.state);

  V = V_par;
  W_v = 0;

  state_out = medium.state;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Conceptually a Volume is a Sink and a Source. It therefore defines the Level of inertial pressure r in a closed loop and acts as a Loop breaker.</p>
<p>This simple volume will become singular for incompressible Fluids and close to singular for Fluids with very low compressibility. For both cases we advise to use VolumeFlex or a Reservoir instead.</p>
<p>Since there is no formula to compute density_derp_h for this volume, it has to be set in the parameter density_derp_h_set. It can also be taken from the media model for all the media that implement the corresponding forumla by setting density_derp_h_from_media=true (default:false).</p>
</html>"));
end Volume;
