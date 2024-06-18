within ThermofluidStream.Undirected.Boundaries.Internal;
partial model PartialTankUndirected "Partial Tank model for media that are partial gas and incompressible liquid. Supports undirected flows"
  replaceable package Medium =
      ThermofluidStream.Media.myMedia.GasAndIncompressible.PartialGasAndIncompressible
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Volume. Make sure it is the same as the
inlets and outlets the volume is connected to.
</p>
</html>"));

  parameter Boolean useHeatport=false "If true heatport is added";
  parameter Modelica.Units.SI.Area A=1 "Contact area of volume with medium"
    annotation (Dialog(enable=useHeatport));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U=200
    "Heat transfer coefficient to medium"
    annotation (Dialog(enable=useHeatport));
  parameter Boolean initialize_pressure=true "If true: initialize Pressure"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Pressure p_start=Medium.p_default
    "Initial Pressure"
    annotation (Dialog(tab="Initialization", enable=initialize_pressure));
  parameter Boolean initialize_energy=false
    "Initialize specific inner energy with temperature or specific enthalpy condition"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Temperature T_start=Medium.T_default
    "Initial Temperature" annotation (Dialog(tab="Initialization", enable=
          initialize_energy and (not use_hstart)));
  parameter Boolean use_hstart=false
    "True: specific enthalpy condition instead of Temperature"
    annotation (Dialog(tab="Initialization", enable=initialize_energy));
  parameter Modelica.Units.SI.SpecificEnthalpy h_start=Medium.h_default
    "Initial specific enthalpy" annotation (Dialog(tab="Initialization", enable
        =initialize_energy and use_hstart));
  parameter Boolean initialize_Xi=false "If true: initialize mass fractions"
    annotation (Dialog(tab="Initialization"));
  parameter Medium.MassFraction Xi_0[Medium.nXi]=Medium.X_default[1:Medium.nXi]
    "Initial mass fraction"
    annotation (Dialog(tab="Initialization", enable=initialize_Xi));
  parameter Boolean initialize_LiquidMass=true
    "If true: initialize with mass of the liquid medium component. Initialize_Xi must be false."
    annotation (Dialog(tab="Initialization", enable=not initialize_Xi));
  parameter Modelica.Units.SI.Mass M_liq_start=0 "Initial mass of the liquid"
    annotation (Dialog(tab="Initialization", enable=initialize_LiquidMass));

  parameter Utilities.Units.Inertance L=dropOfCommons.L
    "Inertance at inlet and outlet" annotation (Dialog(tab="Advanced"));
  parameter Real k_volume_damping(unit="1") = dropOfCommons.k_volume_damping
    "Damping factor multiplicator"
    annotation (Dialog(tab="Advanced", group="Damping"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_assert(max=0) = -
    dropOfCommons.m_flow_reg "Assertion threshold for negative massflows"
    annotation (Dialog(tab="Advanced"));
  parameter Boolean usePreferredMediumStates=false
    "Use medium states instead of the ones differentiated in this component"
    annotation (Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_reg=dropOfCommons.m_flow_reg
    "Regularization threshold of mass flow rate"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.Units.SI.Length outletTransition=0.01
    "Width of band for smooth transition between gas and liquid at outlet"
    annotation (Dialog(tab="Advanced"));
  parameter Boolean chaoticLife=false
    "Allows small gas bubbles to go from inlet through liquid even if staticHead is positive, experimental. Large increase in simulation time."
    annotation (Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.Volume gasBubbleVolume=0.0001
    "Tuning parameter for size of gas bubbles"
    annotation (Dialog(tab="Advanced", enable=chaoticLife));

  ThermofluidStream.Interfaces.Inlet inlet[N_inlets](redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-118,20},{-78,60}})));
  ThermofluidStream.Interfaces.Outlet outlet[N_outlets](redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{80,20},{120,60}})));
  Undirected.Interfaces.Rear rear[N_rears](redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-66},{-80,-26}}),
        iconTransformation(extent={{-120,-66},{-80,-26}})));
  Undirected.Interfaces.Fore fore[N_fores](redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{78,-66},{118,-26}}),
        iconTransformation(extent={{78,-66},{118,-26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(Q_flow=Q_flow, T
      =T_heatPort) if useHeatport
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));

  Medium.BaseProperties medium(preferredMediumStates=usePreferredMediumStates);

  Modelica.Units.SI.Volume V;
  Modelica.Units.SI.Volume V_liquid;
  parameter SI.Pressure p_ref=1e5
    "Reference pressure of tank when volume is measured";
  //The tank gets a bulk modulus to handle the stiffness of incompressible media better
  SI.Volume V_ref(displayUnit="l") "Volume of the tank at p_ref";
  parameter SI.BulkModulus K=5e7
    "Bulk modulus of tank (used also for stiffness modulation)";

  //setting the state is to prohibit dynamic state selection e.g. in VolumesDirectCoupling
  Modelica.Units.SI.Mass M(stateSelect=if usePreferredMediumStates then
        StateSelect.default else StateSelect.always) = V*medium.d;
  Modelica.Units.SI.Mass MXi[Medium.nXi](each stateSelect=if
        usePreferredMediumStates then StateSelect.default else StateSelect.always)
     = M*medium.Xi;
  Modelica.Units.SI.Energy U_med(stateSelect=if usePreferredMediumStates then
        StateSelect.default else StateSelect.always) = M*medium.u;

  Modelica.Units.SI.HeatFlowRate Q_flow;
  Modelica.Units.SI.Power W_v;
  parameter Modelica.Units.SI.Length tankCenter[3]={0,0,0}
    "Position of the tank center"
    annotation (Dialog(tab="General", group="Geometry"));
  parameter Integer N_inlets=2 "Number of inlets"
    annotation (Dialog(tab="General", group="Geometry"));
  parameter Integer N_outlets=2 "Number of outlets"
    annotation (Dialog(tab="General", group="Geometry"));
  parameter Integer N_rears=2 "Number of rears"
    annotation (Dialog(tab="General", group="Geometry"));
  parameter Integer N_fores=2 "Number of fores"
    annotation (Dialog(tab="General", group="Geometry"));
  parameter Modelica.Units.SI.Length inletPositions[N_inlets,3]={{0,0,0} for i in
          1:N_inlets} "Positions of all inlets"
    annotation (Dialog(tab="General", group="Geometry"));
  parameter Modelica.Units.SI.Length outletPositions[N_outlets,3]={{0,0,0} for
      i in 1:N_outlets} "Positions of all outlets"
    annotation (Dialog(tab="General", group="Geometry"));
  parameter Modelica.Units.SI.Length rearPositions[N_rears,3]={{0,0,0} for i in
          1:N_rears} "Positions of all rears"
    annotation (Dialog(tab="General", group="Geometry"));
  parameter Modelica.Units.SI.Length forePositions[N_fores,3]={{0,0,0} for i in
          1:N_fores} "Positions of all fores"
    annotation (Dialog(tab="General", group="Geometry"));
  Modelica.Units.SI.Length centreOfMass[3];

  Modelica.Units.SI.Length staticHeadInlets[N_inlets]
    "distance perpendicular to liquid surface";
  Modelica.Units.SI.Length staticHeadOutlets[N_outlets]
    "distance perpendicular to liquid surface";
  Modelica.Units.SI.Length staticHeadRears[N_rears]
    "distance perpendicular to liquid surface";
  Modelica.Units.SI.Length staticHeadFores[N_fores]
    "distance perpendicular to liquid surface";
  Modelica.Units.SI.Pressure staticHeadInlets_Pa_relative[N_inlets]
    "relative pressure to liquid surface";
  Modelica.Units.SI.Pressure staticHeadOutlets_Pa_relative[N_outlets]
    "relative pressure to liquid surface";
  Modelica.Units.SI.Pressure staticHeadRears_Pa_relative[N_rears]
    "relative pressure to liquid surface";
  Modelica.Units.SI.Pressure staticHeadFores_Pa_relative[N_fores]
    "relative pressure to liquid surface";

  Real normAcc[3]=Modelica.Math.Vectors.normalize(acceleration.a);

protected
  outer DropOfCommons dropOfCommons;
  outer ThermofluidStream.Boundaries.AccelerationBoundary acceleration;
  Modelica.Units.SI.Pressure p_in[N_inlets]=Medium.pressure(inlet.state);
  Modelica.Units.SI.SpecificEnthalpy h_in[N_inlets];
  Medium.MassFraction Xi_in[Medium.nXi,N_inlets];

  Medium.ThermodynamicState state_out[N_outlets];
  Modelica.Units.SI.SpecificEnthalpy h_out[N_outlets];
  Medium.MassFraction Xi_out[Medium.nXi,N_outlets];

  Medium.ThermodynamicState state_out_rear[N_rears];
  Medium.ThermodynamicState state_out_fore[N_fores];

  SI.Pressure r_rear[N_rears];
  SI.Pressure r_fore[N_fores];
  SI.SpecificEnthalpy h_rear[N_rears];
  SI.SpecificEnthalpy h_fore[N_fores];
  Medium.MassFraction Xi_rear[Medium.nXi,N_rears];
  Medium.MassFraction Xi_fore[Medium.nXi,N_fores];

  Real d(unit="1/(m.s)") = k_volume_damping*sqrt(abs(2*L/(V*max(density_derp_h,
    1e-10)))) "Friction factor for coupled boundaries";
  //Modelica.Units.SI.DerDensityByPressure density_derp_h=1e-5 "Partial derivative of density by pressure";
  Modelica.Units.SI.DerDensityByPressure density_derp_h=(V_ref*medium.d)/(V*K)
    "Partial derivative of density by pressure";

  Modelica.Units.SI.Pressure r_damping=d*der(M);

  Modelica.Units.SI.Pressure r[N_inlets];

  Modelica.Units.SI.Temperature T_heatPort;

  Modelica.Units.SI.MassFlowRate m_flow_in[N_inlets]=inlet.m_flow;
  Modelica.Units.SI.MassFlowRate m_flow_out[N_outlets]=outlet.m_flow;

  final parameter Real ThresholdFull = 0.995 "threshold value near 1 to indicate when full";
  final parameter Real ThresholdEmpty = 0.003 "threshold value near 0 to indicate when empty";

  Boolean fFull;
  Boolean fEmpty;
  Real shiftOutlet[N_outlets];
  //Real shiftOutletUp[N_outlets];
  Real shiftRear[N_rears];
  //Real shiftRearUp[N_rears];
  Real shiftFore[N_fores];
  //Real shiftForeUp[N_fores];
  Modelica.Units.SI.Density liquidDensity=Medium.Liquid.density(medium.state)
    "density of the liquid in the tank";
  Modelica.Units.SI.Density gasDensity=Medium.Gas.density(medium.state)
    "density of the gas in the tank";
  Real fChaoticLife[N_inlets];
initial equation
  if initialize_pressure then
    medium.p = p_start;
  end if;

  if initialize_energy then
    if use_hstart then
      medium.h = h_start;
    else
      medium.T = T_start;
    end if;
  end if;

  if initialize_Xi then
    medium.Xi = Xi_0;
  elseif initialize_LiquidMass then
    assert(
      V - M_liq_start/liquidDensity > 0,
      "Initial liquid mass is larger then the tank can contain",
      level=AssertionLevel.error);
    medium.Xi = {(V - M_liq_start/liquidDensity)*gasDensity/((V - M_liq_start/
      liquidDensity)*gasDensity + M_liq_start),M_liq_start/((V - M_liq_start/
      liquidDensity)*gasDensity + M_liq_start)};
  end if;

equation
  for i in 1:N_inlets loop
    assert(
      m_flow_in[i] > m_flow_assert,
      "Negative massflow at tank inlet",
      dropOfCommons.assertionLevel);
  end for;
  for i in 1:N_outlets loop
    assert(
      -m_flow_out[i] > m_flow_assert,
      "Positive massflow at tank outlet",
      dropOfCommons.assertionLevel);
  end for;

  assert(M > 0, "Tanks might not become empty");

  der(inlet.m_flow)*L = inlet.r - r - r_damping*ones(N_inlets);
  der(outlet.m_flow)*L = outlet.r - r_damping*ones(N_outlets);
  der(rear.m_flow)*L = rear.r - r_rear - r_damping*ones(N_rears);
  der(fore.m_flow)*L = fore.r - r_fore - r_damping*ones(N_fores);

  for i in 1:N_inlets loop
    staticHeadInlets_Pa_relative[i] = liquidDensity*acceleration.a*normAcc*
      staticHeadInlets[i];

    if chaoticLife and abs(der(M)) < 1e-1 and Xi_in[1, i] > 0.8 then
      fChaoticLife[i] = abs(inlet[i].r)/sqrt((inlet[i].r)^2 + 1e-4^2);
    else
      fChaoticLife[i] = 0;
    end if;
    //if ChaoticLife and a "static" state, lower the static head temporarily to allow gas to bubble in
    r[i] + p_in[i] = medium.p + (1 - gasBubbleVolume/V_ref*fChaoticLife[i])*max(
       0, staticHeadInlets_Pa_relative[i]);

    // fix potential instabilities by setting the outgoing enthalpy and mass fraction to the medium state
    h_in[i] = if noEvent(m_flow_in[i] >= 0) then Medium.specificEnthalpy(inlet[
      i].state) else medium.h;
    Xi_in[:, i] = if noEvent(m_flow_in[i] >= 0) then Medium.massFraction(inlet[
      i].state) else medium.Xi;
  end for;

  //indication on tank nearly filled with liquid
  fFull = if V_liquid > ThresholdFull*V_ref then true else false;
  //indication on tank nearly emptied of liquid
  fEmpty = if V_liquid < ThresholdEmpty*V_ref then true else false;

  for i in 1:N_outlets loop
    // fix potential instabilities by setting the outgoing enthalpy and mass fraction to the medium state

    h_out[i] = if noEvent(-m_flow_out[i] >= 0) then Medium.specificEnthalpy(
      state_out[i]) else medium.h;
    Xi_out[:, i] = if noEvent(-m_flow_out[i] >= 0) then Medium.massFraction(
      state_out[i]) else medium.Xi;

    staticHeadOutlets_Pa_relative[i] = liquidDensity*acceleration.a*normAcc*
      staticHeadOutlets[i];

    //due to the transition interval of the reg_step, connectors must be shifted inside the tank
    //perimeters when the tank is nearly filled with liquid and there is an outlet on the surface
    //or when the tank is nearly empty and there is an outlet on the surface
    //The full case is moved further down to get better numeric performance with more gas remaining
    if fFull and abs(staticHeadOutlets[i]) < 4*outletTransition then
      shiftOutlet[i] = 3;
    elseif fEmpty and abs(staticHeadOutlets[i]) < 3*outletTransition then
      shiftOutlet[i] = -1;
    else
      shiftOutlet[i] = 0;
    end if;
    //liquid at outlet if static head >0, else gas, with smooth transition
    state_out[i] = Medium.setState_pTX(
      medium.p + max(0, staticHeadOutlets_Pa_relative[i]),
      medium.T,
      {ThermofluidStream.Undirected.Internal.regStep(
        staticHeadOutlets[i] +shiftOutlet[i]*outletTransition,
        0,
        1,
        outletTransition),ThermofluidStream.Undirected.Internal.regStep(
        staticHeadOutlets[i] + shiftOutlet[i]*outletTransition,
        1,
        0,
        outletTransition)});
  end for;

  for i in 1:N_rears loop
    staticHeadRears_Pa_relative[i] = liquidDensity*acceleration.a*normAcc*
      staticHeadRears[i];
    //due to the transition interval of the reg_step, connectors must be shifted inside the tank
    //perimeters when the tank is nearly filled with liquid and there is an outlet on the surface
    //or when the tank is nearly empty  and there is an outlet on the surface
    //The full case is moved further down to get better numeric performance with more gas remaining
    if fFull and abs(staticHeadRears[i]) < 4*outletTransition then
      shiftRear[i] = 3;
    elseif fEmpty and abs(staticHeadRears[i]) < 3*outletTransition then
      shiftRear[i] = -1;
    else
      shiftRear[i] = 0;
    end if;

    r_rear[i] = ThermofluidStream.Undirected.Internal.regStep(
      rear[i].m_flow,
      medium.p + max(0, staticHeadRears_Pa_relative[i]) - Medium.pressure(rear[
        i].state_forwards),
      0,
      m_flow_reg);
    // dont regstep variables that are only in der(state), to increase accuracy
    h_rear[i] = if rear[i].m_flow >= 0 then Medium.specificEnthalpy(rear[i].state_forwards)
       else Medium.specificEnthalpy(state_out_rear[i]);
    Xi_rear[:, i] = if rear[i].m_flow >= 0 then Medium.massFraction(rear[i].state_forwards)
       else Medium.massFraction(state_out_rear[i]);

    state_out_rear[i] = Medium.setState_pTX(
      medium.p + max(0, staticHeadRears_Pa_relative[i]),
      medium.T,
      {ThermofluidStream.Undirected.Internal.regStep(
        staticHeadRears[i] + shiftRear[i]*outletTransition,
        0,
        1,
        outletTransition),ThermofluidStream.Undirected.Internal.regStep(
        staticHeadRears[i] + shiftRear[i]*outletTransition,
        1,
        0,
        outletTransition)});

    rear[i].state_rearwards = state_out_rear[i];
  end for;

  for i in 1:N_fores loop
    staticHeadFores_Pa_relative[i] = liquidDensity*acceleration.a*normAcc*
      staticHeadFores[i];
    //due to the transition interval of the reg_step, connectors must be shifted inside the tank
    //perimeters when the tank is nearly filled with liquid and there is an outlet on the surface
    //or when the tank is nearly empty and there is an outlet on the surface
    //The full case is moved further down to get better numeric performance with more gas remaining
    if fFull and abs(staticHeadFores[i]) < 4*outletTransition then
      shiftFore[i] = 3;
    elseif fEmpty and abs(staticHeadFores[i]) < 3*outletTransition then
      shiftFore[i] = -1;
    else
      shiftFore[i] = 0;
    end if;
    r_fore[i] = ThermofluidStream.Undirected.Internal.regStep(
      fore[i].m_flow,
      medium.p + max(0, staticHeadFores_Pa_relative[i]) - Medium.pressure(fore[
        i].state_rearwards),
      0,
      m_flow_reg);
    // dont regstep variables that are only in der(state), to increase accuracy
    h_fore[i] = if fore[i].m_flow >= 0 then Medium.specificEnthalpy(fore[i].state_rearwards)
       else Medium.specificEnthalpy(state_out_fore[i]);
    Xi_fore[:, i] = if fore[i].m_flow >= 0 then Medium.massFraction(fore[i].state_rearwards)
       else Medium.massFraction(state_out_fore[i]);

    state_out_fore[i] = Medium.setState_pTX(
      medium.p + max(0, staticHeadFores_Pa_relative[i]),
      medium.T,
      {ThermofluidStream.Undirected.Internal.regStep(
        staticHeadFores[i] + shiftFore[i]*outletTransition,
        0,
        1,
        outletTransition),ThermofluidStream.Undirected.Internal.regStep(
        staticHeadFores[i] + shiftFore[i]*outletTransition,
        1,
        0,
        outletTransition)});

    fore[i].state_forwards = state_out_fore[i];
  end for;

  V_liquid = MXi[end]/liquidDensity;

  medium.p = p_ref + K*(V/V_ref - 1);

  der(M) = sum(inlet.m_flow) + sum(outlet.m_flow) + sum(rear.m_flow) + sum(fore.m_flow);
  der(U_med) = W_v + Q_flow + sum(inlet.m_flow .* h_in) + sum(outlet.m_flow .*
    h_out) + h_rear*rear.m_flow + h_fore*fore.m_flow;
  der(MXi) = Xi_in*inlet.m_flow + Xi_out*outlet.m_flow + Xi_rear*rear.m_flow +
    Xi_fore*fore.m_flow;

  Q_flow = U*A*(T_heatPort - medium.T);
  W_v = 0;

  outlet.state = state_out;

  if not useHeatport then
    T_heatPort = medium.T;
  end if;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
          thickness=0.5),
        Ellipse(extent={{-60,24},{60,-32}}, lineColor={28,108,200}),
        Line(
          points={{20,100},{-24,42}},
          color={206,103,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Line(
          points={{52,78},{8,20}},
          color={206,103,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Line(
          points={{84,56},{40,-2}},
          color={206,103,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Text(
          extent={{-120,108},{-94,66}},
          textColor={116,116,116},
          textString="%N_inlets"),
        Text(
          extent={{98,108},{124,66}},
          textColor={116,116,116},
          textString="%N_outlets"),
        Text(
          extent={{40,102},{84,70}},
          textColor={206,103,0},
          textString="a"),
        Text(
          extent={{98,-70},{124,-112}},
          textColor={116,116,116},
          textString="%N_fores"),
        Text(
          extent={{-122,-70},{-96,-112}},
          textColor={116,116,116},
          textString="%N_rears")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>To complete the partialTank, equations for total tank volume V, centreOfMass, staticHeadInlets and staticHeadOutlets needs to be provided. </p>
<p>This separation is made to make it easy to implement arbitrary geometries. In this component, medium.p is interpreted as the pressure at the liquid surface.</p>
<p>This Volume is the parent class for Accumulator and Receiver models that separate the two phases and are able to output gas, liquid or two-phase medium, depending on its liquid level and the height of the outlet. </p>
<p>Since there is no formula to compute density_derp_h for this volume, an upper bound has to be set in the parameter density_derp_h_set. Alternativeley the derivative can be taken from the media model for all the media that implement the corresponding formula by setting density_derp_h_from_media=true (default:false).</p>
<p><span style=\"font-family: Arial; color: #ff5500;\">Beware: This is a new addition to the library. It may be subject to design reconsiderations in future versions</span></p>
</html>"));
end PartialTankUndirected;
