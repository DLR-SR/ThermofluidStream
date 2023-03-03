within ThermofluidStream.Processes;
model Fan "Fan under ideal gas assumption"
  extends Internal.PartialTurboComponent(redeclare function dp_tau=dp_tau_fan);

  replaceable function dp_tau_fan = Internal.TurboComponent.pleaseSelect_dp_tau
    constrainedby Internal.TurboComponent.partial_dp_tau(
      redeclare package Medium = Medium) "Fan characteristic curve"
      annotation(choices(
        choice=ThermofluidStream.Processes.Internal.TurboComponent.pleaseSelect_dp_tau "Please select function",
        choice=ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop "Fixed isentropic efficency"),
        Documentation(info="<html>
<p>
Selectable function to choose beween different fan models.
</p>
</html>"));

  parameter Real max_rel_R(min=0, max=1, unit="1") = 0.05 "Maximum relative allowed divergence from ideal gas"
    annotation(Dialog(tab="Advanced"));

protected
  Real R_in(unit="J/(kg.K)") = p_in/Medium.temperature(inlet.state)/Medium.density(inlet.state);
  Real R_out(unit="J/(kg.K)") = p_out/Medium.temperature(outlet.state)/Medium.density(outlet.state);

equation
  // test for idel gas
  assert(abs(R_in- R_in)/R_in < max_rel_R, "Medium in fan is assumed to be ideal gas, but check failed", dropOfCommons.assertionLevel);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-30,52},{56,20}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-30,-52},{56,-20}},
          color={28,108,200},
          thickness=0.5),
       Ellipse(
          origin={-3,0},
          extent={{0,-5},{40,5}},
          lineThickness=0.5,
          lineColor={28,108,200},
          fillPattern=FillPattern.None,
          pattern=LinePattern.Solid),
       Ellipse(
          rotation = 120,
          origin={-29,15},
          extent={{0,-5},{40,5}},
          lineThickness=0.5,
          lineColor={28,108,200},
          fillPattern=FillPattern.None,
          pattern=LinePattern.Solid),
        Ellipse(
          rotation = -120,
          origin={-29,-15},
          extent={{0,-5},{40,5}},
          lineThickness=0.5,
          lineColor={28,108,200},
          fillPattern=FillPattern.None,
          pattern=LinePattern.Solid)}),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model works under ideal gas assumption and throws an assert if it is violated.</p>
<p>Currently the only fan model is a fan with constant polytropic coefficient.</p>
</html>"));
end Fan;
