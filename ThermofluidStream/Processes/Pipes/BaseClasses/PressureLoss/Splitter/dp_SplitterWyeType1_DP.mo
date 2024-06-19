within ThermofluidStream.Processes.Pipes.BaseClasses.PressureLoss.Splitter;
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
  output Internal.Types.PressureLossCoefficient zeta_cb
    "Pressure loss coefficient of branching pipe w.r.t. common inlet velocity";
  output Internal.Types.PressureLossCoefficient zeta_cs
    "Pressure loss coefficient of straight pipe w.r.t. common inlet velocity";
  //output Real w_rel_bc = w_b/w_c "Velocity ratio branch/inlet";
  //output Real w_rel_sc = w_s/w_c "Velocity ratio straight/inlet";
  //output Fluid_HTWG.Types.PressureLossCoefficient zeta_cb_prime "auxilliary pressure loss coefficient of branch expressed through the velocity in the common channel";
protected
  Real A_prime "Coefficient characterizing the velocity ratio";

  Real w_rel_bc = if abs(w_c) > eps then w_b/w_c else 1 "Velocity ratio branch/inlet";
  Real w_rel_sc = if abs(w_c) > eps then w_s/w_c else 1 "Velocity ratio straight/inlet";

  Internal.Types.PressureLossCoefficient zeta_cb_prime
    "auxilliary pressure loss coefficient of branch w.r.t inlet velocity";
algorithm
  A_prime := 1 - SMOOTH(1.05, 0.8, w_rel_bc)*0.1;
  zeta_cb_prime := 1 + w_rel_bc^2 - 2*w_rel_bc*cos(alpha);
  zeta_cb := A_prime*zeta_cb_prime;
  zeta_cs := 0.4*(1 - w_rel_sc)^2;
  dp_b := zeta_cb*rho/2*w_c^2;
  dp_s := zeta_cs*rho/2*w_c^2;
  annotation (
    Documentation(info="<html>
<p>
<strong>The implementation of the function is based on \"Handbook of Hydraulic Resistance\" in its first translated Version from 1960! The book has been republished in several updated versions since then!</strong>
</p>

<p>
Function calculating the pressure loss of a Y-shaped splitter of type I (<strong>Fig. 1</strong>) as f(w_c,w_b,w_s, alpha, rho). (Currently not yet available)
</p>

<p>
where:
</p>

<ul>
<li>w_c: velocity at common channel [m/s]</li>
<li>w_b: velocity at branching channel [m/s]</li>
<li>w_s: velocity at straight channel [m/s]</li>
<li>alpha: branching angle [rad]</li>
<li>rho: density [kg/m^3]</li>
</ul>

<p>
Calculation according to Idelchik (1960). The pressure loss is calculated as
</p>

<ul>
<li>in branch: <code>dp_b = rho/2 * zeta_cb * w_c^2</code></li>
<li>in straight channel: <code>dp_s = rho/2 * zeta_cs * w_c^2</code></li>
</ul>

<p>
As you can see above both pressure loss calculation are with respect to the velocity at the common branch. The pressure loss coefficient of the branch zeta_cb is calculated as: <code>zeta_cb = A' * zeta'_cb</code>
</p>

<ul>
<li>A': coefficient of velocity ratio w_b/w_c</li>
<li>zeta_cb': uncorrected pressure loss coefficient</li>
</ul>

<p>
According to Idel'chik while <code>w_relbc = w_b/w_c &lt;= 0.8, A'= 1</code> and if <code>w_relbc &gt; 0.8</code> then <code>A' = 0.8</code>.
Since the velocity ratio may change during simulations, the discontinuity in A' is circumvented by the stepsmoother function used in region <code>0.8 &lt; w_relbc &lt; 1.05</code>.
</p>

<p>
The uncorrected pressure loss coefficient <code>zeta'_cb</code> is determined by the formula:
</p>

<p>
<code> zeta'_cb = 1 + w_relbc^2 - 2*cos(alpha)</code>
</p>

<p>
The pressure loss coefficient at the straight channel for all brnaching angles is described as:
</p>

<p>
<code> zeta_cs = 0.4*(1-w_relsc)^2</code>
</p> 

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
end dp_SplitterWyeType1_DP;
