within ThermofluidStream.Undirected.Boundaries.Internal;
partial model PartialVolume "Partial volume with one fore port and one rear port"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (
      choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Volume. Make sure it is the same as
the fores and rears the volume is connected to.
</p>
</html>"));
  parameter Boolean useHeatport = false "=true, if heatport is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean useRear = true "= true, if rear port is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean useFore = true "= true, if fore port is enabled"
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

  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance of rear/fore ports"
    annotation (Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold of mass flow rate"
    annotation(Dialog(tab="Advanced"));
  parameter Real k_volume_damping(unit="1") = dropOfCommons.k_volume_damping "Damping factor multiplicator"
    annotation(Dialog(tab="Advanced", group="Damping"));
  parameter Boolean usePreferredMediumStates=false "=true, if preferred medium states are used"
    annotation(Dialog(tab="Advanced"),Evaluate=true, HideResult=true, choices(checkBox=true));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(Q_flow=Q_flow, T=T_heatPort) if useHeatport
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Interfaces.Rear rear(redeclare package Medium=Medium, m_flow=m_flow_rear, r=r_rear_port, state_rearwards=state_out_rear, state_forwards=state_in_rear) if useRear
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Fore fore(redeclare package Medium=Medium, m_flow=m_flow_fore, r=r_fore_port, state_forwards=state_out_fore, state_rearwards=state_in_fore) if useFore
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));

  Medium.BaseProperties medium(preferredMediumStates=usePreferredMediumStates);

  SI.Volume V "Volume";

  //setting the state is to prohibit dynamic state selection e.g. in VolumesDirectCoupling
  SI.Mass M(stateSelect=if usePreferredMediumStates then StateSelect.default else StateSelect.always) = V*medium.d "Mass";
  SI.Mass MXi[Medium.nXi](each stateSelect=if usePreferredMediumStates then StateSelect.default else StateSelect.always) = M*medium.Xi "Mases of species";
  SI.Energy U_med(stateSelect=if usePreferredMediumStates then StateSelect.default else StateSelect.always) = M*medium.u "Internal energy";

  SI.HeatFlowRate Q_flow "Heat flow rate";
  SI.Power W_v "Work due to change in volume (Volumenänderungsarbeit)";

protected
  SI.Temperature T_heatPort "Heat port temperature";

  //if port.m_flow > 0 -> it is sink (r=medium.p-p_in) else it is source (r=0)
  SI.Pressure r_rear_intern = ThermofluidStream.Undirected.Internal.regStep(m_flow_rear, medium.p - Medium.pressure(state_in_rear), 0, m_flow_reg) "Rear port inertial pressure";
  SI.Pressure r_fore_intern = ThermofluidStream.Undirected.Internal.regStep(m_flow_fore, medium.p - Medium.pressure(state_in_fore), 0, m_flow_reg) "Fore port inertial pressure";
  // dont regstep variables that are only in der(state), to increase accuracy
  SI.EnthalpyFlowRate H_flow_rear = (if m_flow_rear >= 0 then Medium.specificEnthalpy(state_in_rear) else h_out_rear) * m_flow_rear "Rear port enthalpy flow rate";
  SI.EnthalpyFlowRate H_flow_fore = (if m_flow_fore >= 0 then Medium.specificEnthalpy(state_in_fore) else h_out_fore) * m_flow_fore "Fore port enthalpy flow rate";
  SI.MassFlowRate Xi_flow_rear[Medium.nXi] = (if m_flow_rear >= 0 then Medium.massFraction(state_in_rear) else Xi_out_rear) * m_flow_rear "Rear port mass flow rates of species";
  SI.MassFlowRate Xi_flow_fore[Medium.nXi] = (if m_flow_fore >= 0 then Medium.massFraction(state_in_fore) else Xi_out_fore) * m_flow_fore "Fore port mass flow rates of species";

  Medium.ThermodynamicState state_out_rear "Rear port outlet state";
  SI.SpecificEnthalpy h_out_rear = Medium.specificEnthalpy(state_out_rear) "Rear port outlet state specific enthalpy";
  Medium.MassFraction Xi_out_rear[Medium.nXi] = Medium.massFraction(state_out_rear);
  Medium.ThermodynamicState state_out_fore "Fore port outlet state";
  SI.SpecificEnthalpy h_out_fore = Medium.specificEnthalpy(state_out_fore) "Fore port outlet state specific enthalpy";
  Medium.MassFraction Xi_out_fore[Medium.nXi] = Medium.massFraction(state_out_fore) "Fore port outlet state mass fractions";

  Real d(unit="1/(m.s)") = k_volume_damping*sqrt(abs(2*L/(V*max(density_derp_h, 1e-10)))) "Friction factor for coupled boundaries";
  SI.DerDensityByPressure density_derp_h "Partial derivative of density by pressure at constant specific enthalpy";
  SI.Pressure r_damping = d*der(M) "Inertial pressure damping";

  SI.Pressure r_rear_port, r_fore_port "Inertial pressures at rear/fore port";
  SI.MassFlowRate m_flow_rear, m_flow_fore "Mass flow rates at rear/fore port";
  Medium.ThermodynamicState state_in_rear, state_in_fore "Inlet states at rear/fore port";

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
  assert(M > 0, "Volumes might not become empty");

  der(m_flow_rear)*L = r_rear_port - r_rear_intern - r_damping;
  der(m_flow_fore)*L = r_fore_port - r_fore_intern - r_damping;

  der(M) = m_flow_rear + m_flow_fore;
  der(U_med) = Q_flow +H_flow_rear + H_flow_fore;
  der(MXi) = Xi_flow_rear + Xi_flow_fore;

  Q_flow = U*A*(T_heatPort - medium.T);

  if not useHeatport then
    T_heatPort = medium.T;
  end if;
  if not useRear then
    m_flow_rear = 0;
    state_in_rear = Medium.setState_phX(Medium.p_default, Medium.h_default, Medium.X_default[1:Medium.nXi]);
    end if;
  if not useFore then
    m_flow_fore = 0;
    state_in_fore = Medium.setState_phX(Medium.p_default, Medium.h_default, Medium.X_default[1:Medium.nXi]);
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
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This is the partial parent class for all undirected volumes with only one fore and rear. It is partial and is missing one equation for its volume or medium pressure and one for the volume work performed.</p>
<p>Conceptually a volume is a sink and a source. It therefore defines the level of inertial pressure r in a closed loop and acts as a loop breaker.</p>
<p>Volumes implement a damping term on the change of the stored mass to dampen out fast, otherwise undamped oscillations that appear when connecting volumes directly to other volumes or other boundaries (source, sink, boundary_fore, boundary_rear). With the damping term these oscillations will be still very fast, but dampened out, so a stiff solver might be able to handle them well. Damping is enabled by default and can be disabled by setting Advanced.k_volume_damping=0. </p>
<p>Per default the Volume has the two states energy and mass (U_med and M) and one state for each mass, as well as one state for each substance of the fluid (except the first one). These will be enforced to be states of the simulation, which can result in nonlinear systems of size one or two, but works very reliable. To get rid of these systems the modeler can enable the flag &apos;usePreferredMediumStates&apos; in the &apos;Advanced&apos; tab. Then the volume uses the states preferred by the medium object, rather then the default ones, which can improve the nonlinear systems most of the time, but also might lead to larger nonlinear systems (e.g. in the Test &apos;VolumesDirectCoupling&apos;).</p>
</html>"));
end PartialVolume;
