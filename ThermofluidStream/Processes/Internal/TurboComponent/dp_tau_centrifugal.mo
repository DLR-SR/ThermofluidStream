within ThermofluidStream.Processes.Internal.TurboComponent;
function dp_tau_centrifugal "Model of a centrifugal pump"

  extends partial_dp_tau;

  import Modelica.Constants.g_n;

  input Boolean parametrizeByScaling = true "= true, if pump characteristic curve is computed from one design point"
    annotation(Dialog(enable=true));
  input SI.Height TDH_D = 3.6610 "Design pressure head (max efficiency)"
    annotation(Dialog(group="Scaling", enable=parametrizeByScaling));
  input SI.VolumeFlowRate V_flow_D = 3.06e-3 "Design volume flow (max efficiency)"
    annotation(Dialog(group="Scaling", enable=parametrizeByScaling));
  input SI.AngularVelocity omega_D = 314.2 "Design angular velocity"
    annotation(Dialog(group="Scaling", enable=parametrizeByScaling));
  input Real K_D_input(unit="m3/rad") = 9.73e-06 "Vflow_D / omega_D"
    annotation(Dialog(group="General", enable=not parametrizeByScaling));
  input Integer f_q_input = 1 "Number of floods"
    annotation(Dialog(group="General", enable=not parametrizeByScaling));
  input SI.Radius r_input = 1.60e-2 "Pump radius (r2)"
    annotation(Dialog(group="General", enable=not parametrizeByScaling));
  input SI.Density rho_ref_input = 1.00e3 "Reference density"
    annotation(Dialog(group="General", enable=not parametrizeByScaling));
  input Real a_h_input(unit= "m.s2/rad2", displayUnit="m.min2") = 4.864e-5 "HQ factor 1"
    annotation(Dialog(group="HQ characteristic", enable=not parametrizeByScaling));
  input Real b_h_input(unit="s2/(m2.rad)", displayUnit="m.h.min/l") = -2.677 "HQ factor 2"
    annotation(Dialog(group="HQ characteristic", enable=not parametrizeByScaling));
  input Real c_h_input(unit="s2/m5", displayUnit="m.h2/l2") = 3.967e+5 "HQ factor 3"
    annotation(Dialog(group="HQ characteristic", enable=not parametrizeByScaling));
  input Real a_t_input(unit="N.m.s2/(rad.m3)", displayUnit="N.m.min.h/l") = 5.427e-1 "TQ factor 1"
    annotation(Dialog(group="TQ characteristic", enable=not parametrizeByScaling));
  input Real b_t_input(unit="N.m.s2/m6", displayUnit="N.m.h2/l2") = 2.777e+4 "TQ factor 2"
    annotation(Dialog(group="TQ characteristic", enable=not parametrizeByScaling));
  input Real v_i_input(unit="N.m.s2/rad2", displayUnit="N.m.min2") = 1.218e-6 "TQ factor 4"
    annotation(Dialog(group="TQ characteristic", enable=not parametrizeByScaling));
  input Real v_s_input(unit="N.m.s/rad", displayUnit="N.m.min") = 1.832e-4 "TQ factor 3"
    annotation(Dialog(group="TQ characteristic", enable=not parametrizeByScaling));
  input Real Re_mod_min(unit="1") = 1e2 "Minimum modified Reynolds number"
    annotation(Dialog(tab="Advanced", enable=true));

