within ThermofluidStream.Processes.Pipes.Internal.BaseClasses.PressureLoss.Splitter;
function dp_SplitterWyeType2_DP "Pressure loss of wye splitter of type A_s + A_b = A_c | calculate pressure loss in each channel"
  extends Modelica.Icons.Function;

  // Input variables
  input SI.Velocity w_c "Splitter inlet velocity";
  input SI.Velocity w_b "Branching pipe velocity";
  input SI.Velocity w_s "Straight pipe velocity";
  input SI.Angle alpha "Branching angle";
  input SI.Density rho "Medium density";
  input Real k "Scaling factor for family of curves at alpha = 90°";
  input Real K_b_prime "Correction factor for branching angle alpha";
  input SI.Velocity eps "To avoid division by zero";
  // Output variables
  output SI.Pressure dp_b "Pressure loss of branching pipe";
  output SI.Pressure dp_s "Pressure loss of straight pipe";
  output Types.PressureLossCoefficient zeta_cb "Pressure loss coefficient of branching pipe w.r.t. inlet velocity";
  output Types.PressureLossCoefficient zeta_cs "Pressure loss coefficient of straight pipe w.r.t. inlet velocity";
protected
  Real w_rel_bc = if abs(w_c) >= eps then w_b/w_c else 0 "Velocity ratio branch/inlet";
  Real w_rel_sc = if abs(w_c) >= eps then w_s/w_c else 0 "Velocity ratio main/inlet";
algorithm
  zeta_cb := 1 + (w_rel_bc)^2 - 2*w_rel_bc*cos(alpha) - K_b_prime*w_rel_bc^2;
  zeta_cs := max(0, k*0.5345*w_rel_sc^4 - k*1.124*w_rel_sc^3 + k*1.73*w_rel_sc^2 - 2.146*w_rel_sc + 1.0005);
  dp_b := zeta_cb*rho/2*w_c^2;
  dp_s := zeta_cs*rho/2*w_c^2;

  annotation (
    Documentation(info=""));
end dp_SplitterWyeType2_DP;
