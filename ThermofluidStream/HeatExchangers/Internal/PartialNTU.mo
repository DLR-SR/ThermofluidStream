within ThermofluidStream.HeatExchangers.Internal;
partial model PartialNTU "Partial heat exchanger model using the epsilon-NTU method"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package MediumA = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model A"
    annotation (choicesAllMatching=true);
  replaceable package MediumB = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model B"
    annotation (choicesAllMatching=true);

  parameter Modelica.Units.SI.Area A "Heat transfer area";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer k_NTU=50 "Overall heat transfer coefficient";
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance"
    annotation (Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_reg=dropOfCommons.m_flow_reg "Nominal mass flow rate for regularization"
    annotation (Dialog(tab="Advanced", group="Regularization parameters"));
  parameter Modelica.Units.SI.Time TC=0.01 "Heat exchanger time constant (increase as recommended in the documentation)";

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displayArea = true "= true, if the heat transfer area A is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displaykNTU = true "= true, if  the overall heat transfer coefficient k_NTU is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean d1A = displayParameters and displayArea  "displayArea at position 1"
    annotation(Evaluate=true, HideResult=true); //d1A -> Display at position 1 A=Area
  final parameter Boolean d1kNTU = displayParameters and displaykNTU and not d1A  "displaykNTU at position 1"
    annotation(Evaluate=true, HideResult=true);
  final parameter Boolean d2kNTU = displayParameters and displaykNTU and not d1kNTU  "displaykNTU at position 2"
    annotation(Evaluate=true, HideResult=true);
  //-----------------------------------------------------------------

  ThermofluidStream.Interfaces.Inlet inletA(redeclare package Medium = MediumA) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-60}), iconTransformation(extent=if crossFlow then {{-120,-20},{-80,20}} else {{-120,-80},{-80,-40}})));
  ThermofluidStream.Interfaces.Outlet outletA(redeclare package Medium = MediumA) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={100,-60}), iconTransformation(extent=if crossFlow then {{80,-20},{120,20}} else {{80,-80},{120,-40}})));
  ThermofluidStream.Interfaces.Inlet inletB(redeclare package Medium = MediumB) annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={100,60}), iconTransformation(extent=if crossFlow then {{-120,-20},{-80,20}} else {{120,80},{80,40}}, rotation=if crossFlow then -90 else 0)));
  ThermofluidStream.Interfaces.Outlet outletB(redeclare package Medium = MediumB) annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={-100,60}), iconTransformation(extent=if crossFlow then {{80,-20},{120,20}} else {{-80,80},{-120,40}}, rotation=if crossFlow then -90 else 0)));



  Modelica.Units.SI.TemperatureDifference Delta_T_max "Maximum temperature difference";

  Modelica.Units.SI.SpecificEnthalpy dh_A "Specific enthalpy difference medium A";
  Modelica.Units.SI.SpecificEnthalpy dh_B "Specific enthalpy difference medium B";

  SI.HeatFlowRate q_flow "Heat flow rate A to B (Q_flow)";
  Real effectiveness(unit="1") "Heat exchanger efficiency";
  Real NTU(unit="1") "Number of transfer units";

  //Inlet and outlet temperatures
  MediumA.Temperature T_in_MediumA "Inlet temperature of medium A";
  MediumB.Temperature T_in_MediumB "Inlet temperature of medium B";

  ThermofluidStream.HeatExchangers.Internal.DiscretizedHEXSummary summary "Summary record of quantities";

protected
  parameter Boolean crossFlow=false "Selection whether HEX is in crossflow or counterflow configuration";

  Modelica.Units.SI.Pressure p_A=MediumA.pressure(inletA.state) "Inlet A pressure";
  Modelica.Units.SI.Pressure p_B=MediumB.pressure(inletB.state) "Inlet B pressure";

  MediumA.MassFraction Xi_A[MediumA.nXi]=MediumA.massFraction(inletA.state) "Inlet A mass fractions";
  MediumB.MassFraction Xi_B[MediumB.nXi]=MediumB.massFraction(inletB.state) "Inlet B mass fractions";

  //Inlet and outlet specific enthalpies and enthalpy differences
  Modelica.Units.SI.SpecificEnthalpy h_in_A "Specific enthalpy at inlet A";
  Modelica.Units.SI.SpecificEnthalpy h_in_B "Specific enthalpy at inlet B";
  Modelica.Units.SI.SpecificEnthalpy h_out_A "Specific enthalpy at outlet A";
  Modelica.Units.SI.SpecificEnthalpy h_out_B "Specific enthalpy at outlet B";

  SI.HeatFlowRate q_max "Maximum heat flow rate A to B (Q_flow_max)";
  SI.HeatFlowRate q_flowA "Heat flow rate A to B (Q_flowA)";
  SI.HeatFlowRate q_flowB "Heat flow rate B to A (Q_flowB)";

  Real C_A(unit="J/(K.s)") "Heat capacity flow rate of Medium A";
  Real C_B(unit="J/(K.s)") "Heat capacity flow rate of Medium B";
  Real C_min(unit="J/(K.s)") "Minimum heat capacity flow rate";
  Real C_max(unit="J/(K.s)") "Maximum heat capacity flow rate";
  Real C_r(unit="1") "Ratio of heat capacity rates, Cmin/Cmax";

  Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp_A "Specific heat capacity of Medium A";
  Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp_B "Specific heat capacity of Medium B";

  Modelica.Units.SI.MassFlowRate m_flow_A=inletA.m_flow "Mass flow rate on side A";
  Modelica.Units.SI.MassFlowRate m_flow_B=inletB.m_flow "Mass flow rate on side B";

  SI.SpecificHeatCapacity cpA_in=MediumA.specificHeatCapacityCp(inletA.state) "Inlet A specific heat capacity";
  SI.SpecificHeatCapacity cpA_out=MediumA.specificHeatCapacityCp(outletA.state) "Outlet A specific heat capacity";
  SI.SpecificHeatCapacity cpB_in=MediumB.specificHeatCapacityCp(inletB.state) "Inlet B specific heat capacity";
  SI.SpecificHeatCapacity cpB_out=MediumB.specificHeatCapacityCp(outletB.state) "Outlet B specific heat capacity";

  constant Real eps(unit="kg/s") = Modelica.Constants.eps "Mass flow rate regularization";

