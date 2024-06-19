within ThermofluidStream.Processes.Pipes;
model SplitterY "Pressure drop of an Y-shaped splitter"

  extends Interfaces.partialSplitterY;

  // Geometry
  parameter SI.Length d_in "(Common) inlet diameter"
    annotation(Dialog(group = "Geometry"));
  parameter SI.Length d_branching "Branching outlet diameter"
    annotation(Dialog(group = "Geometry"));
  parameter SI.Angle alpha "Branching angle"
    annotation(Dialog(group = "Geometry"));
  parameter Boolean Y_type1 = true "= true, if A_straight_outlet = A_in, (= false, if A_straight_outlet = A_in -  A_branching"
    annotation(Dialog(group = "Geometry"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean assumeConstantDensity=true "= true, if incompressibility is assumed (use '= false' for Ma > 0.3)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

  final parameter SI.Area A_in = pi/4*d_in^2 "Common inlet cross-sectional area";
  final parameter SI.Area A_branching = pi/4*d_branching^2 "Branching outlet cross-sectional area";
  final parameter SI.Area A_straight = if Y_type1 then A_in else A_in - A_branching  "Straight outlet cross sectional area";
  parameter SI.Velocity eps(min=0) = Modelica.Constants.eps "To avoid division by zero";
  SI.Pressure DP_straight "Pressure loss of straight outlet (-dp_straight)";
  SI.Pressure DP_branching "Pressure loss of branching outlet (-dp_branching)";
  Internal.Types.PressureLossCoefficient zeta_straight "Pressure loss coefficient of straight outlet";
  Internal.Types.PressureLossCoefficient zeta_branching "Pressure loss coefficient of branching outlet";
  // Real c_bc = if abs(c_in) > eps then abs(c_branching/c_in) else 0 "Velocity ratio (branching outlet)/(common inlet)";
  // Real c_sc = if abs(c_in) > eps then abs(c_straight/c_in) else 0 "Velocity ratio (straight outlet)/(common inlet)";
  Real A_sc = A_straight/A_in "Area ratio straight/common inlet";
protected
  SI.Density rho_in = Medium.density(inlet.state) "Inlet density";
  SI.Density rho_straight = if assumeConstantDensity then rho_in else Medium.density(outlet_straight.state) "Inlet density";
  SI.Density rho_branching = if assumeConstantDensity then rho_in else Medium.density(outlet_branching.state) "Inlet density";
  Real alpha_deg = alpha*180/pi "Branching angle (in deg)";
  // Table of correction factor K_b_prime for dependency of pressure loss at branching pipe zeta_branch on branching angle alpha
  Modelica.Blocks.Tables.CombiTable1Ds K_b(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1, table = [0, 0.03; 15, 0.04; 30, 0.16; 45, 0.36; 60, 0.64; 90, 1; 95, 1])
    annotation(Placement(visible = true, transformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // Table of correction factor k for dependency of pressure loss in straight pipe zeta_main on area ratio A_relsc
  Modelica.Blocks.Tables.CombiTable1Ds K(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1, table = [0.1, 1; 0.2, 1; 0.3, 1; 0.4, 1; 0.5, 1.158; 0.6, 1.0847; 0.7, 1.0488; 0.8, 1.02; 0.9, 1; 1, 1])
    annotation(Placement(visible = true, transformation(origin = {70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  // Distinction between type 1 and type 2 splitter
  if Y_type1 then
    (DP_branching,DP_straight,zeta_branching,zeta_straight) =BaseClasses.PressureLoss.Splitter.dp_SplitterWyeType1_DP(
      w_c=c_in,
      w_b=c_branching,
      w_s=c_straight,
      alpha=alpha,
      rho=rho_in,
      eps=eps);
    // pressure loss function of type 1
  else
    (DP_branching,DP_straight,zeta_branching,zeta_straight) =BaseClasses.PressureLoss.Splitter.dp_SplitterWyeType2_DP(
      w_c=c_in,
      w_b=c_branching,
      w_s=c_straight,
      alpha=alpha,
      rho=rho_in,
      k=K.y[1],
      K_b_prime=K_b.y[1],
      eps=eps);
    // pressure loss function of type 2
  end if;
  //connecting branching angle [°] and look-up table K_b_prime
  K_b.u = alpha_deg;

  //connecting area ratio and look-up table k
  K.u = A_sc;

  c_in = abs(inlet.m_flow)/(A_in*rho_in);
  c_straight = abs(outlet_straight.m_flow)/(A_straight*rho_straight);
  c_branching = abs(outlet_branching.m_flow)/(A_branching*rho_branching);

  DP_straight = -dp_straight;
  DP_branching = -dp_branching;

  assert(inlet.m_flow >= 0, "Negative mass flow rate at splitter inlet!", AssertionLevel.warning);
  assert(outlet_straight.m_flow <= 0, "Positiv mass flow rate at splitter outletA!", AssertionLevel.warning);
  assert(outlet_branching.m_flow <= 0, "Positiv mass flow rate at splitter outletB!", AssertionLevel.warning);
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
          points={{-80,5},{-20,5},{36,61},{66,31},{40,5},{80,5},{80,-55},{-80,-55},{-80,5}}),
    Line( origin={-24.79,65.21},
          points={{-55.2071,-25.2071},{4.79289,-25.2071},{54.7929,24.7929}},
          color={0,140,72},
          thickness=0.5),
    Line( origin={70.15,46.21},
          points={{9.85355,-6.20711},{-10.1464,-6.20711},{1.85355,5.79289}},
          color={0,140,72},
          thickness=0.5),
    Line( origin={0,-40},
          points={{-80,0},{80,0}},
          color={0,140,72},
          thickness=0.5)},                                                                          coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Documentation(info="<html>
<p>
This component models a <strong>Y-shaped Splitter</strong>. It computes the pressure loss of the fluid depending on the massflow rate or the massflow rate depending on a given pressure difference, 
some medium properties and the geometry of the Splitter. The component is valid for <strong>compressible calculation</strong> of <strong>one phase medium </strong> and <strong>branching angles from 15°-90°</strong>. 
This model is a <strong>splitter</strong> component only. Therfore flows <strong>contrary</strong> to the intended flow direction immediatly mean <strong>inccorect results</strong> and can lead to the 
<strong>model crashing</strong>. The model is used best with <strong>two given mass flow rates</strong> and <strong>one pressure boundary</strong> and <strong>steady state</strong> or 
<strong>slowly changing</strong> boundary conditions. If two pressure buondaries are used be careful to prevent back flow into the component.
</p>

<p>
The Y-Splitter component is extending the partial model <a href=\"modelica://ThermofluidStream.Processes.Pipes.Interfaces.partialSplitterY\">partialSplitterY</a> implementing the common flow balances 
for fluid splitting components. For the pressure loss calculation the functions 
<a href=\"modelica://ThermofluidStream.Processes.Pipes.BaseClasses.PressureLoss.Splitter.dp_SplitterWyeType1_DP\">dp_SplitterWyeType1_DP</a> and 
<a href=\"modelica://ThermofluidStream.Processes.Pipes.BaseClasses.PressureLoss.Splitter.dp_SplitterWyeType2_DP\">dp_SplitterWyeType2_DP</a> are used <strong>depending on the users geometry input</strong>.
See their documentation for a detailed description on the pressure loss calculation and figuers containing pressure loss coefficieint charts.
</p>

<p>
<strong>PLEASE NOTE:</strong> Those functions are based on the formulas and data provided in \"Handbook of Hydraulic Resistance\" by Idel'chik (<strong>1960</strong>). 
Be aware that <strong>the book has been updated</strong> since then. Those functions calculate and feed back the pressure loss at each channel as well as the pressure loss coefficient with respect to the velocity 
in the common channel (inlet section). For more information on the pressure loss function <a href=\"modelica://ThermofluidStream.Processes.Pipes.BaseClasses.PressureLoss.Splitter\">click here</a>.
</p>

<p>
The different types of splitter geometry are defined as described in Idelchik (1960) where:
</p>

<ul>
<li>Type I: Fb + Fs &gt; Fc and Fc = Fs \"straight pipe with attached pipe branch\"</li>
<li>Type II: Fb + Fs = Fc \"straight pipe splitting in two smaller branches, whereby the inlet and total outlet area remain the same\"</li>
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
end SplitterY;
