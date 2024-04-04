within ThermofluidStream;
model PumpTFSExplicit "Inserted PartialTurboComponent and function dp_tau_centrifugal into Pump to have access to all variables"
  extends ThermofluidStream.Interfaces.SISOFlow(m_flowStateSelect=StateSelect.prefer, final clip_p_out=true);

  import ThermofluidStream.Utilities.Types.InitializationMethods;
  import Quantity = ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities;

  parameter Real max_rel_volume(min=0, max=1, unit="1") = 0.05 "Maximum relative volume change"
    annotation(Dialog(tab="Advanced"));

  Real eta(unit="1") = if noEvent(abs(W_t)>1e-4) then dp*v_in*m_flow/W_t else 0.0;

protected
  SI.SpecificVolume v_out = 1/max(rho_min, Medium.density(inlet.state));

public
  parameter Boolean omega_from_input = false "Direct omega input"
    annotation(Dialog(group="Input/Output"));
  parameter Boolean enableOutput = false "Include output for selectable quantity"
    annotation(Dialog(group="Input/Output"));
  parameter Quantity outputQuantity=Quantity.m_flow_kgps "Quantity to output"
    annotation(Dialog(group="Input/Output", enable=enableOutput));
  parameter Boolean enableAccessHeatPort = false "Include access heatport"
    annotation(Dialog(group="Input/Output"));
  parameter SI.MomentOfInertia J_p = 5e-4 "Moment of inertia"
    annotation(Dialog(group="Parameters", enable=not omega_from_input));
  parameter SI.AngularVelocity omega_reg = dropOfCommons.omega_reg "Angular velocity used for normalization"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Mass flow used for normalization"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimum for rho (to make model stable for rho=0 @ p=0)"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter StateSelect omegaStateSelect = if omega_from_input then StateSelect.default else StateSelect.prefer "State select for m_flow"
    annotation(Dialog(tab="Advanced"));
  parameter InitializationMethods initOmega = ThermofluidStream.Utilities.Types.InitializationMethods.none "Initialization method for omega"
    annotation(Dialog(tab= "Initialization", group="Angular", enable=not omega_from_input));
  parameter SI.AngularVelocity omega_0 = 0 "Initial value for omega"
    annotation(Dialog(tab= "Initialization", group="Angular", enable=(initOmega == InitializationMethods.state)));
  parameter SI.AngularAcceleration omega_dot_0 = 0 "Initial value for der(omega)"
    annotation(Dialog(tab= "Initialization", group="Angular", enable=(initOmega == InitializationMethods.derivative)));
  parameter Boolean initPhi = false "If true phi is initialized"
    annotation(Dialog(tab= "Initialization", group="Angular", enable=not omega_from_input));
  parameter SI.Angle phi_0 = 0 "Initial value for phi"
    annotation(Dialog(tab= "Initialization", group="Angular", enable=initPhi));

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange(phi=phi, tau=tau) if not omega_from_input "Flange to receive mechanical power"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={0,-100}, rotation=-90),
      iconTransformation(extent={{-20,-20},{20,20}}, origin={0,-100}, rotation=-90)));
  Modelica.Blocks.Interfaces.RealInput omega_input(unit = "rad/s") = omega if omega_from_input "Input to directly set pump speed [rad/s]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={0,-100}, rotation=-90),
      iconTransformation(extent={{-20,-20},{20,20}}, origin={0,-100}, rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport(Q_flow = Q_t) if enableAccessHeatPort "Access-heat dumping port"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={0,100}, rotation=90),
      iconTransformation(extent={{-20,-20},{20,20}}, origin={0,100}, rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput output_val(unit=ThermofluidStream.Sensors.Internal.getFlowUnit(
                                                                                     outputQuantity)) = getQuantity(inlet.state, m_flow, outputQuantity, rho_min) if enableOutput "Measured value [variable]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-80,-100}, rotation=270)));

function getQuantity = ThermofluidStream.Sensors.Internal.getFlowQuantity (redeclare package Medium = Medium)
                                     "Function to compute a selectable quantity"
  annotation (
      Documentation(info="<html>
      <p>Function to compute a selectable quantity to output. The quantity is associated to the mass flow. </p>
      </html>"));

  SI.Power W_t "technichal work performed on fluid";
  SI.Power Q_t "work that could not be performed on the fluid, and is dumped to heat port";
  SI.Torque tau_st "moment that would result in static operation";

protected
  SI.SpecificVolume v_in = 1/max(rho_min, Medium.density(inlet.state));

  // intermediate quantities related to thermodynamical state
  SI.SpecificEnergy dh "specific technichal work performed under the assumption of positive massflow";

  // quantities related to inertia of component and mechanical power
  SI.Angle phi "component angular position";
  SI.Torque tau "moment from flange";
  SI.Torque tau_normalized "moment after zero massflow normalization";
  SI.AngularVelocity omega(stateSelect=omegaStateSelect) "component angular velocity";

 // extends ThermofluidStream.Processes.Internal.TurboComponent.partial_dp_tau;

public
  parameter Boolean parametrizeByScaling = true "If true scale by three parameters"
    annotation(Dialog(enable=true));
  parameter SI.Height TDH_D = 3.6610 "Design pressure head"
    annotation(Dialog(group="Scaling", enable=parametrizeByScaling));
  parameter SI.VolumeFlowRate V_flow_D = 3.06e-3 "Design volume flow"
    annotation(Dialog(group="Scaling", enable=parametrizeByScaling));
  parameter SI.AngularVelocity omega_D = 314.2 "Design angular velocity"
    annotation(Dialog(group="Scaling", enable=parametrizeByScaling));
  parameter Real K_D_input(unit="m3/rad") = 9.73e-06 "Vflow_D / omega_D"
    annotation(Dialog(group="General", enable=not parametrizeByScaling));
  parameter Integer f_q_input = 1 "Number of floods"
    annotation(Dialog(group="General", enable=not parametrizeByScaling));
  parameter SI.Radius r_input = 1.60e-2 "Radius of pump"
    annotation(Dialog(group="General", enable=not parametrizeByScaling));
  parameter SI.Density rho_ref_input = 1.00e3 "Reference Density"
    annotation(Dialog(group="General", enable=not parametrizeByScaling));
  parameter Real a_h_input(unit= "m.s2/rad2", displayUnit="m.min2") = 4.864e-5 "HQ factor 1"
    annotation(Dialog(group="HQ characteristic", enable=not parametrizeByScaling));
  parameter Real b_h_input(unit="s2/(m2.rad)", displayUnit="m.h.min/l") = -2.677 "HQ factor 2"
    annotation(Dialog(group="HQ characteristic", enable=not parametrizeByScaling));
  parameter Real c_h_input(unit="s2/m5", displayUnit="m.h2/l2") = 3.967e+5 "HQ factor 3"
    annotation(Dialog(group="HQ characteristic", enable=not parametrizeByScaling));
  parameter Real a_t_input(unit="N.m.s2/(rad.m3)", displayUnit="N.m.min.h/l") = 5.427e-1 "TQ factor 1"
    annotation(Dialog(group="TQ characteristic", enable=not parametrizeByScaling));
  parameter Real b_t_input(unit="N.m.s2/m6", displayUnit="N.m.h2/l2") = 2.777e+4 "TQ factor 2"
    annotation(Dialog(group="TQ characteristic", enable=not parametrizeByScaling));
  parameter Real v_i_input(unit="N.m.s2/rad2", displayUnit="N.m.min2") = 1.218e-6 "TQ factor 4"
    annotation(Dialog(group="TQ characteristic", enable=not parametrizeByScaling));
  parameter Real v_s_input(unit="N.m.s/rad", displayUnit="N.m.min") = 1.832e-4 "TQ factor 3"
    annotation(Dialog(group="TQ characteristic", enable=not parametrizeByScaling));
  parameter Real Re_mod_min(unit="1") = 1e2 "Minimum modified Reynolds number"
    annotation(Dialog(tab="Advanced", enable=true));

protected
  Medium.ThermodynamicState state_in = inlet.state "Thermodynamic state at inlet";
  Medium.MassFlowRate m_flow_norm = m_flow_reg "Mass flow used for normalization";
  SI.AngularVelocity omega_norm = omega_reg "Angular velocity used for normalization";

  Real alpha(unit="1") = TDH_D/TDH_D_ref "Pressure scaling factor";
  Real beta(unit="1") = omega_D/omega_D_ref "Speed scaling factor";
  Real gamma(unit="1") = V_flow_D/V_flow_D_ref "Flow scaling factor";

  SI.Density rho_in =  max(rho_min, Medium.density(state_in)) "Density at inlet";
  SI.DynamicViscosity eta_in = Medium.dynamicViscosity(state_in) "Dynamic viscosity at inlet";
  SI.KinematicViscosity mu_in = eta_in/rho_in "Kinematic viscosity at inlet";

  // SI.Power W_t_f "Technical work going into pump";
  SI.Length TDH "Total dynamic head";
  SI.VolumeFlowRate V_flow "Volume flow through pump";

  constant SI.AngularVelocity omega_D_ref = 314.2;
  constant SI.VolumeFlowRate V_flow_D_ref = 3.06e-3;
  constant SI.Height TDH_D_ref = 3.6610;

  constant Real a_h_ref(unit="m.s2/rad2") =   4.864e-5;
  constant Real b_h_ref(unit="s2/(m2.rad)") = -2.677;
  constant Real c_h_ref(unit="s2/m5") =       3.967e+5;

  constant Real a_t_ref(unit="N.m.s2/(rad.m3)") = 5.427e-1;
  constant Real b_t_ref(unit="N.m.s2/m6") =       2.777e+4;
  constant Real v_i_ref(unit="N.m.s2/rad2") =     1.218e-6;
  constant Real v_s_ref(unit="N.m.s/rad") =       1.832e-4;

  constant Real f_q_ref =             1;
  constant Real K_D_ref(unit="m3/rad") = 9.73e-06;
  constant SI.Density rho_ref_ref =      1.00e3;
  constant SI.Length r_ref =             1.60e-2;

  Real a_h(unit="m.s2/rad2") =   if parametrizeByScaling then alpha/(beta^2)*     a_h_ref else a_h_input;
  Real b_h(unit="s2/(m2.rad)") = if parametrizeByScaling then alpha/(beta*gamma)* b_h_ref else b_h_input;
  Real c_h(unit="s2/m5") =       if parametrizeByScaling then alpha/(gamma^2)*    c_h_ref else c_h_input;

  Real a_t(unit="N.m.s2/(rad.m3)") = if parametrizeByScaling then alpha/(beta^2)*                      a_t_ref else a_t_input;
  Real b_t(unit="N.m.s2/m6") =       if parametrizeByScaling then alpha/(beta*gamma)*                  b_t_ref else b_t_input;
  Real v_i(unit="N.m.s2/rad2") =     if parametrizeByScaling then sqrt(alpha)*gamma/beta*              v_i_ref else v_i_input;
  Real v_s(unit="N.m.s/rad") =       if parametrizeByScaling then alpha^(-1/4)*beta^(1/2)*gamma^(3/2)* v_s_ref else v_s_input;

  Real f_q =             if parametrizeByScaling then                 f_q_ref else f_q_input;
  Real K_D(unit="m3/rad") = if parametrizeByScaling then gamma/beta*     K_D_ref else f_q_input;
  SI.Density rho_ref =      if parametrizeByScaling then             rho_ref_ref else rho_ref_input;
  SI.Length r =             if parametrizeByScaling then sqrt(alpha)/beta* r_ref else r_input;

  Real omega_s(unit="1") = ((K_D/f_q)^0.5)/((Modelica.Constants.g_n*(a_h+b_h*K_D+c_h*K_D^2)) ^0.75);
  SI.VolumeFlowRate V_flow_BEP "optimal volume flow at omega";
  SI.AngularVelocity omega_hat "abs omega clipped Re_mod_min";
  Real Re_mod(unit="1");
  Real f_Q(unit="1");
  Real f_H(unit="1");
  Real f_eta(unit="1");

initial equation
  if initOmega == InitializationMethods.state then
    omega = omega_0;
  elseif initM_flow == InitializationMethods.derivative then
    der(omega) = omega_dot_0;
  elseif initM_flow == InitializationMethods.steadyState then
    der(omega) = 0;
  end if;

  if initPhi then
    phi = phi_0;
  end if;

equation

algorithm
  omega_hat  := max(Re_mod_min/(omega_s^1.5*f_q^0.75)/r^2*mu_in, abs(omega));
  //omega_hat  := abs(omega);
  V_flow_BEP := K_D*omega_hat;
  Re_mod     := (omega_hat*r^2)/(mu_in)*(omega_s^1.5*f_q^0.75);

  // compute corresponding volume flow of water and factors

  f_Q    := Re_mod^(-6.7/(Re_mod^0.735));
  f_eta  := Re_mod^(-19/(Re_mod^0.705));
  V_flow := m_flow/f_Q/rho_ref;
  f_H    := 1 - (1 - f_Q)*abs(V_flow/V_flow_BEP)^0.75;

  /*
  f_Q    := 1;
  f_eta  := 1;
  V_flow := m_flow/f_Q/rho_ref;
  f_H    := 1;
*/
  // corrected characteristic curves for TDH and tau_st
  TDH    := f_H *(a_h*omega*abs(omega) - b_h*omega*abs(V_flow) - c_h*V_flow*abs(V_flow));

  // original version
  // tau_st := (f_Q*f_H/f_eta) * (rho_in/rho_ref*(a_t*V_flow*abs(omega) - b_t*V_flow*abs(V_flow) + v_i*omega*abs(omega))) + v_s*abs(omega); // v_s is mechanical and does not scale with medium
  // docu version
  // tau_st := (f_Q*f_H/f_eta)*(rho_in/rho_ref*a_t*abs(omega)*V_flow - rho_in/rho_ref*b_t*abs(V_flow)*V_flow + v_i*abs(omega)*omega + v_s*abs(omega));

  // there could be several versions....
  tau_st := (f_Q*f_H/f_eta)*rho_in/rho_ref*((a_t*V_flow*abs(omega) - b_t*V_flow*abs(V_flow) + v_i*omega*abs(omega)) + v_s*abs(omega)); // v_s is mechanical and does not scale with medium

  //compute dp
  dp := rho_in*Modelica.Constants.g_n*TDH;
equation
  // compute dp, tau_st from characteristic curve
  //(dp, tau_st) = dp_tau_pump(m_flow, omega, inlet.state, m_flow_reg, omega_reg, rho_min);

  h_out = h_in + dh;
  Xi_out = Xi_in;

  // regularize tau_st/W_t such that the equations dont break for m_flow->0
  W_t = tau_st*omega;
  dh = (m_flow*W_t)/(m_flow^2 + (m_flow_reg)^2);
  if noEvent(W_t >= 0) then
    // if work is given to fluid, dump access heat to port
    Q_t = W_t - m_flow*dh;
    tau_normalized = tau_st;
  else
    // if work is taken from fluid, reduce tau, so that the work can be taken from the fluid
    Q_t = 0;
    tau_normalized = dh*m_flow/(noEvent(if abs(omega)>omega_reg then omega else (if omega < 0 then -omega_reg else omega_reg)));
  end if;

  // omega is either a state or directly given by omega_input (depending on omega_from_input)
  if noEvent(omega_from_input) then
    tau = 0;
    phi = 0;
  else
    J_p * der(omega) = tau - tau_normalized;
    omega = der(phi);
  end if;

  // Pump test for incompressibility
  assert(abs(v_in- v_out)/v_in < max_rel_volume, "Medium in pump is assumed to be incompressible, but check failed", dropOfCommons.assertionLevel);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
         Text(visible=displayComponentName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255}),
         Ellipse(
          extent={{-56,54},{64,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,60},{60,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,-60},{60,0}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-60,20},{66,-20}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-52,16},{60,-14}},
          textColor={28,108,200},
          textString="test version")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model is&nbsp;working&nbsp;under&nbsp;the&nbsp;assumption&nbsp;of&nbsp;incompressible&nbsp;fluids and performs an assert for this. </p>
<p>It can be chosen between</p>
<ul>
<li>Nominal-flow pump, where a nominal flow is computed and the difference between it and the actual flow is linearly producing a pressure</li>
<li>Centrifugal pump, which implements the equations of a scalable centrifugal pump.</li>
</ul>
</html>"));
end PumpTFSExplicit;
