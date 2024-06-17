within ThermofluidStream.Processes.Pipes.Internal.BaseClasses.PressureLoss.Splitter;
function dp_SplitterWyeType2_DP "Pressure loss of wye splitter of type A_s + A_b = A_c | calculate pressure loss in each channel"
  extends Modelica.Icons.Function;

  // Input variables
  input SI.Velocity w_c "Splitter inlet velocity";
  input SI.Velocity w_b "Branching pipe velocity";
  input SI.Velocity w_s "Straight pipe velocity";
  input SI.Angle alpha "Branching angle";
  input SI.Density rho "Medium density";
  input Real k "Scaling factor for family of curves at alpha = 90°";
  input Real K_b_prime "Correction factor for branching angle alpha";
  input SI.Velocity eps "To avoid division by zero";
  // Output variables
  output SI.Pressure dp_b "Pressure loss of branching pipe";
  output SI.Pressure dp_s "Pressure loss of straight pipe";
  output Types.PressureLossCoefficient zeta_cb "Pressure loss coefficient of branching pipe w.r.t. inlet velocity";
  output Types.PressureLossCoefficient zeta_cs "Pressure loss coefficient of straight pipe w.r.t. inlet velocity";
protected
  Real w_rel_bc = if abs(w_c) >= eps then w_b/w_c else 0 "Velocity ratio branch/inlet";
  Real w_rel_sc = if abs(w_c) >= eps then w_s/w_c else 0 "Velocity ratio main/inlet";
