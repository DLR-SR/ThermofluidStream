within ThermofluidStream.Processes.Pipes;
model JunctionY "Pressure drop of an Y-shaped junction"

  extends Interfaces.partialJunctionY;

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
    (DP_branching,DP_straight,zeta_branching,zeta_straight) =BaseClasses.PressureLoss.Junction.dp_JunctionWyeType1_DP(
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
    (DP_branching,DP_straight,zeta_branching,zeta_straight) =BaseClasses.PressureLoss.Junction.dp_JunctionWyeType2_DP(
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
    Documentation(info="<html>
<p>
This component models a <strong>Y-shaped Junction</strong>. It computes the <strong>pressure loss</strong> of the fluid depending on the massflow rate or the massflow rate depending on a given pressure difference,
some medium properties and the geometry of the Junction. In addition, the thermodynamic state resulting from mixing of the two fluid flow of possibly differnt states is determined. 
It is not possible to mix different media models. The component is valid for <strong>compressible calculation</strong> of <strong>one phase media</strong> and <strong>branching angles from 15°-90°</strong>. 
This model is a <strong>junction</strong> component only. Therfore flows <strong>contrary</strong> to the intended flow direction immediatly mean <strong>inccorect results</strong> and can lead to the 
<strong>model crashing</strong>. The model is used best with <strong>two given mass flow rates, one pressure boundary and steady state or slowly changing buondary conditions</strong>. 
If two pressure boundaries are used, be careful to prevent back flow into the component.
</p>

<p>
The Y-Junction component is extending the partial model <a href=\"modelica://ThermofluidStream.Processes.Pipes.Interfaces.partialJunctionY\">partialJunctionY</a> implementing the common flow balances 
for fluid merging components. For the pressure loss calculation the functions <a href=\"modelica://ThermofluidStream.Processes.Pipes.BaseClasses.PressureLoss.Junction.dp_JunctionWyeType1_DP\">dp_SplitterWyeType1_DP</a>
and <a href=\"modelica://ThermofluidStream.Processes.Pipes.BaseClasses.PressureLoss.Junction.dp_JunctionWyeType1_DP\">dp_JunctionWyeType2_DP</a> are used <strong>depending on the users geometry input</strong>.
See their documentation for a detailed description on the pressure loss calculation an figuers containing pressure loss coefficieint charts.
</p>

<p>
<strong>PLEASE NOTE:</strong> Those functions are based on the formulas and data provided in \"Handbook of Hydraulic Resistance\" by Idel'chik (<strong>1960</strong>). 
Be aware that there <strong>the book has been updated</strong> since then. Those functions calculate and feed back the pressure loss at each channel as well as the pressure loss coefficient with respect 
to the velocity in the common channel (outlet section). For more information on the pressure loss function <a href=\"modelica://ThermofluidStream.Processes.Pipes.BaseClasses.PressureLoss.Junction\">click here</a>.
</p>

<p>
The different types of splitter geometry are defined as described in Idelchik (1960) where:
</p>

<ul>
<li>Type I: Fb + Fs &gt; Fc and Fc = Fs \"straight pipe with attached pipe branch\"</li>
<li> Type II: Fb + Fs = Fc \"two smaller branches merging into a straight pipe, whereby the total inlet and outlet area remains the same\"</li>
</ul>

<p>
Sketches of both splitter types are shown in <strong>Fig. 1</strong>. (Currently not yet available)
</p>

<p>
<em>[P. Jordan; HTWG Konstanz; 01/24]</em>
</p>

<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"350\" height=\"100\">
</p>

</html>"));
end JunctionY;
