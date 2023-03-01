within ThermofluidStream.Boundaries.Internal;
partial model PartialVolumeN "Partial parent class for Volumes with N inlets and one outlet"
  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (
      choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Volume. Make sure it is the same as the
inlets and outlets the volume is connected to.
</p>
</html>"));

  parameter Integer N = 1 "Number if inlets";
  parameter Boolean useHeatport = false "If true heatport is added";
  parameter SI.Area A = 1 "Contact area of volume with medium"
    annotation(Dialog(enable=useHeatport));
  parameter SI.CoefficientOfHeatTransfer U = 200 "Heat transfer coefficient to medium"
    annotation(Dialog(enable=useHeatport));
 parameter Boolean initialize_pressure = true "If true: initialize Pressure"
    annotation(Dialog(tab= "Initialization"));
  parameter SI.Pressure p_start = Medium.p_default "Initial Pressure"
    annotation(Dialog(tab= "Initialization", enable=initialize_pressure));
  parameter Boolean initialize_energy = true "Initialize specific inner energy with temperature or specific enthalpy condition"
    annotation(Dialog(tab= "Initialization"));
  parameter SI.Temperature T_start = Medium.T_default "Initial Temperature"
    annotation(Dialog(tab= "Initialization", enable=initialize_energy and (not use_hstart)));
  parameter Boolean use_hstart = false "True: spedific enthalpy contition instead of Temperature"
    annotation(Dialog(tab= "Initialization", enable=initialize_energy));
  parameter SI.SpecificEnthalpy h_start = Medium.h_default "Initial specific enthalpy"
    annotation(Dialog(tab= "Initialization", enable=initialize_energy and use_hstart));
  parameter Boolean initialize_Xi = true "If true: initialize mass fractions"
    annotation(Dialog(tab= "Initialization"));
  parameter Medium.MassFraction Xi_0[Medium.nXi] = Medium.X_default[1:Medium.nXi] "Initial mass fraction"
    annotation(Dialog(tab= "Initialization", enable=initialize_Xi));
  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance at inlet and outlet"
    annotation (Dialog(tab="Advanced"));
  parameter Real k_volume_damping(unit="1") = dropOfCommons.k_volume_damping "Damping factor multiplicator"
    annotation(Dialog(tab="Advanced", group="Damping"));
  parameter SI.MassFlowRate m_flow_assert(max=0) = -dropOfCommons.m_flow_reg "Assertion threshold for negative massflows"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean usePreferredMediumStates=false "Use medium states instead of the ones differentiated in this component"
    annotation(Dialog(tab="Advanced"));

  Interfaces.Inlet inlet[N](redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(Q_flow=Q_flow, T=T_heatPort) if useHeatport
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));

  Medium.BaseProperties medium(preferredMediumStates=usePreferredMediumStates);

  SI.Volume V;

  //setting the state is to prohibit dynamic state selection e.g. in VolumesDirectCoupling
  SI.Mass M(stateSelect=if usePreferredMediumStates then StateSelect.default else StateSelect.always) = V*medium.d;
  SI.Mass MXi[Medium.nXi](each stateSelect=if usePreferredMediumStates then StateSelect.default else StateSelect.always) = M*medium.Xi;
  SI.Energy U_med(stateSelect=if usePreferredMediumStates then StateSelect.default else StateSelect.always) = M*medium.u;

  SI.HeatFlowRate Q_flow;
  SI.Power W_v;

