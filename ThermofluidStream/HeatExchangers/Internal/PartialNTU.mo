within ThermofluidStream.HeatExchangers.Internal;
partial model PartialNTU "Base heat exchanger using the epsilon-NTU method"
  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  // Configure icon display options
  parameter Boolean displayArea = true "= true, if you wish to display the conductive surface parameter value" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displaykNTU = true "= true, if you wish to display the heat transfer coefficient parameter value" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean d1A = displayParameters and displayArea  "displayArea at position 1" annotation(Evaluate=true, HideResult=true); //d1A -> Display at position 1 A=Area
  final parameter Boolean d1kNTU = displayParameters and displaykNTU and not d1A  "displaykNTU at position 1" annotation(Evaluate=true, HideResult=true);
  final parameter Boolean d2kNTU = displayParameters and displaykNTU and not d1kNTU  "displaykNTU at position 2" annotation(Evaluate=true, HideResult=true);



  replaceable package MediumA = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation (choicesAllMatching=true);
  replaceable package MediumB = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation (choicesAllMatching=true);
protected
  SI.Pressure inletA_r "Inlet A inertial pressure";
  SI.MassFlowRate inletA_m_flow "Inlet A mass flow rate";
  MediumA.ThermodynamicState inletA_state "Inlet A state";
  SI.Pressure inletB_r "Inlet B inertial pressure";
  SI.MassFlowRate inletB_m_flow "Inlet B mass flow rate";
  MediumB.ThermodynamicState inletB_state "Inlet B state";
  SI.Pressure outletA_r "Inlet A inertial pressure";
  SI.MassFlowRate outletA_m_flow "Inlet A mass flow rate";
  MediumA.ThermodynamicState outletA_state "Outlet A state";
  SI.Pressure outletB_r "Inlet B inertial pressure";
  SI.MassFlowRate outletB_m_flow "Inlet B mass flow rate";
  MediumB.ThermodynamicState outletB_state "Outlet B state";
public
  parameter Modelica.Units.SI.Area A "Conductive Surface";
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of the flow" annotation (Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer k_NTU=50 "Overall heat transfer coefficient";
  parameter Modelica.Units.SI.MassFlowRate m_flow_reg=dropOfCommons.m_flow_reg "Nominal mass flow for regularization" annotation (Dialog(tab="Advanced", group="Regularization parameters"));
  parameter Modelica.Units.SI.Time TC=0.01 "Time constant for dh" annotation (Dialog(tab="Advanced"));

  Modelica.Units.SI.TemperatureDifference Delta_T_max "Maximum Temperature Difference";

  Modelica.Units.SI.SpecificEnthalpy dh_A "Enthalpy difference Medium A";
  Modelica.Units.SI.SpecificEnthalpy dh_B "Enthalpy difference Medium B";

  SI.HeatFlowRate q_flow "actual heat flow rate";
  Real effectiveness(unit="1") "effectiveness derived from NTU correlation";
  Real NTU(unit="1") "Number of Transfer Units";

  //In- and outlet temperatures
  MediumA.Temperature T_in_MediumA "Inlet temperature of Medium A";
  MediumB.Temperature T_in_MediumB "Inlet temperature of Medium B";

  ThermofluidStream.HeatExchangers.Internal.DiscretizedHEXSummary summary "Summary record of Quantities";
protected
  parameter Boolean crossFlow=false "Selection whether HEX is in crossflow or counterflow configuration";

  Modelica.Units.SI.Pressure p_A=MediumA.pressure(inletA_state);
  Modelica.Units.SI.Pressure p_B=MediumB.pressure(inletB_state);

  MediumA.MassFraction Xi_A[MediumA.nXi]=MediumA.massFraction(inletA_state);
  MediumB.MassFraction Xi_B[MediumB.nXi]=MediumB.massFraction(inletB_state);

  //In- and outlet enthalpies and enthalpy differences
  Modelica.Units.SI.SpecificEnthalpy h_in_A "Enthalpy at inlet A";
  Modelica.Units.SI.SpecificEnthalpy h_in_B "Enthalpy at Inlet B";
  Modelica.Units.SI.SpecificEnthalpy h_out_A "Enthalpy at inlet A";
  Modelica.Units.SI.SpecificEnthalpy h_out_B "Enthalpy at Inlet B";

  SI.HeatFlowRate q_max "Maximum heat flow rate";
  SI.HeatFlowRate q_flowA "Heat flow rate side A";
  SI.HeatFlowRate q_flowB "Heat flow rate side B";

  Real C_A(unit="J/(K.s)") "Heat capacity rate of Medium A";
  Real C_B(unit="J/(K.s)") "Heat capacity rate of Medium B";
  Real C_min(unit="J/(K.s)") "minimum heat capacity rate";
  Real C_max(unit="J/(K.s)") "maximum heat capacity rate";
  Real C_r(unit="1") "Cmin/Cmax (ratio of heat capacity rates)";

  Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp_A "specific heat capacity of Medium A";
  Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp_B "specific heat capacity of Medium B";

  Modelica.Units.SI.MassFlowRate m_flow_A=inletA_m_flow "Mass flow on side A";
  Modelica.Units.SI.MassFlowRate m_flow_B=inletB_m_flow "Mass flow on side B";

  SI.SpecificHeatCapacity cpA_in=MediumA.specificHeatCapacityCp(inletA_state);
  SI.SpecificHeatCapacity cpA_out=MediumA.specificHeatCapacityCp(outletA_state);
  SI.SpecificHeatCapacity cpB_in=MediumB.specificHeatCapacityCp(inletB_state);
  SI.SpecificHeatCapacity cpB_out=MediumB.specificHeatCapacityCp(outletB_state);

  constant Real eps(unit="kg/s") = Modelica.Constants.eps;

