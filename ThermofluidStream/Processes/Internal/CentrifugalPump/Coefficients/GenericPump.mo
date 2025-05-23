within ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients;
record GenericPump "Generic coefficient record for centrifugal pumps"

  extends Modelica.Icons.Record;

  parameter SI.Density rho_ref(displayUnit="kg/l") = 1000 "Reference density";
  parameter SI.AngularVelocity  w_ref(displayUnit="rpm") = 314.1592653589793 "Reference angular velocity"; // 3000 rpm
  parameter SI.VolumeFlowRate V_flow_peak(displayUnit="m3/h") = 0  "Volume flow rate at peak efficiency";
  parameter Boolean setHead = true "= true, if reference head shall be given (= false, if reference pressure rise shall be given instead)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Height head_peak = 0 "Head at peak efficiency"
    annotation (Dialog(enable=setHead));
  parameter SI.PressureDifference dp_peak = 0 "Pressure rise at peak efficiency"
    annotation (Dialog(enable= not setHead));
  parameter Real eta_peak(min=0,max=1) = 0.8 "Peak efficiency";
  parameter Real V_0n = 1.946 "Normalized flow V_flow/V_flow_peak at zero head (see doku)";
  parameter Real h_0n = 1.273 "Normalized head h/h_peak at zero flow (see doku)";
  parameter Real P_0n = 0.499 "Normalized power P/P_peak at zero flow (see doku)";
  final parameter SI.Height head_ref_internal = if setHead then head_peak else dp_peak/(Modelica.Constants.g_n*rho_ref);
  annotation(defaultComponentPrefixes = "parameter",Documentation(info="<html>
<p>
The following figures show the normalized head <code>h_n = h/h_peak</code>, the normalized power <code>P_n = P/P_peak</code> and the normalized efficiency <code>eta/eta_peak</code> 
at reference speed <code>w = w_ref</code>
in dependency of the normalized volume flow rate <code>V_flow_n = V_flow/V_flow_peak</code>.<br>
Thereby <code>h_peak</code>, <code>P_peak</code> and <code>V_flow_peak</code> are head, power and volume flow rate at the peak efficiency <code>eta_peak</code>.
</p>
<ul>
<li><code>h_0n ≈ 1.273 ± 0.128, min 1.101, max 1.516</code> is the normalized head at zero volume flow rate</li>
<li><code>V_0n ≈ 1.946 ± 0.087, min 1.784, max 2.090</code> 
is the normalized volume flow rate at zero head</li>
<li><code>P_0n ≈ 0.499 ± 0.099, min 0.372, max 0.677</code> is the normalized power at zero volume flow rate</li>
</ul>
<p>
Colors refer to different pumps. A mean centrifugal pump curve is displayed as think solid.
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/HQ.png\" alt=\"Comparison head\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/PQ.png\" alt=\"Comparison power\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/etaQ.png\" alt=\"Comparison efficiency\" width=\"500\">
</p>
</html>", revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
end GenericPump;
