within ThermofluidStream.HeatExchangers;
model DiscretizedCrossFlowHEX "Discretized Heat Exchanger for single- or two-phase working fluid without pressure drop"
  extends Internal.DiscretizedHexIcon;

  replaceable package MediumA =
      ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model side A"
    annotation (choicesAllMatching=true, Dialog(group = "Medium definitions"));
  replaceable package MediumB =
      ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model side B"
    annotation (choicesAllMatching=true, Dialog(group = "Medium definitions"));

  replaceable model ConductionElementA = Internal.ConductionElementHEX
    constrainedby Internal.PartialConductionElementHEX(
      final nCellsParallel= nCells,
      final A=A/nCells,
      final V=V_Hex/nCells,
      redeclare package Medium=MediumA,
      final enforce_global_energy_conservation=enforce_global_energy_conservation)
    "Heat transfer element model for side A"
      annotation(choicesAllMatching=true, Dialog(group = "Medium definitions"));
  replaceable model ConductionElementB = Internal.ConductionElementHEX
    constrainedby Internal.PartialConductionElementHEX(
      final nCellsParallel= 1,
      final A=A/nCells,
      final V=V_Hex/nCells,
      redeclare package Medium=MediumB,
      final enforce_global_energy_conservation=enforce_global_energy_conservation)
    "Heat transfer element model for side B"
      annotation(choicesAllMatching=true, Dialog(group = "Medium definitions"));

  parameter Boolean initializeMassFlow=false "Initialize mass flow at inlets?" annotation(Dialog(tab = "Initialization", group = "Mass flow"));
  parameter SI.MassFlowRate m_flow_0_A = 0 "Initial mass flow for side A"
    annotation(Dialog(tab = "Initialization", group = "Mass flow", enable = initializeMassFlow));
  parameter SI.MassFlowRate m_flow_0_B = 0 "Initial mass flow for side B"
    annotation(Dialog(tab = "Initialization", group = "Mass flow", enable = initializeMassFlow));
  parameter Integer nCells = 3 "Number of discretization elements";
  parameter Modelica.Units.SI.Area A=10 "Conductive area of heat exchanger"
    annotation (Dialog(group="Heat transfer parameters"));
  parameter Modelica.Units.SI.Volume V_Hex=0.001
    "Volume for heat transfer calculation"
    annotation (Dialog(group="Heat transfer parameters"));
  parameter SI.MassFlowRate m_flow_assert(max=0) = -dropOfCommons.m_flow_reg "Assertion threshold for negative massflows"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean enforce_global_energy_conservation = false "If true, exact global energy conservation is enforced by feeding back all energy stored locally back in the system"
    annotation(Dialog(tab="Advanced"));

  //Parameterization of HEX Wall
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer k_wall=100
    "Coefficient of heat transfer for wall"
    annotation (Dialog(group="Heat transfer parameters"));

  parameter Boolean calculate_efficiency= false "Enable calculation of efficiency";
protected
  parameter Modelica.Units.SI.ThermalConductance G=k_wall*A
    "Wall thermal conductance" annotation (Dialog(group="Wall parameters"));

public
  ConductionElementA thermalElementA[nCells] annotation (Placement(transformation(extent={{-10,90},{10,70}})));

  ConductionElementB thermalElementB[nCells] annotation (Placement(transformation(extent={{10,-90},{-10,-70}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[nCells](each G=G/nCells)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));
  Interfaces.Inlet inletA(redeclare package Medium = MediumA)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-98,80}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,100})));
  Interfaces.Outlet outletA(redeclare package Medium = MediumA) annotation (Placement(transformation(extent={{92,70},{112,90}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-100})));
  Interfaces.Inlet inletB(redeclare package Medium = MediumB) annotation (Placement(transformation(extent={{110,-90},{90,-70}})));
  Interfaces.Outlet outletB(redeclare package Medium = MediumB) annotation (Placement(transformation(extent={{-92,-90},{-112,-70}})));

  SI.HeatFlowRate Q_flow_A=sum(thermalElementA.heatPort.Q_flow);
  SI.HeatFlowRate Q_flow_B=sum(thermalElementB.heatPort.Q_flow);
  SI.Mass M_A=sum(thermalElementA.M);
  SI.Mass M_B=sum(thermalElementB.M);
  SI.Energy deltaE_system=sum(thermalElementA.deltaE_system) + sum(thermalElementB.deltaE_system);

  ThermofluidStream.HeatExchangers.Internal.DiscretizedHEXSummary summary "Summary record of Quantities";

  Processes.FlowResistance flowResistanceA[nCells](
    redeclare package Medium = MediumA,
    each r(each displayUnit="mm") = 0.025,
    each l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      each k=50))
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Topology.JunctionN junctionN(redeclare package Medium = MediumA, N=nCells) annotation (Placement(transformation(extent={{50,70},{70,90}})));
  Topology.SplitterN splitterN(redeclare package Medium = MediumA, N=nCells) annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
protected
  outer DropOfCommons dropOfCommons;

  function efficiency = Internal.calculateEfficiency (
    redeclare package MediumA = MediumA,
    redeclare package MediumB = MediumB);

initial equation

  if initializeMassFlow then
    inletB.m_flow = m_flow_0_B;
    flowResistanceA.m_flow = m_flow_0_A/nCells*ones(nCells);
  else
    for i in 1:nCells-1 loop
      flowResistanceA[i + 1].m_flow = flowResistanceA[1].m_flow;
    end for;
  end if;

