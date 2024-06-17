within ThermofluidStream.Processes.Pipes.Internal.BaseClasses.PressureLoss.Junction;
function dp_JunctionWyeType1_DP
  extends Modelica.Icons.Function;

  import SMOOTH = ThermofluidStream.Processes.Pipes.Internal.Utilities.Stepsmoother;
  // Input variables
  input SI.Area F_c "Cross-sectional area of (common) outlet";
  input SI.Area F_b "Cross-sectional area of branching inlet";
  input SI.Velocity w_c "Velocity at (common) outlet";
  input SI.Velocity w_b "Velocity at branching inlet";
  input SI.Velocity w_s "Velocity at straight inlet";
  input SI.Angle alpha_deg "Branching angle in degree";
  input Real A "Correction factor at alpha = 90°";
  input SI.Density rho_c "Density of fluid at (common) outlet";
  input SI.Velocity eps "To avoid division by zero";
  // Output variables
  output SI.Pressure dp_b "Pressure loss at branching inlet";
  output SI.Pressure dp_s "Pressure loss at straight inlet";
  output Types.PressureLossCoefficient zeta_cb "Pressure loss coefficient of branching inlet w.r.t. outlet velocity";
  output Types.PressureLossCoefficient zeta_cs "Pressure loss coefficient of straight inlet w.r.t. outlet velocity";
  //output Real w_rel_bc = w_b/w_c "Velocity ratio of branch and common channel";
  //output Real w_rel_sc = w_s/w_c "Velocity ratio of main passage and common channel";
  //output Fluid_HTWG.Types.PressureLossCoefficient zeta_cb_prime "Auxilliary pressure loss coefficient of branch expressed through the velocity in the common channel";
protected
  Real w_rel_bc = if abs(w_c) > eps then w_b/w_c else 1 "Velocity ratio branch/outlet";
  Real w_rel_sc = if abs(w_c) > eps then w_s/w_c else 1 "Velocity ratio straight/outlet";
  Real Q_rel_bc = w_rel_bc/F_rel_cb "Volume flow rate ratio branch/outlet";
  Real k "Coefficient characterizing the branching angle dependency";
  Real F_rel_cb = F_c/F_b "Area ratio outlet/branch";
  function interpolate =
      Internal.lin_interpol_Y1_60_90;
