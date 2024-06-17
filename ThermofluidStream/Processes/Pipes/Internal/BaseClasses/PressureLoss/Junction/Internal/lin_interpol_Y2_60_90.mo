within ThermofluidStream.Processes.Pipes.Internal.BaseClasses.PressureLoss.Junction.Internal;
function lin_interpol_Y2_60_90
  // Input variables
  input Real alpha_deg "Branching angle (in deg)";
  input Real w_rel_bc "Velocity ratio branch/common";
  input Real Q_rel_bc "Volume flow rate ratio branch/common";
  input Real F_rel_cb "Area ratio common/branch";
  input Real F_rel_cs "Area ratio common/straight";
  input Real K_b[3] "Free term correction for zeta_cb";
  input Real K_s[3] "Free term correction for zeta_cs";
  // Polynomial coefficients
  input Real A;
  input Real B;
  // Output variables
  output Real zeta_cb;
  output Real zeta_cs;
protected
  Real zeta_cb_60;
  Real zeta_cb_90;
  Real zeta_cs_60;
  Real zeta_cs_90;
algorithm
  zeta_cb_60 := 1 + w_rel_bc^2 - 2*F_rel_cs*(1 - Q_rel_bc)^2 - F_rel_cb*Q_rel_bc^2 + K_b[2];
  zeta_cs_60 := 1 + F_rel_cs^2*(1 - Q_rel_bc)^2 - 2*F_rel_cs*(1 - Q_rel_bc)^2 - F_rel_cb*Q_rel_bc^2 + K_s[2];
  zeta_cb_90 := 1 + w_rel_bc^2 - 2*F_rel_cs*(1 - Q_rel_bc)^2 + K_b[3];
  zeta_cs_90 := A*(1 + F_rel_cs^2*(1 - Q_rel_bc)^2 - B*2*F_rel_cs*(1 - Q_rel_bc)^2 - F_rel_cb*Q_rel_bc^2) + K_s[3];
  // Interpolation
  zeta_cb := zeta_cb_60 + (zeta_cb_90 - zeta_cb_60)/30*(alpha_deg - 60);
  zeta_cs := zeta_cs_60 + (zeta_cs_90 - zeta_cs_60)/30*(alpha_deg - 60);
end lin_interpol_Y2_60_90;
