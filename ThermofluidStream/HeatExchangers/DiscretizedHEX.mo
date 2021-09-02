within ThermofluidStream.HeatExchangers;
model DiscretizedHEX "Discretized Heat Exchanger for two-phase working fluid"

  replaceable package MediumAir =
      ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Dialog(group = "Medium definitions"));
  replaceable package MediumRefrigerant =
      ThermofluidStream.Media.myMedia.Interfaces.PartialTwoPhaseMedium
    "Medium model" annotation (choicesAllMatching=true, Dialog(group = "Medium definitions"));

//   MediumRefrigerant.BaseProperties ref_out;
//
//   SI.Pressure p_out_ref = MediumRefrigerant.pressure(outletRef.state);
//   SI.Temperature T_out_ref = MediumRefrigerant.temperature(outletRef.state);

  parameter Boolean initializeMassFlow=false  "Initialize mass flow at inlets?" annotation(Dialog(tab = "Initialization", group = "Mass flow"));
  parameter SI.MassFlowRate m_flow_0 = 0.01 "Initial mass flow" annotation(Dialog(tab = "Initialization", group = "Mass flow", enable = initializeMassFlow));
  parameter Integer nCells = 3 "Number of discretization elements";
  parameter Modelica.SIunits.Area A = 10 "Conductive area of heat exchanger" annotation(Dialog(group = "Heat transfer parameters"));
  parameter Modelica.SIunits.Volume V_Hex = 0.001 "Volume for heat transfer calculation" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.CoefficientOfHeatTransfer U_nom = 3000 "Nominal coefficient of heat transfer for single-phase side" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.CoefficientOfHeatTransfer U_liq_nom = 700 "Nominal coefficient of heat transfer for liquid region" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.CoefficientOfHeatTransfer U_vap_nom = 500 "Nominal coefficient of heat transfer for vapour region" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.CoefficientOfHeatTransfer U_tp_nom = 1000 "Nominal coefficient of heat transfer for two-phase region" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.MassFlowRate m_flow_nom_ref = 0.3 "Nominal mass-flow rate working fluid" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.MassFlowRate m_flow_nom_air = 1.0 "Nominal mass-flow rate secondary fluid" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.MassFlowRate m_flow_assert(max=0) = -dropOfCommons.m_flow_reg "Assertion threshold for negative massflows"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean enforce_global_energy_conservation = false "If true, exact global energy conservation is enforced by feeding back all energy stored locally back in the system"
    annotation(Dialog(tab="Advanced"));

  //Parameterization of HEX Wall
  parameter Modelica.SIunits.CoefficientOfHeatTransfer k_wall = 100 "Coefficient of heat transfer for pipe wall" annotation(Dialog(group = "Wall parameters"));
protected
  parameter Modelica.SIunits.ThermalConductance G = k_wall*A "Wall thermal conductance" annotation(Dialog(group = "Wall parameters"));


