within ThermofluidStream.Processes;
model Pump "A simple pump model"
  extends Internal.PartialTurboComponent(redeclare function dp_tau =
        dp_tau_pump);

  parameter Real max_rel_volume(min=0, max=1, unit="1") = 0.05 "Maximum relative volume change"
    annotation(Dialog(tab="Advanced"));

  replaceable function dp_tau_pump =
      Internal.TurboComponent.pleaseSelect_dp_tau
    constrainedby Internal.TurboComponent.partial_dp_tau(redeclare package Medium=Medium) "Pump characteristic curve"
    annotation(choices(
       choice=ThermofluidStream.Processes.Internal.TurboComponent.pleaseSelect_dp_tau "Please select function",
       choice=ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal "Centrifugal Pump",
       choice=ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_nominal_flow "Nominal Flow Pump"),
    Documentation(info="<html>
      <p><span style=\"font-size: 12pt;\">Selectable function to choose beween different pump models.</span></p>
      </html>"));

  Real eta(unit="1") = if noEvent(abs(W_t)>1e-4) then dp*v_in*m_flow/W_t else 0.0;

protected
  SI.SpecificVolume v_out = 1/max(rho_min, Medium.density(inlet.state));

equation
  // test for incompressibility
  assert(abs(v_in- v_out)/v_in < max_rel_volume, "medium in pump is assumed ot be incompressible, but check failed", dropOfCommons.assertionLevel);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{0,60},{60,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,-60},{60,0}},
          color={28,108,200},
          thickness=0.5)}),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Courier New; font-size: 12pt;\">This model is&nbsp;working&nbsp;under&nbsp;the&nbsp;assuption&nbsp;of&nbsp;incompressable&nbsp;fluids and performs an assert for this. </span></p>
<p><span style=\"font-family: Courier New; font-size: 12pt;\">It can be chooses between</span></p>
<ul>
<li><span style=\"font-family: Courier New; font-size: 12pt;\">Nominal-flow pump, where a nominal flow is computed and the difference between it and the actual flow is linearly producing a pressure</span></li>
<li><span style=\"font-family: Courier New; font-size: 12pt;\">Centrifugal pump, which implements the equations of a scalable centrifugal pump.</span></li>
</ul>
</html>"));
end Pump;