protected
  Real alpha(unit="1") = TDH_D/TDH_D_ref "Pressure scaling factor";
  Real beta(unit="1") = omega_D/omega_D_ref "Speed scaling factor";
  Real gamma(unit="1") = V_flow_D/V_flow_D_ref "Flow scaling factor";

  SI.SpecificVolume v_in =  1/max(rho_min, Medium.density(state_in)) "Inlet specific volume";
  SI.SpecificVolume mu_in = Medium.dynamicViscosity(state_in) "Inlet dynamic viscosity";
  SI.SpecificVolume v_ref = 1/rho_ref "Reference specific volume";

  SI.Power W_t "Power (technical work flow rate)";
  SI.Length TDH "Total dynamic head";
  SI.VolumeFlowRate V_flow "Volume flow rate";

  constant SI.AngularVelocity omega_D_ref = 314.2 "Design angular velocity of reference pump";
  constant SI.VolumeFlowRate V_flow_D_ref = 3.06e-3 "Design volume flow rate (max efficiency) of reference pump";
  constant SI.Height TDH_D_ref = 3.6610 "Design total dynamic head (max efficiency) of reference pump";

  constant Real a_h_ref(unit="m.s2/rad2") =   4.864e-5 "HQ factor 1";
  constant Real b_h_ref(unit="s2/(m2.rad)") = -2.677 "HQ factor 2";
  constant Real c_h_ref(unit="s2/m5") =       3.967e+5 "HQ factor 3";

  constant Real a_t_ref(unit="N.m.s2/(rad.m3)") = 5.427e-1 "TQ factor 1";
  constant Real b_t_ref(unit="N.m.s2/m6") =       2.777e+4 "TQ factor 2";
  constant Real v_i_ref(unit="N.m.s2/rad2") =     1.218e-6 "TQ factor 4";
  constant Real v_s_ref(unit="N.m.s/rad") =       1.832e-4 "TQ factor 3";

  constant Integer f_q_ref =             1 "Number of floods of reference pump";
  constant Real K_D_ref(unit="m3/rad") = 9.73e-06 "Vflow_D / omega_D for reference pump";
  constant SI.Density rho_ref_ref =      1.00e3 "Reference density of reference pump";
  constant SI.Length r_ref =             1.60e-2 "Radius of reference pump (r2)";

  Real a_h(unit="m.s2/rad2") =   if parametrizeByScaling then alpha/(beta^2)*     a_h_ref else a_h_input "HQ factor 1";
  Real b_h(unit="s2/(m2.rad)") = if parametrizeByScaling then alpha/(beta*gamma)* b_h_ref else b_h_input "HQ factor 2";
  Real c_h(unit="s2/m5") =       if parametrizeByScaling then alpha/(gamma^2)*    c_h_ref else c_h_input "HQ factor 3";

  Real a_t(unit="N.m.s2/(rad.m3)") = if parametrizeByScaling then alpha/(beta^2)*                      a_t_ref else a_t_input "TQ factor 1";
  Real b_t(unit="N.m.s2/m6") =       if parametrizeByScaling then alpha/(beta*gamma)*                  b_t_ref else b_t_input "TQ factor 2";
  Real v_i(unit="N.m.s2/rad2") =     if parametrizeByScaling then sqrt(alpha)*gamma/beta*              v_i_ref else v_i_input "TQ factor 4";
  Real v_s(unit="N.m.s/rad") =       if parametrizeByScaling then alpha^(-1/4)*beta^(1/2)*gamma^(3/2)* v_s_ref else v_s_input "TQ factor 3";

  Integer f_q =             if parametrizeByScaling then                 f_q_ref else f_q_input "Number of floods";
  Real K_D(unit="m3/rad") = if parametrizeByScaling then gamma/beta*     K_D_ref else f_q_input "Vflow_D / omega_D";
  SI.Density rho_ref =      if parametrizeByScaling then             rho_ref_ref else rho_ref_input "Reference density";
  SI.Length r =             if parametrizeByScaling then sqrt(alpha)/beta* r_ref else r_input "Pump radius (r2)";

  Real omega_s(unit="1") = ((K_D/f_q)^0.5)/((g_n*(a_h+b_h*K_D+c_h*K_D^2)) ^0.75) "specific speed (using angular velocity)";
  SI.VolumeFlowRate V_flow_BEP "optimal volume flow at omega";
  SI.AngularVelocity omega_hat "abs omega clipped Re_mod_min";
  Real Re_mod(unit="1") "Modified Reynolds number";
  Real f_Q(unit="1") "Scaling factor for volume flow rate";
  Real f_H(unit="1") "Scaling factor for head";
  Real f_eta(unit="1") "Scaling factor for efficiency";

