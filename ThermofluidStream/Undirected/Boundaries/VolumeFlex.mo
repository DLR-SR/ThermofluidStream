within ThermofluidStream.Undirected.Boundaries;
model VolumeFlex "Flexible volume with fixed bulk modulus, closed to the ambient"
  extends Internal.PartialVolume;

  parameter SI.Pressure p_ref = 1e5 "Reference pressure";
  parameter SI.Volume V_ref(displayUnit="l") = 0.001 "Volume at reference pressure";
  parameter SI.BulkModulus K = 1e6 "Bulk modulus";

equation
  density_derp_h = (V_ref*medium.d)/(V*K);

  medium.p = p_ref + K*(V/V_ref-1);
  W_v = 0;

  state_out_rear = medium.state;
  state_out_fore = medium.state;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
         Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Line(
          points={{-44,18},{-44,-54}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{44,20},{44,-52}},
          color={28,108,200},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>The volume has V_ref at p_ref and expands linearly with its bulk modulus. It can be used to reduce stiffness of the ODE system for loops with incompressible mediums or mediums with very low compressibility.</p>
<p>Currently the volume change work, the volume performs on the environment is neglected.</p>
</html>"));
end VolumeFlex;
