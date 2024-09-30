within ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries;
function pumpCoefficientsFromMeasurements
  extends Modelica.Icons.Function;
  input ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump data "Pump measurement data";
  output ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.InternalCoefficients coefficients(
    rho_ref=data.rho_ref,
    w_ref=data.w_ref,
    head_ref=head_ref,
    V_flow_ref=V_flow_ref,
    eta_ref=eta_ref,
    c_head={c1_head,c2_head,c3_head},
    c_power=c_power) "Pump coefficients";
protected
  Integer N = data.N "Number of data points";
  SI.VolumeFlowRate V_flow_ref_temp =  data.V_flow[end] "Temporary reference volume flow rate";
  SI.Height data_head[N] = if data.setHead then data.head else data.dp/(data.rho_ref*Modelica.Constants.g_n) "Head data points";
  SI.Height head_ref_temp = data_head[1] "Temporary reference head";
  Real A_head[N,3] = [ones(N), data.V_flow/V_flow_ref_temp, (data.V_flow/V_flow_ref_temp).^2] "Approximation matrix";
  Real b_head[N] = data_head/head_ref_temp "Vector of head data for approximation";
  Real c_head_temp[3] = Modelica.Math.Matrices.solve(transpose(A_head)*A_head,transpose(A_head)*b_head) "Temporary coefficients of 2nd order head approximation polynomial"; // A'Ac = A'b, could also be solved wjtb Modelica.Math.Matrices.leastSquares(A_head,b_head);
  SI.Height head_ref = c_head_temp[1]*head_ref_temp "Reference head";
  SI.VolumeFlowRate V_flow_ref = V_flow_ref_temp/(2*c_head_temp[3])*(-c_head_temp[2] - sqrt(c_head_temp[2]^2 - 4*c_head_temp[1]*c_head_temp[3])) "Reference volume flow rate";
  Real c1_head = c_head_temp[1]*head_ref_temp/head_ref "Constant coefficient of head approximation polynomial (=1)";
  Real c2_head = c_head_temp[2]*head_ref_temp/head_ref*V_flow_ref/V_flow_ref_temp "Linear coefficient of head approximation polynomial";
  Real c3_head = c_head_temp[3]*head_ref_temp/head_ref*(V_flow_ref/V_flow_ref_temp)^2 "Quadratic coefficient of head approximation polynomial"; //= - (1 + c2_head)
  Real eta_ref = max(data.V_flow .* data_head*Modelica.Constants.g_n*data.rho_ref ./ data.P) "Reference efficiency";
  SI.Power P_ref = head_ref*data.rho_ref*Modelica.Constants.g_n*V_flow_ref "Reference power";
  Real b_power[N] = data.P*eta_ref/P_ref "Power data for approximation";
  Real A_power[N,3] = [ones(N), data.V_flow/V_flow_ref, (data.V_flow/V_flow_ref).^2] "Approximation matrix for power";
  Real c_power[3] = Modelica.Math.Matrices.solve(transpose(A_power)*A_power,transpose(A_power)*b_power) "Coefficients fof 2nd order torque approximation polynomial (P=tau*w)"; // A'Ac = A'b could also be solved with Modelica.Math.Matrices.leastSquares(A_power,b_power);
algorithm

  annotation (Documentation(info="<html>
<p>
Function to calculate
<a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.InternalCoefficients\">InternalCoefficients record</a> 
based on <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements\">measurements record</a>.<br>
It is used in <a href=\"modelica://ThermofluidStream.Processes.CentrifugalPump\">CentrifugalPump</a>.
</p>
</html>"));
end pumpCoefficientsFromMeasurements;
