within ThermofluidStream.HeatExchangers.Internal;
partial model PartialDiscretizedHEX
  extends Internal.DiscretizedHexIcon;

  replaceable package MediumA = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model side A" annotation (choicesAllMatching=true, Dialog(group="Medium definitions"));
  replaceable package MediumB = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model side B" annotation (choicesAllMatching=true, Dialog(group="Medium definitions"));

  replaceable model ConductionElementA = Internal.ConductionElementHEX constrainedby Internal.PartialConductionElementHEX(
    final nCellsParallel=nCellsParallel,
    final A=A/nCells,
    final V=V_Hex/nCells,
    redeclare package Medium = MediumA,
    final enforce_global_energy_conservation=enforce_global_energy_conservation) "Heat transfer element model for side A" annotation (choicesAllMatching=true, Dialog(group="Medium definitions"));
  replaceable model ConductionElementB = Internal.ConductionElementHEX constrainedby Internal.PartialConductionElementHEX(
    final nCellsParallel=1,
    final A=A/nCells,
    final V=V_Hex/nCells,
    redeclare package Medium = MediumB,
    final enforce_global_energy_conservation=enforce_global_energy_conservation) "Heat transfer element model for side B" annotation (choicesAllMatching=true, Dialog(group="Medium definitions"));

  parameter Boolean initializeMassFlow=false "Initialize mass flow at inlets?" annotation (Dialog(tab="Initialization", group="Mass flow"));
  parameter SI.MassFlowRate m_flow_0_A=0 "Initial mass flow for side A" annotation (Dialog(
      tab="Initialization",
      group="Mass flow",
      enable=initializeMassFlow));
  parameter SI.MassFlowRate m_flow_0_B=0 "Initial mass flow for side B" annotation (Dialog(
      tab="Initialization",
      group="Mass flow",
      enable=initializeMassFlow));
  parameter Integer nCells=3 "Number of discretization elements";
  parameter Modelica.Units.SI.Area A=10 "Conductive area of heat exchanger" annotation (Dialog(group="Heat transfer parameters"));
  parameter Modelica.Units.SI.Volume V_Hex=0.001 "Volume for heat transfer calculation" annotation (Dialog(group="Heat transfer parameters"));
  parameter SI.MassFlowRate m_flow_assert(max=0) = -dropOfCommons.m_flow_reg "Assertion threshold for negative massflows" annotation (Dialog(tab="Advanced"));
  parameter Boolean enforce_global_energy_conservation=false "If true, exact global energy conservation is enforced by feeding back all energy stored locally back in the system" annotation (Dialog(tab="Advanced"));

  //Parameterization of HEX Wall
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer k_wall=100 "Coefficient of heat transfer for pipe wall" annotation (Dialog(group="Heat transfer parameters"));

  parameter Boolean calculate_efficiency=false "Enable calculation of efficiency";

  SI.HeatFlowRate Q_flow_A=sum(thermalElementA.heatPort.Q_flow);
  SI.HeatFlowRate Q_flow_B=sum(thermalElementB.heatPort.Q_flow);
  SI.Mass M_A=sum(thermalElementA.M);
  SI.Mass M_B=sum(thermalElementB.M);
  SI.Energy deltaE_system=sum(thermalElementA.deltaE_system) + sum(thermalElementB.deltaE_system);

  ThermofluidStream.HeatExchangers.Internal.DiscretizedHEXSummary summary "Summary record of Quantities";

protected
  parameter Boolean crossFlow=false "Selection whether HEX is in crossflow or counterflow configuration";
  parameter Integer nCellsParallel=1 "Number of discretization elements in parallel";
  parameter Modelica.Units.SI.ThermalConductance G=k_wall*A "Wall thermal conductance" annotation (Dialog(group="Wall parameters"));
  outer DropOfCommons dropOfCommons;

  function efficiency = Internal.calculateEfficiency (redeclare package MediumA = MediumA, redeclare package MediumB = MediumB);

public
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[nCells](each G=G/nCells) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));

  ConductionElementB thermalElementB[nCells] annotation (Placement(transformation(extent={{-10,90},{10,70}})));
  ConductionElementA thermalElementA[nCells] annotation (Placement(transformation(extent={{10,-90},{-10,-70}})));

  Interfaces.Inlet inletB(redeclare package Medium = MediumB) annotation (Placement(transformation(extent={{-110,70},{-90,90}}), iconTransformation(extent=if crossFlow then {{110,-90},{90,-70}} else {{-110,70},{-90,90}})));
  Interfaces.Outlet outletB(redeclare package Medium = MediumB) annotation (Placement(transformation(extent={{90,70},{110,90}}), iconTransformation(extent=if crossFlow then {{-90,-90},{-110,-70}} else {{90,70},{110,90}})));
  Interfaces.Inlet inletA(redeclare package Medium = MediumA) annotation (Placement(transformation(extent={{110,-90},{90,-70}}), iconTransformation(extent=if crossFlow then {{-110,-10},{-90,10}} else {{110,-90},{90,-70}}, rotation=if crossFlow then -90 else 0)));
  Interfaces.Outlet outletA(redeclare package Medium = MediumA) annotation (Placement(transformation(extent={{-90,-90},{-110,-70}}), iconTransformation(extent=if crossFlow then {{90,-10},{110,10}} else {{-90,-90},{-110,-70}}, rotation=if crossFlow then -90 else 0)));

equation
  assert(
    inletB.m_flow > m_flow_assert,
    "Negative massflow at Air inlet",
    dropOfCommons.assertionLevel);
  assert(
    inletA.m_flow > m_flow_assert,
    "Negative massflow at Refigerant inlet",
    dropOfCommons.assertionLevel);

  //Summary record
  summary.Tin_B = MediumB.temperature(inletB.state);
  summary.Tin_A = MediumA.temperature(inletA.state);
  summary.Tout_B = MediumB.temperature(outletB.state);
  summary.Tout_A = MediumA.temperature(outletA.state);
  summary.hin_B = MediumB.specificEnthalpy(inletB.state);
  summary.hin_A = MediumA.specificEnthalpy(inletA.state);
  summary.hout_B = MediumB.specificEnthalpy(outletB.state);
  summary.hout_A = MediumA.specificEnthalpy(outletA.state);
  summary.dT_A = summary.Tout_A - summary.Tin_A;
  summary.dT_B = summary.Tout_B - summary.Tin_B;
  summary.dh_A = summary.hout_A - summary.hin_A;
  summary.dh_B = summary.hout_B - summary.hin_B;
  summary.Q_flow_A = Q_flow_A;
  summary.Q_flow_B = Q_flow_B;
  summary.efficiency = if calculate_efficiency then efficiency(
    inletA.state,
    inletB.state,
    outletA.state,
    outletB.state,
    inletA.m_flow,
    inletB.m_flow,
    Q_flow_A) else 0;

end PartialDiscretizedHEX;
