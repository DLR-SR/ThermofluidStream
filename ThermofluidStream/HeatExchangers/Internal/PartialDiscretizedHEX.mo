within ThermofluidStream.HeatExchangers.Internal;
partial model PartialDiscretizedHEX "Base class for discretized heat exchangers"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;
  extends Internal.DiscretizedHexIcon;

  replaceable package MediumA = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model side A"
    annotation (choicesAllMatching=true, Dialog(group="Medium definitions"));
  replaceable package MediumB = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model side B"
    annotation (choicesAllMatching=true, Dialog(group="Medium definitions"));
  replaceable model ConductionElementA = Internal.ConductionElementHEX
    constrainedby Internal.PartialConductionElementHEX(
      final nCellsParallel=nCellsParallel,
      final A=A/nCells,
      final V=V_Hex/nCells,
      redeclare package Medium = MediumA,
      final enforce_global_energy_conservation=enforce_global_energy_conservation) "Heat transfer element model for side A" annotation (choicesAllMatching=true, Dialog(group="Medium definitions"));
  replaceable model ConductionElementB = Internal.ConductionElementHEX
    constrainedby Internal.PartialConductionElementHEX(
      final nCellsParallel=1,
      final A=A/nCells,
      final V=V_Hex/nCells,
      redeclare package Medium = MediumB,
      final enforce_global_energy_conservation=enforce_global_energy_conservation) "Heat transfer element model for side B" annotation (choicesAllMatching=true, Dialog(group="Medium definitions"));

  parameter Integer nCells=3 "Number of discretization elements";
  parameter Boolean calculate_efficiency=false "= true, if heat exchanger efficiency is calculated"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

  parameter SI.Area A=10 "Heat transfer area"
    annotation (Dialog(group="Heat transfer parameters"));
  parameter SI.Volume V_Hex=0.001 "Volume for heat transfer calculation"
    annotation (Dialog(group="Heat transfer parameters"));
  parameter SI.CoefficientOfHeatTransfer k_wall=100 "Coefficient of heat transfer for pipe wall"
    annotation (Dialog(group="Heat transfer parameters"));

  parameter Boolean initializeMassFlow=false "= true, if inlet mass flow rates are initialized"
    annotation (Dialog(tab="Initialization", group="Mass flow rate"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.MassFlowRate m_flow_0_A=0 "Initial mass flow rate for side A"
    annotation (Dialog(
      tab="Initialization",
      group="Mass flow rate",
      enable=initializeMassFlow));
  parameter SI.MassFlowRate m_flow_0_B=0 "Initial mass flow rate for side B"
    annotation (Dialog(
      tab="Initialization",
      group="Mass flow rate",
      enable=initializeMassFlow));
  parameter SI.MassFlowRate m_flow_assert(max=0) = -dropOfCommons.m_flow_reg "Assertion threshold for negative mass flow rate"
    annotation (Dialog(tab="Advanced"));
  parameter Boolean enforce_global_energy_conservation=false "= true, if global conservation of energy is enforced"
    annotation (Dialog(tab="Advanced"),Evaluate=true, HideResult=true, choices(checkBox=true));

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displayArea = true "= true, if heat transfer area A is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean d1A = displayParameters and displayArea  "displayArea at position 1"
    annotation(Evaluate=true, HideResult=true); //d1A -> Display at position 1 A=Area
  //-----------------------------------------------------------------

  Interfaces.Inlet inletB(redeclare package Medium = MediumB)
    annotation (Placement(transformation(extent={{-120,40},{-80,80}}), iconTransformation(extent=if crossFlow then {{120,-80},{80,-40}} else {{-120,40},{-80,80}})));
  Interfaces.Outlet outletB(redeclare package Medium = MediumB)
    annotation (Placement(transformation(extent={{80,40},{120,80}}), iconTransformation(extent=if crossFlow then {{-80,-80},{-120,-40}} else {{80,40},{120,80}})));
  Interfaces.Inlet inletA(redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{120,-80},{80,-40}}), iconTransformation(extent=if crossFlow then {{-120,-20},{-80,20}} else {{120,-80},{80,-40}}, rotation=if crossFlow then -90 else 0)));
  Interfaces.Outlet outletA(redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{-80,-80},{-120,-40}}), iconTransformation(extent=if crossFlow then {{80,-20},{120,20}} else {{-80,-80},{-120,-40}}, rotation=if crossFlow then -90 else 0)));


  SI.HeatFlowRate Q_flow_A=sum(thermalElementA.heatPort.Q_flow) "Heat flow rate into medium A";
  SI.HeatFlowRate Q_flow_B=sum(thermalElementB.heatPort.Q_flow) "Heat flow rate into medium B";
  SI.Mass M_A=sum(thermalElementA.M) "Mass of medium A";
  SI.Mass M_B=sum(thermalElementB.M) "Mass of medium B";
  SI.Energy deltaE_system=sum(thermalElementA.deltaE_system) + sum(thermalElementB.deltaE_system) "Error in global conservation of energy";


  ThermofluidStream.HeatExchangers.Internal.DiscretizedHEXSummary summary "Summary record of Quantities";

