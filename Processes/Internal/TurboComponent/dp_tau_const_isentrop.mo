within ThermofluidStream.Processes.Internal.TurboComponent;
function dp_tau_const_isentrop "Compressor model with parameter characteristic curve and constant isentropic efficiency"
  extends partial_dp_tau;
  import R_m = Modelica.Constants.R "General gas constant";

  parameter Real omega_ref(unit="rad/s")= 1000 "Reference speed, that produces pr=1"
    annotation(Dialog(group="Pressure ratio curve"));
  parameter Real skew(unit="1") = 0 "Scewness factor for mixed part of pr equation"
    annotation(Dialog(group="Pressure ratio curve"));
  parameter Real m_flow_ref(unit="kg/s") = 0.25 "Reference mass_flow, that produces pr=-1"
    annotation(Dialog(group="Pressure ratio curve"));
  parameter Real eta(unit="1") = 1 "Isentropic efficenty";

  parameter Real k(unit="1") = 2 "Exponetial factor used for pr<1"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Volume V_ref= 0.001 "Reference volume for chocke torque calculation"
    annotation(Dialog(tab="Advanced"));

  parameter Boolean kappaFromMedia = true "Retrieve kappa from media model?" annotation(Dialog(group = "Isentropic exponent"));
  parameter Real kappa_fixed(unit="1") "Fixed kappa value" annotation(Dialog(group = "Isentropic exponent", enable = not kappaFromMedia));

protected
  SI.Pressure p_in = Medium.pressure(state_in) "pressure at inlet";
  SI.Temperature T_in = Medium.temperature(state_in) "temperatur at inlet";

  Real kappa(unit="1") = if kappaFromMedia then Medium.isentropicExponent(state_in)
  else kappa_fixed "isentropic coefficient at inlet";

  Real R(unit="J/(kg.K)") = R_m/Medium.molarMass(state_in) "medium gas constant";

  SI.SpecificEnergy w_t_is "ideal specific technical work";
  SI.SpecificEnergy w_t "actual specific technical work";
  Real pr(unit="1") "pressure coefficent = p2/p1";

algorithm
  // calc pr from characteristic curve
  pr  := abs(omega)*omega/(omega_ref^2) - skew*omega*m_flow/(omega_ref*m_flow_ref) - abs(m_flow)*m_flow/(m_flow_ref^2) + 1;
  // make shure pressure ratio is alwails positive
  if pr < 1 then
    pr := k^(pr-1);
  end if;
  // calc dp
  dp := p_in*(pr-1);

  // compute w_t_is for isenthalpic compression
  // ideal gas assuptions
  if pr >= 0 then
    w_t_is :=kappa/(kappa - 1)*(R*T_in*(abs(pr)^((kappa - 1)/kappa) - 1));
  end if;

  //constant isenthalpic coefficient for compression and expansion
  if w_t_is*m_flow >= 0 then
    w_t :=w_t_is/eta;
  else
    w_t :=eta*w_t_is;
  end if;

  if sign(m_flow) == 1 and  sign(omega) == 1 then
    tau_st := w_t*m_flow*omega/(omega^2 + omega_norm^2);
  else
    tau_st := +V_ref*dp* omega^2/(omega^2 + omega_norm^2) * m_flow^2/(m_flow^2 + m_flow_norm^2);
  end if;
  tau_st := tau_st + V_ref*dp* omega_norm^2/(omega^2 + omega_norm^2);

  annotation (Documentation(info="<html>
<p>This is a model of isentropic expansion or compression of a ideal gas with a fixed isentropic efficency.</p>
<p>The isentropic exponent (kappa) by default is retrieved from the media model at the inlet. It can be set to a fixed value to allow compressor operation in two-phase region.</p>
<p><br>The computation is as follows:</p>
<ol>
<li>with the scaling factors <span style=\"font-family: Courier New;\">omega_ref, m_flow_ref and the scewness factor skew, the pressure ratio pr=p_outlet/p_inlet is computed as quadratic function of omega/omega_ref, m_flow/m_flow_ref: </span></li>
<p><span style=\"font-family: Courier New;\">pr&nbsp;&nbsp;:=<span style=\"color: #ff0000;\">&nbsp;abs</span>(omega)*omega/(omega_ref^2)&nbsp;-&nbsp;skew*omega*m_flow/(omega_ref*m_flow_ref)&nbsp;-<span style=\"font-family: Courier New; color: #ff0000;\">&nbsp;abs</span>(m_flow)*m_flow/(m_flow_ref^2)&nbsp;+&nbsp;1;</p>
<li>if the pressure ratio is smaller then 1 (expansion of gas), to limit it to 0 compute:</li>
<p><span style=\"font-family: Courier New;\">pr&nbsp;:=&nbsp;k^(pr-1);</span></p>
<li>compute specific technical work w_t from pr using a isenthalpic process</li>
<li>apply constant isentropic efficency </li>
<li>compute static moment by the following law: <br>- if m_dot and omega both &gt; 0 (nominal operation): W_t = w_t*m_flow = tau*omega<br>- else (not nominal operation; with Area of fluid A and radius of pump r) tau = F*r = dp*A*r = dp*V_ref<br>both are scaled so they are smooth at the border to not nominal operation. Additionally a for small omega, a small tau is added, so the standing pump can be pushed by fluid.</li>
</ol>
<p>omega_ref and m_flow_ref are supposed to be scaling factors for omega and m_flow respectiveley. omega_ref is the angular velocity that produces a pressure ratio of 2 at m_flow=0. m_flow_ref is the massflow, that produces a negative pressure ratio of 1 at omega=omega_ref. The skewness factor can be used to shape the characteristic curve inbetween (see fig. 1).</p>
<p>When pr &lt; 1, the recipocal pressure ratio 1/pr = p_inlet/p_outlet is more interesting. It can be seen for different values of skeq in fig. 2.</p>
<p><img width=\"600\" src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.Internal.dp_tau_const_polytrop_skewness.PNG\"/> </p>
<p>Fig. 1: different Skewness factors for omega/omega_ref=1. pressure ratio pr over m_dot/m_dot_ref</p>
<p><img width=\"600\" src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.Internal.dp_tau_const_polytrop_skewness2.PNG\"/> </p>
<p>Fig. 2: different Skewness factors for omega/omega_ref=1. recipocal pressure ratio 1/pr over m_dot/m_dot_ref</p>
</html>"));
end dp_tau_const_isentrop;
