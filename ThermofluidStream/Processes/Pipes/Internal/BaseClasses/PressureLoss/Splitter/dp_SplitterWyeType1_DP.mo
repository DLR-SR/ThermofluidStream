within ThermofluidStream.Processes.Pipes.Internal.BaseClasses.PressureLoss.Splitter;
function dp_SplitterWyeType1_DP "Pressure loss of wye splitter of type A_s + A_b > A_c and A_s = A_c | calculate pressure loss in each channel"
  extends Modelica.Icons.Function;

  import SMOOTH = ThermofluidStream.Processes.Pipes.Internal.Utilities.Stepsmoother;
  // Input variables
  input SI.Velocity w_c "Velocity of common inlet";
  input SI.Velocity w_b "Velocity of branching outlet";
  input SI.Velocity w_s "Velocity of straight outlet";
  input SI.Angle alpha "Branching angle";
  input SI.Density rho "Medium density";
  input SI.Velocity eps "To avoid division by zero";
  // Output variables
  output SI.Pressure dp_b "Pressure loss of branching outlet";
  output SI.Pressure dp_s "Pressure loss of straight outlet";
  output Types.PressureLossCoefficient zeta_cb
    "Pressure loss coefficient of branching pipe w.r.t. common inlet velocity";
  output Types.PressureLossCoefficient zeta_cs
    "Pressure loss coefficient of straight pipe w.r.t. common inlet velocity";
  //output Real w_rel_bc = w_b/w_c "Velocity ratio branch/inlet";
  //output Real w_rel_sc = w_s/w_c "Velocity ratio straight/inlet";
  //output Fluid_HTWG.Types.PressureLossCoefficient zeta_cb_prime "auxilliary pressure loss coefficient of branch expressed through the velocity in the common channel";
protected
  Real A_prime "Coefficient characterizing the velocity ratio";

  Real w_rel_bc = if abs(w_c) > eps then w_b/w_c else 1 "Velocity ratio branch/inlet";
  Real w_rel_sc = if abs(w_c) > eps then w_s/w_c else 1 "Velocity ratio straight/inlet";

  Types.PressureLossCoefficient zeta_cb_prime "auxilliary pressure loss coefficient of branch w.r.t inlet velocity";
algorithm
  A_prime := 1 - SMOOTH(1.05, 0.8, w_rel_bc)*0.1;
  zeta_cb_prime := 1 + w_rel_bc^2 - 2*w_rel_bc*cos(alpha);
  zeta_cb := A_prime*zeta_cb_prime;
  zeta_cs := 0.4*(1 - w_rel_sc)^2;
  dp_b := zeta_cb*rho/2*w_c^2;
  dp_s := zeta_cs*rho/2*w_c^2;
  annotation (
    Documentation(info=""));
end dp_SplitterWyeType1_DP;