algorithm
  k := -0.0001778*alpha_deg^2 - 0.008667*alpha_deg + 2.16;
  if alpha_deg <= 60 then
    zeta_cb := 1 + w_rel_bc^2 - 2*(1 - Q_rel_bc)^2 - k*F_rel_cb*Q_rel_bc^2;
    zeta_cs := 1 - (1 - Q_rel_bc)^2 - k*F_rel_cb*Q_rel_bc^2;
  elseif alpha_deg > 89.5 then
    zeta_cb := A*(1 + w_rel_bc^2 - 2*(1 - Q_rel_bc)^2);
    zeta_cs := 1.55*Q_rel_bc - Q_rel_bc^2;
  else
    (zeta_cb, zeta_cs) := interpolate(alpha_deg, w_rel_bc, Q_rel_bc, F_rel_cb, A);
  end if;
  dp_b := zeta_cb*rho_c/2*w_c^2;
  dp_s := zeta_cs*rho_c/2*w_c^2;
  annotation (
    Documentation(info="<html><head></head><body><div><b>The implementation of the function is based on \"Handbook of Hydraulic Resistance\" in its first translated Version from 1960!</b></div><div><b>The book has been republished in several updated versions since then!</b></div>Function calculating the pressure loss of a Y-shaped junction of type I (<b>Fig. 1</b>) as f(F_c, F_b, w_c, w_b, w_s, alpha, rho, k, A)<div><br></div>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 1:</strong>Y-shaped junction of geometry type I</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType1_DP/JunctionY_sketch.png\" alt=\"Y-shaped junction of geometry type I\" width=\"350\" height=\"200\">
      </td>
      </tr>
      </tbody>
</table><br>
<pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: -webkit-standard; white-space: normal;\">where:</span><!--EndFragment--></pre>


<div><div><ul><li>F_c:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>cross sectional area of common channel [m^2]</li><li>F_b<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>cross sectional area of branch [m^2]</li><li>w_c:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>velocity at common channel [m/s]</li><li>w_b:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>velocity at branching channel [m/s]</li><li>w_s:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>velocity at straight channel [m/s]</li><li>alpha:<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>branching angle [rad]</li><li>rho:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>density [kg/m^3]</li><li>k:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>coefficient of branching angle dependency [-]</li><li>A:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>coefficient of area ratio dependency [-]</li></ul><div>Calculation according to Idelchik (1960)</div><div>The pressure loss is calculated as</div></div><div><ul><li>in branch:<span class=\"Apple-tab-span\" style=\"white-space:pre\">				</span>dp_b = rho/2 * zeta_cb * w_c^2</li><li>in straight channel:<span class=\"Apple-tab-span\" style=\"white-space: pre;\">		</span>dp_s = rho/2 * zeta_cs * w_c^2</li></ul></div><div>As you can see above both pressure loss calculation are with respect to the velocity at the common branch.</div><div>The <b>pressure loss coefficient of the branch zeta_cb</b> is calculated as:</div><div><br></div><div><b>case 1: alpha &lt;= 60°</b></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>zeta_cb = 1 + w_relbc^2 - 2*(1-*Q_relbc)^2 * k * F_relcb*(Q_relbc)^2</div><div><ul><li>w_relbc = w_b/w_c:<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>velocity ratio</li><li>Q_relbc = Q_b/Q_c:<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>volume flow ratio</li><li>F_relbc = F_b/F_c:<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>area ratio</li></ul><div>with coefficient k taking the branching angle depedency into account.</div><div><br></div><div>k is approximated using a 3rd order polynomial</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>k(alpha°) = -0.0001766 * alpha^2 - 0.007536 * alpha + 2.1043</div><div><br></div><div><b>case 2: alpha = 90°</b></div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>zeta_cb = A * [A + w_relbc^2 - 2*(1 - Q_relbc)^2] = A * zeta'_cb</div><div><br></div><div>with coefficient A scaling zeta'_cb with respect to the given area ratio F_relbc. Since no rational approimation of A = f(F_relbc) has been found,</div><div>the coefficient is implemented as a table with cubic spline interpolation between the control points.</div><div><pre style=\"font-size: 12px;\">F_relbc<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>| 0-0.2 | 0.3-0.4 | 0.6 | 0.8  |  1  |</pre><pre style=\"font-size: 12px;\">--------+-------+---------+-----+------+-----+</pre><pre style=\"font-size: 12px;\">A       |   1   |   0.75  | 0.7 | 0.65 | 0.6 |</pre><pre style=\"font-size: 12px;\"><span style=\"font-family: -webkit-standard; font-size: medium; white-space: normal;\"><b>case 3: 60° &lt; alpha &lt;90°</b></span></pre><pre style=\"font-size: 12px;\"><span style=\"font-family: -webkit-standard; font-size: medium; white-space: normal;\">Since there is no aproximation formula nor data available in this case zeta_cb is interpolated linear between the function of case 1 and 2.</span></pre></div><div>The&nbsp;<b>pressure loss coefficient of the straight channel zeta_cs</b>&nbsp;is calculated as:</div></div><div><br></div><div><b>case 1: alpha &lt;= 60°</b></div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>zeta_cs = 1 - (1 - Q_relbc)^2 - k * F_relbc * Q_relbc^2</div><div><br></div><div>where k is the same coefficient discribed above.</div><div><br></div><div><b>case 2: alpha = 90°</b></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>zeta_cs = 1.55 * Q_relbc - Q_relbc^2</div><div><br></div><div><pre style=\"font-size: 12px;\"><span style=\"font-family: -webkit-standard; font-size: medium; white-space: normal;\"><b>case 3: 60° &lt; alpha &lt;90°</b></span></pre></div><div>As before linear interpolation between the function at alpha &lt;= 60 and alpha = 90 is used to determine the pressure loss in case 3.</div><div><br></div><div><br></div>
<div>The following figures&nbsp;pressure loss coefficients of the branching channel &nbsp;<b>Fig.2 </b>and straight channel&nbsp;<b>Fig.3</b>&nbsp;at alpha = 30°&nbsp;are shown.</div>
<div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 2:</strong>Pressure loss coefficient of branch zeta_cb vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType1_DP/zeta_cb1_30.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div><br></div><div>      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 3:</strong>Pressure loss coefficient of straight channel zeta_cs vs. velocity ratio w_s/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType1_DP/zeta_cs1_30.png\" alt=\"zeta_cs vs.w_relsc\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table><div><br></div>
<div>The following figures&nbsp;pressure loss coefficients of the branching channel &nbsp;<b>Fig.4 </b>and straight channel&nbsp;<b>Fig.5</b>&nbsp;at alpha = 45°&nbsp;are shown.</div>
<div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 4:</strong>Pressure loss coefficient of branch zeta_cb vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType1_DP/zeta_cb1_45.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div><br></div><div>      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 5:</strong>Pressure loss coefficient of straight channel zeta_cs vs. velocity ratio w_s/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType1_DP/zeta_cs1_45.png\" alt=\"zeta_cs vs.w_relsc\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table><div><br></div>
      
<div>The following figures&nbsp;pressure loss coefficients of the branching channel &nbsp;<b>Fig.6 </b>and straight channel&nbsp;<b>Fig.7</b>&nbsp;at alpha = 60°&nbsp;are shown.</div>
<div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 6:</strong>Pressure loss coefficient of branch zeta_cb vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType1_DP/zeta_cb1_60.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div><br></div><div>      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 7:</strong>Pressure loss coefficient of straight channel zeta_cs vs. velocity ratio w_s/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType1_DP/zeta_cs1_60.png\" alt=\"zeta_cs vs.w_relsc\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table><div><br></div>
      
<div>The following figures&nbsp;pressure loss coefficients of the branching channel &nbsp;<b>Fig.8 </b>and straight channel&nbsp;<b>Fig.9</b>&nbsp;at alpha = 90°&nbsp;are shown.</div>
<div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 8:</strong>Pressure loss coefficient of branch zeta_cb vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType1_DP/zeta_cb1_90.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div><br></div><div>      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 9:</strong>Pressure loss coefficient of straight channel zeta_cs vs. velocity ratio w_s/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType1_DP/zeta_cs1_90.png\" alt=\"zeta_cs vs.w_relsc\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table><div><br></div>
      
<div>The following figures&nbsp;pressure loss coefficients of the branching channel &nbsp;<b>Fig.10 </b>and straight channel&nbsp;<b>Fig.11</b>&nbsp;at alpha = 75°&nbsp;are shown.</div>
<div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 10:</strong>Pressure loss coefficient of branch zeta_cb vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType1_DP/zeta_cb1_75.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div><br></div><div>      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 11:</strong>Pressure loss coefficient of straight channel zeta_cs vs. velocity ratio w_s/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Junction/dp_JunctionWyeType1_DP/zeta_cs1_75.png\" alt=\"zeta_cs vs.w_relsc\" width=\"1000\" height=\"492\">
      </td>
      </tr>
      </tbody></table><div><br></div>
      
            
      
      
      
      
      <em style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><div><em style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><br><em>[P. Jordan; HTWG Konstanz; 01/24]</em><p></p><p>
  <img src=\"modelica://Fluid_HTWG/Resources/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"175\" height=\"50\">
  </p></div></div></body></html>"));
end dp_JunctionWyeType1_DP;
