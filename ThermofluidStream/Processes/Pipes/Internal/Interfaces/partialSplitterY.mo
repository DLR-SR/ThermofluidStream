within ThermofluidStream.Processes.Pipes.Internal.Interfaces;
partial model partialSplitterY "Duplicate of SplitterM considering dynamic effects"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation(choicesAllMatching = true, Dialog(gruop = "Medium"), Documentation(info = "<html>
          <p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
          </html>"));
  parameter ThermofluidStream.Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation(Dialog(tab = "Advanced"));

  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium = Medium) "Inlet"
    annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}}), iconTransformation(extent = {{-120, -20}, {-80, 20}})));
  ThermofluidStream.Interfaces.Outlet outlet_straight(redeclare package Medium = Medium) "Straight outlet"
    annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermofluidStream.Interfaces.Outlet outlet_branching(redeclare package Medium = Medium) "Branching outlet"
    annotation(Placement(visible = true, transformation(origin = {60, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 45), iconTransformation(origin = {66, 86}, extent = {{-20, -20}, {20, 20}}, rotation = 45)));

  // change of static pressure due to change of velocity
  SI.Pressure dq_straight "Dynamic pressure difference in straight outlet";
  SI.Pressure dq_branching "Dynamic pressure difference in branching outlet";
  //delta = out - in;
  //protected
  // Inlet state quantities
  SI.Pressure p_in = Medium.pressure(inlet.state) "Inlet pressure";
  SI.Velocity c_in "Inlet velocity";
  SI.SpecificEnthalpy h_in = Medium.specificEnthalpy(inlet.state) "Inlet enthalpy";
  Medium.MassFraction Xi_in[Medium.nXi] = Medium.massFraction(inlet.state) "Inlet mass fractions";
  // Outlet state quantities
  SI.Pressure p_straight "Outlet A pressure";
  SI.Velocity c_straight "Outlet A velocity";
  SI.Pressure p_branching "Outlet B pressure";
  SI.Velocity c_branching "Outlet B velocity";
  SI.SpecificEnthalpy h_out "Outlet enthalpy";
  Medium.MassFraction Xi_out[Medium.nXi] "Outlet mass fractions";
  // Pressure loss
  SI.Pressure dp_straight "Static pressure difference in straight outlet";
  SI.Pressure dp_branching "Static pressure difference in branching outlet";
  SI.Pressure r_mix;
equation
  // Inertial pressure calculation from ThermofluidStream
  der(inlet.m_flow)*L = inlet.r - r_mix;
  der(outlet_straight.m_flow)*L = outlet_straight.r - r_mix;
  der(outlet_branching.m_flow)*L = outlet_branching.r - r_mix;
  // Conservation of energy
  dq_straight = Medium.density(inlet.state)/2*(c_in^2 - c_straight^2);
  dq_branching = Medium.density(inlet.state)/2*(c_in^2 - c_branching^2);
  // Thermodynamic state porperties at outlet
  h_out = h_in;
  Xi_out = Xi_in;
  p_straight = p_in + dq_straight + dp_straight;
  p_branching = p_in + dq_branching + dp_branching;
  outlet_straight.state = Medium.setState_phX(p_straight, h_out, Xi_out);
  outlet_branching.state = Medium.setState_phX(p_branching, h_out, Xi_out);
  // Conservation of mass
  outlet_straight.m_flow + outlet_branching.m_flow + inlet.m_flow = 0;
  annotation (
    preserveAspectRatio = true,
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(preserveAspectRatio = true)),
    Documentation(info="<html><head></head><body>Adaption of <a href=\"modelica://ThermofluidStream.Topology.SplitterN\">SplitterN</a> from ThermofluidStream. The outlets vector is replaced with two independent outlets and Bernuolli's principle (change of static pressure due to change of velocity <b>dq</b>) as well as pressure loss variables <b>dp</b> for each branch ( pressure loss of branch and straight channel are computed in the extending model ) are added.<div>From those changes in static pressures each outlet state is defined.<div>Additional equations:</div><div><ul><li>Conservation of energy:</li></ul></div><div>
<pre style=\"margin-top: 0px; margin-bottom: 0px;\"><!--StartFragment--><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  dq_A = Medium.</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#0000ff;\">density</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">(inlet.state)/</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">*(c_in^</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\"> - c_outA^</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">);</span></pre>
<pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  dq_B = Medium.</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#0000ff;\">density</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">(inlet.state)/</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">*(c_in^</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\"> - c_outB^</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#8b008b;\">2</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">);</span><!--EndFragment--></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><p></p><ul><li><font face=\"-webkit-standard\"><span style=\"white-space: normal;\">Outlet pressure</span></font></li></ul><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><!--StartFragment--><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  p_outA = p_in + dq_A + dp_A;</span></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  p_outB = p_in + dq_B + dp_B;</span><!--EndFragment--></pre><ul><li><font face=\"-webkit-standard\"><span style=\"white-space: normal;\">Definition of outlet state:</span></font></li></ul><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><!--StartFragment--><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  outletA.state = Medium.</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#0000ff;\">setState_phX</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">(p_outA, h_out, Xi_out);</span></pre><pre style=\"margin-top: 0px; margin-bottom: 0px;\"><span style=\"font-family: 'Courier New'; font-size: 12pt;\">  outletB.state = Medium.</span><span style=\" font-family:'Courier New'; font-size:12pt; color:#0000ff;\">setState_phX</span><span style=\"font-family: 'Courier New'; font-size: 12pt;\">(p_outB, h_out, Xi_out);</span><!--EndFragment--></pre><p></p></pre></div><div><br></div><div>This partial model is base for Y-shaped splitter models. For implementation of other splitter configurations it is suggested to copy the code and adjust the icon positioning as needed.</div><div><em><br></em></div><div><em>[P. Jordan; HTWG Konstanz; 01/24]</em><p></p><p>
  <img src=\"modelica://Fluid_HTWG/Resources/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"175\" height=\"50\">
  </p></div></div></body></html>"));
end partialSplitterY;
