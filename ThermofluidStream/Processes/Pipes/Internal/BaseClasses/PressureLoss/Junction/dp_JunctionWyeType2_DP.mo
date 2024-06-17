within ThermofluidStream.Processes.Pipes.Internal.BaseClasses.PressureLoss.Junction;
function dp_JunctionWyeType2_DP
  extends Modelica.Icons.Function;

  import SMOOTH = ThermofluidStream.Processes.Pipes.Internal.Utilities.Stepsmoother;
  // Input variables
  input SI.Area F_c "Cross-sectional area of (common) outlet";
  input SI.Area F_b "Cross-sectional area of branching inlet";
  input SI.Area F_s "Cross sectional area of straight inlet";
  input SI.Velocity w_c "Velocity at (common) outlet";
  input SI.Velocity w_b "Velocity at branching inlet";
  input SI.Velocity w_s "Velocity at straight inlet";
  input SI.Angle alpha_deg "Branching angle in degree";
  input Real K_s[3] "Free term correction for straight inlet";
  input Real K_b[3] "Free term correction for branching inlet";
  input SI.Density rho_c "Density of fluid at (common) outlet";
  input SI.Velocity eps "To avoid division by zero";
  // Output variables
  output SI.Pressure dp_b "Pressure loss at branching inlet";
  output SI.Pressure dp_s "Pressure loss at straight inlet";
  output Types.PressureLossCoefficient zeta_cb
    "Pressure loss coefficient of branching inlet w.r.t. (common) outlet velocity";
  output Types.PressureLossCoefficient zeta_cs
    "Pressure loss coefficient of straight inlet w.r.t. (common) outlet velocity";
  //output Real w_rel_bc = w_b/w_c "velocity ratio of branch and common channel";
  //output Real w_rel_sc = w_s/w_c "velocity ratio of main passage and common channel";
  //output Fluid_HTWG.Types.PressureLossCoefficient zeta_cb_prime "auxilliary pressure loss coefficient of branch expressed through the velocity in the common channel";
protected
  Real w_rel_bc = if abs(w_c) > eps then w_b/w_c else 1 "Velocity ratio branch/(common) outlet";
  Real w_rel_sc = if abs(w_c) > eps then w_s/w_c else 1 "Velocity ratio straight/(common) outlet";
  Real Q_rel_bc = w_rel_bc/F_rel_cb "Volume flow rate ratio branch/(common) outlet";
  Real k "Coefficient characterizing the branching angle dependency";
  Real F_rel_cb = F_c/F_b "Area ratio (common) outlet/branching inlet";
  Real F_rel_cs = F_c/F_s "Area ratio (common) outlet/straight inlet";
  // Correction factors at alpha = 90°
  Real A "Coefficient";
  Real B "Coefficient";
  function interpolate =
      Internal.lin_interpol_Y2_60_90;
