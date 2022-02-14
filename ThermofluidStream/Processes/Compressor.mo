within ThermofluidStream.Processes;
model Compressor
  "Compressor under ideal gas assumption"
  extends Internal.PartialTurboComponent(redeclare function dp_tau =
        dp_tau_compressor);

  replaceable function dp_tau_compressor =
      Internal.TurboComponent.pleaseSelect_dp_tau
    constrainedby Internal.TurboComponent.partial_dp_tau(redeclare package
      Medium =                                                                    Medium) "Compressor characteristic curve"
    annotation(choices(
        choice=ThermofluidStream.Processes.Internal.TurboComponent.pleaseSelect_dp_tau "Please select function",
        choice=ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop "Fixed isentropic efficency"),
      Documentation(info="<html>
        <p><span style=\"font-size: 12pt;\">Selectable function to choose beween different compressor models.</span></p>
        </html>"));

  parameter Real max_rel_R(min=0, max=1, unit="1") = 0.05 "Maximum relative allowed divergence from ideal gas"
    annotation(Dialog(tab="Advanced"));

protected
  Real R_in(unit="J/(kg.K)") = p_in/Medium.temperature(inlet.state)/Medium.density(inlet.state);
  Real R_out(unit="J/(kg.K)") = p_out/Medium.temperature(outlet.state)/Medium.density(outlet.state);

equation
  // test for idel gas
  assert(abs(R_in- R_in)/R_in < max_rel_R, "medium in compressor is assumed ot be idel gas, but check failed", dropOfCommons.assertionLevel);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-30,52},{56,20}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-30,-52},{56,-20}},
          color={28,108,200},
          thickness=0.5)}),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-size: 12pt;\">This model works under and asserts the ideal gas assumption.</span></p>
<p><span style=\"font-size: 12pt;\">Currently the only compressor model is a compressor with constant polytropic coefficient.</span></p>
</html>"));
end Compressor;
