within ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements;
record GenericPump "Generic measurement data record for centrifugal pumps"

  extends Modelica.Icons.Record;

  parameter SI.Density rho_ref(displayUnit="kg/l") = 1000 "Reference density";
  parameter SI.AngularVelocity  w_ref(displayUnit="rpm") = 314.1592653589793 "Reference angular velocity"; // 3000 rpm
  final parameter Integer N = size(V_flow,1) "Number of data points";
  parameter SI.VolumeFlowRate V_flow[:](displayUnit="m3/h") = {0,2.777777777778e-3,4.166666666667e-3} "Volume flow rate data points"
    annotation (Dialog(group="Volume flow rate")); // {0,10,15} m3/h
  parameter Boolean setHead = true "= true, if head data points shall be given (= false, if pressure difference shall be given instead)"
    annotation(Dialog(group="Head/Pressure rise"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Height head[:] = {10,5,0} "Head data points"
    annotation (Dialog(group="Head/Pressure rise", enable=setHead));
  parameter SI.PressureDifference dp[:] = {1e5,0.5e5,0} "Pressure rise data points"
    annotation (Dialog(group="Head/Pressure rise", enable= not setHead));
  parameter SI.Power P[:]={100,200,250} "Power data points"
    annotation (Dialog(group="Power"));

  annotation (
  defaultComponentPrefixes = "parameter", Documentation(info="", revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
end GenericPump;
