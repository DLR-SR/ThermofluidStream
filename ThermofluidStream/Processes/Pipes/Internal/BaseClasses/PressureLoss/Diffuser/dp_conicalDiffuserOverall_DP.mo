within ThermofluidStream.Processes.Pipes.Internal.BaseClasses.PressureLoss.Diffuser;
function dp_conicalDiffuserOverall_DP "Pressure loss of conical diffuser | calculate pressure loss | uniform velocity profile | overall flow regime"

  extends Modelica.Icons.Function;

  import c_spline = ThermofluidStream.Processes.Pipes.Internal.Utilities.cubicHermite;

  // Input variables
  input SI.MassFlowRate m_flow "Mass flow rate";
  input SI.Area A_0 "Inlet area";
  input SI.Area A_1 "Outlet area";
  input SI.Angle alpha "Central divergence angle";
  input SI.Length Delta(min = 0) "Relative roughness of diffuser walls";
  input SI.Density rho "Density";
  input SI.DynamicViscosity mu "Dynamic viscosity";
  // Output variables
  output SI.Pressure dp "Pressure loss (>0)";
  output Types.PressureLossCoefficient zeta_dif "Pressure loss coefficient of diffuser";
  output Types.PressureLossCoefficient zeta_exp "Pressure loss coefficient due to diffuser enlargement";
  output Types.PressureLossCoefficient zeta_fr "Pressure loss coefficient due to wall friciton";
  output Real alpha_deg = alpha*180/pi "Central divergence angle (in degree)";
  // [1] Idelchik
  // [2] Modelica.Fluid.Pipes.BaseClasses.WallFriction.Detailed.pressureLoss_m_flow_staticHead
  // Variables for zeta_exp
protected
  Types.PressureLossCoefficient zeta_exp1 "Pressure loss coefficient due to diffuser enlargement in region 1";
  Types.PressureLossCoefficient zeta_exp2 "Pressure loss coefficient due to diffuser enlargement in region 2";
  // Real alpha_deg = alpha*180/pi "central divergence angle of diffuser walls in degree";
  Real n_0 = A_0/A_1 "Area ratio";
  constant Real k_1 = 1 "Coefficient characterizing the state of the boundary layer (uniform velocity profile k_1 = 1)";
  constant Real k_2 = 3.2 "Coefficient characterizing the shape of the diffuser cross cross section (circular k_2 = 3.2)";
  // Polynomial coefficients for zeta_exp2
  Real p_1 = 0.0001116*n_0^3 - 0.0001112*n_0^2 + 1.931e-5*n_0 + 5.91e-6;
  Real p_2 = -0.0292*n_0^3 + 0.02792*n_0^2 - 0.002995*n_0 - 0.002489;
  Real p_3 = 1.012*n_0^2 - 2.428*n_0 + 1.29;
  // Boundaries of cubic hermite spline for transition region
  Real alpha_bound1 = 40 "Lower angle boundary for transition region";
  Real alpha_bound2 = 60 "Upper angle boundary for transition region";
  Real zeta_exp_bound1 = k_2*tan(alpha_bound1/180*pi/2)*(tan(alpha_bound1/180*pi/2))^(1/4)*(1 - n_0)^2 "Pressure loss coefficient zeta_exp at lower transition boundary";
  Real zeta_exp_bound2 = p_1*(alpha_bound2)^2 + p_2*(alpha_bound2) + p_3 "Pressure loss coefficient zeta_exp at upper transition boundary";
  Real dzeta_exp_dalpha_bound1 = (pi*k_2*(n_0 - 1)^2*(1/cos(alpha_bound1/180*pi/2))^2*(tan(alpha_bound1/180*pi/2))^(1/4))/288 "Derivative of diffuser enlargement pressure loss with respect to alpha in region 1 at lower boundary";
  Real dzeta_exp_dalpha_bound2 = 2*p_1*alpha_bound2 + p_2 "Derivative of diffuser enlargement pressure loss with respect to alpha in region 2 at upper boundary";
  // Variables for zeta_fr
  Types.DarcyFrictionFactor lambda "Darcy friciton factor";
  Real Re1 = 2300 "Reynolds number laminar-turbulent transition regime";
  Real Re2 = 4000 "Reynolds number laminar-turbulent transition regime";
  SI.Length D_0 = 2*sqrt(A_0/pi) "Inlet diameter";
  SI.Length D_1 = 2*sqrt(A_1/pi) "Outlet diameter";
  SI.Length L_dif = (D_1 - D_0)/2/tan(alpha/2) "Diffuser length";
