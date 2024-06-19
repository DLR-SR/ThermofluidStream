within ThermofluidStream.Processes.Pipes.BaseClasses.PressureLoss.Junction;
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
  output ThermofluidStream.Processes.Pipes.Internal.Types.PressureLossCoefficient zeta_cb
    "Pressure loss coefficient of branching inlet w.r.t. outlet velocity";
  output ThermofluidStream.Processes.Pipes.Internal.Types.PressureLossCoefficient zeta_cs
    "Pressure loss coefficient of straight inlet w.r.t. outlet velocity";
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
    Documentation(info="<html>
<p>
<strong>The implementation of the function is based on \"Handbook of Hydraulic Resistance\" in its first translated Version from 1960! The book has been republished in several updated versions since then!</strong>
</p>

<p>
Function calculating the pressure loss of a Y-shaped junction of type I (<strong>Fig. 1</strong>, currently not yet available) as f(F_c, F_b, w_c, w_b, w_s, alpha, rho, k, A), where:
</p>

<ul>
<li>F_c: cross sectional area of common channel [m^2]</li>
<li>F_b: cross sectional area of branch [m^2]</li>
<li>w_c: velocity at common channel [m/s]</li>
<li>w_b: velocity at branching channel [m/s]</li>
<li>w_s: velocity at straight channel [m/s]</li>
<li>alpha: branching angle [rad]</li>
<li>rho: density [kg/m^3]</li>
<li>k: coefficient of branching angle dependency [-]</li>
<li>A: coefficient of area ratio dependency [-]</li>
</ul>

<p>
Calculation according to Idelchik (1960). The pressure loss is calculated as:
</p>

<ul>
<li>in branch: <code>dp_b = rho/2 * zeta_cb * w_c^2</code></li>
<li>in straight channel: <code>dp_s = rho/2 * zeta_cs * w_c^2</code></li>
</ul>

<p>
As you can see above both pressure loss calculation are with respect to the velocity at the common branch. The <strong>pressure loss coefficient of the branch zeta_cb</strong> is 
calculated for case 1 (alpha &lt;= 60°) as: <code>zeta_cb = 1 + w_relbc^2 - 2*(1-*Q_relbc)^2 * k * F_relcb*(Q_relbc)^2</code>
</p>

<ul>
<li>w_relbc = w_b/w_c: velocity ratio</li>
<li>Q_relbc = Q_b/Q_c: volume flow ratio</li>
<li>F_relbc = F_b/F_c area ratio</li>
</ul>

<p>
With coefficient k taking the branching angle depedency into account. k is approximated using a 3rd order polynomial:
</p>

<p>
<code>k(alpha°) = -0.0001766 * alpha^2 - 0.007536 * alpha + 2.1043</code>
</p>

<p>
For case 2 (alpha = 90°): <code>zeta_cb = A * [A + w_relbc^2 - 2*(1 - Q_relbc)^2] = A * zeta'_cb</code>, with coefficient A scaling zeta'_cb with respect to the given area ratio F_relbc. 
Since no rational approimation of A = f(F_relbc) has been found, the coefficient is implemented as a table with cubic spline interpolation between the control points.
</p>

<table>
  <tr>
    <td>F_relbc</td>
    <td>0-0.2</td>
    <td>0.3-0.4</td>
    <td>0.6</td>
    <td>0.8</td>
    <td>1</td>
  </tr>
  <tr>
    <td>A</td>
    <td>1</td>
    <td>0.75</td>
    <td>0.7</td>
    <td>0.65</td>
    <td>0.6</td>
  </tr>
</table>

<p>
For case 3 (60° &lt; alpha &lt;90°): Since there is no aproximation formula nor data available in this case zeta_cb is interpolated linear between the function of case 1 and 2.
The <strong>pressure loss coefficient of the straight channel zeta_cs</strong> is calculated as:
</p>

<ul>
<li>case 1 (alpha &lt;= 60°): <code>zeta_cs = 1 - (1 - Q_relbc)^2 - k * F_relbc * Q_relbc^2</code>, where k is the same coefficient discribed above. </li>
<li>case 2 (alpha = 90°): <code>zeta_cs = 1.55 * Q_relbc - Q_relbc^2</code></li>
<li>case 3 (60° &lt; alpha &lt;90°): As before linear interpolation between the function at alpha &lt;= 60 and alpha = 90 is used to determine the pressure loss in case 3.</li>
</ul>
<p>
The following figures, pressure loss coefficients of the branching channel <strong>Fig.2</strong> and straight channel <strong>Fig.3</strong> at alpha = 30° are shown. (Currently not yet available)
</p>

<p>
The following figures pressure loss coefficients of the branching channel <strong>Fig.4</strong> and straight channel <strong>Fig.5</strong> at alpha = 45° are shown. (Currently not yet available)
</p>

<p>
The following figures pressure loss coefficients of the branching channel <strong>Fig.6</strong> and straight channel <strong>Fig.7</strong> at alpha = 60°are shown. (Currently not yet available) 
</p>

<p>
The following figures pressure loss coefficients of the branching channel <strong>Fig.8</strong> and straight channel <strong>Fig.9</strong> at alpha = 90° are shown. (Currently not yet available)
</p>

<p>
The following figures pressure loss coefficients of the branching channel <strong>Fig.10</strong> and straight channel <strong>Fig.11</strong> at alpha = 75° are shown. (Currently not yet available)
</p>

<p>
<em>[P. Jordan; HTWG Konstanz; 01/24]</em>
</p>

<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"350\" height=\"100\">
</p>

</html>"));
end dp_JunctionWyeType1_DP;
