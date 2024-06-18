within ThermofluidStream.Processes.Pipes;
model EdgedOrifice "Pressure drop due to sharp edged orifice using Modelica.Fluid.Dissipation.PressureLoss.Orifice"

  extends ThermofluidStream.Interfaces.SISOFlow(final L = if computeL then l_0/(d_0^2*pi/4) else L_value, final clip_p_out = true);

  //Geometry
  parameter SI.Length d_1 "Perimeter of pipe"
    annotation(Dialog(group="Geometry"));
  parameter SI.Length d_0 "Perimeter of vena contraction"
    annotation(Dialog(group="Geometry"));
  parameter SI.Length l_0 "Length of vena contraction"
    annotation(Dialog(group="Geometry"));

  // parameter Fluid_HTWG.Types.DarcyFrictionFactor lambda_fric=0.02 "Darcy fricition factor at vena contraction";
  //Initalization
  parameter ThermofluidStream.Utilities.Types.InitializationMethods initdp = ThermofluidStream.Utilities.Types.InitializationMethods.none "Initialization method for dp"
    annotation(Dialog(tab = "Initialization", group = "dp"),choicesAllMatching = true);
  parameter SI.Pressure dp_0 = 0 "Initial value for dp" annotation (
    Dialog(tab = "Initialization", group = "dp", enable = (initdp == ThermofluidStream.Utilities.Types.InitializationMethods.state)));
  parameter ThermofluidStream.Utilities.Units.MassFlowAcceleration dp_acceleraton_0 = 0 "Initial value for der(dp)"
    annotation(Dialog(tab = "Initialization", group = "dp", enable = (initdp == ThermofluidStream.Utilities.Types.InitializationMethods.derivative)));
  parameter SI.Pressure dp_smooth = 1 "Start linearisation for decreasing pressure loss"
    annotation(Dialog(tab = "Initalization"));
  //Advanced
  parameter Boolean computeL = true "= true, if inertance L is computed from the geometry"
    annotation(Dialog(tab="Advanced",group="Inertance"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter ThermofluidStream.Utilities.Units.Inertance L_value = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced",group="Inertance", enable=not computeL));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimal input density"
    annotation(Dialog(tab = "Advanced"));
  parameter Boolean assumeConstantMaterialProperties=true "= true, if constant density and dynamic viscosity is assumed (use '= false' e.g. for Ma > 0.3)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

  SI.Density rho "Mean density";
  SI.DynamicViscosity mu "Mean dynamic viscosity";
  final parameter Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con In_con(
    A_0=A_0,
    C_0=d_0,
    A_1=A_1,
    C_1=d_1,
    L=l_0,
    dp_smooth=dp_smooth) "Input record constants";
  Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var In_var(eta=mu, rho=rho) "Input record variables";
  SI.ReynoldsNumber Re = d_0*abs(m_flow)/A_0/mu "Reynoldsnumber at vena contraction";
protected
  final parameter Modelica.Units.SI.Area A_0 = pi/4*d_0^2 "Cross-sectional area of vena contraction";
  final parameter Modelica.Units.SI.Area A_1 = pi/4*d_1^2 "Cross-sectional area of pipe";

  SI.Density rho_in = max(rho_min, Medium.density(inlet.state)) "Inlet density";
  SI.Density rho_out = if assumeConstantMaterialProperties then rho_in else max(rho_min, Medium.density(outlet.state)) "Outlet density";

  SI.DynamicViscosity mu_in = Medium.dynamicViscosity(inlet.state) "Inlet dynamic viscosity";
  SI.DynamicViscosity mu_out = if assumeConstantMaterialProperties then mu_in else Medium.dynamicViscosity(outlet.state) "Outlet dynamic viscosity";
equation
  // Computation of mean dynamic viscosity and mean density
  mu = (mu_in + mu_out)/2;
  rho = (rho_in + rho_out)/2;
  // - lambda_fric*l_0/(d_0/Modelica.Constants.pi)*rho/2*(m_flow/(rho*A_0))^2
  dp =  - Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP(
    In_con,
    In_var,
    m_flow);
  h_out = h_in;
  Xi_out = Xi_in;
  assert(Re > 1e3, "Reynolds number is below valid flow regime. Simulation results might be incorrect!", AssertionLevel.warning);
  assert(0.0149 <= l_0/d_0 and l_0/d_0 <= 15, "Ratio of vena length l_0 and perimeter at vena is outside valid range. Simulation results might be incorrect!", AssertionLevel.warning);
  annotation (
    defaultComponentName = "edged_orifice",
    Documentation(info=""),
    Icon(coordinateSystem(preserveAspectRatio=true, extent = {{-100, -100}, {100, 100}}), graphics={
      Text(visible=displayInstanceName,
          extent={{-150,110},{150,70}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
      Line(
          points={{-80,50},{-10,50},{10,50},{80,50}},
          color={0,140,72},
          thickness=0.5),
      Line(
          points={{-80,-50},{80,-50}},
          color={0,140,72},
          thickness=0.5),
      Polygon(
          lineColor={0,140,72},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid,
          points={{-80,40},{-80,-40},{-10,-40},{-10,-15},{10,-15},{10,-40},{80,-40},{80,40},{10,40},{10,15},{-10,15},{-10,
              40},{-80,40}})}));
end EdgedOrifice;
