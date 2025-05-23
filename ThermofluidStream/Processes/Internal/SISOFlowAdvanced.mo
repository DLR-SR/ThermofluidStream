within ThermofluidStream.Processes.Internal;
partial model SISOFlowAdvanced "Advanced model for SISOFlow"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  import ThermofluidStream.Utilities.Types.InitializationMethods;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
                                                                      "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
    <p>Medium package used in the Component. Make sure it is the same as the components connected to both ports are using.</p>
      </html>"));
  parameter Boolean setFlow = false "= true, if mass flow rate is set (=false, for standard approach)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Time TC = 1e-3 "Time constant for pressure adaption if mass flow rate is set"
    annotation(Dialog(tab="Advanced", group="Pressure dynamics",enable=setFlow));

  parameter ThermofluidStream.Utilities.Units.Inertance L=dropOfCommons.L "Inertance" annotation (Dialog(tab="Advanced", enable=not setFlow));
  parameter StateSelect m_flowStateSelect = StateSelect.default "State selection for mass flow rate"
    annotation(Dialog(tab="Advanced"));
  parameter InitializationMethods initM_flow = ThermofluidStream.Utilities.Types.InitializationMethods.none "Initialization method for mass flow rate"
    annotation(Dialog(tab= "Initialization", group="Mass flow rate", enable= not setFlow));
  parameter SI.MassFlowRate m_flow_0 = 0 "Initial value for mass flow rate"
    annotation(Dialog(tab= "Initialization", group="Mass flow rate", enable= (not setFlow and initM_flow == InitializationMethods.state)));
  parameter ThermofluidStream.Utilities.Units.MassFlowAcceleration m_acceleration_0=0 "Initial value for derivative of mass flow rate" annotation (Dialog(
      tab="Initialization",
      group="Mass flow rate",
      enable=(not setFlow and initM_flow == InitializationMethods.derivative)));
  // no default value to require the modeler to think about it; use final to suppress this option to user
  parameter Boolean clip_p_out "= false, if dr_corr=0 (correction of inertial pressure difference)"
    annotation(Dialog(tab="Advanced", enable = not setFlow));
  parameter SI.Pressure p_min = dropOfCommons.p_min "Minimum steady-state output pressure"
    annotation(Dialog(tab="Advanced", enable= not setFlow and clip_p_out));

  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  ThermofluidStream.Interfaces.Outlet outlet(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{80,-20},{120,20}})));

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
  if not setFlow then
    if initM_flow == InitializationMethods.state then
      m_flow = m_flow_0;
    elseif initM_flow == InitializationMethods.derivative then
      der(m_flow) = m_acceleration_0;
    elseif initM_flow == InitializationMethods.steadyState then
      der(m_flow) = 0;
    end if;
  end if;

equation
  inlet.m_flow + outlet.m_flow = 0;

  if setFlow then
    TC * der(dp) = outlet.r - inlet.r;
    p_out = p_in + dp;
    dr_corr = 0;
  else
    outlet.r = inlet.r + dr_corr - der(inlet.m_flow) * L;
    if clip_p_out then
      p_out = max(p_min, p_in + dp);
      dr_corr = dp - (p_out - p_in);
    else
      p_out = p_in + dp;
      dr_corr = 0;
    end if;
  end if;

  outlet.state = Medium.setState_phX(p_out, h_out, Xi_out);

  annotation (Documentation(info="<html>
<ul>
<li>For <code>setFlow=false</code>, this model is equivalent to <a href=\"modelica://ThermofluidStream.Interfaces.SISOFlow\">ThermofluidStream.Interfaces.SISOFlow</a>, i.e it uses the approach:
<blockquote><pre>
der(inlet.m_flow)*L = inlet.r - outlet.r;
p_out = p_in + dp;
</pre></blockquote>
where the pressure difference <code>dp + dr</code> is given and the <strong>mass flow rate</strong> <code>m_flow</code> is adapted based on the (negative) inertial pressure 
difference <code>-dr = inlet.r - outlet.r</code>.<br> 
The inertance <code>L</code> is its 'time constant' (strictly speaking by dimensional analysis (Buckingham pi theorem) one can derive that the time constant <code>TC ~ L*dp_stationary/m_flow_stationary</code>). 
The inertance <code>L</code> can be derived from instationary Bernoulli equation.
</li>
<li>For <code>setFlow=true</code>, this model is an extension of <a href=\"modelica://ThermofluidStream.Boundaries.TerminalSource\">ThermofluidStream.Boundaries.TerminalSource</a>, i.e it uses the approach:
<blockquote><pre>
TC * der(dp) = outlet.r - inlet.r;
p_out = p_in + dp;
</pre></blockquote>
where the mass flow rate <code>m_flow</code> is given and the <strong>pressure difference</strong> <code>dp</code> is adapted based on the 
(positive) inertial pressure difference <code>dr =  outlet.r - inlet.r</code>.<br>
Currently the time constant <code>TC</code> is used as a numerical tool. It might have a physical explanation considering the pressure change <code>der(dp)</code> 
of a volume for a given inflow/outflow.<br>
Use <code>dp(start=0)</code> or <code>dp(final start=0)</code> if <code>setFlow=true</code>.
</li>
</ul>



</html>", revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
end SISOFlowAdvanced;