protected
  parameter Boolean crossFlow=false "Selection whether HEX is in crossflow or counterflow configuration";
  parameter Integer nCellsParallel=1 "Number of discretization elements in parallel";
  parameter SI.ThermalConductance G=k_wall*A "Wall thermal conductance"
    annotation (Dialog(group="Wall parameters"));
  function efficiency = Internal.calculateEfficiency (redeclare package MediumA = MediumA, redeclare package MediumB = MediumB) "Heat exchanger efficiency";

public
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[nCells](each G=G/nCells) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));

  ConductionElementB thermalElementB[nCells] annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  ConductionElementA thermalElementA[nCells] annotation (Placement(transformation(extent={{10,-50},{-10,-70}})));

equation
  assert(
    inletB.m_flow > m_flow_assert,
    "Negative mass flow rate at inlet B",
    dropOfCommons.assertionLevel);
  assert(
    inletA.m_flow > m_flow_assert,
    "Negative massflow at inlet A",
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

  annotation (Documentation(info="<html>
<p>
This is the partial parent class for discretized heat exchangers. It contains
the inlet and outlet connectors as well as a number of conduction elements (which
is set by the parameter <code>nCells</code>) as discrete control volumes to
exchange heat between two fluid streams.
</p>
<p>
The conduction elements are computing a heat transfer coefficient between their
heatport and the fluid contained. They are replaceable with a choice between
a single-phase and a two-phase version, both can be further parametrized.
Although the single-phase version works for two-phase media (not the other
way around), using the two-phase one for two-phase media enables to set different
heat transfer coefficients depending on the phase (liquid/gaseous/2-phase) state
of the medium.
</p>
<p>
Note that since the model uses conductionElements as discrete control volumes that
in turn assume quasi-stationary mass and, therefore, are part of a fluid stream
rather than break it into two (like a full volume would), the same holds for
both sides of the heat exchanger &ndash; they are part of a fluid stream and
don&apos;t break it. The quasi-stationary mass assumption also implies that for
(fast) changing masses/densities in any of the conduction elements the heat
exchanger will (slightly) violate the conservation of energy. Furthermore, the
conduction elements change their behavior for reversed mass-flow, therefore, this
model asserts for negative mass-flow with the level
&quot;<a href=\"ThermofluidStream.DropOfCommons\">DropOfCommons</a>.assertionLevel&quot;.
</p>
<p>
The parameters <code>A</code> (heat transferring area), <code>k_wall</code> (heat
transfer coefficient of the wall between the streams) and the heat transfer
coefficients in the conduction elements scale the transferred heat (the middle
only if the wall and the latter only of the heat transfer into a fluid is the
choke of the heatflow).
</p>
<p>
The parameter <code>V</code> determines the amount of fluid in the heat exchanger
and, therefore, the dynamic for non-steady states.
</p>
<p>
The &quot;Initialization&quot; tab allows for a mass-flow initialization for both paths.
</p>
<p>
The &quot;Advanced&quot; tab allows to modify the massflow that triggers the
reverse-massflow-assertion and has an option to enforce global conservation of
energy. The latter is done by feeding back any energy the conduction elements
accumulated over time, basically making it impossible to store energy in their
fluid long-term. While this enforces long-term conservation of energy, it
changes the medium-/short-term dynamics of the system and is, therefore,
disabled by default.
</p>
</html>"));
end PartialDiscretizedHEX;
