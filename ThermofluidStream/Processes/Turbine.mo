within ThermofluidStream.Processes;
model Turbine "Turbine under ideal gas assumption"
  extends Internal.PartialTurboComponent(redeclare function dp_tau =
        dp_tau_turbine);

  replaceable function dp_tau_turbine =
      Internal.TurboComponent.pleaseSelect_dp_tau
    constrainedby Internal.TurboComponent.partial_dp_tau(
      redeclare package Medium = Medium) "Compressor characteristic curve"
    annotation(choices(
        choice=ThermofluidStream.Processes.Internal.TurboComponent.pleaseSelect_dp_tau "Please select function",
        choice=ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop(omega_ref=1e6) "Fixed isentropic efficency"),
      Documentation(info="<html>
<p>
Selectable function to choose beween different turbine models.
</p>
</html>"));

  parameter Real max_rel_R(min=0, max=1, unit="1") = 0.05 "Maximum relative allowed divergence from ideal gas"
    annotation(Dialog(tab="Advanced"));

protected
  Real R_in(unit="J/(kg.K)") = p_in/Medium.temperature(inlet.state)/Medium.density(inlet.state);
  Real R_out(unit="J/(kg.K)") = p_out/Medium.temperature(outlet.state)/Medium.density(outlet.state);

equation
  // test for idel gas
  assert(abs(R_in- R_in)/R_in < max_rel_R, "Medium in turbine is assumed to be ideal gas, but check failed", dropOfCommons.assertionLevel);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-56,20},{30,52}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-56,-20},{30,-52}},
          color={28,108,200},
          thickness=0.5)}),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model works under ideal gas assumption and throws an assert if it is violated.</p>
<p>Currently the only turbine model is a turbine with constant polytropic coefficient. It this is used, the turbine should have a very high a_h (e.g. Inf).</p>
</html>"));
end Turbine;
