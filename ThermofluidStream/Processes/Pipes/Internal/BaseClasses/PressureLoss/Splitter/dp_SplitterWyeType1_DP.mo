within ThermofluidStream.Processes.Pipes.Internal.BaseClasses.PressureLoss.Splitter;
function dp_SplitterWyeType1_DP "Pressure loss of wye splitter of type A_s + A_b > A_c and A_s = A_c | calculate pressure loss in each channel"
  extends Modelica.Icons.Function;

  import SMOOTH = ThermofluidStream.Processes.Pipes.Internal.Utilities.Stepsmoother;
  // Input variables
  input SI.Velocity w_c "Velocity of common inlet";
  input SI.Velocity w_b "Velocity of branching outlet";
  input SI.Velocity w_s "Velocity of straight outlet";
  input SI.Angle alpha "Branching angle";
  input SI.Density rho "Medium density";
  input SI.Velocity eps "To avoid division by zero";
  // Output variables
  output SI.Pressure dp_b "Pressure loss of branching outlet";
  output SI.Pressure dp_s "Pressure loss of straight outlet";
  output Types.PressureLossCoefficient zeta_cb
    "Pressure loss coefficient of branching pipe w.r.t. common inlet velocity";
  output Types.PressureLossCoefficient zeta_cs
    "Pressure loss coefficient of straight pipe w.r.t. common inlet velocity";
  //output Real w_rel_bc = w_b/w_c "Velocity ratio branch/inlet";
  //output Real w_rel_sc = w_s/w_c "Velocity ratio straight/inlet";
  //output Fluid_HTWG.Types.PressureLossCoefficient zeta_cb_prime "auxilliary pressure loss coefficient of branch expressed through the velocity in the common channel";
protected
  Real A_prime "Coefficient characterizing the velocity ratio";

  Real w_rel_bc = if abs(w_c) > eps then w_b/w_c else 1 "Velocity ratio branch/inlet";
  Real w_rel_sc = if abs(w_c) > eps then w_s/w_c else 1 "Velocity ratio straight/inlet";

  Types.PressureLossCoefficient zeta_cb_prime "auxilliary pressure loss coefficient of branch w.r.t inlet velocity";
algorithm
  A_prime := 1 - SMOOTH(1.05, 0.8, w_rel_bc)*0.1;
  zeta_cb_prime := 1 + w_rel_bc^2 - 2*w_rel_bc*cos(alpha);
  zeta_cb := A_prime*zeta_cb_prime;
  zeta_cs := 0.4*(1 - w_rel_sc)^2;
  dp_b := zeta_cb*rho/2*w_c^2;
  dp_s := zeta_cs*rho/2*w_c^2;
  annotation (
    Documentation(info="<html><head></head><body><div><b>The implementation of the function is based on \"Handbook of Hydraulic Resistance\" in its first translated Version from 1960!</b></div><div><b>The book has been republished in several updated versions since then!</b></div>Function calculating the pressure loss of a Y-shaped splitter of type I (<b>Fig. 1</b>) as f(w_c,w_b,w_s, alpha, rho)<div><br></div>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 1:</strong>Y-shaped splitter of geometry type I</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Splitter/dp_SplitterWyeType1_DP/SplitterY_sketch.png\" alt=\"Y-shaped splitter of geometry type I\" width=\"350\" height=\"200\">
      </td>
      </tr>
      </tbody>
</table><br>
<pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: -webkit-standard; white-space: normal;\">where:</span><!--EndFragment--></pre>


<div><div><ul><li>w_c:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>velocity at common channel [m/s]</li><li>w_b:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>velocity at branching channel [m/s]</li><li>w_s:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>velocity at straight channel [m/s]</li><li>alpha:<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>branching angle [rad]</li><li>rho:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>density [kg/m^3]</li></ul><div>Calculation according to Idelchik (1960)</div><div>The pressure loss is calculated as</div></div><div><ul><li>in branch:<span class=\"Apple-tab-span\" style=\"white-space:pre\">                                </span>dp_b = rho/2 * zeta_cb * w_c^2</li><li>in straight channel:<span class=\"Apple-tab-span\" style=\"white-space: pre;\">                </span>dp_s = rho/2 * zeta_cs * w_c^2</li></ul></div><div>As you can see above both pressure loss calculation are with respect to the velocity at the common branch.</div><div>The pressure loss coefficient of the branch zeta_cb is calculated as:</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>zeta_cb &nbsp;= A' * zeta'_cb</div><div><ul><li>A':<span class=\"Apple-tab-span\" style=\"white-space:pre\">                </span>coefficient of velocity ratio w_b/w_c</li><li>zeta_cb':<span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>uncorrected pressure loss coefficient</li></ul><div>According to Idel'chik while w_relbc = w_b/w_c &lt;= 0.8 A'= 1 and if w_relbc &gt; 0.8 then A' = 0.8.</div><div>Since the velocity ratio may change during simulations, the discontinuity in A' is circumvented by the stepsmoother function used in region 0.8 &lt; w_relbc &lt; 1.05.</div><div><br></div><div>The uncorrected pressure loss coefficient zeta'_cb is determined by the formula</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>zeta'_cb = 1 + w_relbc^2 -2 *cos(alpha)</div><br><div>The pressure loss coefficient at the straight channel for all brnaching angles is described as:</div></div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">        </span>zeta_cs = 0.4*(1-w_relsc)^2</div><div><br></div><div>The following figure <b>Fig.2</b>, &nbsp;pressure loss coefficients of the branching channel are shown.</div><div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 2:</strong>Pressure loss coefficient of branch zeta_cb vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Splitter/dp_SplitterWyeType1_DP/zeta_cb1.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"775\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div>The following <b>Fig.3</b>&nbsp;shows the pressure loss coefficient of the straight channel.</div><div><br></div><div>      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 3:</strong>Pressure loss coefficient of straight channel zeta_cs vs. velocity ratio w_s/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Splitter/dp_SplitterWyeType1_DP/zeta_cs1.png\" alt=\"zeta_cs vs.w_relsc\" width=\"1000\" height=\"434\">
      </td>
      </tr>
      </tbody></table><div><br></div><em style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><div><em>[P. Jordan; HTWG Konstanz; 01/24]</em><p></p><p>
  <img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"175\" height=\"50\">
  </p></div></div></body></html>"));
end dp_SplitterWyeType1_DP;