initial equation

  h_out_A = h_in_A;
  h_out_B = h_in_B;

equation

  //Balance Equations
  inletA_m_flow + outletA_m_flow= 0;
  inletB_m_flow + outletB_m_flow = 0;
  inletA_r - outletA_r = der(inletA_m_flow)*L;
  inletB_r - outletB_r = der(inletB_m_flow)*L;

  //Specific heat capacities
  cp_A = (cpA_in + cpA_out)/2;
  cp_B = (cpB_in + cpB_out)/2;

  //Heat capacity rates
  C_A = (abs(inletA_m_flow) + eps)*cp_A;
  C_B = (abs(inletB_m_flow) + eps)*cp_B;

  //Inlet temperatures and enthalpies
  T_in_MediumA = MediumA.temperature(inletA_state);
  T_in_MediumB = MediumB.temperature(inletB_state);

  h_in_A = MediumA.specificEnthalpy(inletA_state);
  h_in_B = MediumB.specificEnthalpy(inletB_state);

  //Finding minimum heat capacity rate
  if noEvent(C_A > C_B) then
    C_min = C_B;
    C_max = C_A;
  else
    C_min = C_A;
    C_max = C_B;
  end if;

  C_r = C_min/(max(C_max, 1e-3));

  //Number of Transfer Units
  NTU = (k_NTU*A)/(max(C_min, 1e-3));


  //Maximum possible temperature difference
  Delta_T_max = T_in_MediumA - T_in_MediumB;

  //Maximum possible heat flow rate
  q_max = Delta_T_max*C_min;

  //Actual heat flow rate
  q_flow = effectiveness*q_max;

  if noEvent(C_A < C_B) then

    //if both mass flows are smaller than regularization mass flow, no heat is transferred
    if noEvent(inletA_m_flow < m_flow_reg) and noEvent(inletB_m_flow < m_flow_reg) then
      dh_A = 0;
    else
      dh_A = Delta_T_max*cp_A*effectiveness;
    end if;

    q_flowA = m_flow_A*dh_A;
    q_flowB = -q_flowA;

    //Based on regularization for mass flow
    dh_B = (m_flow_B*q_flowB)/(m_flow_B^2 + (m_flow_reg/10)^2);

    der(h_out_A)*TC = h_in_A - dh_A - h_out_A;
    der(h_out_B)*TC = h_in_B - dh_B - h_out_B;

  else

    //if both mass flows are smaller than regularization mass flow, no heat is transferred
    if noEvent(inletA_m_flow < m_flow_reg) and noEvent(inletB_m_flow < m_flow_reg) then
      dh_B = 0;
    else
      dh_B = -Delta_T_max*cp_B*effectiveness;
    end if;

    q_flowB = m_flow_B*dh_B;
    q_flowA = -q_flowB;

    //Based on regularization for mass flow
    dh_A = (m_flow_A*q_flowA)/(m_flow_A^2 + (m_flow_reg/10)^2);

    der(h_out_A)*TC = h_in_A - dh_A - h_out_A;
    der(h_out_B)*TC = h_in_B - dh_B - h_out_B;

  end if;

  outletA_state = MediumA.setState_phX(
    p_A,
    h_out_A,
    Xi_A);
  outletB_state = MediumB.setState_phX(
    p_B,
    h_out_B,
    Xi_B);

  //Summary record
  summary.Tin_B = MediumB.temperature(inletB_state);
  summary.Tin_A = MediumA.temperature(inletA_state);
  summary.Tout_B = MediumB.temperature(outletB_state);
  summary.Tout_A = MediumA.temperature(outletA_state);
  summary.hin_A = h_in_A;
  summary.hout_A = h_out_A;
  summary.hin_B = h_in_B;
  summary.hout_B = h_out_B;
  summary.dT_A = summary.Tout_A - summary.Tin_A;
  summary.dT_B = summary.Tout_B - summary.Tin_B;
  summary.dh_A = summary.hout_A - summary.hin_A;
  summary.dh_B = summary.hout_B - summary.hin_B;
  summary.Q_flow_A = q_flowA;
  summary.Q_flow_B = q_flowB;
  summary.efficiency = effectiveness;

  annotation (Documentation(info="<html>
<p>
This is the partial parent class for all heat exchangers based on the the
effectiveness-NTU method.
</p>
<p>
For stream dominated applications the following assumptions are made for mass
flow regularization close to zero:
</p>
<ul>
  <li>
    if the mass flow on both sides of the heat exchanger is zero, no heat
    is transferred
  </li>
</ul>
</html>"));
end PartialNTU;
