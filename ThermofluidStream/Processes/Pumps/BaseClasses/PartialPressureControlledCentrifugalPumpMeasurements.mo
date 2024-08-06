within ThermofluidStream.Processes.Pumps.BaseClasses;
partial model PartialPressureControlledCentrifugalPumpMeasurements "Base model of pressure controlled centrifugal pump based on measurements at reference speed"

  extends ThermofluidStream.Processes.Pumps.BaseClasses.PartialPressureControlledCentrifugalPump(
    final w_ref=data.w_ref,
    final rho_ref=data.rho_ref,
    final V_flow_ref=V_flow_ref_temp/(2*c_head_temp[3])*(-c_head_temp[2] - sqrt(c_head_temp[2]^2 - 4*c_head_temp[1]*
        c_head_temp[3])),
    final head_ref=c_head_temp[1]*head_ref_temp,
    final c_head={c1_head,c2_head,c3_head},
    final c_power=c_power_temp,
    final eta_ref=max(data_V_flow .* data_head*Modelica.Constants.g_n*data.rho_ref ./ data_power));

  replaceable parameter
    ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnMeasurements.MeasurementData.GenericPump data
    "Measurement data" annotation (choicesAllMatching=true);
protected
  final parameter Integer N = data.N "Number of data points";
  final parameter SI.VolumeFlowRate data_V_flow[N] = data.V_flow "Volume flow rate data points";
  final parameter SI.VolumeFlowRate V_flow_ref_temp = data_V_flow[end] "Temporary reference volume flow rate";
  final parameter SI.Height data_head[:] = if data.setHead then data.head else data.dp/(rho_ref*Modelica.Constants.g_n) "Head data points";
  final parameter SI.Height head_ref_temp = data_head[1] "Temporary reference head";
  final parameter Real A_head[N,3] = [ones(N), data_V_flow/V_flow_ref_temp, (data_V_flow/V_flow_ref_temp).^2] "Approximation matrix";
  final parameter Real b_head[N] = data_head/head_ref_temp "Vector of head data for approximation";
  final parameter Real c_head_temp[3] = Modelica.Math.Matrices.solve(transpose(A_head)*A_head,transpose(A_head)*b_head) "Temporary coefficients of 2nd order head approximation polynomial"; // A'Ac = A'b //Modelica.Math.Matrices.leastSquares(A_head,b_head);

  final parameter Real c1_head = 1 "Constant coefficient of head approximation polynomial";
  final parameter Real c2_head = c_head_temp[2]*head_ref_temp/head_ref*V_flow_ref/V_flow_ref_temp "Linear coefficient of head approximation polynomial";
  final parameter Real c3_head = c_head_temp[3]*head_ref_temp/head_ref*(V_flow_ref/V_flow_ref_temp)^2 "Quadratic coefficient of head approximation polynomial"; //= - (1 + c2_head)

  final parameter SI.Power data_power[N] = data.P "Power data points";
  final parameter SI.Power P_ref_temp = head_ref*rho_ref*Modelica.Constants.g_n*V_flow_ref "Reference power";
  final parameter Real b_power[N] = data_power*eta_ref/P_ref_temp "Power data for approximation";
  final parameter Real A_power[N,3] = [ones(N), data_V_flow/V_flow_ref, (data_V_flow/V_flow_ref).^2] "Approximation matrix for power";
  final parameter Real c_power_temp[3] = Modelica.Math.Matrices.solve(transpose(A_power)*A_power,transpose(A_power)*b_power) "Coefficients fof 2nd order torque approximation polynomial (P=tau*w)"; // A'Ac = A'b //Modelica.Math.Matrices.leastSquares(A_power,b_power);
end PartialPressureControlledCentrifugalPumpMeasurements;
