within ThermofluidStream.Processes.Pipes.BaseClasses.PressureLoss.Junction;
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
  output ThermofluidStream.Processes.Pipes.Internal.Types.PressureLossCoefficient zeta_cb
    "Pressure loss coefficient of branching inlet w.r.t. (common) outlet velocity";
  output ThermofluidStream.Processes.Pipes.Internal.Types.PressureLossCoefficient zeta_cs
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
    Documentation(info="<html>
<p>
<strong>The implementation of the function is based on \"Handbook of Hydraulic Resistance\" in its first translated Version from 1960! The book has been republished in several updated versions since then!</strong>
</p>

<p>
Function calculating the pressure loss of a Y-shaped junction of type II (<strong>Fig. 1</strong>, currently not yet available) as f(F_c, F_b, w_c, w_b, w_s, alpha, rho, k, K_b, K_s), where:
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
<li>K_b: free term correction of area ratio dependency at branch [-]</li>
<li>K_s: free term correction of area ratio dependency at straight channel [-]</li>
</ul>

<p>
Calculation according to Idelchik (1960). The pressure loss is calculated as:
</p>

<ul>
<li>in branch: <code>dp_b = rho/2 * zeta_cb * w_c^2</code></li>
<li>in straight channel: <code>dp_s = rho/2 * zeta_cs * w_c^2</code></li>
</ul>

<p>
As you can see above both pressure loss calculation are with respect to the velocity at the common branch. The <strong>pressure loss coefficient of the branch zeta_cb</strong> is calculated as:
</p>

<p>
case 1 (alpha &lt;= 60°): <code>zeta_cb = 1 + w_relbc^2 - 2*F_relcs*(1 - Q_relbc)^2 - k * F_relcb*(Q_relbc)^2 + K_b</code>
</p>

<ul>
<li>w_relbc = w_b/w_c: velocity ratio</li>
<li>Q_relbc = Q_b/Q_c: volume flow ratio</li>
<li>F_relcb = F_c/F_b: area ratio</li>
<li>F_relcs = F_c/F_s: area ratio</li>
</ul>

<p>
with coefficient k taking the branching angle depedency into account. k is approximated using a 3rd order polynomial
</p>

<p>
<code>k(alpha°) = -0.0001766 * alpha^2 - 0.007536 * alpha + 2.1043</code>
</p>

<p>
and with free term correction K_b as f(alpha, F_relbc). Since there are few data points a defining a approximation formula is not useful, table interpolation is used instead.
As shown K_b is a function of 2 variables a 2-dimensional tables is used. Furthermore the table is using vector in- and output as this data is requierd for interpolation at region 60&lt;alpha&lt;90.
The interpolation is done by linear segments since \"CombiTable2Dv\" does not perform cubic spline interpolation.
</p>

<table>
  <tr>
    <td>F_relbc</td>
    <td>0.06</td>
    <td>0.1</td>
    <td>0.2</td>
    <td>0.33</td>
    <td>0.5</td>
  </tr>
  <tr>
    <td>alpha = 60°</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0.1</td>
  </tr>
  <tr>
    <td>alpha=90°</td>
    <td>0</td>
    <td>0</td>
    <td>0.1</td>
    <td>0.2</td>
    <td>0.25</td>
  </tr>
</table>


<p>
For case 2 (alpha = 90°): <code>zeta_cb = 1 + w_relbc^2 - 2*F_relcs*(1 - Q_relbc)^2 + K_b</code>
</p>

<p> 
case 3 (60° &lt; alpha &lt;90°): Since there is no aproximation formula nor data available in this case zeta_cb is interpolated linear between the function of case 1 and 2.
The <strong>pressure loss coefficient of the straight channel zeta_cs</strong> is calculated as:
case 1 (alpha &lt;= 60°): <code>zeta_cs = 1 + F_relcs^2 * (1-Q_relbc)^2 - k * F_relcb * Q_relbc^2 + K_s</code>, where k is the same coefficient discribed above and K_s the free term correction of the area ratio. 
As befor K_s is implemented using table interpolation of 2-dimensional table and vector in- and output.
</p>

<table>
  <tr>
    <td>F_relbc</td>
    <td>0.06</td>
    <td>0.1</td>
    <td>0.2</td>
    <td>0.33</td>
    <td>0.5</td>
  </tr>
  <tr>
    <td>alpha = 15°</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0.14</td>
    <td>0.4</td>
  </tr>
  <tr>
    <td>alpha=30°</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0.14</td>
    <td>0.4</td>
  </tr>
  <tr>
    <td>alpha=45°</td>
    <td>0</td>
    <td>0.05</td>
    <td>0.14</td>
    <td>0.14</td>
    <td>0.3</td>
  </tr>
  <tr>
    <td>alpha=60°</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0.1</td>
    <td>0.25</td>
  </tr>
  <tr>
    <td>alpha=90°</td>
    <td>0.37</td>
    <td>0.46</td>
    <td>0.46</td>
    <td>0.57</td>
    <td>0.81</td>
  </tr>
</table>

<p>
case 2 (alpha = 90°): Since Idel'chik does not provied a approximation formula for alpha = 90° an approximation of the given date has to be definied. 
Because there is only a small amount of data available, the approximation shuold be understood as an estimate, especially for small area ratios:
<code>zeta_cs = A * [1 + F_relcs^2 * (1 - Q_relbc)^2 - 2 * B * F_relcs * (1 - Q_relbc)^2 - F_rel_cb * Q_relbc^2] + K_s</code>
with the coefficients A and B approximated with the formulas:
</p>

<p>
<code>
A = 0.242 * log(F_relbc) + 1.048<br>
B = 3.02 * (Frelbc)^2 - 2.278 * F_relbc + 1.582
</code>
</p>

<p>
case 3 (60° &lt; alpha &lt;90°): As before linear interpolation between the function at alpha &lt;= 60 and alpha = 90 is used to determine the pressure loss in case 3. 
</p>

<p>
The following figure <strong>Fig.2</strong> pressure loss coefficients of the branching channel and straight channel at alpha = 15° are shown. (Currently not yet available)
</p>

<p>
The following figure <strong>Fig.3</strong> pressure loss coefficients of the branching channel and straight channel at alpha = 30° are shown. (Currently not yet available)
</p>

<p>
The following figure <strong>Fig.4</strong> pressure loss coefficients of the branching channel and straight channel at alpha = 45° are shown. (Currently not yet available)
</p>

<p>
The following figure <strong>Fig.5</strong> pressure loss coefficients of the branching channel and straight channel at alpha = 60° are shown. (Currently not yet available)
</p>

<p>
The following figure <strong>Fig.6</strong> pressure loss coefficients of the branching channel and straight channel at alpha = 90° are shown. (Currently not yet available)
</p>

<p>
The following figures pressure loss coefficients of the branching channel <strong>Fig.7</strong> and straight channel <strong>Fig.8</strong> at alpha = 75° are shown. (Currently not yet available)
</p>

<p>
<em>[P. Jordan; HTWG Konstanz; 01/24]</em>
</p>

<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"350\" height=\"100\">
</p>

</html>"));
end dp_JunctionWyeType2_DP;