public
  Internal.ConductionElementHEX thermalElementAir[nCells](
    redeclare package Medium = MediumAir,
    each V(displayUnit="l") = V_Hex/nCells,
    each enforce_global_energy_conservation=enforce_global_energy_conservation,
    each A=A/nCells,
    each U_nom=U_nom,
    each m_flow_nom=m_flow_nom_air)
                                annotation (Placement(transformation(extent={{-10,90},{10,70}})));

  Internal.ConductionElementHEX_twoPhase thermalElementRefrigerant[nCells](
    each V(displayUnit="l") = V_Hex/nCells,
    each enforce_global_energy_conservation=enforce_global_energy_conservation,
    each A=A/nCells,
    each U_liq_nom=U_liq_nom,
    each U_vap_nom=U_vap_nom,
    each U_tp_nom=U_tp_nom,
    each m_flow_nom=m_flow_nom_ref,
    redeclare package Medium = MediumRefrigerant) annotation (Placement(transformation(extent={{10,-90},{-10,-70}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[nCells](each G=G/nCells)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));
  Interfaces.Inlet inletAir(redeclare package Medium = MediumAir)
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Interfaces.Outlet outletAir(redeclare package Medium = MediumAir)
    annotation (Placement(transformation(extent={{92,70},{112,90}})));
  Interfaces.Inlet inletRef(redeclare package Medium = MediumRefrigerant)
    annotation (Placement(transformation(extent={{110,-90},{90,-70}})));
  Interfaces.Outlet outletRef(redeclare package Medium = MediumRefrigerant)
    annotation (Placement(transformation(extent={{-92,-90},{-112,-70}})));

  SI.HeatFlowRate Q_flow_ref=sum(thermalElementRefrigerant.heatPort.Q_flow);
  SI.HeatFlowRate Q_flow_air=sum(thermalElementAir.heatPort.Q_flow);
  SI.Energy deltaE_system = sum(thermalElementAir.deltaE_system) + sum(thermalElementRefrigerant.deltaE_system);
  SI.Mass M_ref = sum(thermalElementRefrigerant.M);

  Real x_in(unit="1") = thermalElementRefrigerant[1].x;
  Real x_out(unit="1") = thermalElementRefrigerant[nCells].x;

  SI.SpecificEnthalpy dh_ref = MediumRefrigerant.specificEnthalpy(outletRef.state) - MediumRefrigerant.specificEnthalpy(inletRef.state);
  SI.SpecificEnthalpy dh_air = MediumAir.specificEnthalpy(outletAir.state) - MediumAir.specificEnthalpy(inletAir.state);

  //SI.Temperature T_sat;

  ThermofluidStream.HeatExchangers.Internal.DiscretizedHEXSummary summary "Summary record of Quantities";

protected
  outer DropOfCommons dropOfCommons;

initial equation

  if initializeMassFlow then
   inletRef.m_flow = m_flow_0;
   inletAir.m_flow = m_flow_0;
  else
  end if;

equation
  assert(inletAir.m_flow > m_flow_assert, "Negative massflow at Air inlet", dropOfCommons.assertionLevel);
  assert(inletRef.m_flow > m_flow_assert, "Negative massflow at Refigerant inlet", dropOfCommons.assertionLevel);


//Summary record
 summary.Tin_air = MediumAir.temperature(inletAir.state);
 summary.Tin_ref = MediumRefrigerant.temperature(inletRef.state);
 summary.Tout_air = MediumAir.temperature(outletAir.state);
 summary.Tout_ref = MediumRefrigerant.temperature(outletRef.state);

 summary.hin_air = MediumAir.specificEnthalpy(inletAir.state);
 summary.hin_ref = MediumRefrigerant.specificEnthalpy(inletRef.state);
 summary.hout_air = MediumAir.specificEnthalpy(outletAir.state);
 summary.hout_ref = MediumRefrigerant.specificEnthalpy(outletRef.state);

  //Connecting equations (to interconnect pipes)
  //Fluid Side A
  connect(inletAir, thermalElementAir[1].inlet) annotation (Line(points={{-100,80},{-10,80}}, color={28,108,200}));
  for i in 1:nCells-1 loop
    connect(thermalElementAir[i].outlet, thermalElementAir[i + 1].inlet);
  end for;
  connect(thermalElementAir[nCells].outlet, outletAir) annotation (Line(points={{10,80},{10,80},{10,80},{102,80}}, color={28,108,200}));

  //Fluid Side B
  connect(inletRef, thermalElementRefrigerant[1].inlet) annotation (Line(points={{100,-80},{10,-80}}, color={28,108,200}));
  for i in 1:nCells-1 loop
    connect(thermalElementRefrigerant[i].outlet, thermalElementRefrigerant[i + 1].inlet);
  end for;
  connect(thermalElementRefrigerant[nCells].outlet, outletRef) annotation (Line(points={{-10,-80},{-102,-80}}, color={28,108,200}));

  connect(thermalElementAir.heatPort, thermalConductor.port_b) annotation(Line(points={{4.44089e-16,70.2},{4.44089e-16,40},{0,40},{0,10}}, color={191,0,0}));

  for i in 1:nCells loop
    connect(thermalElementRefrigerant[i].heatPort, thermalConductor[nCells+1-i].port_a)
    annotation(Line(points={{-6.66134e-16,-70.2},{-6.66134e-16,-10},{0,-10}},color={191,0,0}));
  end for;


  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                                                                graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=25),
        Polygon(points={{-80,-92},{70,-92},{70,-62},{-80,-62},{-70,-52},{80,-52},{80,-82},{70,-92},{70,-62},{80,-52},{-70,-52},{-80,-62},{-80,-92}},
            lineColor={5,188,185}),
        Line(points={{-40,-52},{-50,-62},{-50,-92}}, color={5,188,185}),
        Line(points={{-10,-52},{-20,-62},{-20,-92}},color={5,188,185}),
        Line(points={{20,-52},{10,-62},{10,-92}}, color={5,188,185}),
        Line(points={{50,-52},{40,-62},{40,-92}}, color={5,188,185}),
        Text(
          extent={{-70,-72},{-58,-84}},
          lineColor={5,188,185},
          pattern=LinePattern.Dash,
          textString="N"),
        Text(
          extent={{52,-72},{64,-84}},
          lineColor={5,188,185},
          pattern=LinePattern.Dash,
          textString="1"),
        Text(
          extent={{20,-72},{32,-84}},
          lineColor={5,188,185},
          pattern=LinePattern.Dash,
          textString="2"),
        Text(
          extent={{-10,-72},{2,-84}},
          lineColor={5,188,185},
          pattern=LinePattern.Dash,
          textString="..."),
        Text(
          extent={{-40,-72},{-28,-84}},
          lineColor={5,188,185},
          pattern=LinePattern.Dash,
          textString="..."),
        Polygon(points={{-80,56},{70,56},{70,86},{-80,86},{-70,96},{80,96},{80,66},{70,56},{70,86},{80,96},{-70,96},{-80,86},{-80,56}}, lineColor={28,
              108,200}),
        Line(points={{-40,96},{-50,86},{-50,56}}, color={28,108,200}),
        Line(points={{-10,96},{-20,86},{-20,56}}, color={28,108,200}),
        Line(points={{20,96},{10,86},{10,56}}, color={28,108,200}),
        Line(points={{50,96},{40,86},{40,56}}, color={28,108,200}),
        Text(
          extent={{50,76},{62,64}},
          lineColor={28,108,200},
          pattern=LinePattern.Dash,
          textString="N"),
        Text(
          extent={{20,76},{32,64}},
          lineColor={28,108,200},
          pattern=LinePattern.Dash,
          textString="..."),
        Text(
          extent={{-10,76},{2,64}},
          lineColor={28,108,200},
          pattern=LinePattern.Dash,
          textString="..."),
        Text(
          extent={{-42,76},{-30,64}},
          lineColor={28,108,200},
          pattern=LinePattern.Dash,
          textString="2"),
        Text(
          extent={{-72,76},{-60,64}},
          lineColor={28,108,200},
          pattern=LinePattern.Dash,
          textString="1"),
        Text(
          extent={{-8,41},{8,-41}},
          lineColor={188,36,38},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="«",
          origin={-61,36},
          rotation=270),
        Text(
          extent={{-8,41},{8,-41}},
          lineColor={188,36,38},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="«",
          origin={1,36},
          rotation=270),
        Text(
          extent={{-8,41},{8,-41}},
          lineColor={188,36,38},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="«",
          origin={61,36},
          rotation=270),
        Text(
          extent={{-8,41},{8,-41}},
          lineColor={188,36,38},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="«",
          origin={57,-36},
          rotation=90),
        Text(
          extent={{-8,41},{8,-41}},
          lineColor={188,36,38},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="«",
          origin={-65,-36},
          rotation=90),
        Text(
          extent={{-8,41},{8,-41}},
          lineColor={188,36,38},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="«",
          origin={-3,-36},
          rotation=90),
        Polygon(points={{-82,-16},{68,-16},{68,4},{-82,4},{-72,14},{78,14},{78,-6},{68,-16},{68,4},{78,14},{-72,14},{-82,4},{-82,-16}}, lineColor={188,
              36,38}),
        Line(points={{-42,14},{-52,4},{-52,-16}}, color={188,36,38}),
        Line(points={{-12,14},{-22,4},{-22,-16}}, color={188,36,38}),
        Line(points={{18,14},{8,4},{8,-16}},   color={188,36,38}),
        Line(points={{48,14},{38,4},{38,-16}}, color={188,36,38})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end DiscretizedHEX;
