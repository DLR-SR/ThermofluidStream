within ThermofluidStream.HeatExchangers;
model CrossFlowNTU "Cross flow heat exchanger using the epsilon-NTU method"

  replaceable package MediumA =
      ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true);
  replaceable package MediumB =
      ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true);

  parameter Modelica.SIunits.Area A "Conductive Surface";
  parameter Utilities.Units.Inertance L = dropOfCommons.L "inertance of the flow"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer k_NTU = 50 "overall heat transfer coefficient";
  parameter Modelica.SIunits.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "nominal mass flow for regularisation"
    annotation(Dialog(tab = "Advanced", group = "Regularisation parameters"));
  parameter Modelica.SIunits.Time TC = 0.01 "time constant for dh"
    annotation(Dialog(tab="Advanced"));

  ThermofluidStream.Interfaces.Inlet inletA(redeclare package Medium = MediumA)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,10}), iconTransformation(extent={{-120,-20},{-80,20}})));
  ThermofluidStream.Interfaces.Outlet outletA(redeclare package Medium =
        MediumA) annotation (Placement(transformation(extent={{100,0},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  ThermofluidStream.Interfaces.Inlet inletB(redeclare package Medium = MediumB)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,60}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  ThermofluidStream.Interfaces.Outlet outletB(redeclare package Medium =
        MediumB) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-108,60}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,-100})));

  Modelica.SIunits.TemperatureDifference Delta_T_max "Maximum Temperature Difference";

  Modelica.SIunits.SpecificEnthalpy dh_A "Enthalpy difference Medium A";
  Modelica.SIunits.SpecificEnthalpy dh_B "Enthalpy difference Medium B";

  SI.HeatFlowRate q_flow "actual heat flow rate";
  Real effectiveness(unit="1") "effectiveness derived from NTU correlation";
  Real NTU(unit="1") "Number of Transfer Units";

  //In- and outlet temperatures
  Modelica.SIunits.Temperature T_in_MediumA "Inlet temperature of Medium A";
  Modelica.SIunits.Temperature T_in_MediumB "Inlet temperature of Medium B";

protected
  outer DropOfCommons dropOfCommons;

  Modelica.SIunits.Pressure p_A = MediumA.pressure(inletA.state);
  Modelica.SIunits.Pressure p_B = MediumB.pressure(inletB.state);

  MediumA.MassFraction Xi_A[MediumA.nXi] = MediumA.massFraction(inletA.state);
  MediumB.MassFraction Xi_B[MediumB.nXi] = MediumB.massFraction(inletB.state);

  //In- and outlet enthalpies and enthalpy differences
  Modelica.SIunits.SpecificEnthalpy h_in_A "Enthalpy at inlet A";
  Modelica.SIunits.SpecificEnthalpy h_in_B "Enthalpy at Inlet B";
  Modelica.SIunits.SpecificEnthalpy h_out_A "Enthalpy at inlet A";
  Modelica.SIunits.SpecificEnthalpy h_out_B "Enthalpy at Inlet B";

  SI.HeatFlowRate q_max "Maximum heat flow rate";
  SI.HeatFlowRate q_flowA "Heat flow rate side A";
  SI.HeatFlowRate q_flowB "Heat flow rate side B";

  Real C_A(unit="J/(K.s)") "Heat capacity rate of Medium A";
  Real C_B(unit="J/(K.s)") "Heat capacity rate of Medium B";
  Real C_min(unit="J/(K.s)") "minimum heat capacity rate";
  Real C_max(unit="J/(K.s)") "maximum heat capacity rate";
  Real C_r(unit="1") "Cmin/Cmax (ratio of heat capacity rates)";

  Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp_A "specific heat capacity of Medium A";
  Modelica.SIunits.SpecificHeatCapacityAtConstantPressure cp_B "specific heat capacity of Medium B";

  Modelica.SIunits.MassFlowRate m_flow_A = inletA.m_flow "Mass flow on side A";
  Modelica.SIunits.MassFlowRate m_flow_B = inletB.m_flow "Mass flow on side B";

  SI.SpecificHeatCapacity cpA_in = MediumA.specificHeatCapacityCp(inletA.state);
  SI.SpecificHeatCapacity cpA_out = MediumA.specificHeatCapacityCp(outletA.state);
  SI.SpecificHeatCapacity cpB_in = MediumB.specificHeatCapacityCp(inletB.state);
  SI.SpecificHeatCapacity cpB_out = MediumB.specificHeatCapacityCp(outletB.state);

protected
  constant Real eps(unit="kg/s") = Modelica.Constants.eps;

initial equation
  h_out_A = h_in_A;
  h_out_B = h_in_B;

equation
  //Balance Equations
  inletA.m_flow + outletA.m_flow = 0;
  inletB.m_flow + outletB.m_flow = 0;
  inletA.r - outletA.r  = der(inletA.m_flow) * L;
  inletB.r - outletB.r  = der(inletB.m_flow) * L;

  //Specific heat capacities
  cp_A = (cpA_in + cpA_out)/2;
  cp_B = (cpB_in + cpB_out)/2;

  //Heat capacity rates
  C_A = (abs(inletA.m_flow)+eps)*cp_A;
  C_B = (abs(inletB.m_flow)+eps)*cp_B;

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
  //it is assumed that both fluids are unmixed
  effectiveness = 1 - exp((1/C_r)*NTU^(0.22)*(exp(-C_r*NTU^(0.78))-1));

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
        Text(
          extent={{-120,-20},{-80,-60}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{20,120},{60,80}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Line(
          points={{0,70},{0,-80}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-56,54},{64,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-70,0},{80,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,18},{0,56}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-48,6},{52,6}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-48,-6},{52,-6}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{28,18},{28,42}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-28,18},{-28,44}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-25,24},
          rotation=270),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-31,24},
          rotation=270),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={3,24},
          rotation=270),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-3,24},
          rotation=270),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={31,24},
          rotation=270),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={25,24},
          rotation=270),
        Line(
          points={{-28,-50},{-28,-24}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-25,-44},
          rotation=270),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-31,-44},
          rotation=270),
        Line(
          points={{0,-50},{0,-12}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={-3,-44},
          rotation=270),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={3,-44},
          rotation=270),
        Line(
          points={{28,-50},{28,-26}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{6,3},{-5,-2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={25,-44},
          rotation=270),
        Line(
          points={{6,-3},{-5,2}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA < T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5,
          origin={31,-44},
          rotation=270),
        Line(
          points={{42,2},{52,6}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{42,10},{52,6}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{42,-10},{52,-6}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{42,-2},{52,-6}},
          color=DynamicSelect({215,215,215}, if T_in_MediumA > T_in_MediumB then {238,46,47} else {21,85,157}),
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Basic model of a cross-flow heat exchanger based on the effectiveness-NTU method.</p>
<p>The equations are derived from the generic effectiveness-NTU relations which can be found in the &quot;VDI W&auml;rmeatlas&quot; and noumerous standard literature.</p>
<p>For stream dominated applications the following assumptions are made for mass flow regularisation close to zero:</p>
<p>- if the mass flow on both sides of the heat exchanger is zero, no heat is transferred</p>
</html>"));
end CrossFlowNTU;
