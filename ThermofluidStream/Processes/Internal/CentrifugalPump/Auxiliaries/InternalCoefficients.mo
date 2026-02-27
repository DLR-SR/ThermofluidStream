within ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries;
record InternalCoefficients "Coefficient record used in CentrifugalPump"

  extends Modelica.Icons.Record;

  parameter SI.Density rho_ref(displayUnit="kg/l") = 1000 "Reference density";
  parameter SI.AngularVelocity  w_ref(displayUnit="rpm") = 314.1592653589793 "Reference angular velocity"; // 3000 rpm

  parameter Real head_ref = 1 "Reference for head, e.g. at peak efficiency";
  parameter Real V_flow_ref = 1 "Reference for volume flow rate, e.g. at peak efficiency";
  parameter Real eta_ref = 1 "Reference for efficiency, e.g. peak efficiency";

  parameter Real c_head[3] = {1,0.23,-1.23} "Coefficients of second order head approximation polynomial";
  parameter Real c_power[3] = {0.20, 0.55,-0.28} "Coefficients of second order torque approximation polynomial (P=tau*w)";

  parameter SI.Power P_ref = rho_ref*Modelica.Constants.g_n*head_ref*V_flow_ref/eta_ref "Reference power";
  parameter SI.Torque tau_ref = P_ref/w_ref "Reference torque";

  annotation(defaultComponentPrefixes = "parameter", Documentation(info="<html>
<p>
Coefficient record internally used in <a href=\"modelica://ThermofluidStream.Processes.CentrifugalPump\">CentrifugalPump</a> and 
calculated either based on <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements\">measurements</a>
or based on <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.CoefficientData\">coefficients</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
end InternalCoefficients;