algorithm
  // Pressure loss coefficient due to diffuser enlargement zeta_exp
  // Determine zeta_exp
  // [1]
  zeta_exp1 := k_2*tan(alpha_deg/180*pi/2)*(tan(alpha_deg/180*pi/2))^(1/4)*(1 - n_0)^2;
  // Own aproximation formula
  zeta_exp2 := p_1*(alpha_deg)^2 + p_2*(alpha_deg) + p_3;
  // Section wise defined  overall formula
  if alpha_deg < alpha_bound1 then
    zeta_exp := zeta_exp1;
  elseif alpha_deg > alpha_bound2 then
    zeta_exp := zeta_exp2;
  else
    zeta_exp := c_spline(alpha_deg, alpha_bound1, alpha_bound2, zeta_exp_bound1, zeta_exp_bound2, dzeta_exp_dalpha_bound1, dzeta_exp_dalpha_bound2);
  end if;
  // Pressure loss due to wall friction zeta_fr
  // determine zeta_fr
  lambda := WallFriction.Utilities.DarcyFriction(
    m_flow,
    D_0,
    Delta,
    rho,
    mu,
    Re1,
    Re2);
  // [1]
  zeta_fr := lambda/(8*sin(alpha/2))*(1 - n_0^2)*1.5;
  // Determine total pressure loss coefficient of diffuser zeta_dif
  zeta_dif := k_1*zeta_exp + zeta_fr;
  // Determine pressure loss
  dp := rho/2*zeta_dif*(abs(m_flow)/(rho*A_0))^2;
  annotation (
    Documentation(info="<html>

<p>
The implementation of the function is based on \"Handbook of Hydraulic Resistance\" in its first translated Version from 1960! The book has been republished in several updated versions since then!
Function calculating the pressure loss of a conical diffuser as f(m_flow, F_0, F_1, alpha, Delta, rho,mu) where:
</p>

<ul>
<li>m_flow: mass flow rate [kg/s]</li>
<li>F_0: cross sectional of narrow section [m^2]</li>
<li>F_1: cross sectional of wide section [m^2]</li>
<li>alpha: central divergence angle [rad]</li>
<li>Delta: relative wall roughness [-]</li>
<li>rho: density [kg/m^3]</li>
<li>mu: dynamic viscosity [Pa.s]</li>
</ul>

<p>
Calculation according to Idelchik (1960). The pressure loss is calculated as: 
</p>

<p>
<code>dp = rho/2 * zeta_dif * c_0^2</code>
</p> 

<p>
with the total pressure loss coefficient of the diffuser zeta_dif:
</p>

<p>
<code>zeta_dif = k_1* zeta_exp + zeta_fr </code>
</p>

<ul>
<li>k_1 = 1 coefficient characterizing the state of the boundary layer (uniform velocity profil k_1 = 1)</li>
</ul>

<p>
The local resistance due to diffuser enlargement zeta_exp is diveded in 2 regions and a transition region blending both forumlas using a cubic hermite spline.
In the first region (alpha &lt; 40°) the function provided by Idelchik is used:
</p>

<p>
<code> zeta_exp = k_2 * tan(alpha/2) * (tan(alpha/2))^1/4 * (1 - n_0)^2 </code>
</p>

<ul>
<li>k_2 = 3.2 coefficient characterizing the shape of the diffuser cross section (circular k_2 = 3.2)</li>
<li>n_0 = F_0/F_1 area ratio of diffuser</li>
</ul>

<p>
In the second region (60 &lt; alpha &lt; 180) a 2nd degree polynomial is fitted to the data given by Idelchik.
</p>

<p>
<code> zeta_exp = p_1 * alpha^2 + p_2 * alpha + p_3 </code>
</p>

<p>
where the polynomial coefficients a described as functions of n_0:
</p>

<p>
<code> p_1 = 0.0001116 * n_0^3 - 0.0001112 * n_0^2 + 1.931e-6 + n_0 + 5.91e-6 n_0<br>
p_2 = -0.0292 * n_0^3 + 0.02792 * n_0^2 - 0.002995 * n_0 - 0.002489<br>
p_3 = 1.012 * n_0^2 - 2.428 * n_0 + 1.29
</code>
</p>

<p>
The following figure <strong>Fig.1</strong>, the data and fitted polynomial coefficients are shown. (Currently not yet available)
</p>

<p>
<em>[P. Jordan; HTWG Konstanz; 01/24]</em>
</p>

<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"350\" height=\"100\">
</p>

</html>"));
end dp_conicalDiffuserOverall_DP;
