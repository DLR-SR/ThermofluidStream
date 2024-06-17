within ThermofluidStream.Processes.Pipes.Internal.Interfaces;
partial model SISOFlow_nonConstArea "SISOFlow considering dynamic effects due to different inlet/outlet cross sectional areas"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  import ThermofluidStream.Utilities.Types.InitializationMethods;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (
    choicesAllMatching = true,
    Documentation(info = "<html>
          <p>Medium package used in the Component. Make sure it is the same as the components connected to both ports are using.</p>
            </html>"));
  parameter ThermofluidStream.Utilities.Units.Inertance L = dropOfCommons.L "Inertance of the flow"
    annotation(Dialog(tab = "Advanced"));
  parameter StateSelect m_flowStateSelect = StateSelect.default "State select for m_flow"
    annotation(Dialog(tab = "Advanced"));
  parameter InitializationMethods initM_flow = ThermofluidStream.Utilities.Types.InitializationMethods.none "Initialization method for m_flow"
    annotation(Dialog(tab = "Initialization", group = "Mass flow"), choicesAllMatching = true);
  parameter SI.MassFlowRate m_flow_0 = 0 "Initial value for m_flow"
    annotation(Dialog(tab = "Initialization", group = "Mass flow", enable = (initM_flow == InitializationMethods.state)));
  parameter ThermofluidStream.Utilities.Units.MassFlowAcceleration m_acceleraton_0 = 0 "Initial value for der(m_flow)"
    annotation(Dialog(tab = "Initialization", group = "Mass flow", enable = (initM_flow == InitializationMethods.derivative)));
  // no default value to require the modeler to think about it; use final to suppress this option to user
  parameter Boolean clip_p_out "If false, set dr_corr to zero"
    annotation(Dialog(tab = "Advanced"));
  parameter SI.Pressure p_min = dropOfCommons.p_min "Minimal steady-state output pressure"
    annotation(Dialog(tab = "Advanced", enable = clip_p_out));
  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium = Medium)
    annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}}), iconTransformation(extent = {{-120, -20}, {-80, 20}})));
  ThermofluidStream.Interfaces.Outlet outlet(redeclare package Medium = Medium)
    annotation(Placement(transformation(extent = {{80, -20}, {120, 20}}), iconTransformation(extent = {{80, -20}, {120, 20}})));
  SI.MassFlowRate m_flow(stateSelect = m_flowStateSelect) = inlet.m_flow "mass flow through component";
  // Inlet and outlet velocities
  SI.Velocity c_in "Inlet velocity";
  SI.Velocity c_out "Outlet velocity";
  // changing pressure calculation
  SI.Pressure dr_corr;

  SI.Pressure dp "Static pressure difference dp = p_out - p_in";
  SI.Pressure dq "Dynamic pressure difference dq = q_out - q_in";
  // Inlet state quantities
protected
  SI.Pressure p_in = Medium.pressure(inlet.state) "Inlet pressure";
  SI.SpecificEnthalpy h_in = Medium.specificEnthalpy(inlet.state) "Inlet specific enthaply";
  Medium.MassFraction Xi_in[Medium.nXi] = Medium.massFraction(inlet.state) "Inlet mass fractions";
  // Outlet state quantities
  SI.Pressure p_out "Outlet pressure";
  SI.SpecificEnthalpy h_out "Outlet specific enthaply";
  Medium.MassFraction Xi_out[Medium.nXi] "Outlet mass fractions";
initial equation
  if initM_flow == InitializationMethods.state then
    m_flow = m_flow_0;
  elseif initM_flow == InitializationMethods.derivative then
    der(m_flow) = m_acceleraton_0;
  elseif initM_flow == InitializationMethods.steadyState then
    der(m_flow) = 0;
  end if;
equation
  inlet.m_flow + outlet.m_flow = 0;
  outlet.r = inlet.r + dr_corr - der(inlet.m_flow)*L;
  dq = Medium.density(inlet.state)/2*(c_in^2 - c_out^2);
  if clip_p_out then
    p_out = max(p_min, p_in + dp + dq);
    dr_corr = dp + dq - (p_out - p_in);
  else
    p_out = p_in + dp + dq;
    dr_corr = 0;
  end if;
  outlet.state = Medium.setState_phX(p_out, h_out, Xi_out);
  annotation (
    Documentation(info="<html><head></head><body><p> <a href=\"modelica://ThermofluidStream.Interfaces.SISOFlow\">SISOFlow</a> from ThermofluidStream extended to&nbsp;<b>restore Bernoulli's principle</b>&nbsp;(change of static pressure due to change of velocity), i.e. diffusors (different crosssectional area of inlet and outlet) .</p><p><font face=\"Courier New\">p_out = p_in&nbsp;+ dq + dp</font></p><p><font face=\"MS Shell Dgl 2\">Change of static pressure due to change of velocity dq:</font></p><p><sub><font size=\"3\"><span style=\"font-family: 'Courier New';\">dq = rho/2 * (c_in^2 - c_out^2)</span></font></sub></p><p><sub><font size=\"3\"><span style=\"font-family: 'Courier New';\"><br></span></font></sub></p><p><span style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">&nbsp;&nbsp;</span><em style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">[P. Jordan; HTWG Konstanz; 10/23]</em></p>
      </body></html>"));
end SISOFlow_nonConstArea;
