within ThermofluidStream.Processes.Pipes.BaseClasses.PressureLoss.Junction.Internal;
function lin_interpol_Y1_60_90
  // Input variables
  input Real alpha_deg "Branching angle";
  input Real w_rel_bc "Velocity ratio branch/common";
  input Real Q_rel_bc "Volume flow rate ratio branch/common";
  input Real F_rel_cb "Area ratio common/branch";
  input Real A "Correction factor at alpha = 90°";
  // Output variables
  output Real zeta_cb;
  output Real zeta_cs;
protected
  Real zeta_cb_60;
  Real zeta_cb_90;
  Real zeta_cs_60;
  Real zeta_cs_90;
algorithm
  zeta_cb_60 := 1 + w_rel_bc^2 - 2*(1 - Q_rel_bc)^2 - F_rel_cb*Q_rel_bc^2;
  zeta_cs_60 := 1 - (1 - Q_rel_bc)^2 - F_rel_cb*Q_rel_bc^2;
  zeta_cb_90 := A*(1 + w_rel_bc^2 - 2*(1 - Q_rel_bc)^2);
  zeta_cs_90 := 1.55*Q_rel_bc - Q_rel_bc^2;
  // Interpolation
  zeta_cb := zeta_cb_60 + (zeta_cb_90 - zeta_cb_60)/30*(alpha_deg - 60);
  zeta_cs := zeta_cs_60 + (zeta_cs_90 - zeta_cs_60)/30*(alpha_deg - 60);
end lin_interpol_Y1_60_90;