equation
  assert(inletA.m_flow > m_flow_assert,"Negative massflow at Air inlet",dropOfCommons.assertionLevel);
  assert(inletB.m_flow > m_flow_assert,"Negative massflow at Refigerant inlet",dropOfCommons.assertionLevel);

  //Summary record
  summary.Tin_B =MediumB.temperature(inletB.state);
  summary.Tin_A =MediumA.temperature(inletA.state);
  summary.Tout_B =MediumB.temperature(outletB.state);
  summary.Tout_A =MediumA.temperature(outletA.state);
  summary.hin_B =MediumB.specificEnthalpy(inletB.state);
  summary.hin_A =MediumA.specificEnthalpy(inletA.state);
  summary.hout_B =MediumB.specificEnthalpy(outletB.state);
  summary.hout_A =MediumA.specificEnthalpy(outletA.state);
  summary.dT_A = summary.Tout_A - summary.Tin_A;
  summary.dT_B = summary.Tout_B - summary.Tin_B;
  summary.dh_A = summary.hout_A - summary.hin_A;
  summary.dh_B = summary.hout_B - summary.hin_B;
  summary.Q_flow_A=Q_flow_A;
  summary.Q_flow_B=Q_flow_B;
  summary.efficiency = if calculate_efficiency then efficiency(inletA.state, inletB.state, outletA.state, outletB.state, inletA.m_flow, inletB.m_flow, Q_flow_A) else 0;

  //Connecting equations (to interconnect pipes)

  //Fluid Side B
  connect(inletB, thermalElementB[1].inlet) annotation (Line(points={{100,-80},{10,-80}}, color={28,108,200}));
  for i in 1:nCells-1 loop
    connect(thermalElementB[i].outlet, thermalElementB[i + 1].inlet);
  end for;
  connect(thermalElementB[nCells].outlet, outletB) annotation (Line(points={{-10,-80},{-102,-80}}, color={28,108,200}));

  connect(thermalElementB.heatPort, thermalConductor.port_a)
    annotation (Line(points={{4.44089e-16,-70.2},{4.44089e-16,-40},{0,-40},{0,-10}}, color={191,0,0}));
  connect(thermalElementA.heatPort, thermalConductor.port_b)
    annotation (Line(points={{4.44089e-16,70.2},{4.44089e-16,40},{0,40},{0,10}}, color={191,0,0}));

  connect(inletA, splitterN.inlet) annotation (Line(
      points={{-98,80},{-60,80}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets, thermalElementA.inlet) annotation (Line(
      points={{-40,80},{-10,80}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalElementA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{10,80},{20,80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceA.outlet, junctionN.inlets) annotation (Line(
      points={{40,80},{50,80}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.outlet, outletA) annotation (Line(
      points={{70,80},{102,80}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    Icon(
      graphics={
        Text(
          extent={{-72,76},{-60,64}},
          textColor={28,108,200},
          textString="N"),
        Text(
          extent={{-42,76},{-30,64}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{-10,76},{2,64}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{20,76},{32,64}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{50,76},{62,64}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{10,134},{50,94}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{80,-94},{120,-134}},
          textColor={175,175,175},
          textString="B")}),
    Documentation(info="<html>
<p>The cross-flow discretized heat exchanger uses a number of conduction elements (which is set by the parameter nCells) as discrete control volumes to exchange heat between two fluid streams. </p>
<p>Side A splits the fluid stream into nCells substreams that are parallel. The flow-resistance is chosen to be very small and only ensures numerical stability of the parallel streams. By default, it is a linear-quadratic flow resistance, so the massflows through each of the parallel streams is the same. If exchanged for flow-resistance that depends on media properties (e.g. a laminar-turbulent) the mass-flow on the paths will be different. For side B the elements are serial and numbered 1 to nCells in the flow direction. The elements&apos; heatports are connected via a thermal conductor that models the wall. The connections are ordered to result in a cross-flow configuration. </p>
<p>The conduction elements are computing a heat transfer coefficient between their heatport and the fluid contained. They are replaceable with a choice between a single-phase and a two-phase version, both can be further parametrized. Although the single-phase version works for two-phase media (not the other way around), using the two-phase one for two-phase media enables to set different heat transfer coefficients depending on the phase (liquid/gaseous/2-phase) state of the medium. </p>
<p>Note that since the model uses conductionElements as discrete control volumes that in turn assume quasi-stationary mass and therefore are part of a fluid stream rather than break it into two (like a full volume would), the same holds for both sides of the heat exchanger - they are part of a fluid stream and don&apos;t break it. The quasi-stationary mass assumption also implies that for (fast) changing masses/densities in any of the conduction elements the heat exchanger will (slightly) violate the conservation of energy. Furthermore, the conduction elements change their behavior for reversed mass-flow, therefore this model asserts for negative mass-flow with the level dropOfCommons.globalAssertionLevel. </p>
<p>The parameters A (heat transferring area), k_wall (heat transfer coefficient of the wall between the streams) and the heat transfer coefficients in the conduction elements scale the transferred heat (the middle only if the wall and the latter only of the heat transfer into a fluid is the choke of the heatflow). </p>
<p>The parameter V determines the amount of fluid in the heat exchanger and therefore the dynamic for non-steady states. </p>
<p>The initialization tab allows for a mass-flow initialization for both paths. </p>
<p>The Advanced tab allows to modify the massflow that triggers the reverse-massflow-assertion and has an option to enforce global conservation of energy. The latter is done by feeding back any energy the conduction elements accumulated over time, basically making it impossible to store energy in their fluid long-term. While this enforces long-term conservation of energy it changes the medium-/short-term dynamics of the system and is therefore disabled by default. </p>
</html>"));
end DiscretizedCrossFlowHEX;
