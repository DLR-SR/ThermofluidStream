within ThermofluidStream.Undirected.HeatExchangers.Internal;
partial model PartialDiscretizedHEX "Base class for undirected discretized heat exchangers"
  extends ThermofluidStream.HeatExchangers.Internal.DiscretizedHexIcon;

  replaceable package MediumA = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model side A" annotation (choicesAllMatching=true, Dialog(group="Medium definitions"));
  replaceable package MediumB = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model side B" annotation (choicesAllMatching=true, Dialog(group="Medium definitions"));

  replaceable model ConductionElementA = ThermofluidStream.Undirected.HeatExchangers.Internal.ConductionElementHEX constrainedby ThermofluidStream.Undirected.HeatExchangers.Internal.PartialConductionElementHEX(
    final nCellsParallel=nCellsParallel,
    final A=A/nCells,
    final V=V_Hex/nCells,
    redeclare package Medium = MediumA,
    final enforce_global_energy_conservation=enforce_global_energy_conservation,
    final init=init_A,
    final h_0=h0_A) "Heat transfer element model for side A" annotation (choicesAllMatching=true, Dialog(group="Medium definitions"));
  replaceable model ConductionElementB = ThermofluidStream.Undirected.HeatExchangers.Internal.ConductionElementHEX constrainedby ThermofluidStream.Undirected.HeatExchangers.Internal.PartialConductionElementHEX(
    final nCellsParallel=1,
    final A=A/nCells,
    final V=V_Hex/nCells,
    redeclare package Medium = MediumB,
    final enforce_global_energy_conservation=enforce_global_energy_conservation,
    final init=init_B,
    final h_0=h0_B) "Heat transfer element model for side B" annotation (choicesAllMatching=true, Dialog(group="Medium definitions"));

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
  parameter Boolean enforce_global_energy_conservation=false "If true, exact global energy conservation is enforced by feeding back all energy stored locally back in the system" annotation (Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_reg=dropOfCommons.m_flow_reg "Regularization mass flow to switch between positive- and negative-massflow model" annotation (Dialog(tab="Advanced"));

  parameter ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement init_A=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.h "Initialization method for h side A" annotation (Dialog(tab="Initialization", group="Enthalpy"), choices(
      choice=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.h "h0",
      choice=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.rear "rear",
      choice=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.fore "fore"));
  parameter SI.SpecificEnthalpy h0_A=MediumA.h_default "Initial enthalpy side A" annotation (Dialog(
      tab="Initialization",
      group="Enthalpy",
      enable=(init_A == ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.h)));
  parameter ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement init_B=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.h "Initialization method for h side B" annotation (Dialog(tab="Initialization", group="Enthalpy"), choices(
      choice=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.h "h0",
      choice=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.rear "rear",
      choice=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.fore "fore"));
  parameter SI.SpecificEnthalpy h0_B=MediumB.h_default "Initial enthalpy side B" annotation (Dialog(
      tab="Initialization",
      group="Enthalpy",
      enable=(init_B == ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.h)));

  //Parameterization of HEX Wall
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer k_wall=100 "Coefficient of heat transfer for pipe wall" annotation (Dialog(group="Heat transfer parameters"));

  parameter Boolean calculate_efficiency=false "Enable calculation of efficiency";

  SI.HeatFlowRate Q_flow_A=sum(thermalElementA.heatPort.Q_flow);
  SI.HeatFlowRate Q_flow_B=sum(thermalElementB.heatPort.Q_flow);
  SI.MassFlowRate m_flow_A=rearA.m_flow;
  SI.MassFlowRate m_flow_B=rearB.m_flow;
  SI.Mass M_A=sum(thermalElementA.M);
  SI.Mass M_B=sum(thermalElementB.M);
  SI.Energy deltaE_system=sum(thermalElementA.deltaE_system) + sum(thermalElementB.deltaE_system);

  ThermofluidStream.HeatExchangers.Internal.DiscretizedHEXSummary summary "Summary record of quantities";

protected
  parameter Boolean crossFlow=false "Selection whether HEX is in crossflow or counterflow configuration";
  parameter Integer nCellsParallel=1 "Number of discretization elements in parallel";
  parameter Modelica.Units.SI.ThermalConductance G=k_wall*A "Wall thermal conductance" annotation (Dialog(group="Wall parameters"));
  outer DropOfCommons dropOfCommons;

  function efficiency = ThermofluidStream.HeatExchangers.Internal.calculateEfficiency (redeclare package MediumA = MediumA, redeclare package MediumB = MediumB);

  // no regstep since this is only used as a output
  MediumA.ThermodynamicState stateA_in=if noEvent(rearA.m_flow) > 0 then rearA.state_forwards else foreA.state_rearwards;
  MediumA.ThermodynamicState stateA_out=if noEvent(rearA.m_flow) > 0 then foreA.state_forwards else rearA.state_rearwards;
  MediumB.ThermodynamicState stateB_in=if noEvent(rearB.m_flow) > 0 then rearB.state_forwards else foreB.state_rearwards;
  MediumB.ThermodynamicState stateB_out=if noEvent(rearB.m_flow) > 0 then foreB.state_forwards else rearB.state_rearwards;

public
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[nCells](each G=G/nCells) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));

  ConductionElementA thermalElementA[nCells] annotation (Placement(transformation(extent={{10,-90},{-10,-70}})));
  ConductionElementB thermalElementB[nCells] annotation (Placement(transformation(extent={{-10,90},{10,70}})));

  Interfaces.Rear rearA(redeclare package Medium = MediumA) annotation (Placement(transformation(extent={{110,-90},{90,-70}}), iconTransformation(extent=if crossFlow then {{-110,-10},{-90,10}} else {{110,-90},{90,-70}}, rotation=if crossFlow then -90 else 0)));
  Interfaces.Fore foreA(redeclare package Medium = MediumA) annotation (Placement(transformation(extent={{-90,-90},{-110,-70}}), iconTransformation(extent=if crossFlow then {{90,-10},{110,10}} else {{-90,-90},{-110,-70}}, rotation=if crossFlow then -90 else 0)));
  Interfaces.Rear rearB(redeclare package Medium = MediumB) annotation (Placement(transformation(extent={{-110,70},{-90,90}}), iconTransformation(extent=if crossFlow then {{110,-90},{90,-70}} else {{-110,70},{-90,90}})));
  Interfaces.Fore foreB(redeclare package Medium = MediumB) annotation (Placement(transformation(extent={{90,70},{110,90}}), iconTransformation(extent=if crossFlow then {{-90,-90},{-110,-70}} else {{90,70},{110,90}})));

