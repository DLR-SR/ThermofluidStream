within ThermofluidStream.Processes.Internal.TurboComponent;
function dp_tau_nominal_flow "Pump model with the nominal massflow model"
  extends partial_dp_tau;

  input SI.Volume V_r = 0.0001 "Reference Volume of pump" annotation(Dialog(enable=true));
  input Real k_p(unit="N.s/(m5)") = 1e5 "Linear pressure factor" annotation(Dialog(enable=true));
  input Real k_fric(unit="N.s/(m2)") = 1e-2 "Linear friction factor" annotation(Dialog(enable=true));

protected
  SI.SpecificVolume v_in = 1/max(rho_min, Medium.density(state_in)) "specifiv volume at inlet";

  SI.VolumeFlowRate V_dot_nominal "nominal volume flow though pump";
  SI.VolumeFlowRate V_dot "actual volume flow though pump";

algorithm
  // calc nominal and actual flow through pump
  V_dot :=v_in*m_flow;
  V_dot_nominal := omega*V_r;

  //calc dp as linear resistance model and w_t as volume change work in positive flow direction
  dp := k_p*(V_dot_nominal - V_dot);
  // for positive dp, if fluid goes against pressure gradient, Work performed is positive, else negative.
  // additionaly a linear friction is added.
  tau_st := V_dot*dp*omega/(omega^2 + omega_norm^2) + k_fric*(V_dot_nominal - V_dot);

  annotation (Documentation(info="<html>
<p><span style=\"font-size: 12pt;\">Model that computes nominal volume flow and has a linar factor that determines the pressure generataed linearly from the difference of actual volume flow </span></span><span style=\"font-family: Courier New;\">V_dot<span style=\"font-family: Courier New; font-size: 12pt;\"> and nominal volume flow </span>V_dot_nominal = A*l*omega = V_r*omega<span style=\"font-family: Courier New; font-size: 12pt;\">.</span></p>
<p><span style=\"font-size: 12pt;\">The static moment has two parts. the first part is the work performed on the fluid. The second term describes linear friction with the friction factor </span></span><span style=\"font-family: Courier New;\">k_fric.</p>
</html>"));
end dp_tau_nominal_flow;