algorithm
  zeta_cb := 1 + (w_rel_bc)^2 - 2*w_rel_bc*cos(alpha) - K_b_prime*w_rel_bc^2;
  zeta_cs := max(0, k*0.5345*w_rel_sc^4 - k*1.124*w_rel_sc^3 + k*1.73*w_rel_sc^2 - 2.146*w_rel_sc + 1.0005);
  dp_b := zeta_cb*rho/2*w_c^2;
  dp_s := zeta_cs*rho/2*w_c^2;

  annotation (
    Documentation(info="<html><head></head><body><div><b>The implementation of the function is based on \"Handbook of Hydraulic Resistance\" in its first translated Version from 1960!</b></div><div><b>The book has been republished in several updated versions since then!</b></div><div><b><br></b></div><div><b><br></b></div>Function calculating the pressure loss of a Y-shaped splitter of type II (<b>Fig. 1</b>) as f(w_c,w_b,w_s, alpha, rho, k, K'_b)<div><br></div>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 1:</strong>Y-shaped splitter of geometry type II</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Splitter/dp_SplitterWyeType2_DP/SplitterY_sketch_type2.png\" alt=\"Y-shaped splitter of geometry type II\" width=\"350\" height=\"200\">
      </td>
      </tr>
      </tbody>
</table><br>
<pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: -webkit-standard; white-space: normal;\">where:</span><!--EndFragment--></pre>


<div><div><ul><li>w_c:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>velocity at common channel [m/s]</li><li>w_b:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>velocity at branching channel [m/s]</li><li>w_s:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>velocity at straight channel [m/s]</li><li>alpha:<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>branching angle [rad]</li><li>rho:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>density [kg/m^3]</li><li>k:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>scaling factor for area ratio dependency at alpha = 90° [-]</li><li>K'_b:<span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>correction factor for branching angle dependency [-]</li></ul><div>Calculation according to Idelchik (1960)</div><div>The pressure loss is calculated as</div></div><div><ul><li>in branch:<span class=\"Apple-tab-span\" style=\"white-space:pre\">				</span>dp_b = rho/2 * zeta_cb * w_c^2</li><li>in straight channel:<span class=\"Apple-tab-span\" style=\"white-space: pre;\">		</span>dp_s = rho/2 * zeta_cs * w_c^2</li></ul></div><div>As you can see above both pressure loss calculation are with respect to the velocity at the common branch.</div><div>The <b>pressure loss coefficient of the branch zeta_cb</b> is calculated as:</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>zeta_cb &nbsp;=1 + (w_relbc)^2 - 2*w_relbc *cos(alpha) - K'_b * (w_relbc)^2</div><div><br></div><div><div>Idel'chik provides table data for the coefficient K'_b. Since no sufficiently precise approximation equation can be defined for this factor, a table is also used for implementation.&nbsp;</div><div>A cubic spline is used to interpolate between the control points. To control the limit behavior at table boundaries control points at alpha = 0° and alpha = 105° are added</div><div><pre style=\"font-size: 12px;\">alpha°<span class=\"Apple-tab-span\">	</span>|&nbsp;  0  |&nbsp; 15  |  30  |  45  |  60  |  90 | 105 |</pre><pre style=\"font-size: 12px;\">--------+------+------+------+------+------+-----+-----+</pre><pre style=\"font-size: 12px;\">K'_b    | 0.03 | 0.04 | 0.16 | 0.36 | 0.64 |  1  |  1  |</pre></div><div><b>Notice: </b>In more recent editions Idelchik gives the same approximation formula, but the diagram and data sets show a limit value against which the friction coefficients of all angles converge.</div><div>Adjustments using a C-spline have not yet been made.&nbsp;</div><div><br></div><div>For calculation of the <b>pressure loss coefficient of th straight channel zeta_cs</b> there is no aproximation formula by Idel'chik.</div></div><div>Therefore an own aproximation on basis of the data from Idel'chik has to be found.</div><div>The given table data suggest a basis function, which is transformed into a set of curves by the scaling factor k taking the area ratio dependency at alpha = 90° into account.<br></div><div><br></div><div>A 4th order polynomial is selected as the basis function and fitted to the data set.</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>zeta_cs_base = 0.5345*w_relsc^4 - 1.124+w_relsc^3 + 1.73*w_relsc^2 - 2.146*w_relsc + 1.005</div><div><br></div><div>In order to obtain a set of curves. the basis function is expanded by the scaling factor k.</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>zeta_cs = <b>k</b>*0.5345*w_relsc^4 - <b>k</b>*1.124+w_relsc^3 + <b>k</b>*1.73*w_relsc^2 - 2.146*w_relsc + 1.005</div><div><br></div><div>As befor since no rational approximation has been found the scaling factor is implemented using a look-up table.</div><div><pre style=\"font-size: 12px;\">F_relsc<span class=\"Apple-tab-span\">	</span>|  0  |  0.3  |  0.4  |  0.5  |  0.6  |  0.8  |  0.9  |  1  |</pre><pre style=\"font-size: 12px;\">--------+-----+-------+-------+-------+-------+-------+-------+-----+</pre><pre style=\"font-size: 12px;\">k       |  1  |   1   |   1   |  1.16 | 1.075 | 1.05  |   1   |  1  |</pre></div><div><br></div><div>The following figure <b>Fig.2</b>, &nbsp;pressure loss coefficients of the branching channel are shown.</div><div><br>&nbsp;
      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 2:</strong>Pressure loss coefficient of branch zeta_cb vs. velocity ratio w_b/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Splitter/dp_SplitterWyeType2_DP/zeta_cb2.png\" alt=\"zeta_cb vs. w_relcb\" width=\"1000\" height=\"694\">
      </td>
      </tr>
      </tbody></table></div><div><br></div><div>The following <b>Fig.3</b>&nbsp;shows the pressure loss coefficient of the straight channel.</div><div><br></div><div>      
      <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
      <caption align=\"bottom\"><strong>Fig. 3:</strong>Pressure loss coefficient of straight channel zeta_cs vs. velocity ratio w_s/w_c</caption>
      <tbody><tr>
      <td>
        <img src=\"modelica://Fluid_HTWG/Resources/Images/Fluid/Pipes/BaseClasses/PressureLoss/Splitter/dp_SplitterWyeType2_DP/zeta_cs2.png\" alt=\"zeta_cs vs.w_relsc\" width=\"1000\" height=\"624\">
      </td>
      </tr>
      </tbody></table><div><br></div><em style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><div><em>[P. Jordan; HTWG Konstanz; 01/24]</em><p></p><p>
  <img src=\"modelica://Fluid_HTWG/Resources/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"175\" height=\"50\">
  </p></div></div></body></html>"));
end dp_SplitterWyeType2_DP;