algorithm
  k := -0.0001778*alpha_deg^2 - 0.008667*alpha_deg + 2.16;
  A := 0.242*log(1/F_rel_cb) + 1.048;
  B := 3.02*(1/F_rel_cb)^2 - 2.278*(1/F_rel_cb) + 1.582;
  if alpha_deg < 60 then
    zeta_cb := 1 + w_rel_bc^2 - 2*F_rel_cs*(1 - Q_rel_bc)^2 - k*F_rel_cb*Q_rel_bc^2 + K_b[1];
    zeta_cs := 1 + F_rel_cs^2*(1 - Q_rel_bc)^2 - 2*F_rel_cs*(1 - Q_rel_bc)^2 - k*F_rel_cb*Q_rel_bc^2 + K_s[1];
  elseif alpha_deg >= 89.5 then
    zeta_cb := 1 + w_rel_bc^2 - 2*F_rel_cs*(1 - Q_rel_bc)^2 - k*F_rel_cb*Q_rel_bc^2 + K_b[1];
    zeta_cs := A*(1 + F_rel_cs^2*(1 - Q_rel_bc)^2 - B*2*F_rel_cs*(1 - Q_rel_bc)^2 - F_rel_cb*Q_rel_bc^2) + K_s[1];
  else
    (zeta_cb, zeta_cs) := interpolate(alpha_deg, w_rel_bc, Q_rel_bc, F_rel_cb, F_rel_cs, K_b, K_s, A, B);
  end if;
  dp_b := zeta_cb*rho_c/2*w_c^2;
  dp_s := zeta_cs*rho_c/2*w_c^2;
  annotation (
    Documentation(info="<html><head></head><body><div><b>The implementation of the function is based on \"Handbook of Hydraulic Resistance\" in its first translated Version from 1960!</b></div><div><b>The book has been republished in several updated versions since then!</b></div>Function calculating the pressure loss of a Y-shaped junction of type II (<b>Fig. 1</b>) as f(F_c, F_b, w_c, w_b, w_s, alpha, rho, k, K_b, K_s)<div><br></div>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 1:</strong>Y-shaped junction of geometry type II</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType2_DP/JunctionY_sketch_type2.png\" alt=\"Y-shaped junction of geometry type II\" width=\"350\" height=\"200\">
      </td>
      </tr>
      </tbody>
</table><br>
<pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: -webkit-standard; white-space: normal;\">where:</span><!--EndFragment--></pre>


<div><div><ul><li>F_c:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>cross sectional area of common channel [m^2]</li><li>F_b<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>cross sectional area of branch [m^2]</li><li>w_c:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>velocity at common channel [m/s]</li><li>w_b:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>velocity at branching channel [m/s]</li><li>w_s:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>velocity at straight channel [m/s]</li><li>alpha:<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>branching angle [rad]</li><li>rho:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>density [kg/m^3]</li><li>k:<span class=\"Apple-tab-span\" style=\"white-space: pre;\">                </span>coefficient of branching angle dependency [-]</li><li>K_b:<span class=\"Apple-tab-span\" style=\"white-space: pre;\">                </span>free term correction of area ratio dependency at branch [-]</li><li>K_s:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>free term correction of area ratio dependency at straight channel [-]</li></ul><div>Calculation according to Idelchik (1960)</div><div>The pressure loss is calculated as</div></div><div><ul><li>in branch:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                                </span>dp_b = rho/2 * zeta_cb * w_c^2</li><li>in straight channel:<span class=\"Apple-tab-span\" style=\"white-space: pre;\">                </span>dp_s = rho/2 * zeta_cs * w_c^2</li></ul></div><div>As you can see above both pressure loss calculation are with respect to the velocity at the common branch.</div><div>The <b>pressure loss coefficient of the branch zeta_cb</b> is calculated as:</div><div><br></div><div><b>case 1: alpha &lt;= 60°</b></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>zeta_cb = 1 + w_relbc^2 - 2*F_relcs*(1 - Q_relbc)^2 - k * F_relcb*(Q_relbc)^2 + K_b</div><div><ul><li>w_relbc = w_b/w_c:<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>velocity ratio</li><li>Q_relbc = Q_b/Q_c:<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>volume flow ratio</li><li>F_relcb = F_c/F_b:<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>area ratio</li><li>F_relcs = F_c/F_s:<span class=\"Apple-tab-span\" style=\"white-space: pre;\">        </span>area ratio</li></ul><div>with coefficient k taking the branching angle depedency into account.</div><div><br></div><div>k is approximated using a 3rd order polynomial</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>k(alpha°) = -0.0001766 * alpha^2 - 0.007536 * alpha + 2.1043</div><div><br></div><div>and with free term correction K_b as f(alpha, F_relbc).</div><div><br></div><div>Since there are few data points a defining a approximation formula is not useful, table interpolation is used instead.</div><div>As shown K_b is a function of 2 variables a 2-dimensional tables is used. Furthermore the table is using vector in- and output as this data is requierd for interpolation at region 60&lt;alpha&lt;90.</div><div>The interpolation is done by linear segments since \"CombiTable2Dv\" does not perform cubic spline interpolation.</div><div><pre style=\"font-size: 12px;\"><pre>F_relbc<span class=\"Apple-tab-span\">        </span>| 0.06 | 0.1 | 0.2 | 0.33 | 0.5 |</pre></pre><pre style=\"font-size: 12px;\">--------+------+-----+-----+------+-----+</pre><pre style=\"font-size: 12px;\">alpha<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>|</pre><pre style=\"font-size: 12px;\">60° <span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>|  0  |  0  |  0  |  0   | 0.1  |</pre><pre style=\"font-size: 12px;\"><pre>90° <span class=\"Apple-tab-span\">        </span>|  0  |  0  | 0.1 |  0.2 | 0.25 |</pre></pre></div><div><br></div><div><b>case 2: alpha = 90°</b></div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>zeta_cb = &nbsp;1 + w_relbc^2 - 2*F_relcs*(1 - Q_relbc)^2 + K_b</div><div><br></div><div><b>case 3: 60° &lt; alpha &lt;90°</b></div><div><pre style=\"font-size: 12px;\"><span style=\"font-family: -webkit-standard; font-size: medium; white-space: normal;\">Since there is no aproximation formula nor data available in this case zeta_cb is interpolated linear between the function of case 1 and 2.</span></pre><pre style=\"font-size: 12px;\"><span style=\"font-family: -webkit-standard; font-size: medium; white-space: normal;\"><br></span></pre><p>The&nbsp;<b>pressure loss coefficient of the straight channel zeta_cs</b>&nbsp;is calculated as:</p></div></div><div><b>case 1: alpha &lt;= 60°</b></div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>zeta_cs = 1 + F_relcs^2 * (1-Q_relbc)^2 - k * F_relcb * Q_relbc^2 + K_s</div><div><br></div><div>where k is the same coefficient discribed above and K_s the free term correction of the area ratio. As befor K_s is implemented using table interpolation of 2-dimensional table and vector in- and output.</div><div><pre style=\"font-size: 12px;\"><pre>F_relbc<span class=\"Apple-tab-span\">        </span>| 0.06 |  0.1 |  0.2 |  0.33 |  0.5  |</pre></pre><pre style=\"font-size: 12px;\">--------+------+------+------+-------+-------+</pre><pre style=\"font-size: 12px;\">alpha<span class=\"Apple-tab-span\">        </span>|</pre><pre style=\"font-size: 12px;\">15° <span class=\"Apple-tab-span\">        </span>|   0  |   0  |   0  |  0.14 |  0.4  |</pre><pre style=\"font-size: 12px;\"><pre>30° <span class=\"Apple-tab-span\">        </span>|   0  |   0  |   0  |  0.14 |  0.4  |</pre><pre>45° <span class=\"Apple-tab-span\">        </span>|   0  | 0.05 | 0.14 |  0.14 |  0.3  |</pre><pre>60° <span class=\"Apple-tab-span\">        </span>|   0  |   0  |   0  |  0.1  |  0.25 |</pre><pre>90° <span class=\"Apple-tab-span\">        </span>| 0.37 | 0.46 | 0.46 |  0.57 |  0.81 |</pre></pre></div><div><br></div><div><b>case 2: alpha = 90°</b></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span></div><div>Since Idel'chik does not provied a approximation formula for alpha = 90° an approximation of the given date has to be definied.&nbsp;<br></div><div>Because there is only a small amount of data available, the approximation shuold be understood as an estimate, especially for small area ratios.</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>zeta_cs = A * [1 + &nbsp;F_relcs^2 * (1 - Q_relbc)^2 - 2 * B * F_relcs * (1 - Q_relbc)^2 - F_rel_cb * Q_relbc^2] + K_s</div><div><br></div><div>with the coefficients A and B approximated with thee formulas</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>A = 0.242 * log(F_relbc) + 1.048</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>B = 3.02 * (Frelbc)^2 - 2.278 * F_relbc + 1.582</div><div><br></div><div><br></div><div><pre style=\"font-size: 12px;\"><span style=\"font-family: -webkit-standard; font-size: medium; white-space: normal;\"><b>case 3: 60° &lt; alpha &lt;90°</b></span></pre></div><div>As before linear interpolation between the function at alpha &lt;= 60 and alpha = 90 is used to determine the pressure loss in case 3.</div><div><br></div><div><br></div>
<div>The following figure &nbsp;<b>Fig.2&nbsp;</b>&nbsp;pressure loss coefficients of the branching channel and straight channel&nbsp;at alpha = 15°&nbsp;are shown.</div>
<div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 2:</strong> Pressure loss coefficient of branch zeta_cb and zeta_cs vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType2_DP/zeta_15.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div><br></div><div>      
</div>
<div>The following figure &nbsp;<b>Fig.3&nbsp;</b>&nbsp;pressure loss coefficients of the branching channel and straight channel&nbsp;at alpha = 30°&nbsp;are shown.</div>
<div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 3:</strong> Pressure loss coefficient of branch zeta_cb and zeta_cs vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType2_DP/zeta_30.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div><br></div><div>      
</div>
<div>The following figure &nbsp;<b>Fig.4&nbsp;</b>&nbsp;pressure loss coefficients of the branching channel and straight channell&nbsp;at alpha = 45°&nbsp;are shown.</div>
<div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 4:</strong> Pressure loss coefficient of branch zeta_cb and zeta_cs vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType2_DP/zeta_45.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div><br></div><div>      
</div>
<div>The following figure &nbsp;<b>Fig.5&nbsp;</b>&nbsp;pressure loss coefficients of the branching channel and straight channell&nbsp;at alpha = 60°&nbsp;are shown.</div>
<div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 5:</strong> Pressure loss coefficient of branch zeta_cb and zeta_cs vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType2_DP/zeta_60.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div><br></div><div>      
</div>
<div>The following figure &nbsp;<b>Fig.6&nbsp;</b>&nbsp;pressure loss coefficients of the branching channel and straight channell&nbsp;at alpha = 90°&nbsp;are shown.</div>
<div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 6:</strong> Pressure loss coefficient of branch zeta_cb and zeta_cs vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType2_DP/zeta_Y_type2_90.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div><br></div><div>      
</div>

      
<div>The following figures&nbsp;pressure loss coefficients of the branching channel &nbsp;<b>Fig.7 </b>and straight channel&nbsp;<b>Fig.8</b>&nbsp;at alpha = 75°&nbsp;are shown.</div>
<div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 7:</strong>Pressure loss coefficient of branch zeta_cb vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType2_DP/zeta_cb2_75.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div><br></div><div>      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 8:</strong>Pressure loss coefficient of straight channel zeta_cs vs. velocity ratio w_s/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType2_DP/zeta_cs2_75.png\" alt=\"zeta_cs vs.w_relsc\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table><div><br></div>      
          
      <em style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><div><em style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><br><em>[P. Jordan; HTWG Konstanz; 01/24]</em><p></p><p>
  <img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"175\" height=\"50\">
  </p></div></div></body></html>"));
end dp_JunctionWyeType2_DP;
