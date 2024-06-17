within ThermofluidStream.Processes.Pumps.BaseClasses;
partial model PartialFlowControlledCentrifugalPump "Base model of flow controlled centrifugal pump"
  extends ThermofluidStream.Processes.Pumps.BaseClasses.SISOFlow_v2;

  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Mass flow rate for regularization"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Power eps_P = 1e-5 "Power/efficiency regularization (eta = 0 for P < eps_P"
    annotation(Dialog(tab="Advanced"));
  parameter SI.AngularVelocity w_ref "Reference angular velocity";
  parameter SI.Density rho_ref "Reference density";
  parameter Real head_ref "Reference for head, preferably (V_flow = 0,w_ref)";
  parameter Real V_flow_ref "Reference for volume flow rate, preferably V_flow(head=0,w_ref)";
  parameter Real eta_ref "Reference for efficiency, preferably max eta(V_flow)";
  parameter Real c_head[3] "Coefficients of second order head approximation polynomial, preferably c_head = {1, c2, -(1+c2)}";
  parameter Real c_power[3] = Modelica.Math.Matrices.solve(transpose(A_power)*A_power,transpose(A_power)*b_power) "Coefficients fof 2nd order torque approximation polynomial (P=tau*w)";

  final parameter SI.Power P_ref = head_ref*rho_ref*Modelica.Constants.g_n*V_flow_ref "Reference power";
  final parameter SI.Torque tau_ref = P_ref/w_ref "Reference torque";
protected
  SI.Density rho_in = Medium.density(inlet.state) "Inlet density";
  SI.Density rho = rho_in "Density";
  SI.VolumeFlowRate V_flow = m_flow/rho "Volume flow rate";
public
  SI.AngularVelocity w(start=w_ref) "Angular velocity";
  SI.Torque tau "Torque";
  SI.Height head "Head";
  SI.SpecificEnthalpy w_t "Specific technical work";
  SI.Power P "Power (technichal work flow rate)";
  Real eta_is "Isentropic efficiency";
protected
  Real w_r(start=1) = w/w_ref "Angular velocity ratio";
  Real V_r = V_flow/V_flow_ref "Volume flow rate ratio";
  Real head_r = head/head_ref "Head ratio";
  Real tau_r(start=1) = tau/tau_ref "Torque ratio";
  Real rho_r = rho/rho_ref "Density ratio";
equation
  w_r = 1/(2*c_head[1])*(-c_head[2]*V_r + sqrt(c_head[2]^2*V_r^2 - 4*c_head[1]*(c_head[3]*V_r^2 - head_r))); // c_head[1] = 1, c_head[3] = - (1 + c_head[2])
  // head_r =  c_head[1]*w_r^2 + c_head[2]*w_r*V_r + c_head[3]*V_r^2; // c_head[1] = 1, c_head[3] = - (1 + c_head[2])
  tau_r =  rho_r/eta_ref*(c_power[1]*w_r^2 + c_power[2]*w_r*V_r + c_power[3]*V_r^2);

  dp = head*rho*Modelica.Constants.g_n;
  P = tau*w;
  h_out = h_in + w_t;
  w_t = P/max(m_flow,m_flow_reg); //P*m_flow/(m_flow^2 + m_flow_reg^2);
  eta_is = if noEvent(abs(P) <= eps_P) then 0 else dp*V_flow/P;
  annotation (Icon(graphics={
         Text(visible=displayInstanceName,
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
         Ellipse(
          extent={{-58,54},{62,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,60},{60,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,-60},{60,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5)}));
end PartialFlowControlledCentrifugalPump;
