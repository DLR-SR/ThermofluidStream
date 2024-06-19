within ThermofluidStream.Processes.Pipes.BaseClasses.PressureLoss.Splitter;
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
  output Internal.Types.PressureLossCoefficient zeta_cb
    "Pressure loss coefficient of branching pipe w.r.t. inlet velocity";
  output Internal.Types.PressureLossCoefficient zeta_cs
    "Pressure loss coefficient of straight pipe w.r.t. inlet velocity";
protected
  Real w_rel_bc = if abs(w_c) >= eps then w_b/w_c else 0 "Velocity ratio branch/inlet";
  Real w_rel_sc = if abs(w_c) >= eps then w_s/w_c else 0 "Velocity ratio main/inlet";
algorithm
  zeta_cb := 1 + (w_rel_bc)^2 - 2*w_rel_bc*cos(alpha) - K_b_prime*w_rel_bc^2;
  zeta_cs := max(0, k*0.5345*w_rel_sc^4 - k*1.124*w_rel_sc^3 + k*1.73*w_rel_sc^2 - 2.146*w_rel_sc + 1.0005);
  dp_b := zeta_cb*rho/2*w_c^2;
  dp_s := zeta_cs*rho/2*w_c^2;

  annotation (
    Documentation(info="<html>
<p>
<strong>The implementation of the function is based on \"Handbook of Hydraulic Resistance\" in its first translated Version from 1960! The book has been republished in several updated versions since then!</strong>
</p>

<p>
Function calculating the pressure loss of a Y-shaped splitter of type II (<strong>Fig. 1</strong>) as f(w_c,w_b,w_s, alpha, rho, k, K'_b). (Currently not yet available)
</p>

<ul>
<li>w_c: velocity at common channel [m/s]</li>
<li>w_b: velocity at branching channel [m/s]</li>
<li>w_s: velocity at straight channel [m/s]</li>
<li>alpha: branching angle [rad]</li>
<li>rho: density [kg/m^3]</li>
<li>k: scaling factor for area ratio dependency at alpha = 90° [-]</li>
<li>K'_b: correction factor for branching angle dependency [-]</li>
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
<code>zeta_cb =1 + (w_relbc)^2 - 2*w_relbc *cos(alpha) - K'_b * (w_relbc)^2</code>
</p>

<p>
Idel'chik provides table data for the coefficient K'_b. Since no sufficiently precise approximation equation can be defined for this factor, a table is also used for implementation.
A cubic spline is used to interpolate between the control points. To control the limit behavior at table boundaries control points at alpha = 0° and alpha = 105° are added
</p>

<table>
  <tr>
    <td>alpha in °</td>
    <td>0</td>
    <td>15</td>
    <td>30</td>
    <td>45</td>
    <td>60</td>
    <td>90</td>
    <td>105</td>
  </tr>
  <tr>
    <td>K'_b</td>
    <td>0.03</td>
    <td>0.04</td>
    <td>0.16</td>
    <td>0.36</td>
    <td>0.64</td>
    <td>1</td>
    <td>1</td>
  </tr>
</table>

<p>
<strong>Notice:</strong> In more recent editions Idelchik gives the same approximation formula, but the diagram and data sets show a limit value against which the friction coefficients of all angles converge.
Adjustments using a C-spline have not yet been made. For calculation of the <strong>pressure loss coefficient of th straight channel zeta_cs</strong> there is no aproximation formula by Idel'chik.
Therefore an own aproximation on basis of the data from Idel'chik has to be found. The given table data suggest a basis function, which is transformed into a set of curves by the scaling factor k 
taking the area ratio dependency at <code>alpha = 90°</code> into account.
</p>

<p>
A 4th order polynomial is selected as the basis function and fitted to the data set:
</p>

<p>
<code> zeta_cs_base = 0.5345*w_relsc^4 - 1.124+w_relsc^3 + 1.73*w_relsc^2 - 2.146*w_relsc + 1.005</code>
</p>

<p>
In order to obtain a set of curves. the basis function is expanded by the scaling factor k.
</p>

<p>
<code> zeta_cs = k*0.5345*w_relsc^4 - k*1.124+w_relsc^3 + k*1.73*w_relsc^2 - 2.146*w_relsc + 1.005</code>
</p>

<p>
As befor since no rational approximation has been found the scaling factor is implemented using a look-up table.
</p>

<table>
  <tr>
    <td>F_relsc</td>
    <td>0</td>
    <td>0.3</td>
    <td>0.4</td>
    <td>0.5</td>
    <td>0.6</td>
    <td>0.8</td>
    <td>0.9</td>
    <td>1</td>
  </tr>
  <tr>
    <td>k</td>
    <td>1</td>
    <td>1</td>
    <td>1</td>
    <td>1.16</td>
    <td>1.075</td>
    <td>1.05</td>
    <td>1</td>
    <td>1</td>
  </tr>
</table>

<p>
The following figure <strong>Fig.2</strong>, pressure loss coefficients of the branching channel are shown. (Currently not yet available)
</p>

<p>
<em>[P. Jordan; HTWG Konstanz; 01/24]</em>
</p>

<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"350\" height=\"100\">
</p>

</html>"));
end dp_SplitterWyeType2_DP;