algorithm
  //limit abs(omega) to effectiveley limit the Re_mod to Re_mod_min
  omega_hat  := max(Re_mod_min/(omega_s^1.5*f_q^0.75)/r^2*mu_in, abs(omega));
  V_flow_BEP := K_D*omega_hat;
  Re_mod     := (omega_hat*r^2)/(mu_in)*(omega_s^1.5*f_q^0.75);

  // compute corresponding volume flow of water and factors
  f_Q    := Re_mod^(-6.7/(Re_mod^0.735));
  f_eta  := Re_mod^(-19/(Re_mod^0.705));
  V_flow := v_in*m_flow/f_Q;
  f_H    := 1 - (1 - f_Q)*abs(V_flow/V_flow_BEP)^0.75;

  // corrected characteristic curves for TDH and tau_st
  TDH    := f_H *(a_h*omega*abs(omega) - b_h*omega*abs(V_flow) - c_h*V_flow*abs(V_flow));
  tau_st := (f_Q*f_H/f_eta) * (v_ref/v_in* (a_t*V_flow*abs(omega) - b_t*V_flow*abs(V_flow) + v_i*omega*abs(omega))) + v_s*abs(omega); // v_s is mechanical and does not scale with medium

  //compute dp
  dp := g_n*TDH/v_in;

  annotation (Documentation(info="<html>
<p>Centrifugal pump with HQ and TQ characteristic curve. </p>
<p>HQ curve: <code>TDH&nbsp;&nbsp;&nbsp;&nbsp;:=&nbsp;f_H&nbsp;*(a_h*omega*abs(omega)&nbsp;-&nbsp;b_h*omega*abs(V_flow)&nbsp;-&nbsp;c_h*V_flow*abs(V_flow));</code></p>
<p>TQ curve: <code>tau_st&nbsp;:=&nbsp;(f_Q*f_H/f_eta)*(&nbsp;v_ref/v_in*a_t*abs(omega)*V_flow&nbsp;-&nbsp;v_ref/v_in*b_t*abs(V_flow)*V_flow&nbsp;+&nbsp;v_i*abs(omega)*omega&nbsp;+&nbsp;v_s*abs(omega));</code></p>
<p>Both characteristics are generalized to all four quadrants of the V_flow/omega plot.</p>
<p>The parameters a,b,c,v can be set directly or by three scaling factors alpha, beta and gamma, which scale the reference pump.</p>
<p>Reference pump:</p>
<blockquote><pre>
omega_D = 314.2 rad/s
V_flow_D = 3.06e-3 m3/s
TDH_D = 3.6610 m

a_h_ref =  4.864e-5 m.s2/rad2;
b_h_ref = -2.677 s2/(m2.rad);
c_h_ref =  3.967e+5 s2/m5;
a_t_ref =  5.427e-1 N.m.s2/(rad.m3);
b_t_ref =  2.777e+4 N.m.s2/m6;
v_i_ref =  1.218e-6 N.m.s2/rad2;
v_s_ref =  1.832e-4 N.m.s/rad;
f_q_ref =  1;
K_D_ref =  9.73e-06 m3/rad;
rho_ref_ref = 1.00e3 kg/m3;
r_ref   =  1.60e-2 m;
</pre></blockquote>
<p>The characteristic curves are getting scaled to accommodate different densities and viscosities (according to G&uuml;lich, Kreiselpumpen: Handbuch f&uuml;r Entwicklung, Anlageplanung und Betrieb, 3. Auflage, Chap. 13.1).</p>
</html>"));
end dp_tau_centrifugal;