protected
  outer DropOfCommons dropOfCommons;

  SI.Pressure p_in[N] = Medium.pressure(inlet.state);
  SI.SpecificEnthalpy h_in[N];
  Medium.MassFraction Xi_in[Medium.nXi,N];

  Medium.ThermodynamicState state_out;
  // fix potential instabilities by setting the outgoing enthalpy and mass fraction to the medium state
  SI.SpecificEnthalpy h_out = if noEvent(-m_flow_out) >= 0 then Medium.specificEnthalpy(state_out) else medium.h;
  Medium.MassFraction Xi_out[Medium.nXi] = if noEvent(-m_flow_out >= 0) then Medium.massFraction(state_out) else medium.Xi;

  Real d(unit="1/(m.s)") = k_volume_damping*sqrt(abs(2*L/(V*max(density_derp_h, 1e-10)))) "Friction factor for coupled boundaries";
  SI.DerDensityByPressure density_derp_h "Partial derivative of density by pressure";
  SI.Pressure r_damping = d*der(M);

  SI.Pressure r[N];

  SI.Temperature T_heatPort;

  SI.MassFlowRate m_flow_in[N] = inlet.m_flow;
  SI.MassFlowRate m_flow_out = outlet.m_flow;

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
  for i in 1:N loop
    assert(m_flow_in[i] > m_flow_assert, "Negative massflow at Volume inlet", dropOfCommons.assertionLevel);
  end for;
  assert(-m_flow_out > m_flow_assert, "Positive massflow at Volume outlet", dropOfCommons.assertionLevel);
  assert(M > 0, "Volumes might not become empty");

  der(inlet.m_flow)*L = inlet.r - r - r_damping*ones(N);
  der(outlet.m_flow)*L = outlet.r - r_damping;

  for i in 1:N loop
    r[i] + p_in[i] = medium.p;

    // fix potential instabilities by setting the outgoing enthalpy and mass fraction to the medium state
    h_in[i] =  if noEvent(m_flow_in[i]) >= 0 then Medium.specificEnthalpy(inlet[i].state) else medium.h;
    Xi_in[:,i] = if noEvent(m_flow_in[i]) >= 0 then Medium.massFraction(inlet[i].state) else medium.Xi;
  end for;

  der(M) = sum(inlet.m_flow) + outlet.m_flow;
  der(U_med) = W_v + Q_flow + sum(inlet.m_flow.*h_in) + outlet.m_flow*h_out;
  der(MXi) = Xi_in*inlet.m_flow + Xi_out*outlet.m_flow;

  Q_flow = U*A*(T_heatPort - medium.T);

  outlet.state = state_out;

  if not useHeatport then
    T_heatPort = medium.T;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
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
          thickness=0.5), Text(
          extent={{-92,46},{-66,4}},
          lineColor={116,116,116},
          textString="%N")}),
                            Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This is the partial parent class for unidirectional volumes with N inlets. It is partial and missing the number if inputs, as well as a equations for its volume or medium pressure and one for the volume change work performed.</p>
<p>Conceptually a volume is a sink and a source. It therefore defines the level of inertial pressure r in a closed loop and acts as a loop breaker.</p>
<p>Volumes implement a damping term on the change of the stored mass to dampen out fast, otherwise undamped oscillations that appear when connecting volumes directly to other volumes or other boundaries (source, sink, boundary_fore, boundary_rear). With the damping term these oscillations will be still very fast, but dampened out, so a stiff solver might be able to handle them well. Damping is enabled by default and can be disabled by setting Advanced.k_volume_damping=0. </p>
<p>Due to stability reasons, mass-flows in the wrong direction (fluid entering the outlet or exiting the inlet) is considered to have the enthalpy and mass-fractions of the medium in the volume. This results in a stable steady-state solution, since this method effectiveley removes the parts of the energy and mass-fraction differential equations, that are associated with mass-flows. </p>
<p>Per default the Volume has the two states energy and mass (U_med and M) and one state for each mass, as well as one state for each substance of the fluid (except the first one). These will be enforced to be states of the simulation, which can result in nonlinear systems of size one or two, but works very reliable. To get rid of these systems the modeler can enable the flag &apos;usePreferredMediumStates&apos; in the &apos;Advanced&apos; tab. Then the volume uses the states prefered by the medium object, rather then the default ones, which can improve the nonlinear systems most of the time, but also might lead to larger nonlinear systems (e.g. in the Test &apos;VolumesDirectCoupling&apos;).</p>
</html>"));
end PartialVolumeN;
