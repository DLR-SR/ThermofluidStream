within ThermofluidStream.Processes.Pipes;
model EdgedBend "Pressure drop due to edged bend using Modelica.Fluid.Dissipation.PressureLoss.Bend"

  extends Interfaces.SISOFlowBend(         final L=if computeL then (10*d/(d^2*pi/4)) else L_value, final clip_p_out=
        true);

  //Geometry
  parameter SI.Length d "Diameter"
    annotation(Dialog(group="Geometry"));
  parameter SI.Angle delta "Bending angle (5° <= delta <= 180°)"
    annotation(Dialog(group="Geometry"));
  parameter ThermofluidStream.Processes.Internal.Material material = ThermofluidStream.Processes.Internal.Material.other "Material of pipe"
    annotation(Dialog(group="Roughness"));
  parameter SI.Length ks "Roughness of pipe"
    annotation(Dialog(group="Roughness"),enable = material == ThermofluidStream.Processes.Internal.Material.other);
  //Initialization
  parameter StateSelect dpStateSelect = StateSelect.default "State select for pressure difference dp"
    annotation(Dialog(tab = "Advanced"));
  parameter ThermofluidStream.Utilities.Types.InitializationMethods initdp = ThermofluidStream.Utilities.Types.InitializationMethods.none "Initialization method for pressure difference dp"
    annotation(Dialog(tab = "Initialization", group = "Pressure difference"),choicesAllMatching = true);
  parameter SI.Pressure dp_0 = 0 "Initial value for pressure difference dp"
    annotation(Dialog(tab = "Initialization", group = "Pressure difference", enable = (initdp == ThermofluidStream.Utilities.Types.InitializationMethods.state)));
  parameter ThermofluidStream.Utilities.Units.MassFlowAcceleration dp_acceleraton_0 = 0 "Initial value for der(dp)"
    annotation(Dialog(tab = "Initialization", group = "Pressure difference", enable = (initdp == ThermofluidStream.Utilities.Types.InitializationMethods.derivative)));
  // no default value to require the modeler to think about it; use final to suppress this option to user
  //Advanced
  parameter ThermofluidStream.Utilities.Units.Inertance L_value = dropOfCommons.L "Inertance"
    annotation(Dialog(tab = "Advanced", enable = not computeL));
  parameter Boolean computeL = true "Compute L from r and l"
    annotation(Dialog(tab = "Advanced"));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimal density"
    annotation (Dialog(tab = "Advanced"));
  parameter Boolean assumeConstantMaterialProperties=true "= true, if constant density and dynamic viscosity is assumed (use '= false' e.g. for Ma > 0.3)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

  SI.Density rho "Mean density";
  SI.DynamicViscosity mu "Mean dynamic viscosity";
protected
  SI.Density rho_in = max(rho_min, Medium.density(inlet.state)) "Inlet density";
  SI.Density rho_out = if assumeConstantMaterialProperties then rho_in else max(rho_min, Medium.density(outlet.state)) "Outlet density";
  SI.DynamicViscosity mu_in = Medium.dynamicViscosity(inlet.state) "Inlet dynamic viscosity";
  SI.DynamicViscosity mu_out = if assumeConstantMaterialProperties then mu_in else Medium.dynamicViscosity(outlet.state) "Outlet dynamic viscosity";
  final parameter SI.Length ks_internal=
   if material == ThermofluidStream.Processes.Internal.Material.concrete then 5e-3
   elseif material == ThermofluidStream.Processes.Internal.Material.wood then 0.5e-3
   elseif material == ThermofluidStream.Processes.Internal.Material.castIron then 0.25e-3
   elseif material == ThermofluidStream.Processes.Internal.Material.galvanizedIron then 0.15e-3
   elseif material == ThermofluidStream.Processes.Internal.Material.steel then 0.059e-3
   elseif material == ThermofluidStream.Processes.Internal.Material.drawnPipe then 0.0015e-3
   else ks "Pipe roughness";

  final parameter Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con In_con(
    d_hyd=d,
    delta=delta,
    K=ks_internal) "Input record constants";
  Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var In_var(eta=mu, rho=rho) "Input record variables";
