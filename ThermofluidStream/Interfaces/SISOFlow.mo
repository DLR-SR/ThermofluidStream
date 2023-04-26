within ThermofluidStream.Interfaces;
partial model SISOFlow "Base Model with basic flow eqautions for SISO"

  import ThermofluidStream.Utilities.Types.InitializationMethods;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
    <p>Medium package used in the Component. Make sure it is the same as the components connected to both ports are using.</p>
      </html>"));

  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance of the flow"
    annotation(Dialog(tab="Advanced"));
  parameter StateSelect m_flowStateSelect = StateSelect.default "State select for m_flow"
    annotation(Dialog(tab="Advanced"));
  parameter InitializationMethods initM_flow = ThermofluidStream.Utilities.Types.InitializationMethods.none "Initialization method for m_flow"
    annotation(Dialog(tab= "Initialization", group="Mass flow"), choicesAllMatching=true);
  parameter SI.MassFlowRate m_flow_0 = 0 "Initial value for m_flow"
    annotation(Dialog(tab= "Initialization", group="Mass flow", enable=(initM_flow == InitializationMethods.state)));
  parameter Utilities.Units.MassFlowAcceleration m_acceleration_0 = 0 "Initial value for der(m_flow)"
    annotation(Dialog(tab= "Initialization", group="Mass flow", enable=(initM_flow == InitializationMethods.derivative)));
  // no default value to require the modeler to think about it; use final to suppress this option to user
  parameter Boolean clip_p_out "If false, set dr_corr to zero"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Pressure p_min = dropOfCommons.p_min "Minimal steady-state output pressure"
    annotation(Dialog(tab="Advanced", enable=clip_p_out));

  Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

SI.MassFlowRate m_flow(stateSelect=m_flowStateSelect) = inlet.m_flow "mass flow through component";

// changing pressure calculation
SI.Pressure dr_corr; // delta = out - in
SI.Pressure dp; // delta = out - in


protected
  outer DropOfCommons dropOfCommons;

  // inlet state quantities
  SI.Pressure p_in = Medium.pressure(inlet.state) "pressure of medium entering";
  SI.SpecificEnthalpy h_in = Medium.specificEnthalpy(inlet.state) "enthaply of medium entering";
  Medium.MassFraction Xi_in[Medium.nXi] = Medium.massFraction(inlet.state) "mass fraction of medium entering";

  //outlet state quantities
  SI.Pressure p_out "pressure of medium exiting";
  SI.SpecificEnthalpy h_out "enthaply of medium exiting";
  Medium.MassFraction Xi_out[Medium.nXi] "mass fraction of medium exiting";

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
<p>The component offers different initalization methods for the massflow, as well as several parameters used in the equations above. </p>
<p>The clipping of the massflow can be turned off (this should be done by the modeler as a final modificator while extending to hide this option from the end-user).</p>
</html>"));
end SISOFlow;
