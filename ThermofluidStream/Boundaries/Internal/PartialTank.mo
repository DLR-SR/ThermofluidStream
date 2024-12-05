within ThermofluidStream.Boundaries.Internal;
partial model PartialTank "Partial Tank model for media that are partial gas and incompressible liquid"
  replaceable package Medium =
      ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.PartialSingleGasAndIncompressible
    "Medium model" annotation (
      choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Volume. Make sure it is the same as the
inlets and outlets the volume is connected to.
</p>
</html>"));

  parameter Boolean useHeatport = false "If true heatport is added";
  parameter Modelica.Units.SI.Area A = 1 "Contact area of volume with medium"
    annotation(Dialog(enable=useHeatport));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U = 200 "Heat transfer coefficient to medium"
    annotation(Dialog(enable=useHeatport));
 parameter Boolean initialize_pressure = true "If true: initialize Pressure"
    annotation(Dialog(tab= "Initialization"));
  parameter Modelica.Units.SI.Pressure p_start = Medium.p_default "Initial Pressure"
    annotation(Dialog(tab= "Initialization", enable=initialize_pressure));
  parameter Boolean initialize_energy = false "Initialize specific inner energy with temperature or specific enthalpy condition"
    annotation(Dialog(tab= "Initialization"));
  parameter Modelica.Units.SI.Temperature T_start = Medium.T_default "Initial Temperature"
    annotation(Dialog(tab= "Initialization", enable=initialize_energy and (not use_hstart)));
  parameter Boolean use_hstart = false "True: specific enthalpy condition instead of Temperature"
    annotation(Dialog(tab= "Initialization", enable=initialize_energy));
  parameter Modelica.Units.SI.SpecificEnthalpy h_start = Medium.h_default "Initial specific enthalpy"
    annotation(Dialog(tab= "Initialization", enable=initialize_energy and use_hstart));
  parameter Boolean initialize_Xi = false "If true: initialize mass fractions"
    annotation(Dialog(tab= "Initialization"));
  parameter Medium.MassFraction Xi_0[Medium.nXi] = Medium.X_default[1:Medium.nXi] "Initial mass fraction"
    annotation(Dialog(tab= "Initialization", enable=initialize_Xi));
  parameter Boolean initialize_LiquidMass = true "If true: initialize with mass of the liquid medium component. Initialize_Xi must be false."
    annotation(Dialog(tab= "Initialization", enable=not initialize_Xi));
  parameter Modelica.Units.SI.Mass M_liq_start=0 "Initial mass of the liquid"
    annotation(Dialog(tab= "Initialization", enable=initialize_LiquidMass));

  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance at inlet and outlet"
    annotation (Dialog(tab="Advanced"));
  parameter Real k_volume_damping(unit="1") = dropOfCommons.k_volume_damping "Damping factor multiplicator"
    annotation(Dialog(tab="Advanced", group="Damping"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_assert(max=0) = -dropOfCommons.m_flow_reg "Assertion threshold for negative massflows"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean usePreferredMediumStates=false "Use medium states instead of the ones differentiated in this component"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.Length outletTransition=0.01 "Width of band for smooth transition between gas and liquid at outlet"
                                                                                                                                 annotation(Dialog(tab="Advanced"));


  Interfaces.Inlet inlet[N_inlets](redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outlet[M_outlets](redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(Q_flow=Q_flow, T=T_heatPort) if useHeatport
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));

  Medium.BaseProperties medium(preferredMediumStates=usePreferredMediumStates);

  Modelica.Units.SI.Volume V;
  Modelica.Units.SI.Volume V_liquid;
  parameter SI.Pressure p_ref = 1e5 "Reference pressure of tank when volume is measured";
  //The tank gets a bulk modulus to handle the stiffness of incompressible media better
  SI.Volume V_ref(displayUnit="l") "Volume of the tank at p_ref";
  parameter SI.BulkModulus K = 5e7 "Bulk modulus of tank (used also for stiffness modulation)";

  //Modelica.Units.SI.Volume V_gas "Gas volume in Tank";

  //setting the state is to prohibit dynamic state selection e.g. in VolumesDirectCoupling
  Modelica.Units.SI.Mass M(stateSelect=if usePreferredMediumStates then StateSelect.default else StateSelect.always) = V*medium.d;
  Modelica.Units.SI.Mass MXi[Medium.nXi](each stateSelect=if usePreferredMediumStates then StateSelect.default else StateSelect.always) = M*medium.Xi;
  Modelica.Units.SI.Energy U_med(stateSelect=if usePreferredMediumStates then StateSelect.default else StateSelect.always) = M*medium.u;

  Modelica.Units.SI.HeatFlowRate Q_flow;
  Modelica.Units.SI.Power W_v;
   parameter Modelica.Units.SI.Length tankCenter[3]={0,0,0} "Position of the tank center" annotation(Dialog(tab="General",group="Geometry"));
   parameter Integer N_inlets = 2 "Number of inlets"
                                                    annotation(Dialog(tab="General",group="Geometry"));
   parameter Integer M_outlets = 2 "Number of outlets"
                                                      annotation(Dialog(tab="General",group="Geometry"));

   parameter Modelica.Units.SI.Length inletPositions[N_inlets,3]={{0,0,0},{0,0,0}} "Positions of all inlets" annotation(Dialog(tab="General",group="Geometry"));
   parameter Modelica.Units.SI.Length outletPositions[M_outlets,3]={{0,0,0},{0,0,0}} "Positions of all outlets" annotation(Dialog(tab="General",group="Geometry"));
   Modelica.Units.SI.Length centerOfMass[3];

   Modelica.Units.SI.Length staticHeadInlets[N_inlets] "distance perpendicular to liquid surface, 0 if above surface";
   Modelica.Units.SI.Length staticHeadOutlets[M_outlets] "distance perpendicular to liquid surface, 0 if above surface";
   Medium.AbsolutePressure staticHeadInlets_Pa_relative[N_inlets] "relative pressure to liquid surface, 0 if above surface";
   Medium.AbsolutePressure staticHeadOutlets_Pa_relative[M_outlets] "relative pressure to liquid surface, 0 if above surface";

Real normAcc[3]=Modelica.Math.Vectors.normalize(acceleration.a);



protected
  outer DropOfCommons dropOfCommons;
  outer ThermofluidStream.Boundaries.AccelerationBoundary acceleration;

  Medium.AbsolutePressure p_in[N_inlets] = Medium.pressure(inlet.state);
  Medium.SpecificEnthalpy h_in[N_inlets];
  Medium.MassFraction Xi_in[Medium.nXi,N_inlets];

  Medium.ThermodynamicState state_out[M_outlets];
  Medium.SpecificEnthalpy h_out[M_outlets];
  Medium.MassFraction Xi_out[Medium.nXi,M_outlets];

  Real d(unit="1/(m.s)") = k_volume_damping*sqrt(abs(2*L/(V*max(density_derp_h, 1e-10)))) "Friction factor for coupled boundaries";
  //Modelica.Units.SI.DerDensityByPressure density_derp_h=1e-5 "Partial derivative of density by pressure";
   Medium.DerDensityByPressure density_derp_h=(V_ref*medium.d)/(V*K) "Partial derivative of density by pressure";

  Medium.AbsolutePressure r_damping = d*der(M);

  Medium.AbsolutePressure r[N_inlets];

  Medium.Temperature T_heatPort;

  Medium.MassFlowRate m_flow_in[N_inlets] = inlet.m_flow;
  Medium.MassFlowRate m_flow_out[M_outlets] = outlet.m_flow;

  final parameter Real ThresholdFull = 0.995 "threshold value near 1 to indicate when full";
  final parameter Real ThresholdEmpty = 0.003 "threshold value near 0 to indicate when empty";

  Boolean fFull;
  Boolean fEmpty;
  Real shiftOutlet[M_outlets];
  Medium.Density liquidDensity=Medium.Incompressible.density(Medium.Incompressible.setState_pTX(medium.state.p,medium.state.T))
   "density of the liquid in the tank";
  Medium.Density gasDensity=Medium.SingleGas.density(Medium.SingleGas.setState_pTX(medium.state.p,medium.state.T))
   "density of the gas in the tank";
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
  elseif initialize_LiquidMass then
    assert(V-M_liq_start/liquidDensity > 0,"Initial liquid mass is larger then the tank can contain",level = AssertionLevel.error);
      medium.Xi={(V-M_liq_start/liquidDensity)*gasDensity/((V-M_liq_start/liquidDensity)*gasDensity+M_liq_start),M_liq_start/((V-M_liq_start/liquidDensity)*gasDensity+M_liq_start)};
  end if;

equation
  for i in 1:N_inlets loop
    assert(m_flow_in[i] > m_flow_assert, "Negative massflow at tank inlet", dropOfCommons.assertionLevel);
  end for;
    for i in 1:M_outlets loop
    assert(-m_flow_out[i] > m_flow_assert, "Positive massflow at tank outlet", dropOfCommons.assertionLevel);
  end for;

  assert(M > 0, "Tanks might not become empty");

  der(inlet.m_flow)*L = inlet.r - r - r_damping*ones(N_inlets);
  der(outlet.m_flow)*L = outlet.r - r_damping*ones(M_outlets);

  for i in 1:N_inlets loop
    staticHeadInlets_Pa_relative[i]=liquidDensity*acceleration.a*normAcc*staticHeadInlets[i];
    r[i] + p_in[i] = medium.p + max(0,staticHeadInlets_Pa_relative[i]);

    // fix potential instabilities by setting the outgoing enthalpy and mass fraction to the medium state
    h_in[i] =  if noEvent(m_flow_in[i] >= 0) then Medium.specificEnthalpy(inlet[i].state) else medium.h;
    Xi_in[:,i] = if noEvent(m_flow_in[i] >= 0) then Medium.massFraction(inlet[i].state) else medium.Xi;
  end for;
  //indication on tank nearly filled with liquid
  fFull = if V_liquid > ThresholdFull*V_ref then true else false;
  //indication on tank nearly emptied of liquid
  fEmpty = if V_liquid < ThresholdEmpty*V_ref then true else false;


  for i in 1:M_outlets loop
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


  V_liquid= MXi[end]/liquidDensity;

  medium.p = p_ref + K*(V/V_ref-1);

  der(M) = sum(inlet.m_flow) + sum(outlet.m_flow);
  der(U_med) = W_v + Q_flow + sum(inlet.m_flow.*h_in) + sum(outlet.m_flow.*h_out);
  der(MXi) = Xi_in*inlet.m_flow + Xi_out*outlet.m_flow;

  Q_flow = U*A*(T_heatPort - medium.T);
  W_v = 0;

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
         extent={{-120,48},{-94,6}},
         textColor={116,116,116},
          textString="%N_inlets"),
       Text(
         extent={{68,48},{94,6}},
         textColor={116,116,116},
          textString="%M_outlets"),
        Text(
          extent={{40,102},{84,70}},
          textColor={206,103,0},
          textString="a")}),Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This Volume is the parent class for Accumulator and Receiver models that separate the two phases and are able to output gas, liquid or two-phase medium, depending on its liquid level and the height of the outlet. Numerical stiffness is handled the same way as in the VolumeFlex.</p>
<p>To complete the partialTank, equations for total tank volume V, centreOfMass, staticHeadInlets and staticHeadOutlets needs to be provided. This separation is made to make it easy to implement arbitrary geometries. In this component, medium.p is interpreted as the pressure at the liquid surface.</p>
<p>Since there is no formula to compute density_derp_h for this volume, an upper bound has to be set in the parameter density_derp_h_set. Alternativeley the derivative can be taken from the media model for all the media that implement the corresponding formula by setting density_derp_h_from_media=true (default:false)</p>
<p>The fundamental idea of the model is based on work by Hans Ellstroem (https://www.researchgate.net/profile/Soeren-Steinkellner/publication/312590863_MODELLING_AND_SIMULATION_OF_FUEL_SYSTEMS_IN_MILITARY_AIRCRAFTS/links/5884927e4585150dde47b6aa/MODELLING-AND-SIMULATION-OF-FUEL-SYSTEMS-IN-MILITARY-AIRCRAFTS.pdf).</p>
<p><span style=\"color: #ff5500;\">Beware: This is a new addition to the library. It may be subject to design reconsiderations in future versions.</span></p>
</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end PartialTank;
