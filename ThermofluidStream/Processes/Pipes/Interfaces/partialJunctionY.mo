within ThermofluidStream.Processes.Pipes.Interfaces;
partial model partialJunctionY "Duplicate of JunctionN considering dynamic effects"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (
    choicesAllMatching = true,
    Documentation(info = "<html>
          <p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
          </html>"));
  parameter Boolean assumeConstantDensity = true "= true, if mixture states are determined by mass flow rates"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.MassFlowRate m_flow_eps = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
    annotation(Dialog(tab = "Advanced"));
  parameter ThermofluidStream.Utilities.Units.Inertance L = dropOfCommons.L "Inertance on each Branch of Component"
    annotation(Dialog(tab = "Advanced"));

  ThermofluidStream.Interfaces.Outlet outlet(redeclare package Medium = Medium) "Outlet"
    annotation(Placement(transformation(extent = {{80, -20}, {120, 20}}), iconTransformation(extent = {{80, -20}, {120, 20}})));
  ThermofluidStream.Interfaces.Inlet inlet_straight(redeclare package Medium = Medium) "Inlet A"
    annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermofluidStream.Interfaces.Inlet inlet_branching(redeclare package Medium = Medium) "Inlet B"
    annotation(Placement(visible = true, transformation(origin = {-60, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -45), iconTransformation(origin = {-60, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -45)));

  // these are needed by DynamicJunctionN
  Real w_straight(unit = "1") "Regularized weighting factor for specific enthalpy inlet straight";
  Real w_branching(unit = "1") "Regularized weighting factor for specific enthalpy inlet branching";

  SI.Density rho_straight = Medium.density(inlet_straight.state) "Density at straight inlet";
  SI.Density rho_branching = Medium.density(inlet_branching.state) "Density at branching inlet";
  SI.Density rho[2] = {rho_straight, rho_branching} "Density at inlet [straight branching]";

  Real w[2] = {w_straight, w_branching} "Regularized weighting factor for specific enthalpy";

  SI.Pressure p_in_straight = Medium.pressure(inlet_straight.state) "(steady mass-flow) pressure straight inlet";
  SI.Pressure p_in_branching = Medium.pressure(inlet_branching.state) "(steady mass-flow) pressure branching inlet";

  SI.Pressure p_straight "Total pressure straight inlet";
  SI.Pressure p_branching "Total pressure branching inlet";
  SI.Pressure p[2] = {p_straight, p_branching} "Total pressure inlets [straight branching]";

  SI.Pressure dq_straight "Dynamic pressure difference straight inlet - outlet";
  SI.Pressure dq_branching "Dynamic pressure difference straight inlet - outlet";

  SI.Pressure dp_straight "Pressure difference straight inlet - outlet";
  SI.Pressure dp_branching "Pressure difference branching inlet - outlet";
  SI.Pressure dp[2] = {dp_straight, dp_branching} "Pressure differences inlets [straight branching]";

  SI.SpecificEnthalpy h_straight = Medium.specificEnthalpy(inlet_straight.state) "Specific enthapy inlet straight";
  SI.SpecificEnthalpy h_branching = Medium.specificEnthalpy(inlet_branching.state) "Specific enthapy inlet branching";
  SI.SpecificEnthalpy h[2] = {h_straight, h_branching} "Specific enthapy inlets [straight branching]";
  SI.SpecificEnthalpy h_mix "Outlet specific enthalpy";

  Medium.MassFraction Xi[Medium.nXi, 2] "Mass factions inlets [straight branching]";
  Medium.MassFraction Xi_mix[Medium.nXi] "Mass fractions outlet";

  SI.Pressure p_mix "Outlet (steady mass-flow) pressure";
  SI.Pressure r_mix "Outlet inertial pressure";

  SI.Velocity c_straight "Velocity straight inlet";
  SI.Velocity c_branching "Velocity branching inlet";
  SI.Velocity c_mix "Velocity outlet";

  Real w2_straight(unit = "1") "Regularized weighting factor for steady mass flow pressure (straight inlet)";
  Real w2_branching(unit = "1") "Regularized weighting factor for steady mass flow pressure (branching inlet)";
  Real w2[2] = {w2_straight, w2_branching} "Regularized weighting factor for steady mass flow pressure [straight branching]";

  SI.Pressure r_in[2] "Inertal pressure inlet [straight branching]";

  function mfk = ThermofluidStream.Utilities.Functions.massFractionK(redeclare package Medium = Medium);

equation
  inlet_straight.m_flow + inlet_branching.m_flow + outlet.m_flow = 0;
  der(inlet_straight.m_flow)*L = inlet_straight.r - r_in[1];
  der(inlet_branching.m_flow)*L = inlet_branching.r - r_in[2];
  // OM_WORKAROUND
  for j in 1:Medium.nXi loop
    Xi[j, 1] = mfk(inlet_straight.state, j);
  end for;
  for j in 1:Medium.nXi loop
    Xi[j, 2] = mfk(inlet_straight.state, j);
  end for;
  //instead of
  /* Xi[:,i] = Medium.massFraction(inlets[i].state); */
  p_straight = p_in_straight + dp_straight + dq_straight;
  p_branching = p_in_branching  + dp_branching + dq_branching;
  p_straight + r_in[1] = p_mix + r_mix;
  p_branching + r_in[2] = p_mix + r_mix;
  dq_straight = Medium.density(inlet_straight.state)/2*(c_straight^2 - c_mix^2);
  dq_branching = Medium.density(inlet_branching.state)/2*(c_branching^2 - c_mix^2);
  w_straight = (abs(inlet_straight.m_flow) + m_flow_eps)/(abs(inlet_straight.m_flow) + abs(inlet_branching.m_flow) + 2*m_flow_eps);
  w_branching = (abs(inlet_branching.m_flow) + m_flow_eps)/(abs(inlet_straight.m_flow) + abs(inlet_branching.m_flow) + 2*m_flow_eps);
  w2[1] = ((abs(inlet_straight.m_flow) + m_flow_eps)/rho[1])/((abs(inlet_straight.m_flow) + m_flow_eps)/rho[1] + (abs(inlet_branching.m_flow) + m_flow_eps)/rho[2]);
  w2[2] = ((abs(inlet_branching.m_flow) + m_flow_eps)/rho[2])/((abs(inlet_straight.m_flow) + m_flow_eps)/rho[1] + (abs(inlet_branching.m_flow) + m_flow_eps)/rho[2]);
  der(outlet.m_flow)*L = outlet.r - r_mix;
  h_mix = w_straight*h_straight + w_branching*h_branching;
  //sum(w.*h);
  Xi_mix = Xi*w;
  if not assumeConstantDensity then
    p_mix = sum(w2.*(p));
  else
    p_mix = sum(w.*(p));
  end if;
  outlet.state = Medium.setState_phX(p_mix, h_mix, Xi_mix);
  annotation (
    preserveAspectRatio = true,
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(preserveAspectRatio = true)),
    Documentation(info="<html>
<p>
Extension of <a href=\"ThermofluidStream.Topology.JunctionN\">JunctionN</a>. The inlets vector is replaced with two independent inlets and Bernuolli's principle 
(change of static pressure due to change of velocity <code>dq</code>) as well as pressure loss variables <code>dp</code> for each branch (pressure loss of branch and straight channel are computed in the 
extending model) are added.
</p>

<p>
Each inlet pressure <code>p_in</code> and the associated pressure changes <code>dp</code> and <code>dq</code> are added together and equated with the mixing pressure and the inertial pressure used by
ThermofluidStream.
</p>

<p>
The other state properties mass fraction and specific enthalpy are massflow averaged and defined as outlet state quantities as well.
</p>

<p>
For implementation of other junction configurations it is suggested to copy the code and adjust the icon positioning as needed.
</p>

<p>
<em>[P. Jordan; HTWG Konstanz; 01/24]</em>
</p>

<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"350\" height=\"100\">
</p>
</html>"));
end partialJunctionY;
