within ThermofluidStream.HeatExchangers;
model CounterFlowNTU "Counter flow heat exchanger using the epsilon-NTU method"

  replaceable package MediumA =
      ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true);
  replaceable package MediumB =
      ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true);

  ThermofluidStream.Interfaces.Inlet inletA(redeclare package Medium = MediumA)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-60})));
  ThermofluidStream.Interfaces.Outlet outletA(
    redeclare package Medium = MediumA) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={100,-60})));
  ThermofluidStream.Interfaces.Inlet inletB(redeclare package Medium = MediumB)
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={100,60})));
  ThermofluidStream.Interfaces.Outlet outletB(redeclare package Medium = MediumB)
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={-100,60})));

  parameter Modelica.Units.SI.Area A "Conductive Surface";
  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance of the flow"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer k_NTU=50
    "Overall heat transfer coefficient";
  parameter Modelica.Units.SI.MassFlowRate m_flow_reg=dropOfCommons.m_flow_reg
    "Nominal mass flow for regularisation"
    annotation (Dialog(tab="Advanced", group="Regularisation parameters"));
  parameter Modelica.Units.SI.Time TC=0.01 "Time constant for dh"
    annotation (Dialog(tab="Advanced"));

  Modelica.Units.SI.TemperatureDifference Delta_T_max
    "Maximum Temperature Difference";

  Modelica.Units.SI.SpecificEnthalpy dh_A "Enthalpy difference Medium A";
  Modelica.Units.SI.SpecificEnthalpy dh_B "Enthalpy difference Medium B";

  SI.HeatFlowRate q_flow "actual heat flow rate";
  Real effectiveness(unit="1") "effectiveness derived from NTU correlation";
  Real NTU(unit="1") "Number of Transfer Units";

  //In- and outlet temperatures
  MediumA.Temperature T_in_MediumA "Inlet temperature of Medium A";
  MediumB.Temperature T_in_MediumB "Inlet temperature of Medium B";

protected
  outer DropOfCommons dropOfCommons;

  Modelica.Units.SI.Pressure p_A=MediumA.pressure(inletA.state);
  Modelica.Units.SI.Pressure p_B=MediumB.pressure(inletB.state);

  MediumA.MassFraction Xi_A[MediumA.nXi] = MediumA.massFraction(inletA.state);
  MediumB.MassFraction Xi_B[MediumB.nXi] = MediumB.massFraction(inletB.state);

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

  Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp_A
    "specific heat capacity of Medium A";
  Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp_B
    "specific heat capacity of Medium B";

  Modelica.Units.SI.MassFlowRate m_flow_A=inletA.m_flow "Mass flow on side A";
  Modelica.Units.SI.MassFlowRate m_flow_B=inletB.m_flow "Mass flow on side B";

  SI.SpecificHeatCapacity cpA_in = MediumA.specificHeatCapacityCp(inletA.state);
  SI.SpecificHeatCapacity cpA_out = MediumA.specificHeatCapacityCp(outletA.state);
  SI.SpecificHeatCapacity cpB_in = MediumB.specificHeatCapacityCp(inletB.state);
  SI.SpecificHeatCapacity cpB_out = MediumB.specificHeatCapacityCp(outletB.state);

initial equation

  h_out_A = h_in_A;
  h_out_B = h_in_B;

equation

  //Balance Equations
  inletA.m_flow + outletA.m_flow = 0;
  inletB.m_flow + outletB.m_flow = 0;
  inletA.r - outletA.r = der(inletA.m_flow) * L;
  inletB.r - outletB.r = der(inletB.m_flow) * L;

  //Specific heat capacities
  cp_A = (cpA_in + cpA_out)/2;
  cp_B = (cpB_in + cpB_out)/2;

  //Heat capacity rates
  C_A = abs(inletA.m_flow)*cp_A;
  C_B = abs(inletB.m_flow)*cp_B;

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

  //Calculating heat exchanger effectiveness derived from NTU correlations (see VDI Wärmeatlas)
  effectiveness = if noEvent(C_r < 1) then (1-exp(-NTU*(1-C_r)))/(1-C_r*exp(-NTU*(1-C_r))) else NTU/(1+NTU);

  //Maximum possible temperature difference
  Delta_T_max = T_in_MediumA - T_in_MediumB;

  //Maximum possible heat flow rate
  q_max = Delta_T_max*C_min;

  //Actual heat flow rate
  q_flow = effectiveness*q_max;

  if noEvent(C_A < C_B) then

      //if both mass flows are smaller than regularisation mass flow, no heat is transferred
     if noEvent(inletA.m_flow < m_flow_reg) and noEvent(inletB.m_flow < m_flow_reg) then

       dh_A = 0;
     else
       dh_A = Delta_T_max*cp_A*effectiveness;
     end if;

     q_flowA = m_flow_A*dh_A;
     q_flowB = -q_flowA;

     //Based on regularisation for mass flow
     dh_B = (m_flow_B*q_flowB)/(m_flow_B^2+(m_flow_reg/10)^2);

     der(h_out_A)*TC = h_in_A - dh_A - h_out_A;
     der(h_out_B)*TC = h_in_B - dh_B - h_out_B;

  else

     //if both mass flows are smaller than regularisation mass flow, no heat is transferred
     if noEvent(inletA.m_flow < m_flow_reg) and noEvent(inletB.m_flow < m_flow_reg) then
        dh_B = 0;
     else
        dh_B = -Delta_T_max*cp_B*effectiveness;
     end if;

     q_flowB = m_flow_B*dh_B;
     q_flowA = -q_flowB;

     //Based on regularisation for mass flow
     dh_A = (m_flow_A*q_flowA)/(m_flow_A^2+(m_flow_reg/10)^2);

     der(h_out_A)*TC = h_in_A - dh_A - h_out_A;
     der(h_out_B)*TC = h_in_B - dh_B - h_out_B;

  end if;

   outletA.state = MediumA.setState_phX(p_A, h_out_A, Xi_A);
   outletB.state = MediumB.setState_phX(p_B, h_out_B, Xi_B);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-70,66},{84,-86}},
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          radius=6),
        Rectangle(
          extent={{-76,78},{76,-78}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=6),
        Line(
          points={{-60,64},{60,64}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-60,44},{60,44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Text(
          extent={{-120,-74},{-80,-114}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{82,112},{122,72}},
          textColor={175,175,175},
          textString="B"),
        Line(
          points={{-60,-44},{60,-44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-60,24},{60,24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-60,-64},{60,-64}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,40},{-60,44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,48},{-60,44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,-48},{60,-44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,-40},{60,-44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,60},{-60,64}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,68},{-60,64}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,20},{-60,24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,28},{-60,24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,-68},{60,-64}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,-60},{60,-64}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-60,-24},{60,-24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,-20},{60,-24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,-28},{60,-24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Basic model of a counter-flow heat exchanger based on the effectiveness-NTU method.</p>
<p>The equations are derived from the generic effectiveness-NTU relations which can be found in the &quot;VDI W&auml;rmeatlas&quot; and noumerous standard literature.</p>
<p>For stream dominated applications the following assumptions are made for mass flow regularisation close to zero:</p>
<p>- if the mass flow on both sides of the heat exchanger is zero, no heat is transferred</p>
</html>"));
end CounterFlowNTU;
