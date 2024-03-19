within ThermofluidStream.Interfaces;
partial model SISOFlow "Base Model with basic flow eqautions for SISO"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  import ThermofluidStream.Utilities.Types.InitializationMethods;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
    <p>Medium package used in the Component. Make sure it is the same as the components connected to both ports are using.</p>
      </html>"));
  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced"));
  parameter StateSelect m_flowStateSelect = StateSelect.default "State selection for mass flow rate"
    annotation(Dialog(tab="Advanced"));
  parameter InitializationMethods initM_flow = ThermofluidStream.Utilities.Types.InitializationMethods.none "Initialization method for mass flow rate"
    annotation(Dialog(tab= "Initialization", group="Mass flow rate"));
  parameter SI.MassFlowRate m_flow_0 = 0 "Initial value for mass flow rate"
    annotation(Dialog(tab= "Initialization", group="Mass flow rate", enable=(initM_flow == InitializationMethods.state)));
  parameter Utilities.Units.MassFlowAcceleration m_acceleration_0 = 0 "Initial value for derivative of mass flow rate"
    annotation(Dialog(tab= "Initialization", group="Mass flow rate", enable=(initM_flow == InitializationMethods.derivative)));
  // no default value to require the modeler to think about it; use final to suppress this option to user
  parameter Boolean clip_p_out "= false, if dr_corr=0 (correction of inertial pressure difference)"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Pressure p_min = dropOfCommons.p_min "Minimum steady-state output pressure"
    annotation(Dialog(tab="Advanced", enable=clip_p_out));

  Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

  SI.MassFlowRate m_flow(stateSelect=m_flowStateSelect) = inlet.m_flow "Mass flow rate";

  // changing pressure calculation
  SI.Pressure dr_corr "Correction of inertial pressure difference";
  SI.Pressure dp "Pressure difference";

  // inlet state quantities
protected
  SI.Pressure p_in = Medium.pressure(inlet.state) "Inlet pressure";
  SI.SpecificEnthalpy h_in = Medium.specificEnthalpy(inlet.state) "Inlet specific enthalpy";
  Medium.MassFraction Xi_in[Medium.nXi] = Medium.massFraction(inlet.state) "Inlet mass fractions";

  //outlet state quantities
  SI.Pressure p_out "Outlet pressure";
  SI.SpecificEnthalpy h_out "Outlet specific enthalpy";
  Medium.MassFraction Xi_out[Medium.nXi] "Outlet mass fractions";

initial equation
  if initM_flow == InitializationMethods.state then
    m_flow = m_flow_0;
  elseif initM_flow == InitializationMethods.derivative then
    der(m_flow) = m_acceleration_0;
  elseif initM_flow == InitializationMethods.steadyState then
    der(m_flow) = 0;
  end if;

equation

  inlet.m_flow + outlet.m_flow = 0;
  outlet.r = inlet.r + dr_corr - der(inlet.m_flow) * L;

  if clip_p_out then
    p_out = max(p_min, p_in + dp);
    dr_corr = dp - (p_out - p_in);
  else
    p_out = p_in + dp;
    dr_corr = 0;
  end if;

  outlet.state = Medium.setState_phX(p_out, h_out, Xi_out);

  annotation (Documentation(info="<html>
<p>Interface class for all components with an Inlet and an Outlet and a massflow without a mass storage between.</p>
<p>This class already implements the equations that are common for such components, namly the conservation of mass, the intertance equation, as well as the clipping of p_out to p_min. </p>
<p>If p_out should be lower the p_min, the remaining pressure drop is added on the difference in inertial pressure r, basically accelerating or decelerating the massflow. </p>
<p>The component offers different initialization methods for the massflow, as well as several parameters used in the equations above. </p>
<p>The clipping of the massflow can be turned off (this should be done by the modeler as a final modificator while extending to hide this option from the enduser).</p>
</html>"));
end SISOFlow;
