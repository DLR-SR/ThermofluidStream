within ThermofluidStream.Processes.Pipes;
model Diffuser "Pressure drop of a conical diffusor"

  extends Interfaces.SISOFlow_nonConstArea(         final L=if computeL then ((d_2 - d_1)/tan(alpha/2))/(d_2^2*pi/4)
         else L_value, final clip_p_out=true);

  //Geometry
  parameter SI.Length d_1 "Inlet diameter"
    annotation(Dialog(group="Geometry"));
  parameter SI.Length d_2 "Outlet diameter"
    annotation(Dialog(group="Geometry"));
  parameter Boolean setLength = true "= true, if diffusor length l_par is given (= false, if divergence angle alpha_par is given)"
    annotation(Dialog(group="Geometry"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Length l_par = 0 "Diffusor length"
    annotation(Dialog(group="Geometry",enable=setLength),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Angle alpha_par = 0 "Central divergence angle of diffuser walls"
    annotation(Dialog(group="Geometry",enable = not setLength));
  parameter ThermofluidStream.Processes.Internal.Material material = ThermofluidStream.Processes.Internal.Material.other "Material of pipe"
    annotation(Dialog(group="Roughness"));
  parameter SI.Length ks "Pipe roughness"
    annotation(Dialog(group="Roughness",enable=ThermofluidStream.Processes.Internal.Material.other));
  //Advanced
  parameter ThermofluidStream.Utilities.Units.Inertance L_value = dropOfCommons.L "Inertance of pipe" annotation (
    Dialog(tab = "Advanced", enable = not computeL));
  parameter Boolean computeL = true "Compute L from r and l"
    annotation(Dialog(tab = "Advanced"));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimal input density"
    annotation(Dialog(tab = "Advanced"));
  parameter StateSelect dpStateSelect = StateSelect.default "State select for dp"
    annotation(Dialog(tab = "Advanced"));
  parameter Boolean assumeConstantDensity=true "= true, if incompressibility is assumed (use '= false' for Ma > 0.3)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

  final parameter SI.Angle alpha = if not setLength then alpha_par else 2*atan((d_2-d_1)/2/l_par) "Central divergence angle of diffuser walls";
  final parameter SI.Length l_dif = if not setLength then (d_2 - d_1)/2/tan(alpha/2) else l_par "Diffuser length";

  final parameter SI.Length ks_internal=
    if material == ThermofluidStream.Processes.Internal.Material.concrete then 5e-3
    elseif material == ThermofluidStream.Processes.Internal.Material.wood then 0.5e-3
    elseif material == ThermofluidStream.Processes.Internal.Material.castIron then 0.25e-3
    elseif material == ThermofluidStream.Processes.Internal.Material.galvanizedIron then 0.15e-3
    elseif material == ThermofluidStream.Processes.Internal.Material.steel then  0.059e-3
    elseif material == ThermofluidStream.Processes.Internal.Material.drawnPipe then 0.0015e-3
    else ks "Pipe roughness";

  SI.Density rho "Mean density";
  SI.DynamicViscosity mu "Mean dynamic viscosity";
  SI.ReynoldsNumber Re = d_1*abs(m_flow)/A_1/mu "Reynolds Number";
  Internal.Types.PressureLossCoefficient zeta_dif "Total pressure loss coefficient of diffuser";
  Internal.Types.PressureLossCoefficient zeta_exp "Pressure loss coefficient due to diffuser enlargement";
  Internal.Types.PressureLossCoefficient zeta_fr "Pressure loss coefficient of diffuser due to wall friction";

protected
  SI.Density rho_in = max(rho_min, Medium.density(inlet.state)) "Inlet density";
  SI.Density rho_out = if assumeConstantDensity then rho_in else max(rho_min, Medium.density(outlet.state)) "Outlet density";
  SI.DynamicViscosity mu_in = Medium.dynamicViscosity(inlet.state) "Inlet dynamic viscosity";
  SI.DynamicViscosity mu_out = if assumeConstantDensity then mu_in else Medium.dynamicViscosity(outlet.state) "Outlet dynamic viscosity";

  SI.Pressure DP "Pressure difference (-dp)";

  final parameter SI.Area A_1 = pi/4*d_1^2 "Inlet cross-sectional area";
  final parameter SI.Area A_2 = pi/4*d_2^2 "Outlet cross-sectional area";
  final parameter SI.Length d_mean = 0.5*(d_1 + d_2) "Mean diameter";
  final parameter Real Delta = ks_internal/d_1 "Dimensionless pipe roughness";

equation

  // Computation of mean dynamic viscosity and mean density
  mu = (mu_in + mu_out)/2;
  rho = (rho_in + rho_out)/2;
  // Computation of inlet and outlet velocity
  c_in = m_flow/rho_in/A_1;
  c_out = m_flow/rho_out/A_2;
  // pressure loss ans pressure loss coefficients
  (DP,zeta_dif,zeta_exp,zeta_fr) =BaseClasses.PressureLoss.Diffuser.dp_conicalDiffuserOverall_DP(
    m_flow,
    A_1,
    A_2,
    alpha,
    Delta,
    rho,
    mu);
  dp = -DP;
  h_out = h_in;
  Xi_out = Xi_in;
  assert(m_flow > 0, "Model can not handle negative mass flow through component!", AssertionLevel.warning);
  annotation (
    Documentation(info="<html>
<p>
This component models a <strong>diffuser</strong>. It computes the pressure loss of the fluid depending on the massflow rate or the massflow rate depending on a given pressure difference, some medium properties 
and the geometry of the diffuser. The component is valid for <strong>both incompressible and compressible calculation</strong> up to at least Ma 0.3 at pipe outlet and <strong>one phase medium.</strong>
</p>

<p>
The pipe bend component is using the partial model <a href=\"modelica://ThermofluidStream.Processes.Pipes.Interfaces.SISOFlow_nonConstArea\">SISOFlow_nonConstArea</a> implementing the common flow balances 
for components with non constant cross sectional areas. For the calculation of pressure loss the function 
<a href=\"modelica://Fluid_HTWG.Pipes.BaseClasses.PressureLoss.Diffuser.dp_conicalDiffuserOverall_DP\">dp_conicalDiffuserOverall_DP</a> is used. It is based on the formulas and data provided in 
\"Handbook of Hydraulic Resistance\" by Idel'chik (<strong>1960</strong>). Be aware that there <strong>the book has been updated</strong> since then.
</p>

<p>
The function calculates and feeds back the pressure loss as well as total pressure loss coefficient and the partial pressure loss coefficientes due to diffuser enlargement and wall friction. 
For more information <a href=\"modelica://ThermofluidStream.Processes.Pipes.BaseClasses.PressureLoss.Diffuser.dp_conicalDiffuserOverall_DP\">click here</a>. The functions assumes pressure loss coefficient 
due to diffuser enlargement to be independent from Reynolds Number, constant wall fricition along diffuser length and uniform velocity profile at inlet.
</p>

<p>
To improve the accuracy when compressible media are used, center state fluid properties (mean dynamic viscosity &amp; mean density) are defined and refered to in the pressure loss function.
</p>

<p>
The following figure pressure loss of the diffuser in the described in the figure is shown. (Currently not yet available)     
</p>

<p>
<em>[P. Jordan; HTWG Konstanz; 01/24]</em>
</p>

<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"350\" height=\"100\">
</p>
</html>"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics={
    Text(visible=displayInstanceName,
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
    Line( points={{-80,30},{-60,30},{60,60},{80,60}},
          color={0,140,72},
          thickness=0.5),
    Line( points={{-80,-30},{-60,-30},{60,-60},{80,-60}},
          color={0,140,72},
          thickness=0.5),                                                                                                                                                                                                        Polygon(
          lineColor={0,140,72},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid,
          points={{-80,20},{-80,-20},{-60,-20},{60,-50},{80,-50},{80,50},{60,50},{-60,20},{-80,20}})}));
end Diffuser;
