within ThermofluidStream.Processes;
model ThermalConvectionPipe "Very simple model of thermal convection"

  extends Interfaces.SISOFlow(final clip_p_out=false);

  parameter SI.Length l(min=0) "Length";
  parameter SI.Radius r "Radius";
  parameter SI.ReynoldsNumber Re_D_crit = 2300 "Critical Reynolds number for laminar-turbulent transition"
    annotation(Dialog(tab = "Advanced", group = "flow characteristics"));
  //parameter Real C_dh(unit="J/(K.s)") = 1e-6 "Dimensionless constant for mass flow regularization";
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Nominal mass flow rate for regularization"
    annotation(Dialog(tab = "Advanced", group = "Regularization parameters"));

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displayLength = true "= true, if length l is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayRadius = true "= true, if radius r is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter String parameterString=
    if displayParameters and displayLength and displayRadius then
      "l = %l, r = %r"
    elseif displayParameters and displayLength and not displayRadius then
      "l = %l"
    elseif  displayParameters and not displayLength and displayRadius then
      "r = %r"
    else "";
  //-----------------------------------------------------------------

  Medium.ThermodynamicState center_state = Medium.setState_phX(p_in,h_in+dh/2,Xi_in) "State at (h_in+h_out)/2";
  Medium.Temperature T = Medium.temperature(center_state) "Temperature at center state";

  Integer turb_flag "= 0 for laminar flow, = 1 for turbulent flow (Re > 2300)";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation (
      Placement(transformation(extent={{-10,-110},{10,-90}}),
                                                            iconTransformation(
          extent={{-10,-110},{10,-90}})));


protected
  SI.Area A_cond = 2*Modelica.Constants.pi*r*l "Heat transfer area";
  SI.Area A_cross = Modelica.Constants.pi*r^2
    "Cross-sectional area";
  SI.Volume V = A_cross*l "Volume";
  constant SI.NusseltNumber Nu_laminar = 4.36 "Nusselt number for laminar flow";
  SI.CoefficientOfHeatTransfer h_avg "Average heat transfer coefficient";

  SI.ThermalConductivity k =  Medium.thermalConductivity(center_state) "Center state thermal conductivity ";

  SI.Density rho = Medium.density(center_state) "Center state density";
  SI.Mass M = V*rho "Mass";
  SI.SpecificEnthalpy dh "Specific enthalpy difference (outlet-inlet)";

  //Flow characteristics
  SI.DynamicViscosity mu = Medium.dynamicViscosity(center_state) "Center state dynamic viscosity";
  SI.ReynoldsNumber Re_D "Reynolds number";
  SI.NusseltNumber Nu_turb "Nusselt number for turbulent flow";
  SI.PrandtlNumber Pr = Medium.prandtlNumber(center_state) "Center state Prandtl number";

  SI.Velocity v_m "Mean fluid velocity";

  //SI.VelocityOfSound c = Medium.velocityOfSound(center_state) "Velocity of sound";

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

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,60},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(
          extent={{-150,-50},{150,-80}},
          textColor={0,0,0},
          textString=parameterString),
        Rectangle(
          extent={{-84,36},{88,-36}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={28,108,200},
          radius=2),
        Line(points={{-84,44},{88,44}}, color={238,46,47}),
        Line(points={{-84,-44},{88,-44}}, color={238,46,47}),
        Line(
          points={{-60,0},{64,0}},
          color={28,108,200}),
        Line(visible=not parameterString=="", points={{0,-44},{0,-50}},
                                    color={238,46,47}),
        Line(visible=not parameterString=="", points={{0,-80},{0,-90}},
                                    color={238,46,47}),
        Line(visible=parameterString=="", points={{0,-44},{0,-90}},
                                    color={238,46,47})}),
                                 Diagram(coordinateSystem(
          preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This component models the convective heat transfer in a pipe element with constant heat flux. </p>
<p>So far, the transition from laminar to turbulent flow regime is not implemented, thus a turbulent flow regime is assumed.</p>
<p>Hence the average convective heat transfer coefficient is calculated from the Reynolds number and the Nusselt-Number for turbulent flow.</p>
</html>"));
end ThermalConvectionPipe;