initial equation
  h_out_A = h_in_A;
  h_out_B = h_in_B;

equation
  //Balance Equations
  inletA.m_flow + outletA.m_flow= 0;
  inletB.m_flow + outletB.m_flow = 0;
  inletA.r - outletA.r = der(inletA.m_flow)*L;
  inletB.r - outletB.r = der(inletB.m_flow)*L;

  //Specific heat capacities
  cp_A = (cpA_in + cpA_out)/2;
  cp_B = (cpB_in + cpB_out)/2;

  //Heat capacity rates
  C_A = (abs(inletA.m_flow) + eps)*cp_A;
  C_B = (abs(inletB.m_flow) + eps)*cp_B;

  //Inlet temperatures and enthalpies
  T_in_MediumA = MediumA.temperature(inletA.state);
  T_in_MediumB = MediumB.temperature(inletB.state);

  h_in_A = MediumA.specificEnthalpy(inletA.state);
  h_in_B = MediumB.specificEnthalpy(inletB.state);

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

    //No heat is transferred, if both mass flow rates are smaller than regularization mass flow rate
    if noEvent(inletA.m_flow < m_flow_reg) and noEvent(inletB.m_flow < m_flow_reg) then
      dh_A = 0;
    else
      dh_A = Delta_T_max*cp_A*effectiveness;
    end if;

    q_flowA = m_flow_A*dh_A;
    q_flowB = -q_flowA;

    //Based on regularization for mass flow
    dh_B = (m_flow_B*q_flowB)/(m_flow_B^2 + (m_flow_reg/10)^2);

  else

    //No heat is transferred, if both mass flow rates are smaller than regularization mass flow rate
    if noEvent(inletA.m_flow < m_flow_reg) and noEvent(inletB.m_flow < m_flow_reg) then
      dh_B = 0;
    else
      dh_B = -Delta_T_max*cp_B*effectiveness;
    end if;

    q_flowB = m_flow_B*dh_B;
    q_flowA = -q_flowB;

    //Based on regularization for mass flow
    dh_A = (m_flow_A*q_flowA)/(m_flow_A^2 + (m_flow_reg/10)^2);
  end if;

  der(h_out_A)*TC = h_in_A - dh_A - h_out_A;
  der(h_out_B)*TC = h_in_B - dh_B - h_out_B;

  outletA.state = MediumA.setState_phX(
    p_A,
    h_out_A,
    Xi_A);
  outletB.state = MediumB.setState_phX(
    p_B,
    h_out_B,
    Xi_B);

  //Summary record
  summary.Tin_B = MediumB.temperature(inletB.state);
  summary.Tin_A = MediumA.temperature(inletA.state);
  summary.Tout_B = MediumB.temperature(outletB.state);
  summary.Tout_A = MediumA.temperature(outletA.state);
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

  <h5>Heat exchanger time constant</h5>

  <p>
    The model approximates the transient behavior of the heat exchanger with a first-order ordinary differential equation.<br>
    Based on the conservation of energy one can derive that its time constant <code>TC</code> can be approximated by the 
    ratio of thermal inertia (wall + fluid) <code>dU / dT</code> to the enthalpy flow 
    rate \"inertia\" <code>dH_flow / dT</code>:
  </p>

  <p>
    <code>TC ~ (m_HEX * c_HEX + m_FluidA * c_FluidA + m_FluidB * c_FluidB) / (m_flow_FluidA * c_FluidA + m_flow_FluidB * c_FluidB)</code> ,
  </p>
  <p>
    where <code>m</code> is the mass, <code>m_flow</code> is the mass flow rate, <code>c</code> is the specific heat capacity, 
    <code>U</code> is the internal energy, <code>T</code> is the temperature and <code>H_flow = m_flow*h</code> is the enthalpy flow rate.
  </p>
  <p>
    <strong>The default time constant <code>TC = 0.01</code> is not realistic and will be updated in the next major release.</strong> 
    For example a heat exchanger with a mass of <code>10 kg</code> and mass flow rates of <code>0.5 kg/s</code> of air on both sides has a time constant in the magnitude of about <code>10 s</code>.    
    The default time constant can also lead to a stiff system, and thereby increase simulation time.
  </p>
  <p>
    Note that the time constant also avoids algebraic loops and may also be beneficial from a numerical point of view.
  </p>


</html>
"));
end PartialNTU;
