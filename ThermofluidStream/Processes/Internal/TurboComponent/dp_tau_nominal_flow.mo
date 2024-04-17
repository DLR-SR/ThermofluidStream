within ThermofluidStream.Processes.Internal.TurboComponent;
function dp_tau_nominal_flow "Pump model with the nominal massflow model"
  extends partial_dp_tau;

  input Boolean parametrizeByDesignPoint= false "= true, if pump characteristic curve is computed from one design point"
    annotation(Dialog(enable=true));
  input SI.Pressure dp_D=500000 "Design pressure difference"
    annotation(Dialog(group="Design Point", enable=parametrizeByDesignPoint));
  input SI.VolumeFlowRate V_flow_D(displayUnit="l/min")=0.0016666666666667 "Design volume flow rate"
    annotation(Dialog(group="Design Point", enable=parametrizeByDesignPoint));
  input SI.AngularVelocity omega_D=314.2 "Design angular velocity"
    annotation(Dialog(group="Design Point", enable=parametrizeByDesignPoint));
  input Real slip_D(unit="1", min=0, max=1) = 0.5 "Design slip ((V_flow_nominal-V_flow)/V_flow_nominal)"
    annotation(Dialog(group="Design Point", enable=parametrizeByDesignPoint));
  input Real eta_D(unit="1", min=0.001, max=1) = 0.75 "Design efficiency"
    annotation(Dialog(group="Design Point", enable=parametrizeByDesignPoint));

  input SI.Volume V_r_input=0.0001 "Reference volume of pump"
    annotation(Dialog(group="Direct Parameters", enable=not parametrizeByDesignPoint));
  input Real k_p_input(unit="N.s/(m5)") = 1e5 "Linear pressure factor"
    annotation(Dialog(group="Direct Parameters", enable=not parametrizeByDesignPoint));
  input Real k_fric_input(unit="N.s/(m2)") = 1e-2 "Linear friction factor"
    annotation(Dialog(group="Direct Parameters", enable=not parametrizeByDesignPoint));

protected
  SI.SpecificVolume v_in = 1/max(rho_min, Medium.density(state_in)) "Inlet specific volume";

  SI.VolumeFlowRate V_flow_nominal "Nominal volume flow rate";
  SI.VolumeFlowRate V_flow "Volume flow rate";
  //slip = (V_flow_nominal - V_flow)/V_flow_nominal

  SI.Volume V_r = if parametrizeByDesignPoint then V_flow_D*radPrevolution/omega_D/(1-slip_D) else V_r_input "Pump volume";
  Real k_p(unit="N.s/(m5)") = if parametrizeByDesignPoint then dp_D/(slip_D/(1-slip_D)*V_flow_D) else k_p_input "Linear pressure factor";
  Real k_fric(unit="N.s/(m2)") = if parametrizeByDesignPoint then (dp_D*(1-slip_D))/(slip_D*omega_D)*(1/eta_D-1) else k_fric_input "Linear frication factor";

  constant Real radPrevolution(unit="rad") = 2*Modelica.Constants.pi;

algorithm
  // calc nominal and actual flow through pump
  V_flow := v_in*m_flow;
  V_flow_nominal := omega*V_r/radPrevolution;

  //calc dp as linear resistance model and w_t as volume change work in positive flow direction
  dp := k_p*(V_flow_nominal - V_flow);
  // for positive dp, if fluid goes against pressure gradient, Work performed is positive, else negative.
  // additionally a linear friction is added.
  tau_st := V_flow*dp*omega/(omega^2 + omega_norm^2) + k_fric*(V_flow_nominal - V_flow);

  annotation (Documentation(info="<html>
<p>Model that computes nominal volume flow and has a linear factor that determines the pressure generated linearly from the difference of actual volume flow V_flow and nominal volume flow V_flow_nominal = A*l*omega = V_r*omega. </p>
<p>The static moment has two parts. The first is the work performed on the fluid. The second term describes linear friction with the friction factor k_fric. </p>
<p>Parameters V_r &quot;Reference Volume&quot;, k_fric &quot;friction coefficient&quot; and k_p &quot;pressure coefficient&quot; can be set directly or by setting a design point of operation (angular velocity, pressure head, volume flow, slip and efficiency). </p>
</html>"));
end dp_tau_nominal_flow;
