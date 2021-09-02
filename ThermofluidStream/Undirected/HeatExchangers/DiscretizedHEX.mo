within ThermofluidStream.Undirected.HeatExchangers;
model DiscretizedHEX

  replaceable package MediumAir =
      ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Dialog(group = "Medium definitions"));

  replaceable package MediumRefrigerant =
      ThermofluidStream.Media.myMedia.Interfaces.PartialTwoPhaseMedium
    "Medium model" annotation (choicesAllMatching=true, Dialog(group = "Medium definitions"));

  parameter ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement initRef=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.h
    "Initialization method for h (refrigerant side)"
    annotation (Dialog(tab="Initialization", group="Enthalpy"),
      choices(
        choice=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.h "h0",
        choice=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.rear "rear",
        choice=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.fore "fore"));

  parameter SI.SpecificEnthalpy h0 = MediumRefrigerant.h_default "Initial enthalpy"
   annotation(Dialog(tab = "Initialization", group = "Enthalpy", enable=(initRef == ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.h)));
  parameter Integer nCells = 3 "Number of discretization elements";
  parameter Modelica.SIunits.Area A = 10 "Conductive area of heat exchanger" annotation(Dialog(group = "Heat transfer parameters"));
  parameter Modelica.SIunits.Volume V_Hex = 0.001 "Volume for heat transfer calculation" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.CoefficientOfHeatTransfer U_nom = 3000 "Nominal coefficient of heat transfer for single-phase side" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.CoefficientOfHeatTransfer U_liq_nom = 700 "Nominal coefficient of heat transfer for liquid region" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.CoefficientOfHeatTransfer U_vap_nom = 500 "Nominal coefficient of heat transfer for vapour region" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.CoefficientOfHeatTransfer U_tp_nom = 1000 "Nominal coefficient of heat transfer for two-phase region" annotation(Dialog(group = "Heat transfer parameters"));
  parameter Boolean initializeMassFlow = false "Initialize mass flow at inlets?" annotation(Dialog(tab = "Initialization", group = "Mass flow"));
  parameter SI.MassFlowRate m_flow_0 = 0.01 "Initial mass flow" annotation(Dialog(tab = "Initialization", group = "Mass flow", enable = initializeMassFlow));
  parameter SI.MassFlowRate m_flow_nom_ref = 0.3 "Nominal mass-flow rate working fluid" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.MassFlowRate m_flow_nom_air = 1.0 "Nominal mass-flow rate secondary fluid" annotation(Dialog(group = "Heat transfer parameters"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization massflow to switch between positive- and negative-massflow model"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean enforce_global_energy_conservation = false "If true, exact global energy conservation is enforced by feeding back all energy stored locally back in the system"
    annotation(Dialog(tab="Advanced"));

//Parameterization of HEX Wall
  parameter Modelica.SIunits.CoefficientOfHeatTransfer k_wall = 100 "Coefficient of heat transfer for pipe wall" annotation(Dialog(group = "Wall parameters"));
protected
  parameter Modelica.SIunits.ThermalConductance G = k_wall*A "Wall thermal conductance" annotation(Dialog(group = "Wall parameters"));


public
  Interfaces.Fore foreAir(redeclare package Medium = MediumAir) annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Interfaces.Fore foreRef(redeclare package Medium = MediumRefrigerant) annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Interfaces.Rear rearAir(redeclare package Medium = MediumAir) annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Interfaces.Rear rearRef(redeclare package Medium = MediumRefrigerant) annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Internal.ConductionElementHEX conductionElementAir[nCells](
    redeclare package Medium = MediumAir,
    each V=V_Hex/nCells,
    each enforce_global_energy_conservation=enforce_global_energy_conservation,
    each A=A/nCells,
    each U_nom=U_nom,
    each m_flow_nom=m_flow_nom_air)
                      annotation (Placement(transformation(extent={{-10,90},{10,70}})));
  Internal.ConductionElementHEX_twoPhase conductionElementRefrigerant[nCells](
    each init=initRef,
    each enforce_global_energy_conservation=enforce_global_energy_conservation,
    each U_liq_nom=U_liq_nom,
    each U_vap_nom=U_vap_nom,
    each U_tp_nom=U_tp_nom,
    each m_flow_nom=m_flow_nom_ref,
    each h_0 = h0,
    redeclare package Medium = MediumRefrigerant,
    each V=V_Hex/nCells,
    each A=A/nCells)
              annotation (Placement(transformation(extent={{10,-90},{-10,-70}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[nCells](each G=G/nCells)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));

  SI.HeatFlowRate Q_flow_Air=sum(conductionElementAir.heatPort.Q_flow);
  SI.HeatFlowRate Q_flow_Ref=sum(conductionElementRefrigerant.heatPort.Q_flow);
  SI.Energy deltaE_system = sum(conductionElementAir.deltaE_system) + sum(conductionElementRefrigerant.deltaE_system);
  SI.Mass M_ref = sum(conductionElementRefrigerant.M);

  //Relevant variables
  SI.SpecificEnthalpy h_out_ref = Undirected.Internal.regStep(   rearRef.m_flow,
  MediumRefrigerant.specificEnthalpy(foreRef.state_forwards), MediumRefrigerant.specificEnthalpy(rearRef.state_rearwards), m_flow_reg);
  SI.SpecificEnthalpy h_out_air = Undirected.Internal.regStep(   rearAir.m_flow,
  MediumAir.specificEnthalpy(foreAir.state_forwards), MediumAir.specificEnthalpy(rearAir.state_rearwards), m_flow_reg);
  SI.Temperature T_out_ref = Undirected.Internal.regStep(   rearRef.m_flow,
  MediumRefrigerant.temperature(foreRef.state_forwards), MediumRefrigerant.temperature(rearRef.state_rearwards), m_flow_reg);
  SI.Temperature T_out_air = Undirected.Internal.regStep(   rearAir.m_flow,
  MediumAir.temperature(foreAir.state_forwards), MediumAir.temperature(rearAir.state_rearwards), m_flow_reg);

protected
  outer DropOfCommons dropOfCommons;

initial equation
   if initializeMassFlow then
    foreAir.m_flow = m_flow_0;
    foreRef.m_flow = m_flow_0;
  else
  end if;
equation

  //Connection equations (to interconnect segments)
  //Fluid Side A
  connect(rearAir, conductionElementAir[1].rear) annotation (Line(points={{-100,80},{-10,80}}, color={28,108,200}));
  for i in 1:nCells-1 loop
    connect(conductionElementAir[i].fore, conductionElementAir[i + 1].rear);
  end for;
  connect(conductionElementAir[nCells].fore, foreAir) annotation (Line(points={{10,80},{100,80}}, color={28,108,200}));

  //Fluid Side B
  connect(rearRef, conductionElementRefrigerant[1].rear) annotation (Line(points={{100,-80},{10,-80}}, color={28,108,200}));
  for i in 1:nCells-1 loop
    connect(conductionElementRefrigerant[i].fore, conductionElementRefrigerant[i + 1].rear);
  end for;
  connect(conductionElementRefrigerant[nCells].fore, foreRef) annotation (Line(points={{-10,-80},{-100,-80}}, color={28,108,200}));

  for i in 1:nCells loop
    connect(conductionElementAir[i].heatPort, thermalConductor[i].port_b) annotation(Line(points={{4.44089e-16,70.2},{4.44089e-16,40},{0,40},{0,10}}, color={191,0,0}));
  end for;

  for i in 1:nCells loop
    connect(conductionElementRefrigerant[i].heatPort, thermalConductor[nCells + 1 - i].port_a) annotation(Line(points={{-6.66134e-16,-70.2},{
            -6.66134e-16,-10},{0,-10}},                                                                                                                                    color={191,0,0}));
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
