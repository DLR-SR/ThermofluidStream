within ThermofluidStream.Undirected.Interfaces;
partial model SISOBiFlow "Base Model with basic flow eqautions for SISO"

  import ThermofluidStream.Utilities.Types.InitializationMethods;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
                                                                "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
      <p>Medium package used in the Component. Make sure it is the same as the one both ports are connected to.</p>
      </html>"));

  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance of the flow"
    annotation(Dialog(tab="Advanced"));
  parameter StateSelect m_flowStateSelect = StateSelect.default "State select for m_flow"
    annotation(Dialog(tab="Advanced"));
  parameter InitializationMethods initM_flow = ThermofluidStream.Utilities.Types.InitializationMethods.none "Initialization method for m_flow"
    annotation(Dialog(tab= "Initialization"), choicesAllMatching=true);
  parameter SI.MassFlowRate m_flow_0 = 0 "Initial value for m_flow"
    annotation(Dialog(tab= "Initialization", enable=(initM_flow == InitializationMethods.state)));
  parameter Utilities.Units.MassFlowAcceleration m_acceleraton_0 = 0 "Initial value for der(m_flow)"
    annotation(Dialog(tab= "Initialization", enable=(initM_flow == InitializationMethods.derivative)));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold of mass flow rate"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  // no default value to require the modeler to think about it; use final to suppress this option to user
  parameter Boolean clip_p_out "If true, set dr_corr to zero"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Pressure p_min = dropOfCommons.p_min "Minimal steady-state output pressure"
    annotation(Dialog(tab="Advanced", enable=clip_p_out));

  Fore fore(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Rear rear(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));

  SI.MassFlowRate m_flow(stateSelect=m_flowStateSelect) = rear.m_flow;

  // delta pressure computation
  SI.Pressure dp_fore; // delta = fore - rear
  SI.Pressure dp_rear; // delta = rear - fore

  SI.Pressure dr_corr_fore; //forward direction; delta = fore - rear
  SI.Pressure dr_corr_rear; //rearward direction; delta = rear - fore
  SI.Pressure dr_corr; // regstep regulated one used; delta = fore - rear

protected
  outer DropOfCommons dropOfCommons;

  // input state quantities
  SI.Pressure p_rear_in = Medium.pressure(rear.state_forwards) "pressure of medium entering";
  SI.Pressure p_fore_in = Medium.pressure(fore.state_rearwards) "pressure of medium entering";
  SI.SpecificEnthalpy h_rear_in = Medium.specificEnthalpy(rear.state_forwards) "enthaply of medium enetering";
  SI.SpecificEnthalpy h_fore_in = Medium.specificEnthalpy(fore.state_rearwards) "enthaply of medium enetering";
  Medium.MassFraction Xi_rear_in[Medium.nXi] = Medium.massFraction(rear.state_forwards) "mass fraction of medium entering";
  Medium.MassFraction Xi_fore_in[Medium.nXi] = Medium.massFraction(fore.state_rearwards) "mass fraction of medium entering";

  //outlet state quantities
  SI.Pressure p_rear_out "pressure of medium exiting";
  SI.Pressure p_fore_out "pressure of medium exiting";
  SI.SpecificEnthalpy h_rear_out "enthaply of medium exiting";
  SI.SpecificEnthalpy h_fore_out "enthaply of medium exiting";
  Medium.MassFraction Xi_rear_out[Medium.nXi] "mass fraction of medium exiting";
  Medium.MassFraction Xi_fore_out[Medium.nXi] "mass fraction of medium exiting";

initial equation
  if initM_flow == InitializationMethods.state then
    m_flow = m_flow_0;
  elseif initM_flow == InitializationMethods.derivative then
    der(m_flow) = m_acceleraton_0;
  elseif initM_flow == InitializationMethods.steadyState then
    der(m_flow) = 0;
  end if;

equation

  fore.m_flow + rear.m_flow = 0;
  fore.r = rear.r + dr_corr - der(rear.m_flow) * L;

  if clip_p_out then
    p_fore_out = max(p_min, p_rear_in + dp_fore);
    dr_corr_fore = dp_fore - (p_fore_out - p_rear_in);

    p_rear_out = max(p_min, p_fore_in + dp_rear);
    dr_corr_rear = dp_rear - (p_rear_out - p_fore_in);

    dr_corr = Internal.regStep(m_flow, dr_corr_fore, -dr_corr_rear, m_flow_reg);
  else
    p_fore_out = p_rear_in + dp_fore;
    p_rear_out = p_fore_in + dp_rear;

    dr_corr_fore = 0;
    dr_corr_rear = 0;
    dr_corr = 0;
  end if;

  rear.state_rearwards = Medium.setState_phX(p_rear_out, h_rear_out, Xi_rear_out);
  fore.state_forwards = Medium.setState_phX(p_fore_out, h_fore_out, Xi_fore_out);

  annotation (Documentation(info="<html>
<p>Interface class for all components with one fore and one rear port and a massflow without a mass storage between.</p>
<p>This class already implements the equations that are common for such components, namly the conservation of mass, the intertance equation, as well as the clipping of p_out to p_min. </p>
<p>If p_out should be lower the p_min, the remaining pressure drop is added on the difference in inertial pressure r, basically accelerating or decelerating the massflow. </p>
<p>The component offers different initalization methdos for the massflow, as well as several parameters used in the equations above. </p>
<p>The clipping of the massflow can be turned off (this should be done by the modeler as a final modificator while extending to hide this option from the enduser).</p>
</html>"));
end SISOBiFlow;
