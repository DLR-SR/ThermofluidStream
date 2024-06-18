within ThermofluidStream.Processes.Pipes;
model JunctionY "Pressure drop of an Y-shaped junction"

  extends Internal.Interfaces.partialJunctionY;

  // Geometry
  parameter SI.Length d_straight "Straight inlet diameter"
    annotation(Dialog(group = "Geometry"));
  parameter SI.Length d_branching "Branching inlet diameter"
    annotation(Dialog(group = "Geometry"));
  parameter SI.Angle alpha "Branching angle"
    annotation(Dialog(group = "Geometry"));
  parameter Boolean Y_type1 = true "= true, if A_out = A_straight, (= false, if  A_out = A_straight + A_branching)"
    annotation(Dialog(group = "Geometry"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Velocity eps(min=0) = Modelica.Constants.eps "To avoid division by zero";
  parameter Boolean assumeConstantDensity=true "= true, if incompressibility is assumed (use '= false' for Ma > 0.3)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

  final parameter SI.Area A_out = if Y_type1 then A_straight else A_straight + A_branching "(Common) outlet cross-sectional area";
  final parameter SI.Area A_straight = pi/4*d_straight^2 "Straight inlet cross-sectional area";
  final parameter SI.Area A_branching = pi/4*d_branching^2 "Branching inlet cross-sectional area";

  SI.Pressure DP_straight "Pressure loss in straight pipe (-dp_straight)";
  SI.Pressure DP_branching "Pressure loss in branching pipe (-dp_branching)";

  Internal.Types.PressureLossCoefficient zeta_straight "Pressure loss coefficient of straight pipe";
  Internal.Types.PressureLossCoefficient zeta_branching "Pressure loss coefficient of branching pipe";

  // protected
  Modelica.Blocks.Tables.CombiTable1Ds A(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1, table = [0, 1; 0.1, 1; 0.2, 1; 0.3, 0.75; 0.4, 0.75; 0.6, 0.7; 0.8, 0.65; 1, 0.6], verboseExtrapolation = true)
    annotation(Placement(visible = true, transformation(origin = {50, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Real A_rel_bc = A_branching/A_out "Area ratio branch/ (common) outlet";
  SI.Density rho_straight = Medium.density(inlet_straight.state) "Density straight inlet";
  SI.Density rho_branching = Medium.density(inlet_branching.state) "Density branching inlet";
  SI.Density rho_out = if assumeConstantDensity then (rho_straight + rho_branching)/2 else Medium.density(outlet.state) "Outlet density";
  final parameter Real alpha_deg = alpha*180/pi "Branching angle (in deg)";
  Real Q_rel_bc;

  Modelica.Blocks.Tables.CombiTable2Dv K_b1(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, n = 3, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, table = [0, 15, 30, 45, 60, 90; 0, 0, 0, 0, 0, 0; 0.06, 0, 0, 0, 0, 0; 0.1, 0, 0, 0, 0, 0; 0.2, 0, 0, 0, 0, 0.1; 0.33, 0, 0, 0, 0, 0.2; 0.5, 0, 0, 0, 0.1, 0.25])
    annotation(Placement(visible = true, transformation(origin = {-50, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable2Dv K_s1(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, n = 3, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, table = [0, 15, 30, 45, 60, 90; 0, 0, 0, 0, 0, 0; 0.06, 0, 0, 0, 0, 0.37; 0.1, 0, 0, 0.05, 0, 0.46; 0.2, 0, 0, 0.14, 0, 0.46; 0.33, 0.14, 0.14, 0.14, 0.1, 0.5712; 0.5, 0.4, 0.4, 0.3, 0.25, 0.806])
    annotation(Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  // Distinction between type 1 and type 2 junction
  if Y_type1 then
    // Pressure loss function of type 1
    (DP_branching,DP_straight,zeta_branching,zeta_straight) =
      Internal.BaseClasses.PressureLoss.Junction.dp_JunctionWyeType1_DP(
      F_c=A_out,
      F_b=A_branching,
      w_c=c_mix,
      w_b=c_branching,
      w_s=c_straight,
      alpha_deg=alpha_deg,
      A=A.y[1],
      rho_c=rho_out,
      eps=eps);
  else
    // Pressure loss function of type 2
    (DP_branching,DP_straight,zeta_branching,zeta_straight) =
      Internal.BaseClasses.PressureLoss.Junction.dp_JunctionWyeType2_DP(
      F_c=A_out,
      F_b=A_branching,
      F_s=A_straight,
      w_c=c_mix,
      w_b=c_branching,
      w_s=c_straight,
      alpha_deg=alpha_deg,
      K_s=K_s1.y,
      K_b=K_b1.y,
      rho_c=rho_out,
      eps=eps);
  end if;
  c_straight = abs(inlet_straight.m_flow)/(A_straight*rho_straight);
  c_branching = abs(inlet_branching.m_flow)/(A_branching*rho_branching);
  c_mix = abs(outlet.m_flow)/(A_out*rho_out);
  dp_straight = -DP_straight;
  dp_branching = -DP_branching;
  A.u = A_rel_bc;
  K_b1.u1 = fill(A_rel_bc, 3);
  K_s1.u1 = fill(A_rel_bc, 3);
  K_b1.u2 = {alpha_deg, 60, 90};
  K_s1.u2 = {alpha_deg, 60, 90};
  Q_rel_bc = abs(inlet_branching.m_flow/rho_branching)/abs(outlet.m_flow/rho_out);
  assert(outlet.m_flow <= 0, "Positiv mass flow at junction outlet!", AssertionLevel.warning);
  assert(inlet_straight.m_flow >= 0, "Negativ mass flow at straight inlet!", AssertionLevel.warning);
  assert(inlet_branching.m_flow >= 0, "Negativ mass flow at branching inlet!", AssertionLevel.warning);
  annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)),
    Icon(graphics={
    Text(visible=displayInstanceName,
          extent={{-150,-100},{150,-60}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
    Polygon(
          origin={0,25},
          lineColor={0,140,72},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid,
          points={{80,5},{20,5},{-36,61},{-66,31},{-40,5},{-80,5},{-80,-55},{80,-55},{80,5}}),
    Line( origin={25,65},
          points={{55,-25},{-5,-25},{-55,25}},
          color={0,140,72},
          thickness=0.5),
    Line( origin={-70,46},
          points={{-10,-6},{10,-6},{-0.42,3.78}},
          color={0,140,72},
          thickness=0.5),
    Line( origin={0,-40},
          points={{-80,0},{80,0}},
          color={0,140,72},
          thickness=0.5)},                                                                          coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Documentation(info=""));
end JunctionY;
