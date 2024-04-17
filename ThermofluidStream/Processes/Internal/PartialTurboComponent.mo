within ThermofluidStream.Processes.Internal;
partial model PartialTurboComponent "Partial model of turbo component"
  extends Interfaces.SISOFlow(m_flowStateSelect = StateSelect.prefer, final clip_p_out=true);

  import ThermofluidStream.Utilities.Types.InitializationMethods;
  import Quantity = ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities;

  parameter Boolean omega_from_input = false "= true, if omega input connector is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean enableAccessHeatPort = false "= true, if heatPort is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.MomentOfInertia J_p = 5e-4 "Moment of inertia"
    annotation(Dialog(group="Parameters", enable=not omega_from_input));
  parameter Boolean enableOutput = false "= true, if selectable quantity output connector is enabled"
    annotation(Dialog(group="Output"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Quantity outputQuantity=Quantity.m_flow_kgps "Output quantity"
    annotation(Dialog(group="Output", enable=enableOutput));
  parameter SI.AngularVelocity omega_reg = dropOfCommons.omega_reg "Normalization angular velocity"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Normalization mass flow rate"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimum density (relevant at p=0)"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter StateSelect omegaStateSelect = if omega_from_input then StateSelect.default else StateSelect.prefer "State select for angular velocity"
    annotation(Dialog(tab="Advanced"));
  parameter InitializationMethods initOmega = ThermofluidStream.Utilities.Types.InitializationMethods.none "Initialization method for angular velocity"
    annotation(Dialog(tab= "Initialization", group="Angular velocity", enable=not omega_from_input));
  parameter SI.AngularVelocity omega_0 = 0 "Initial value for angular velocity"
    annotation(Dialog(tab= "Initialization", group="Angular velocity", enable=(initOmega == InitializationMethods.state)));
  parameter SI.AngularAcceleration omega_dot_0 = 0 "Initial value for der(omega)"
    annotation(Dialog(tab= "Initialization", group="Angular velocity", enable=(initOmega == InitializationMethods.derivative)));
  parameter Boolean initPhi = false "= true, if angle is initialized"
    annotation(Dialog(tab= "Initialization", group="Angle", enable=not omega_from_input),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Angle phi_0 = 0 "Initial value for angle"
    annotation(Dialog(tab= "Initialization", group="Angle", enable=initPhi));

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange(phi=phi, tau=tau) if not omega_from_input "Flange"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={0,-100}, rotation=-90),
      iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealInput omega_input(unit = "rad/s") = omega if omega_from_input "Angular velocity input connector [rad/s]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={0,-100}, rotation=-90),
      iconTransformation(extent={{-20,-20},{20,20}}, origin={0,-120}, rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport(Q_flow = Q_t) if enableAccessHeatPort "HeatPort"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-60,-100},
                                                                                     rotation=90),
      iconTransformation(extent={{-10,-10},{10,10}}, origin={-60,-100},
                                                                     rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput output_val(unit=Sensors.Internal.getFlowUnit(outputQuantity)) = getQuantity(inlet.state, m_flow, outputQuantity, rho_min) if enableOutput "Quantity output connector"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-80,-100}, rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-110})));

  replaceable function dp_tau = TurboComponent.pleaseSelect_dp_tau
    constrainedby TurboComponent.partial_dp_tau(redeclare package Medium=Medium)  "Component characteristic curve"
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

  SI.Power W_t "Power (technichal work flow rate)";
  SI.Power Q_t "Heat flow rate";
  SI.Torque tau_st "Steady-state torque";

protected
  SI.SpecificVolume v_in = 1/max(rho_min, Medium.density(inlet.state)) "Inlet specific volume";

  // intermediate quantities related to thermodynamical state
  SI.SpecificEnergy dh "Difference of specific enthalpy";

  // quantities related to inertia of component and mechanical power
  SI.Angle phi "Angle";
  SI.AngularVelocity omega(stateSelect=omegaStateSelect) "Angular velocity";
  SI.Torque tau "Torque";
  SI.Torque tau_normalized "Normalized torque";


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
  // Compute pressure difference dp, and steady-state torque tau_st
  (dp, tau_st) = dp_tau(m_flow, omega, inlet.state, m_flow_reg, omega_reg, rho_min);
  h_out = h_in + dh;
  Xi_out = Xi_in;

  // Regularize tau_st/W_t such that the equations does not break for m_flow->0
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

  // Angle and angular velocity
  if noEvent(omega_from_input) then
    tau = 0;
    phi = 0;
  else
    J_p * der(omega) = tau - tau_normalized;
    omega = der(phi);
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
         Text(visible=displayInstanceName,
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
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
          fillPattern=FillPattern.Solid),
        Line(visible=enableAccessHeatPort, points={{-60,-100},{-60,-68},{-38,-46}}, color={191,0,0}),
        Line(
          visible=enableOutput,
          points={{60,-100},{60,-68},{38,-46}},
          color={0,0,127}),
        Line(visible=omega_from_input,
          points={{0,-100},{0,-60}},
          color={0,0,127}),
      Rectangle(visible=not omega_from_input,
        lineColor={64,64,64},
        fillColor={191,191,191},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{-100.0,-10.0},{-50.0,10.0}},
          rotation=90),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(preserveAspectRatio=true)),
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
