within ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries;
function internalCoefficientsFromMeasurements "Calculates InteralCoefficients record from measurements record"
  extends Modelica.Icons.Function;
  input ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump data "Pump measurement data";
  output ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.InternalCoefficients coefficients "Pump coefficients";
protected
  Integer N = data.N "Number of data points";
  SI.Height data_head[N] = if data.setHead then data.head else data.dp/(data.rho_ref*Modelica.Constants.g_n) "Head data points";
  SI.Height data_eta[N] = data.V_flow.* data_head*Modelica.Constants.g_n*data.rho_ref ./ data.P "Efficiency data points";
  Real eta_ref_temp = max(data_eta) "Measured peak efficiency";
  Integer i_eta_ref = Modelica.Math.Vectors.find(eta_ref_temp,data_eta) "Index of measured peak efficiency";
  SI.VolumeFlowRate V_flow_ref_temp = data.V_flow[i_eta_ref] "Temporary reference volume flow rate (at measured peak efficiency)";
  SI.Height head_ref_temp = data_head[i_eta_ref] "Temporary reference head (at measured peak efficiency)";
  SI.Power P_ref_temp = data.P[i_eta_ref] "Temporary reference power (at measured peak efficiency)";

  Real A[N,3] = [ones(N), data.V_flow/V_flow_ref_temp, (data.V_flow/V_flow_ref_temp).^2] "Approximation matrix";
  Real b_head[N] = data_head/head_ref_temp "Vector of head data for approximation";
  Real b_power[N] = data.P/P_ref_temp "Vector of power data for approximation";

  Real c_head_temp[3] = Modelica.Math.Matrices.solve(transpose(A)*A,transpose(A)*b_head) "Temporary coefficients of 2nd order head approximation polynomial";
  Real c_power_temp[3] = Modelica.Math.Matrices.solve(transpose(A)*A,transpose(A)*b_power) "Temporary coefficients fof 2nd order torque/power approximation polynomial (P=tau*w)";
  // A'*A*c = A'*b could also be solved with Modelica.Math.Matrices.leastSquares(A,b);

  // Determine normalized flow at calculated peak efficiency (by solving deta/dV = 0)
  Real V_flow_peak_n = Modelica.Math.Nonlinear.solveOneNonlinearEquation(function ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.res_detadV(
                                                                                                                                                     ch = c_head_temp, cp = c_power_temp),0,2);
  Real head_peak_n = c_head_temp[1] + c_head_temp[2]*V_flow_peak_n + c_head_temp[3]*V_flow_peak_n^2 "Head at calculated peak efficiency (normalized with head at measured peak efficiency)";
  Real P_peak_n = c_power_temp[1] + c_power_temp[2]*V_flow_peak_n + c_power_temp[3]*V_flow_peak_n^2 "Power at calculated peak efficiency (normalized with power at measured peak efficiency)";

  Real eta_peak_n = V_flow_peak_n*head_peak_n/P_peak_n  "Calculated peak efficiency (normalized with measured peak efficiency)";

  SI.VolumeFlowRate V_flow_ref = V_flow_peak_n*V_flow_ref_temp "Reference volume flow rate (at calculated peak efficiency)";
  SI.Height head_ref = head_ref_temp*head_peak_n "Reference head (at calculated peak efficiency)";
  SI.Power P_ref = P_ref_temp*P_peak_n "Reference power (at calculated peak efficiency)";
  SI.Efficiency eta_ref = eta_ref_temp*eta_peak_n "Calculated peak efficiency";

  Real ch0 = c_head_temp[1]/head_peak_n  "Constant coefficient of 2nd order head approximation polynomial";
  Real ch1 = c_head_temp[2]/head_peak_n*V_flow_peak_n "Linear coefficient of 2nd order head approximation polynomial";
  Real ch2 = c_head_temp[3]/head_peak_n*V_flow_peak_n^2 "Quadratic coefficient of 2nd order head approximation polynomial";
  Real c_head[3] = {ch0, ch1, ch2};
  Real cP0 = c_power_temp[1]/P_peak_n  "Constant coefficient of 2nd order power approximation polynomial";
  Real cP1 = c_power_temp[2]/P_peak_n*V_flow_peak_n "Linear coefficient of 2nd order power approximation polynomial";
  Real cP2 = c_power_temp[3]/P_peak_n*V_flow_peak_n^2 "Quadratic coefficient of 2nd order power approximation polynomial";
  Real c_power[3] = {cP0, cP1, cP2};
algorithm

  coefficients.eta_ref :=eta_ref;
  coefficients.rho_ref:=data.rho_ref;
  coefficients.w_ref:=data.w_ref;
  coefficients.head_ref:=head_ref;
  coefficients.V_flow_ref:=V_flow_ref;
  coefficients.c_head:=c_head;
  coefficients.c_power:=c_power;
  coefficients.P_ref:=P_ref;
  coefficients.tau_ref:=P_ref/data.w_ref;

  annotation (Documentation(info="<html>
<p>
Function to calculate
<a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.InternalCoefficients\">InternalCoefficients record</a> 
based on <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump\">measurements record</a>.<br>
It is used in <a href=\"modelica://ThermofluidStream.Processes.CentrifugalPump\">CentrifugalPump</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
end internalCoefficientsFromMeasurements;
