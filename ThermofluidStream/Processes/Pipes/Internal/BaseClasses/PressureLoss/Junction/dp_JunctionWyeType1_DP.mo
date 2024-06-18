within ThermofluidStream.Processes.Pipes.Internal.BaseClasses.PressureLoss.Junction;
function dp_JunctionWyeType1_DP
  extends Modelica.Icons.Function;

  import SMOOTH = ThermofluidStream.Processes.Pipes.Internal.Utilities.Stepsmoother;
  // Input variables
  input SI.Area F_c "Cross-sectional area of (common) outlet";
  input SI.Area F_b "Cross-sectional area of branching inlet";
  input SI.Velocity w_c "Velocity at (common) outlet";
  input SI.Velocity w_b "Velocity at branching inlet";
  input SI.Velocity w_s "Velocity at straight inlet";
  input SI.Angle alpha_deg "Branching angle in degree";
  input Real A "Correction factor at alpha = 90°";
  input SI.Density rho_c "Density of fluid at (common) outlet";
  input SI.Velocity eps "To avoid division by zero";
  // Output variables
  output SI.Pressure dp_b "Pressure loss at branching inlet";
  output SI.Pressure dp_s "Pressure loss at straight inlet";
  output Types.PressureLossCoefficient zeta_cb "Pressure loss coefficient of branching inlet w.r.t. outlet velocity";
  output Types.PressureLossCoefficient zeta_cs "Pressure loss coefficient of straight inlet w.r.t. outlet velocity";
  //output Real w_rel_bc = w_b/w_c "Velocity ratio of branch and common channel";
  //output Real w_rel_sc = w_s/w_c "Velocity ratio of main passage and common channel";
  //output Fluid_HTWG.Types.PressureLossCoefficient zeta_cb_prime "Auxilliary pressure loss coefficient of branch expressed through the velocity in the common channel";
protected
  Real w_rel_bc = if abs(w_c) > eps then w_b/w_c else 1 "Velocity ratio branch/outlet";
  Real w_rel_sc = if abs(w_c) > eps then w_s/w_c else 1 "Velocity ratio straight/outlet";
  Real Q_rel_bc = w_rel_bc/F_rel_cb "Volume flow rate ratio branch/outlet";
  Real k "Coefficient characterizing the branching angle dependency";
  Real F_rel_cb = F_c/F_b "Area ratio outlet/branch";
  function interpolate =
      Internal.lin_interpol_Y1_60_90;
algorithm
  k := -0.0001778*alpha_deg^2 - 0.008667*alpha_deg + 2.16;
  if alpha_deg <= 60 then
    zeta_cb := 1 + w_rel_bc^2 - 2*(1 - Q_rel_bc)^2 - k*F_rel_cb*Q_rel_bc^2;
    zeta_cs := 1 - (1 - Q_rel_bc)^2 - k*F_rel_cb*Q_rel_bc^2;
  elseif alpha_deg > 89.5 then
    zeta_cb := A*(1 + w_rel_bc^2 - 2*(1 - Q_rel_bc)^2);
    zeta_cs := 1.55*Q_rel_bc - Q_rel_bc^2;
  else
    (zeta_cb, zeta_cs) := interpolate(alpha_deg, w_rel_bc, Q_rel_bc, F_rel_cb, A);
  end if;
  dp_b := zeta_cb*rho_c/2*w_c^2;
  dp_s := zeta_cs*rho_c/2*w_c^2;
  annotation (
    Documentation(info=""));
end dp_JunctionWyeType1_DP;
