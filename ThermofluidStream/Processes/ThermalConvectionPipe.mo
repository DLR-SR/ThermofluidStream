within ThermofluidStream.Processes;
model ThermalConvectionPipe "Very simple model of thermal convection"
  extends Interfaces.SISOFlow(final clip_p_out=false);

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation (
      Placement(transformation(extent={{-10,90},{10,110}}), iconTransformation(
          extent={{-10,90},{10,110}})));

  parameter SI.Radius r(min = 0) "Radius of Pipe";
  parameter SI.Length l(min=0) "Length of pipe";
  parameter SI.ReynoldsNumber Re_D_crit = 2300
    "Critical Reynolds number for transition to turbulent"
  annotation(Dialog(tab = "Advanced", group = "flow characteristics"));
  //parameter Real C_dh(unit="J/(K.s)") = 1e-6 "dimensionless constant for mass flow regularisation";
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg
    "Nominal mass flow rate for regularisation"
  annotation(Dialog(tab = "Advanced", group = "Regularisation parameters"));

  Medium.ThermodynamicState center_state = Medium.setState_phX(p_in,h_in+dh/2,Xi_in);
  Medium.Temperature T = Medium.temperature(center_state);

  Integer turb_flag "0: laminar flow, 1: turbulent flow (Re > 2300)";

protected
  SI.Area A_cond = 2*Modelica.Constants.pi*r*l
    "conductive surface of pipe (shell surface)";
  SI.Area A_cross = Modelica.Constants.pi*r^2
    "cross sectional area of pipe";
  SI.Volume V = A_cross*l "representative Volume = S*d";
  constant SI.NusseltNumber Nu_laminar = 4.36
    "Nusselt number for laminar pipe flow";

  SI.CoefficientOfHeatTransfer h_avg
    "Average convective coefficient of heat transfer";

  SI.ThermalConductivity k =  Medium.thermalConductivity(center_state);

  SI.Density rho = Medium.density(center_state);
  SI.Mass M = V*rho;
  SI.SpecificEnthalpy dh;

  //Flow characteristics
  SI.DynamicViscosity mu = Medium.dynamicViscosity(center_state)
    "dynamic viscosity of fluid at center";
  SI.ReynoldsNumber Re_D "Reynolds number of fluid (D: characteristic length)";
  SI.NusseltNumber Nu_turb "Nusselt number for turbulent flow";
  SI.PrandtlNumber Pr = Medium.prandtlNumber(center_state)
    "Prandtl Number of fluid";

  SI.Velocity v_m "velocity of fluid";

  //SI.VelocityOfSound c = Medium.velocityOfSound(center_state) "velocity of sound";

  parameter Real eps(unit="1") = Modelica.Constants.eps;

equation

  //mean velocity calculation
  v_m = inlet.m_flow/(rho*A_cross);

  //Reynolds number for pipe flow
  Re_D = max((rho*v_m*2*r)/(mu), 1);

  //Nusselt number for turbulent flow and constant heat flux
  Nu_turb = ((0.0396*Re_D+eps)^(0.75)*Pr)/(1+(2.44*Re_D+eps)^(-0.125)*(Pr-1));


//    //Calculation of heat transfer coefficient dependent on flow characteristics
//     if noEvent(Re_D < Re_D_crit) then
//
//       h_avg = (Nu_laminar*k)/(2*r);
//
//       turb_flag = 0;
//
//     else
//       h_avg = (Nu_turb*k)/(2*r);
//
//       turb_flag = 1;
//     end if;


   //assuming constant conditions
   h_avg = (Nu_turb*k)/(2*r);
   turb_flag = 1;

  heatPort.Q_flow = h_avg*A_cond*(heatPort.T - T);

  //der(dh)*M/2 + inlet.m_flow*dh = heatPort.Q_flow;

  dh = (inlet.m_flow*heatPort.Q_flow)/((inlet.m_flow)^2+(m_flow_reg/10)^2);

  //dh = (inlet.m_flow*heatPort.Q_flow)/((inlet.m_flow)^2 + 0.5*M^2*C_dh*(c/l)^2);

  dp = 0;
  h_out = h_in+dh;
  Xi_out = Xi_in;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-84,36},{88,-36}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={28,108,200},
          radius=2),
        Line(points={{0,90},{0,44}},color={238,46,47}),
        Line(points={{-84,44},{88,44}}, color={238,46,47}),
        Line(points={{-84,-44},{88,-44}}, color={238,46,47}),
        Line(
          points={{-60,0},{64,0}},
          color={28,108,200})}), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This component models the convective heat transfer in a pipe element with constant heat flux. </p>
<p>So far, the transition from laminar to turbulent flow regime is not implemented, thus a turbulent flow regime is assumed.</p>
<p>Hence the average convective heat transfer coefficient is calculated from the Reynolds number and the Nusselt-Number for turbulent flow.</p>
</html>"));
end ThermalConvectionPipe;