equation
  //Summary record
  summary.Tin_A = MediumA.temperature(stateA_in);
  summary.Tin_B = MediumB.temperature(stateB_in);
  summary.Tout_A = MediumA.temperature(stateA_out);
  summary.Tout_B = MediumB.temperature(stateB_out);
  summary.hin_A = MediumA.specificEnthalpy(stateA_in);
  summary.hin_B = MediumB.specificEnthalpy(stateB_in);
  summary.hout_A = MediumA.specificEnthalpy(stateA_out);
  summary.hout_B = MediumB.specificEnthalpy(stateB_out);
  summary.dT_A = summary.Tout_A - summary.Tin_A;
  summary.dT_B = summary.Tout_B - summary.Tin_B;
  summary.dh_A = summary.hout_A - summary.hin_A;
  summary.dh_B = summary.hout_B - summary.hin_B;

  summary.efficiency = if calculate_efficiency then efficiency(
    stateA_in,
    stateB_in,
    stateA_out,
    stateB_out,
    rearA.m_flow,
    rearB.m_flow,
    Q_flow_A) else 0;

  summary.Q_flow_A = Q_flow_A;
  summary.Q_flow_B = Q_flow_B;

  annotation (Documentation(info="<html>
<p>
This is the partial parent class for undirected discretized heat exchangers. It contains
the rear and fore connectors as well as a number of conduction elements (which
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
conduction elements change their behavior for reversed mass flow, therefore, this
model asserts for negative mass flow with the level
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
The &quot;Initialization&quot; tab allows for a mass flow initialization for both
paths, as well as to determine from which direction the enthalpy in the control
volumes should be initialized (fore/rear), or if it should start with a given
enthalpy. The other option is to initialize the enthalpy with a given value.
</p>
<p>
The &quot;Advanced&quot; tab allows to modify the mass flow that triggers the
reverse-mass-flow-assertion and has an option to enforce global conservation of
energy. The latter is done by feeding back any energy the conduction elements
accumulated over time, basically making it impossible to store energy in their
fluid long-term. While this enforces long-term conservation of energy, it
changes the medium-/short-term dynamics of the system and is, therefore,
disabled by default.
</p>
</html>"));
end PartialDiscretizedHEX;