equation
  // Computation of mean dynamic viscosity and mean density
  mu = (mu_in + mu_out)/2;
  rho = (rho_in + rho_out)/2;
  -dp = Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP(
    In_con,
    In_var,
    m_flow);
  assert(ks_internal < d/2, "Parameter roughness of pipe ks must be less than radius of pipe d/2.");
  assert(5 <= delta*180/pi and delta*180/pi <= 180, "Parameter angle of pipe bend must between boundaries 5° < delta < 180°.");
  h_out = h_in;
  Xi_out = Xi_in;
  annotation (
    Dialog(enable = (material == ThermofluidStream.Processes.Internal.Material.other)),
    choices(choice = ThermofluidStream.Processes.Internal.Material.concrete "Concrete ks=5mm", choice = ThermofluidStream.Processes.Internal.Material.wood "Wood ks=0.5mm", choice = ThermofluidStream.Processes.Internal.Material.castIron "Cast Iron ks=0.25mm", choice = ThermofluidStream.Processes.Internal.Material.galvanizedIron "Galvanized Iron ks=0.15mm", choice = ThermofluidStream.Processes.Internal.Material.steel "Steel ks=0.059mm", choice = ThermofluidStream.Processes.Internal.Material.drawnPipe "Drawn Pipe ks=0.0015mm"),
    Documentation(info="<html>
<p>
This pipe bend model computes the pressure loss of the fluid depending on the massflow or the massflow depending on a given pressure difference, some medium properties and the geometry of the pipe bend.
</p>

<p>
The pressure loss of the model refers to a <strong>flowpath length l = 5*d_hyd upstream as well as downstream of the edge</strong>. If the adjacent components are pipes, these must be adjusted accordingly.
</p>

<p>
Note that the <strong>results may differ from actual values</strong>. Due to <strong>complex flow behavior in pipe bends, widely applicable formulas are approximations only</strong>. If the pressure drop 
coefficient of a real component is known, it is recommended to <strong>calibrate the model</strong> to this value <strong>using the roughness parameter</strong>.
</p>

<p>
This component is an adaptation of <a href=\"modelica://Modelica.Fluid.Fittings.Bends.EdgedBend\">EdgedBend</a> by Modelica to make it compatible with ThermofludiStream library.
</p>

<p>
The model is usable for <strong>both incompressible and compressible calculation</strong> up to at least Ma 0.3 at pipe outlet and <strong>one phase medium</strong>. The best performance is achieved 
when using <strong>steady state</strong> or slowly changing boundary conditions. Numerical stability is best by <strong>given mass flow rate and one given pressure boundary</strong>. 
When using <strong>two pressure boundaries</strong> deviations due to inertia have to be accepted. The Model is <strong> not valid for hydraulic shock calculation</strong> (sudden change of pressure or 
mass flow rate).
</p>

<p>
The pipe bend component is using the partial model <a href=\"modelica://ThermofluidStream.Processes.Pipes.Interfaces.SISOFlowBend\">SISOFlowBend</a> implementing the common flow balances.  For the 
calculation of pressure loss the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.edgedOverall_DP\">dp_edgedOverall_DP</a> by Modelica is implemented. The input records 
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con\">dp_edgedOverall_IN_con</a> &amp; 
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var\">dp_edgedOverall_IN_var</a> are overwritten with the input parameters defining the pipe bend geometry and fluid properties. 
For more information on the underlying pressure loss function, <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">click here</a>. 
To improve the accuracy when compressible media are used, center state fluid properties (mean dynamic viscosity &amp; mean density) are defined and refered to in the pressure loss function.
</p>

<p>
The following 2 figures, resistance coefficient charts representing the pressure loss model under common conditions are shown. (Currently not yet available)
</p>

<p>
<em>[P. Jordan; HTWG Konstanz; 10/23]</em>
</p>

<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"350\" height=\"100\">
</p>
</html>"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}),
    graphics={
    Text(visible=displayInstanceName,
          extent={{-150,-100},{150,-60}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
    Polygon(fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, lineThickness = 0, points={{-80,40},
              {-40,40},{-40,80},{40,80},{40,-40},{-80,-40},{-80,40}}),
    Line(points={{-80,-30},{30,-30},{30,80}},        color = {26, 95, 180}),
    Line(origin={-20,20},    points = {{-60, -60}, {60, -60}, {60, 60}}, color = {26, 95, 180}, thickness = 0.5),
    Line(origin={-60,60},    points = {{-20, -20}, {20, -20}, {20, 20}}, color = {26, 95, 180}, thickness = 0.5),
    Line(points={{-80,30},{-30,30},{-30,80}},        color = {26, 95, 180}), Line(origin={0,80},    points = {{-30, 0}, {30, 0}}, color = {26, 95, 180}),
    Line(origin={-80,0},    points = {{0, 30}, {0, -30}}, color = {26, 95, 180})}));
end EdgedBend;
