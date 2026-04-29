within ThermofluidStream.Processes.Internal.TurboComponent;
partial function partial_dp_tau "Compute dp and tau_st of a TurboComponent from the current state"

  extends Modelica.Icons.Function;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation(choicesAllMatching=true, Documentation(info="<html>
<p>
Medium model needet to compute properties from the inlet_state.
</p>
</html>"));
  input Medium.MassFlowRate m_flow "Mass flow rate";
  input SI.AngularVelocity omega "Angular velocity";
  input Medium.ThermodynamicState state_in "Inlet state";
  input Medium.MassFlowRate m_flow_norm "Normalization mass flow rate";
  input SI.AngularVelocity omega_norm "Normalization angular velocity";
  input SI.Density rho_min "Minimum density (relevant at p=0)";

  output SI.Pressure dp "Pressure difference";
  output SI.Torque tau_st "Steady state torque";

  annotation(Inline=true, Documentation(info="<html>
<p>This function computes the pressure differential and the moment needed for static operation of a partialTurboComponent in its current state. </p>
<p>By changing this function the partialTurboComponent implements different kinds of turbo components like fans, pumps, compressors, turbines, etc.</p>
</html>"));
end partial_dp_tau;
