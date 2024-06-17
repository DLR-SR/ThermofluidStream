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
    Documentation(info="<html><head></head><body><div><b>The implementation of the function is based on \"Handbook of Hydraulic Resistance\" in its first translated Version from 1960!</b></div><div><b>The book has been republished in several updated versions since then!</b></div>Function calculating the pressure loss of a conical diffuser as f(m_flow, F_0, F_1, alpha, Delta, rho,mu) where:<div><ul><li>m_flow:<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>mass flow rate [kg/s]</li><li>F_0:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>cross sectional&nbsp;of narrow section [m^2]</li><li>F_1:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>cross sectional&nbsp;of wide section [m^2]</li><li>alpha:<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>central divergence angle [rad]</li><li>Delta:<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>relative wall roughness [-]</li><li>rho:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>density [kg/m^3]</li><li>mu:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>dynamic viscosity [Pa.s]</li></ul><div>Calculation according to Idelchik (1960)</div><div>The pressure loss is calculated as:</div></div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>dp = rho/2 * zeta_dif * c_0^2</div><div><br></div><div>with the total pressure loss coefficient of the diffuser zeta_dif:</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>zeta_dif = k_1* zeta_exp + zeta_fr</div><div><ul><li>k_1 = 1 coefficient characterizing the state of the boundary layer (uniform velocity profil k_1 = 1)</li></ul><div>The local resistance due to diffuser enlargement zeta_exp is diveded in 2 regions and a transition region blending both forumlas using a cubic hermite spline.</div></div><div>In the first region (alpha &lt; 40°) the function provided by Idelchik is used:</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>zeta_exp = k_2 * tan(alpha/2) * (tan(alpha/2))^1/4 * (1 - n_0)^2</div><div><ul><li>k_2 = 3.2 <span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>coefficient characterizing the shape of the diffuser cross section (circular k_2 = 3.2)</li><li>n_0 = F_0/F_1<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>area ratio of diffuser</li></ul><div>In the second region (60 &lt; alpha &lt; 180) a 2nd degree polynomial is fitted to the data given by Idelchik.</div></div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>zeta_exp = p_1 * alpha^2 + p_2 * alpha + p_3</div><div><br></div><div>where the polynomial coefficients a described as functions of n_0</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>p_1 = 0.0001116 * n_0^3 - 0.0001112 * n_0^2 + 1.931e-6 + n_0 + 5.91e-6 n_0</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>p_2 = -0.0292 * n_0^3 + 0.02792 * n_0^2 - 0.002995 * n_0 - 0.002489</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>p_3 = 1.012 * n_0^2 - 2.428 * n_0 + 1.29</div><div><br></div><div>The following figure <b>Fig.1</b>, &nbsp;the data and fitted polynomial coefficients are shown.</div><div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 1:</strong> data and fitted polynomial coefficients p1, p2 &amp; p3</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Diffuser/dp_conicalDiffuserOverall_DP/polycoef.png\" alt=\"data and fitted polynomial coefficients p1, p2 &amp; p3\" width=\"750\" height=\"600\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div>In order to create a smooth transition between the two functions, a cubic hermite spline is used. The following <b>Fig.2</b> shows two forumals for each region, and the final function with blended transition.</div><div><br></div><div>      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 2:</strong> zeta_exp: region1, region 2 &amp; transition</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Diffuser/dp_conicalDiffuserOverall_DP/zeta_exp.png\" alt=\"zeta_exp: region1, region 2 &amp; transition\" width=\"1000\" height=\"740\">
      </td>
      </tr>
      </tbody></table><br></div><div><br></div><div>The pressure loss coefficient due to wall fricition zeta_fr of unity length of diffuser is calculated using the equations provided by Idelchik in turn:</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>zeta_fr = lambda/(8* sin(alpha/2)) * (1 - n_0)^2</div><div><ul><li>lambda: Dracy Fricition factor determined through funtion <a href=\"modelica://Fluid_HTWG.Pipes.BaseClasses.WallFriction.Utilities.DarcyFriction\">Darcy Friction</a></li></ul><div>To get the pressure loss coefficient of &nbsp;the full diffuser, zeta_fr (of unity length) is multiplied by the length of the diffuser.</div></div><div><br></div><div>The following <b>Fig.3</b> shows the pressure loss coeffients of unity lentgh of diffuser due to wall friciton zeta_fr</div>      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 1:</strong> Pressure loss coefficient zeta_fr due to wall friciton of unity length of diffuser</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Diffuser/dp_conicalDiffuserOverall_DP/zeta_fr.png\" alt=\"Pressure loss coefficient zeta_fr due to wall friciton of unity length of diffuser\" width=\"750\" height=\"710\">
      </td>
      </tr>
      </tbody></table><div><br></div><div>
      <em>[P. Jordan; HTWG Konstanz; 01/24]</em><p></p><p>
  <img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"175\" height=\"50\">
  </p></div></div></body></html>"));
end dp_conicalDiffuserOverall_DP;
