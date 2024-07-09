within ThermofluidStream.Processes.Internal.TurboComponent;
function dp_tau_const_isentrop "Compressor model with parameter characteristic curve and constant isentropic efficiency"
  extends partial_dp_tau;

  import R_m = Modelica.Constants.R "General gas constant";

  input Real omega_ref(unit="rad/s")= 1000 "Reference speed, that produces pr=1-skew (at m_flow = m_flow_ref)"
    annotation(Dialog(group="Pressure ratio curve", enable=true));
  input Real skew(unit="1") = 0 "Scewness factor for mixed part of pr equation"
    annotation(Dialog(group="Pressure ratio curve", enable=true));
  input Real m_flow_ref(unit="kg/s") = 0.25 "Reference mass flow rate, that produces pr=1-skew (at omega = omega_ref)"
    annotation(Dialog(group="Pressure ratio curve", enable=true));
  input Real eta(unit="1") = 1 "Isentropic efficienty"
    annotation(Dialog(enable=true));
  input Real k(unit="1") = 2 "Exponential factor used for pr<1"
    annotation(Dialog(tab="Advanced", enable=true));
  input SI.Volume V_ref= 0.001 "Reference volume for chocke torque calculation"
    annotation(Dialog(tab="Advanced", enable=true));
  input Boolean kappaFromMedia = true "=true, if isentropic coefficient is calculated using the media model"
    annotation(Dialog(group = "Isentropic exponent", enable=true),choices(checkBox=true));
  input Real kappa_fixed(unit="1") = 1.4 "Isentropic coefficient"
    annotation(Dialog(group = "Isentropic exponent", enable = not kappaFromMedia));


protected
  SI.Pressure p_in = Medium.pressure(state_in) "Inlet pressure";
  SI.Temperature T_in = Medium.temperature(state_in) "Inlet temperature";
  Real kappa(unit="1") = if kappaFromMedia then Medium.isentropicExponent(state_in) else kappa_fixed "Inlet isentropic coefficient";
  Real R(unit="J/(kg.K)") = R_m/Medium.molarMass(state_in) "Inlet specific gas constant";

  SI.SpecificEnergy w_t_is "Specific technical work (for isentropic reference)";
  SI.SpecificEnergy w_t "Specific technical work";
  Real pr(unit="1") "Pressure ratio = p2/p1";

algorithm
  // Calculate the pressure ratio pr from characteristic curve
  pr := abs(omega)*omega/(omega_ref^2) - skew*omega*m_flow/(omega_ref*m_flow_ref) - abs(m_flow)*m_flow/(m_flow_ref^2) + 1;
  // make sure pressure ratio is always positive
  if pr < 1 then
    pr := k^(pr-1);
  end if;
  // Calculate the pressure difference dp from the pressure ratio pr
  dp := p_in*(pr-1);

  // Compute the technical work for isentropic reference w_t_is
  if pr >= 0 then
    // use this instead of h_in - Medium.isentropicEnthalpy(p_in+dp, state_in);
    // to make it more robust, isentropicEnthalpy fails to solve often
    w_t_is := kappa/(kappa - 1)*(R*T_in*(abs(pr)^((kappa - 1)/kappa) - 1));
  end if;

  //constant isenthalpic coefficient for compression and expansion
  if w_t_is*m_flow >= 0 then
    w_t :=w_t_is/eta;
  else
    w_t :=eta*w_t_is;
  end if;

  if sign(m_flow) == 1 and sign(omega) == 1 then
    tau_st := w_t*m_flow*omega/(omega^2 + omega_norm^2);
  else
    tau_st := +V_ref*dp* omega^2/(omega^2 + omega_norm^2) * m_flow^2/(m_flow^2 + m_flow_norm^2);
  end if;
  tau_st := tau_st + V_ref*dp* omega_norm^2/(omega^2 + omega_norm^2);

  annotation (Documentation(info="<html>
<p>
This is a model of isentropic expansion or compression of an ideal gas with a fixed
isentropic efficiency.
</p>
<p>
The isentropic exponent (kappa) by default is retrieved from the media model at
the inlet. It can be set to a fixed value to allow compressor operation in
two-phase region.
</p>
<p>
<br>The computation is as follows:
</p>
<ol>
  <li>
    with the scaling factors <code>omega_ref</code>, <code>m_flow_ref</code> and
    the scewness factor <code>skew</code>, the pressure ratio
    <code>pr=p_outlet/p_inlet</code> is computed as quadratic function of
    <code>omega/omega_ref</code>, <code>m_flow/m_flow_ref:</code>
    <br>
    <code>pr&nbsp;&nbsp;:=&nbsp;abs(omega)*omega/(omega_ref^2)
      &nbsp;-&nbsp;skew*omega*m_flow/(omega_ref*m_flow_ref)
      &nbsp;-&nbsp;abs(m_flow)*m_flow/(m_flow_ref^2)
      &nbsp;+&nbsp;1;</code>
  </li>
  <li>
    if the pressure ratio is smaller then 1 (expansion of gas), to limit it
    to 0 compute:
    <br>
    <code>pr&nbsp;:=&nbsp;k^(pr-1);</code>
  </li>
  <li>
    compute specific technical work w_t from pr using a isenthalpic process
  </li>
  <li>
    apply constant isentropic efficiency
  </li>
  <li>
    compute static moment by the following law:
    <ul>
      <li>
        if m_dot and omega both &gt; 0 (nominal operation):
        W_t = w_t*m_flow = tau*omega
      </li>
      <li>
        else (not nominal operation; with area of fluid A and radius of pump r)
        tau = F*r = dp*A*r = dp*V_ref
      </li>
    </ul>
    both are scaled so they are smooth at the border to nominal operation.
    Additionally for small omega, a small tau is added, so the standing pump can
    be pushed by the fluid.
  </li>
</ol>
<p>
<code>omega_ref</code> and <code>m_flow_ref</code> are supposed to be scaling
factors for omega and m_flow respectiveley. <code>omega_ref</code> is the angular
velocity that produces a pressure ratio of 2 at m_flow=0. <code>m_flow_ref</code>
is the massflow, that produces a negative pressure ratio of 1 at
<code>omega=omega_ref</code>. The skewness factor can be used to shape the
characteristic curve inbetween (see fig. 1).
</p>
<p>
When pr&nbsp;&lt;&nbsp;1, the reciprocal pressure ratio 1/pr&nbsp;= p_inlet/p_outlet
is more interesting. It can be seen for different values of skew in fig. 2.
</p>
<div>
<img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.Internal.dp_tau_const_polytrop_skewness.PNG\"/>
</div>
<p>
Fig. 1: different skewness factors for omega/omega_ref=1. pressure ratio pr over
m_dot/m_dot_ref
</p>
<div>
<img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.Internal.dp_tau_const_polytrop_skewness2.PNG\"/>
</div>
<p>
Fig. 2: different skewness factors for omega/omega_ref=1. Reciprocal pressure ratio
1/pr over m_dot/m_dot_ref
</p>
</html>"));
end dp_tau_const_isentrop;
