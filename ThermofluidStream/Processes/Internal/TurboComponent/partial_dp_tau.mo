within ThermofluidStream.Processes.Internal.TurboComponent;
partial function partial_dp_tau "Compute dp and tau_st of a TurboComponent from the current state"
  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation(choicesAllMatching=true, Documentation(info="<html>
<p>
Medium model needet to compute properties from the inlet_state.
</p>
</html>"));

  input SI.MassFlowRate m_flow "Mass flow through component";
  input SI.AngularVelocity omega "Component angular velocity";
  input Medium.ThermodynamicState state_in "Thermodynamic state at inlet";
  input SI.MassFlowRate m_flow_norm "Mass flow used for normalization";
  input SI.AngularVelocity omega_norm "Angular velocity used for normalization";
  input SI.Density rho_min "Minimum for rho (to make model robust for rho=0 @ p=0)";

  output SI.Pressure dp "Pressure difference of fluid (dp=p1-p2)";
  output SI.Torque tau_st "Moment that would leed to static operation";

  annotation(Inline=true, Documentation(info="<html>
<p>This function computes the pressure differential and the moment needed for static operation of a partialTurboComponent in its current state. </p>
<p>By changing this function the partialTurboComponent implements different kinds of turbo components like fans, pumps, compressors, turbines ect.</p>
</html>"));
end partial_dp_tau;
