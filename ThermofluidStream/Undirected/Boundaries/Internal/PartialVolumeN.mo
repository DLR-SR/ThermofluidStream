within ThermofluidStream.Undirected.Boundaries.Internal;
partial model PartialVolumeN "Partial parent class for Volumes with N_fore fores and N_rear rears"
  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (
      choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Volume. Make sure it is the same as
the fores and rears the volume is connected to.
</p>
</html>"));

  parameter Integer N_rear = 1 "Number if rears";
  parameter Integer N_fore = 1 "Number if fores";
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
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold of mass flow rate"
    annotation(Dialog(tab="Advanced"));
  parameter Real k_volume_damping(unit="1") = dropOfCommons.k_volume_damping "Damping factor multiplicator"
    annotation(Dialog(tab="Advanced", group="Damping"));
  parameter Boolean usePreferredMediumStates=false "Use medium states instead of the ones differentiated in this component"
    annotation(Dialog(tab="Advanced"));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(Q_flow=Q_flow, T=T_heatPort) if useHeatport
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Interfaces.Rear rear[N_rear](redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Fore fore[N_fore](redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));

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

  SI.Temperature T_heatPort;


  Medium.ThermodynamicState state_out_rear[N_rear];
  Medium.ThermodynamicState state_out_fore[N_fore];

  SI.Pressure r_rear[N_rear];
  SI.Pressure r_fore[N_fore];
  SI.SpecificEnthalpy h_rear[N_rear];
  SI.SpecificEnthalpy h_fore[N_fore];
  Medium.MassFraction Xi_rear[Medium.nXi, N_rear];
  Medium.MassFraction Xi_fore[Medium.nXi, N_fore];

  Real d(unit="1/(m.s)") = k_volume_damping*sqrt(abs(2*L/(V*max(density_derp_h, 1e-10)))) "Friction factor for coupled boundaries";
  SI.DerDensityByPressure density_derp_h "Partial derivative of density by pressure";
  SI.Pressure r_damping = d*der(M);

initial equation
  assert(M > 0, "Volumes might not become empty");

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
  assert(M > 0, "Volumes might not become empty");

  der(rear.m_flow)*L = rear.r - r_rear - r_damping*ones(N_rear);
  der(fore.m_flow)*L = fore.r - r_fore - r_damping*ones(N_fore);

  for i in 1:N_rear loop
    r_rear[i] = ThermofluidStream.Undirected.Internal.regStep(
      rear[i].m_flow,
      medium.p - Medium.pressure(rear[i].state_forwards),
      0,
      m_flow_reg);
    // dont regstep variables that are only in der(state), to increase accuracy
    h_rear[i] = if rear[i].m_flow >= 0 then Medium.specificEnthalpy(rear[i].state_forwards) else Medium.specificEnthalpy(state_out_rear[i]);
    Xi_rear[:, i] = if rear[i].m_flow >= 0 then Medium.massFraction(rear[i].state_forwards) else Medium.massFraction(state_out_rear[i]);

    rear[i].state_rearwards = medium.state;
  end for;
  for i in 1:N_fore loop
    r_fore[i] = ThermofluidStream.Undirected.Internal.regStep(
      fore[i].m_flow,
      medium.p - Medium.pressure(fore[i].state_rearwards),
      0,
      m_flow_reg);
    // dont regstep variables that are only in der(state), to increase accuracy
    h_fore[i] = if fore[i].m_flow >= 0 then Medium.specificEnthalpy(fore[i].state_rearwards) else Medium.specificEnthalpy(state_out_fore[i]);
    Xi_fore[:, i] = if fore[i].m_flow >= 0 then Medium.massFraction(fore[i].state_rearwards) else Medium.massFraction(state_out_fore[i]);

    fore[i].state_forwards = medium.state;
  end for;

  der(M) = sum(rear.m_flow) + sum(fore.m_flow);
  der(U_med) = W_v + Q_flow + h_rear*rear.m_flow +h_fore*fore.m_flow;
  der(MXi) = Xi_rear*rear.m_flow + Xi_fore*fore.m_flow;

  Q_flow = U*A*(T_heatPort - medium.T);

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
          extent={{-90,48},{-64,6}},
          lineColor={116,116,116},
          textString="%N_rear"), Text(
          extent={{66,48},{92,6}},
          lineColor={116,116,116},
          textString="%N_fore")}),
                            Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This is the partial parent class for all unidirectional volumes with more then one fore or rear. It is partial missing one equation its volume or the medium pressure and one for the volume work performed.</p>
<p>Conceptually a volume is a sink and a source. It therefore defines the level of inertial pressure r in a closed loop and acts as a loop breaker.</p>
<p>Volumes implement a damping term on the change of the stored mass to dampen out fast, otherwise undamped oscillations that appear when connecting volumes directly to other volumes or other boundaries (source, sink, boundary_fore, boundary_rear). With the damping term these oscillations will be still very fast, but dampened out, so a stiff solver might be able to handle them well. Damping is enabled by default and can be disabled by setting Advanced.k_volume_damping=0. </p>
<p>Per default the Volume has the two states energy and mass (U_med and M) and one state for each mass, as well as one state for each substance of the fluid (except the first one). These will be enforced to be states of the simulation, which can result in nonlinear systems of size one or two, but works very reliable. To get rid of these systems the modeler can enable the flag &apos;usePreferredMediumStates&apos; in the &apos;Advanced&apos; tab. Then the volume uses the states prefered by the medium object, rather then the default ones, which can improve the nonlinear systems most of the time, but also might lead to larger nonlinear systems (e.g. in the Test &apos;VolumesDirectCoupling&apos;).</p>
</html>"));
end PartialVolumeN;
