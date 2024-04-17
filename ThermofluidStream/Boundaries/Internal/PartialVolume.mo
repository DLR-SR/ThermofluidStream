within ThermofluidStream.Boundaries.Internal;
partial model PartialVolume "Partial volume with one inlet and one outlet"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
   annotation (
      choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Volume. Make sure it is the same as the
inlets and outlets the volume is connected to.
</p>
</html>"));
  parameter Boolean useHeatport = false "=true, if heatport is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean useInlet = true "= true, if inlet is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean useOutlet = true "= true, if outlet is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Area A = 1 "Heat transfer area"
    annotation(Dialog(enable=useHeatport));
  parameter SI.CoefficientOfHeatTransfer U = 200 "Thermal transmittance"
    annotation(Dialog(enable=useHeatport));

  parameter Boolean initialize_pressure = true "=true, if pressure is initialized"
    annotation(Dialog(tab= "Initialization",group="Pressure"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Pressure p_start = Medium.p_default "Initial pressure set value"
    annotation(Dialog(tab= "Initialization",group="Pressure", enable=initialize_pressure));
  parameter Boolean initialize_energy = true "= true, if internal energy is initialized"
    annotation(Dialog(tab= "Initialization",group="Temperature"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Temperature T_start = Medium.T_default "Initial Temperature set value"
    annotation(Dialog(tab= "Initialization",group="Temperature", enable=initialize_energy and (not use_hstart)));
  parameter Boolean initialize_Xi = true "=true, if mass fractions are iinitialized"
    annotation(Dialog(tab= "Initialization",group="Mass fractions"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Medium.MassFraction Xi_0[Medium.nXi] = Medium.X_default[1:Medium.nXi] "Initial mass fractions set values"
    annotation(Dialog(tab= "Initialization",group="Mass fractions", enable=initialize_Xi));
  parameter Boolean use_hstart = false "=true, if internal energy is initialized with specific enthalpy"
    annotation(Dialog(tab= "Initialization",group="Specific enthalpy", enable=initialize_energy),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.SpecificEnthalpy h_start = Medium.h_default "Initial specific enthalpy set value"
    annotation(Dialog(tab= "Initialization",group="Specific enthalpy", enable=initialize_energy and use_hstart));

  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance of inlet/outlet"
    annotation (Dialog(tab="Advanced"));
  parameter Real k_volume_damping(unit="1", min=0) = dropOfCommons.k_volume_damping "Damping factor multiplicator"
    annotation(Dialog(tab="Advanced", group="Damping"));
  parameter SI.MassFlowRate m_flow_assert(max=0) = -dropOfCommons.m_flow_reg "Assertion threshold for negative massflow"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean usePreferredMediumStates=false "=true, if preferred medium states are used"
    annotation(Dialog(tab="Advanced"),Evaluate=true, HideResult=true, choices(checkBox=true));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(Q_flow=Q_flow, T=T_heatPort) if useHeatport
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Interfaces.Inlet inlet(redeclare package Medium=Medium, m_flow=m_flow_in, r=r_in, state=state_in) if useInlet
    annotation (Placement(transformation(extent={{-120,
            -20},{-80,20}}),
                        iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outlet(redeclare package Medium=Medium, m_flow=m_flow_out, r=r_out, state=state_out) if useOutlet
    annotation (Placement(transformation(extent={{80,-20},
            {120,20}}), iconTransformation(extent={{80,-20},{120,20}})));

  Medium.BaseProperties medium(preferredMediumStates=usePreferredMediumStates);

  SI.Volume V "Volume";

  //setting the state is to prohibit dynamic state selection e.g. in VolumesDirectCoupling
  SI.Mass M(stateSelect=if usePreferredMediumStates then StateSelect.default else StateSelect.always) = V*medium.d "Mass";
  SI.Mass MXi[Medium.nXi](each stateSelect=if usePreferredMediumStates then StateSelect.default else StateSelect.always) = M*medium.Xi "Masses of species";
  SI.Energy U_med(stateSelect=if usePreferredMediumStates then StateSelect.default else StateSelect.always) = M*medium.u "Internal energy";

  SI.HeatFlowRate Q_flow "Heat flow rate";
  SI.Power W_v "Work due to change of volume";  // Volumenaenderungsarbeitsstrom

protected
  SI.Temperature T_heatPort "Heat port temperature";
  SI.Pressure r "Inertial pressure";

  Real d(unit="1/(m.s)") = k_volume_damping*sqrt(abs(2*L/(V*max(density_derp_h, 1e-10)))) "Friction factor for coupled boundaries";
  SI.DerDensityByPressure density_derp_h "Partial derivative of density by pressure at constant specific enthalpy";
  SI.Pressure r_damping = d*der(M) "Damping of inertial pressure";

  Medium.ThermodynamicState state_in "Inlet state";
  SI.Pressure p_in = Medium.pressure(state_in) "Inlet pressure";
  // fix potential instabilities by setting the outgoing enthalpy and mass fraction to the medium state
  SI.SpecificEnthalpy h_in = if noEvent(m_flow_in >= 0) then Medium.specificEnthalpy(state_in) else medium.h "Inlet specific enthalpy";
  Medium.MassFraction Xi_in[Medium.nXi] = if noEvent(m_flow_in >= 0) then Medium.massFraction(state_in) else medium.Xi "Inlet mass fractions";

  Medium.ThermodynamicState state_out "Oulet state";
  // fix potential instabilities by setting the incoming enthalpy and mass fraction inlet ones,
  // effectiveley removing the mass-flow related parts of the differential equations for U and MXi
  SI.SpecificEnthalpy h_out = if noEvent(-m_flow_out >= 0) then Medium.specificEnthalpy(state_out) else medium.h "Outlet specific enthalpy";
  Medium.MassFraction Xi_out[Medium.nXi] = if noEvent(-m_flow_out >= 0) then Medium.massFraction(state_out) else medium.Xi "Outlet mass fractions";

  SI.Pressure r_in, r_out "Inlet/Outlet inertial pressure";
  SI.MassFlowRate m_flow_in, m_flow_out "Inlet/Outlet mass flow rate";

initial equation
  if initialize_pressure then
    medium.p=p_start;
  end if;

  if initialize_energy then
    if use_hstart then
      medium.h = h_start;
    else
      medium.T=T_start;
    end if;
  end if;

  if initialize_Xi then
    medium.Xi = Xi_0;
  end if;

equation
  assert(m_flow_in > m_flow_assert, "Negative mass flow rate at Volume inlet", dropOfCommons.assertionLevel);
  assert(-m_flow_out > m_flow_assert, "Positive mass flow rate at Volume outlet", dropOfCommons.assertionLevel);
  assert(M > 0, "Negative mass inside the volume");

  der(m_flow_in)*L = r_in - r - r_damping;
  der(m_flow_out)*L = r_out - r_damping;

  r + p_in = medium.p;

  der(M) = m_flow_in + m_flow_out;
  der(U_med) = W_v + Q_flow + h_in*m_flow_in + h_out*m_flow_out;
  der(MXi) = Xi_in*m_flow_in + Xi_out*m_flow_out;

  Q_flow = U*A*(T_heatPort - medium.T);

  if not useHeatport then
    T_heatPort = medium.T;
  end if;
  if not useInlet then
    m_flow_in = 0;
    state_in = Medium.setState_phX(Medium.p_default, Medium.h_default, Medium.X_default[1:Medium.nXi]);
  end if;
  if not useOutlet then
    m_flow_out = 0;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Ellipse(
          extent={{-56,76},{64,16}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-56,46},{64,-56}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-56,-28},{64,-88}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-60,-20},{60,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,50},{60,-50}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-60,80},{60,20}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,50},{-60,-52}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{60,50},{60,-52}},
          color={28,108,200},
          thickness=0.5),
        Line(visible=useInlet,
          points={{-100,0},{-60,0}},
          color={28,108,200},
          thickness=0.5),
        Line(visible=useOutlet,
          points={{60,0},{100,0}},
          color={28,108,200},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This is the partial parent class for all unidirectional volumes with only one inlet and outlet. It is partial and is missing one equation for its volume or the medium pressure and one the volume work performed.</p>
<p>Conceptually a volume is a sink and a source. It therefore defines the level of inertial pressure r in a closed loop and acts as a loop breaker.</p>
<p>Volumes implement a damping term on the change of the stored mass to dampen out fast, otherwise undamped oscillations that appear when connecting volumes directly to other volumes or other boundaries (source, sink, boundary_fore, boundary_rear). With the damping term these oscillations will be still very fast, but dampened out, so a stiff solver might be able to handle them well. Damping is enabled by default and can be disabled by setting Advanced.k_volume_damping=0. </p>
<p>Due to stability reasons, mass-flows in the wrong direction (fluid entering the outlet or exiting the inlet) is considered to have the enthalpy and mass-fractions of the medium in the volume. This results in a stable steady-state solution, since this method effectiveley removes the parts of the energy and mass-fraction differential equations, that are associated with mass-flows. </p>
<p>Per default the Volume has the two states energy and mass (U_med and M) and one state for each mass, as well as one state for each substance of the fluid (except the first one). These will be enforced to be states of the simulation, which can result in nonlinear systems of size one or two, but works very reliable. To get rid of these systems the modeler can enable the flag &apos;usePreferredMediumStates&apos; in the &apos;Advanced&apos; tab. Then the volume uses the states preferred by the medium object, rather then the default ones, which can improve the nonlinear systems most of the time, but also might lead to larger nonlinear systems (e.g. in the Test &apos;VolumesDirectCoupling&apos;).</p>
</html>"));
end PartialVolume;
