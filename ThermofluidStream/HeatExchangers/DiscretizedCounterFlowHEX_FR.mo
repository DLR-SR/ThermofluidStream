within ThermofluidStream.HeatExchangers;
model DiscretizedCounterFlowHEX_FR "Discretized Heat Exchanger for single- or two-phase working fluid with pressure drop"
  extends Internal.DiscretizedHexIcon;

  replaceable package MediumA =
      ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model side A"
    annotation (choicesAllMatching=true, Dialog(group = "Medium definitions"));
  replaceable package MediumB =
      ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model side B"
    annotation (choicesAllMatching=true, Dialog(group = "Medium definitions"));

  replaceable model ConductionElementA = Internal.ConductionElementHEX
    constrainedby Internal.PartialConductionElementHEX(
      final nCellsParallel= 1,
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

  parameter Real k1_A= 1e2 "Linear flowres factor A"
    annotation(Dialog(group="laminar-turbulent flowRes"));
  parameter Real k2_A = 1e2 "Quadratic flowres factor A"
    annotation(Dialog(group="laminar-turbulent flowRes"));
  parameter Real k1_B = 1e2 "Linear flowres factor B"
    annotation(Dialog(group="laminar-turbulent flowRes"));
  parameter Real k2_B = 1e2 "Quadratic flowres factor B"
    annotation(Dialog(group="laminar-turbulent flowRes"));


  //Parameterization of HEX Wall
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer k_wall=100
    "Coefficient of heat transfer for pipe wall"
    annotation (Dialog(group="Heat transfer parameters"));

  parameter Boolean calculate_efficiency= false "Enable calculation of efficiency";
protected
  parameter Modelica.Units.SI.ThermalConductance G=k_wall*A
    "Wall thermal conductance" annotation (Dialog(group="Wall parameters"));

public
  ConductionElementB thermalElementB[nCells]
    annotation (Placement(transformation(extent={{-10,90},{10,70}})));
  ConductionElementA thermalElementA[nCells]
    annotation (Placement(transformation(extent={{10,-90},{-10,-70}})));
  Processes.FlowResistance flowResistanceA[nCells](
    redeclare package Medium = MediumA,
    each r = 1,
    each l= 1,
    each computeL=false,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      each k=k1_A,
      each k2=k2_A))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=180,origin={-50,-80})));
  Processes.FlowResistance flowResistanceB[nCells](
    redeclare package Medium = MediumB,
    each r=1,
    each l=1,
    each computeL=false,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      each k=k1_B,
      each k2=k2_B))
      annotation (Placement(transformation(extent={{40,70},{60,90}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[nCells](each G=G/nCells)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=90,origin={0,0})));
  Interfaces.Inlet inletB(redeclare package Medium = MediumB) annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Interfaces.Outlet outletB(redeclare package Medium = MediumB) annotation (Placement(transformation(extent={{92,70},{112,90}})));
  Interfaces.Inlet inletA(redeclare package Medium = MediumA) annotation (Placement(transformation(extent={{110,-90},{90,-70}})));
  Interfaces.Outlet outletA(redeclare package Medium = MediumA) annotation (Placement(transformation(extent={{-92,-90},{-112,-70}})));

  SI.HeatFlowRate Q_flow_A=sum(thermalElementA.heatPort.Q_flow);
  SI.HeatFlowRate Q_flow_B=sum(thermalElementB.heatPort.Q_flow);
  SI.Mass M_A=sum(thermalElementA.M);
  SI.Mass M_B=sum(thermalElementB.M);
  SI.Energy deltaE_system=sum(thermalElementA.deltaE_system) + sum(thermalElementB.deltaE_system);

  ThermofluidStream.HeatExchangers.Internal.DiscretizedHEXSummary summary "Summary record of Quantities";

protected
  outer DropOfCommons dropOfCommons;
  function efficiency = Internal.calculateEfficiency (
    redeclare package MediumA = MediumA,
    redeclare package MediumB = MediumB);

initial equation

  if initializeMassFlow then
    inletA.m_flow = m_flow_0_A;
    inletB.m_flow = m_flow_0_B;
  end if;

equation
  assert(inletB.m_flow > m_flow_assert,"Negative massflow at Air inlet",dropOfCommons.assertionLevel);
  assert(inletA.m_flow > m_flow_assert,"Negative massflow at Refigerant inlet",dropOfCommons.assertionLevel);

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
  summary.efficiency = if calculate_efficiency and not initial() then
    efficiency(inletA.state, inletB.state, outletA.state, outletB.state, inletA.m_flow, inletB.m_flow, Q_flow_A) else 0;

  //Connecting equations (to interconnect pipes)
  //Fluid Side B
  connect(inletB, thermalElementB[1].inlet) annotation (Line(points={{-100,80},{-10,80}}, color={28,108,200}));
  connect(flowResistanceB.inlet, thermalElementB.outlet)
    annotation (Line(
      points={{40,80},{10,80}},
      color={28,108,200},
      thickness=0.5));
  for i in 1:nCells-1 loop
    connect(flowResistanceB[i].outlet, thermalElementB[i + 1].inlet);
  end for;
  connect(flowResistanceB[nCells].outlet, outletB)
    annotation (Line(
      points={{60,80},{102,80}},
      color={28,108,200},
      thickness=0.5));


  //Fluid Side A
  connect(inletA, thermalElementA[1].inlet) annotation (Line(points={{100,-80},{10,-80}}, color={28,108,200}));
  connect(flowResistanceA.inlet, thermalElementA.outlet)
    annotation (Line(
      points={{-40,-80},{-10,-80}},
      color={28,108,200},
      thickness=0.5));
  for i in 1:nCells-1 loop
    connect(flowResistanceA[i].outlet, thermalElementA[i + 1].inlet);
  end for;
  connect(flowResistanceA[nCells].outlet, outletA)
    annotation (Line(
      points={{-60,-80},{-102,-80}},
      color={28,108,200},
      thickness=0.5));

  //Thermal connection
  connect(thermalElementB.heatPort, thermalConductor.port_b)
    annotation (Line(points={{4.44089e-16,70.2},{4.44089e-16,40},{0,40},{0,10}}, color={191,0,0}));
  for i in 1:nCells loop
    connect(thermalElementA[i].heatPort, thermalConductor[nCells + 1 - i].port_a)
      annotation (Line(points={{-6.66134e-16,-70.2},{-6.66134e-16,-10},{0,-10}}, color={191,0,0}));
  end for;

  annotation (
    Icon(graphics={
        Text(
          extent={{-70,76},{-58,64}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-40,76},{-28,64}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-8,76},{4,64}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{22,76},{34,64}},
          textColor={28,108,200},
          textString="..."),
        Text(
          extent={{50,76},{62,64}},
          textColor={28,108,200},
          textString="N"),
        Text(
          extent={{-120,132},{-80,92}},
          textColor={175,175,175},
          textString="B"),
        Text(
          extent={{80,-94},{120,-134}},
          textColor={175,175,175},
          textString="A")}),
    Documentation(info="<html>
<p>The counter-flow discretized heat exchanger uses a number of conduction elements (which is set by the parameter nCells) as discrete control volumes to exchange heat between two fluid streams. This model differs from DiscretizedCounterFlowHEX by introducing flow-resistances after each control volume, but otherwise is the same, therefore consider the documentation of DiscretizedCounterFlowHEX. </p>
<p>The flowResistances are parametrized by the parameters in the group laminar-turbulent flowRes.</p>
</html>"));
end DiscretizedCounterFlowHEX_FR;
