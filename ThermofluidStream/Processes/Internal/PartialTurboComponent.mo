within ThermofluidStream.Processes.Internal;
partial model PartialTurboComponent "Partial of components that exchange work between a flange and a fluid stream"
  extends Interfaces.SISOFlow(m_flowStateSelect = StateSelect.prefer, final clip_p_out=true);

  import ThermofluidStream.Utilities.Types.InitializationMethods;
  import Quantity = ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities;

  parameter Boolean omega_from_input = false "Direct omega input"
    annotation(Dialog(group="Input/Output"));
  parameter Boolean enableOutput = false "Include output for selectable quantity"
    annotation(Dialog(group="Input/Output"));
  parameter Quantity outputQuantity=Quantity.m_flow_kgps "Quantity to output"
    annotation(Dialog(group="Input/Output", enable=enableOutput));
  parameter Boolean enableAccessHeatPort = false "Include access heatport"
    annotation(Dialog(group="Input/Output"));
  parameter SI.MomentOfInertia J_p = 5e-4 "Moment of inertia"
    annotation(Dialog(group="Parameters", enable=not omega_from_input));
  parameter SI.AngularVelocity omega_reg = dropOfCommons.omega_reg "Angular velocity used for normalization"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Mass flow used for normalization"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimum for rho (to make model stable for rho=0 @ p=0)"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter StateSelect omegaStateSelect = if omega_from_input then StateSelect.default else StateSelect.prefer "State select for m_flow"
    annotation(Dialog(tab="Advanced"));
  parameter InitializationMethods initOmega = ThermofluidStream.Utilities.Types.InitializationMethods.none "Initialization method for omega"
    annotation(Dialog(tab= "Initialization", group="Angular", enable=not omega_from_input));
  parameter SI.AngularVelocity omega_0 = 0 "Initial value for omega"
    annotation(Dialog(tab= "Initialization", group="Angular", enable=(initOmega == InitializationMethods.state)));
  parameter SI.AngularAcceleration omega_dot_0 = 0 "Initial value for der(omega)"
    annotation(Dialog(tab= "Initialization", group="Angular", enable=(initOmega == InitializationMethods.derivative)));
  parameter Boolean initPhi = false "If true phi is initialized"
    annotation(Dialog(tab= "Initialization", group="Angular", enable=not omega_from_input));
  parameter SI.Angle phi_0 = 0 "Initial value for phi"
    annotation(Dialog(tab= "Initialization", group="Angular", enable=initPhi));

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange(phi=phi, tau=tau) if not omega_from_input "Flange to receive mechanical power"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={0,-100}, rotation=-90),
      iconTransformation(extent={{-20,-20},{20,20}}, origin={0,-100}, rotation=-90)));
  Modelica.Blocks.Interfaces.RealInput omega_input(unit = "rad/s") = omega if omega_from_input "Input to directly set pump speed [rad/s]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={0,-100}, rotation=-90),
      iconTransformation(extent={{-20,-20},{20,20}}, origin={0,-100}, rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport(Q_flow = Q_t) if enableAccessHeatPort "Access-heat dumping port"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={0,100}, rotation=90),
      iconTransformation(extent={{-20,-20},{20,20}}, origin={0,100}, rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput output_val(unit=Sensors.Internal.getFlowUnit(outputQuantity)) = getQuantity(inlet.state, m_flow, outputQuantity, rho_min) if enableOutput "Measured value [variable]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-80,-100}, rotation=270)));

  replaceable function dp_tau = TurboComponent.pleaseSelect_dp_tau
    constrainedby TurboComponent.partial_dp_tau(redeclare package Medium=Medium)  "Component characteristic curves"
      annotation(choicesAllMatching=true,
        Documentation(info="<html>
<p>This functions computes the pressure difference over the component, as well as the moment that leads to stationary operation in the current state. </p>
</html>"));

function getQuantity = Sensors.Internal.getFlowQuantity (
  redeclare package Medium = Medium) "Function to compute a selectable quantity"
  annotation (
      Documentation(info="<html>
      <p>Function to compute a selectable quantity to output. The quantity is associated to the mass flow. </p>
      </html>"));

  SI.Power W_t "technichal work performed on fluid";
  SI.Power Q_t "work that could not be performed on the fluid, and is dumped to heat port";
  SI.Torque tau_st "moment that would result in static operation";

protected
  SI.SpecificVolume v_in = 1/max(rho_min, Medium.density(inlet.state));

  // intermediate quantities related to thermodynamical state
  SI.SpecificEnergy dh "specific technichal work performed under the assumption of positive massflow";

  // quantities related to inertia of component and mechanical power
  SI.Angle phi "component angular position";
  SI.Torque tau "moment from flange";
  SI.Torque tau_normalized "moment after zero massflow normalization";
  SI.AngularVelocity omega(stateSelect=omegaStateSelect) "component angular velocity";

initial equation
  if initOmega == InitializationMethods.state then
    omega = omega_0;
  elseif initM_flow == InitializationMethods.derivative then
    der(omega) = omega_dot_0;
  elseif initM_flow == InitializationMethods.steadyState then
    der(omega) = 0;
  end if;

  if initPhi then
    phi = phi_0;
  end if;

equation
  // compute dp, tau_st from characteristic curve
  (dp, tau_st) = dp_tau(m_flow, omega, inlet.state, m_flow_reg, omega_reg, rho_min);
  h_out = h_in + dh;
  Xi_out = Xi_in;

  // regularize tau_st/W_t such that the equations dont break for m_flow->0
  W_t = tau_st*omega;
  dh = (m_flow*W_t)/(m_flow^2 + (m_flow_reg)^2);
  if noEvent(W_t >= 0) then
    // if work is given to fluid, dump access heat to port
    Q_t = W_t - m_flow*dh;
    tau_normalized = tau_st;
  else
    // if work is taken from fluid, reduce tau, so that the work can be taken from the fluid
    Q_t = 0;
    tau_normalized = dh*m_flow/(noEvent(if abs(omega)>omega_reg then omega else (if omega < 0 then -omega_reg else omega_reg)));
  end if;

  // omega is either a state or directly given by omega_input (depending on omega_from_input)
  if noEvent(omega_from_input) then
    tau = 0;
    phi = 0;
  else
    J_p * der(omega) = tau - tau_normalized;
    omega = der(phi);
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
         Ellipse(
          extent={{-56,54},{64,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model has an inlet and an outlet, representing a single fluid stream, as well as a flange to exchange mechanical work, an optional heatport to dump heat that the fluid cannot take on, and an optional output for a measureable quantity.</p>
<p>The component does the following:</p>
<ol>
<li>Compute the pressure differential and the moment on the flange, that would result in static operation from characteristic curves (static moment). These curves differ for different components.</li>
<li>Regularize dh for low mass-flows. If the fluid is receiving energy, the heat that cannot be given to the fluid, is given to an accessible heatport. If the fluid is giving away energy, the static moment is reduced until dh is small enough within the regularization. </li>
<li>Compute mechanics of system if omega is not direct input of the system. The ifference between the static moment and the moment at the flange leeds to angular acceleration against the inertia of the system. </li>
</ol>
<p><br>An output can be enabled that measures one of multiple selectable quantities. Different initial conditions and state selections for the component can be selected.</p>
<p><br>Useful hints:</p>
<ul>
<li>The optional output might be useful for simplifying the overall model in a control loop, since no additional sensor is required. </li>
<li>If one wants to prescribe a speed of the component, instead of being interested in the omega dynamics, enable omegaFromInput.</li>
<li>The heatport is only of interest, if the overall energy of the system must be conserved.</li>
</ul>
</html>"));
end PartialTurboComponent;
