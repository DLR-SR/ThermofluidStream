within ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries;
record InternalCoefficients "Coefficient record internally used in CentrifugalPump"

  extends Modelica.Icons.Record;

  parameter SI.Density rho_ref(displayUnit="kg/l") = 1000 "Reference density";
  parameter SI.AngularVelocity  w_ref(displayUnit="rpm") = 314.1592653589793 "Reference angular velocity"; // 3000 rpm

  parameter Real head_ref "Reference for head, preferably at (V_flow = 0, w = w_ref)";
  parameter Real V_flow_ref "Reference for volume flow rate, preferably at (head = 0, w = w_ref)";
  parameter Real eta_ref "Reference for efficiency, preferably maximum efficiency eta(V_flow)";

  parameter Real c_head[3] = {1,0.23,-1.23} "Coefficients of second order head approximation polynomial, preferably c_head = {1, c2, -(1+c2)}";
  parameter Real c_power[3] = {0.20, 0.55,-0.28} "Coefficients of 2nd order torque approximation polynomial (P=tau*w)";

  final parameter SI.Power P_ref = head_ref*rho_ref*Modelica.Constants.g_n*V_flow_ref "Reference power";
  final parameter SI.Torque tau_ref = P_ref/w_ref "Reference torque";

 /* For your information: based on 18 Wilo Pumps the coefficients are: 
 c_head[2]_mean = 0.2335 +- 0.3010;
 c_head[2]_min = -0.2949;
 c_head[2]_max = 0.7039;
 
 c_power_mean = {0.2010 +- 0.0314, 0.5497 +- 0.1416, -0.2827 +- 0.0898};
 c_power_min = {0.1574, 0.3197, -0.4465};
 c_power_max = {0.2614, 0.7583, -0.1643};
 */
  annotation(defaultComponentPrefixes = "parameter", Documentation(info="<html>
<p>
Coefficient record internally used in <a href=\"modelica://ThermofluidStream.Processes.CentrifugalPump\">CentrifugalPump</a> and 
calculated either based on <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements\">measurements</a>
or based on <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.CoefficientData\">coefficients</a>.
</p>
</html>"));
end InternalCoefficients;
