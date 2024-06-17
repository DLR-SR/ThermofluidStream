within ThermofluidStream.Processes.Pipes.Internal.Interfaces;
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
    Documentation(info="<html><head></head><body>Adaption of <a href=\"ThermofluidStream.Topology.JunctionN\">JunctionN</a> from ThermofluidStream. The inlets vector is replaced with two independent inlets and Bernuolli's principle (change of static pressure due to change of velocity <b>dq</b>) as well as pressure loss variables <b>dp</b> for each branch ( pressure loss of branch and straight channel are computed in the extending model ) are added.<div>Each inlet pressure <b>p_in</b> and the associated pressure changes <b>dp</b> and <b>dq</b> are added together and equated with the mixing pressure and the inertial pressure used bei ThermofluidStream.</div><div>The other state properties mass fraction and specific enthalpy are massflow averaged and defined as outlet state quantities as well.</div><div><div>Additional equations:</div><div><ul><li>Conservation of energy:</li></ul></div><div><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><!--StartFragment--><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  dq_A = Medium.</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#0000ff;\">density</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">(inletA.state)/</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">*(c_A^</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\"> - c_mix^</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">);</span></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  dq_B = Medium.</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#0000ff;\">density</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">(inletB.state)/</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">*(c_B^</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\"> - c_mix^</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">);</span><!--EndFragment--></pre></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><!--EndFragment--></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><p></p><ul><li><font face=\"-webkit-standard\"><span style=\"white-space: normal;\">Pressure calculation</span></font></li></ul><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><!--StartFragment--><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  p_A = p_inA + dp_A + dq_A;</span></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  p_B = p_inB + dp_B + dq_B;</span></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  p_A + r_in[</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">1</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">] = p_mix + r_mix;</span></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  p_B + r_in[</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">] = p_mix + r_mix;</span><!--EndFragment--></pre></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><!--EndFragment--></pre><ul><li><font face=\"-webkit-standard\"><span style=\"white-space: normal;\">Definition of outlet state:</span></font></li></ul><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><!--StartFragment--><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  outlet.state = Medium.</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#0000ff;\">setState_phX</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">(p_mix, h_mix, Xi_mix);</span></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt;\"><br></span></pre></pre></div><div>This partial model is base for Y-shaped junction models. For implementation of other junction configurations it is suggested to copy the code and adjust the icon positioning as needed.</div><div><em><br></em></div><div><em>[P. Jordan; HTWG Konstanz; 01/24]</em><p></p><p>
  <img src=\"modelica://Fluid_HTWG/Resources/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"175\" height=\"50\">
  </p></div></div></body></html>"));
end partialJunctionY;
