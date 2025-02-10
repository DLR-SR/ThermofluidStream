within ThermofluidStream.Undirected.Interfaces.MSLplug.Tests;
model TargetTest_10_NOK
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Water.StandardWaterOnePhase
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation (
      choicesAllMatching=true);

  parameter Modelica.Units.NonSI.Temperature_degC T_SP=80 "Solar field outlet temperature setpoint"
    annotation(Dialog(group = "Control"));
  parameter  Modelica.Units.NonSI.Temperature_degC l_s=55 "Security maximum temperature threshold for production switching"
    annotation(Dialog(group = "Control"));
  parameter Modelica.Units.NonSI.Temperature_degC hyst_prod_pre=5  "Temperature hysteresis for switches in between in production and out of production"
    annotation(Dialog(group = "Control"));
  parameter Modelica.Units.NonSI.Temperature_degC detlat_T_SP=10  "Security margin deduced from the temperature setpoint to switch in production (compared with l_s and valuabe process temperature)."
    annotation(Dialog(group = "Control"));
  parameter Modelica.Units.NonSI.Temperature_degC detlat_T_min=5  "Minimum temperature difference supplied to the process"
    annotation(Dialog(group = "Control"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "nominal mass flow rate for regularisation"
    annotation(Dialog(tab = "Advanced", group = "Regularisation parameters"));
  parameter Boolean computeL=true "Compute L from r and l" annotation (Dialog(tab="Advanced", group="Flow inertance"));

  ThermofluidStream.HeatExchangers.CounterFlowNTU pHEXSimplified(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={6,10})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,30},{110,50}})));

  ThermofluidStream.FlowControl.MCV mCV(
    redeclare package Medium = Medium,
    setpointFromInput=true,
    massFlow_set_par=1)
          annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
  ThermofluidStream.FlowControl.MCV flowGenerator_SF(
    redeclare package Medium = Medium, massFlow_set_par=10)
          annotation (Placement(transformation(extent={{-50,-10},{-70,-30}})));

  ThermofluidStream.Boundaries.Source source(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{110,-30},{90,-10}})));
  inner DropOfCommons dropOfCommons(L=1000)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Noise.UniformNoise mFlowScenario(
    samplePeriod=60,
    y_min=0.001,
    y_max=15) annotation (Placement(transformation(extent={{108,-10},{88,10}})));
  ThermofluidStream.Boundaries.Reservoir reservoir(redeclare package Medium = Medium, A_surf(displayUnit="m2"))
    annotation (Placement(transformation(extent={{-24,-30},{-44,-10}})));
  Boundaries.Volume volume(redeclare package Medium = Medium, V_par=0.1) annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=2) annotation (Placement(transformation(extent={{82,-4},{74,4}})));
  Topology.ConnectorInletOutletFore connectorInletOutletFore(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{34,34},{46,46}})));
  Topology.ConnectRearRear connectRearRear(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{42,-18},{62,2}})));
  Topology.ConnectorInletOutletFore connectorInletOutletFore1(redeclare package Medium = Medium)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={46,-20})));
  ThermofluidStream.FlowControl.MCV flowGenerator_SF1(redeclare package Medium = Medium, massFlow_set_par=10)
          annotation (Placement(transformation(extent={{36,-10},{16,-30}})));
  Modelica.Blocks.Noise.UniformNoise heatScenario(
    samplePeriod=60,
    y_min=10,
    y_max=95) annotation (Placement(transformation(extent={{-120,0},{-100,20}})));
  ThermofluidStream.Processes.ConductionElement conductionElement(
    redeclare package Medium = Medium,
    V=0.01,
    resistanceFromAU=false,
    k_par=500) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-76,10})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
                                                           prescribedTemperature
                                                                              annotation (Placement(transformation(extent={{-94,6},{-86,14}})));
  ThermofluidStream.FlowControl.Switch switch(
    redeclare package Medium = Medium,
    m_flow_ref=10,
    invertInput=true) annotation (Placement(transformation(extent={{-16,46},{-4,34}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C,
    outputValue=true) annotation (Placement(transformation(extent={{-62,40},{-42,60}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{-30,56},{-22,64}})));
  Modelica.Blocks.Sources.RealExpression stepoint(y=80) annotation (Placement(transformation(extent={{-52,52},{-40,68}})));
  ThermofluidStream.Topology.JunctionT2 junctionT2_1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-14,-26},{-6,-14}})));
protected
  parameter Medium.ThermodynamicState state_0_CS = Medium.setState_phX(Medium.p_default, Medium.h_default, Medium.X_default[1:Medium.nXi]);
  parameter Modelica.Units.SI.Density rho_CS = Medium.density(state_0_CS);
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_CS = Medium.specificHeatCapacityCp(state_0_CS);
  parameter Medium.ThermodynamicState state_0_cuve = Medium.setState_phX(Medium.p_default, Medium.h_default, Medium.X_default[1:Medium.nXi]);
  parameter Modelica.Units.SI.Density rho_cuve = Medium.density(state_0_cuve);
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_cuve = Medium.specificHeatCapacityCp(state_0_cuve);

equation

  connect(mCV.inlet, source.outlet) annotation (Line(
      points={{80,-20},{90,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowGenerator_SF.inlet, reservoir.outlet) annotation (Line(
      points={{-50,-20},{-44,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(mFlowScenario.y, firstOrder.u) annotation (Line(points={{87,0},{82.8,0}}, color={0,0,127}));
  connect(firstOrder.y, mCV.setpoint_var) annotation (Line(points={{73.6,0},{70,0},{70,-12}}, color={0,0,127}));
  connect(connectRearRear.rear_b, volume.fore) annotation (Line(
      points={{55,-8},{60,-8},{60,10}},
      color={28,108,200},
      thickness=0.5));
  connect(volume.rear, connectorInletOutletFore.fore) annotation (Line(
      points={{40,10},{40,34}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, connectorInletOutletFore1.inlet) annotation (Line(
      points={{60,-20},{52,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(connectorInletOutletFore1.fore, connectRearRear.rear_a) annotation (Line(
      points={{46,-14},{46,-8},{49,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(connectorInletOutletFore1.outlet, flowGenerator_SF1.inlet) annotation (Line(
      points={{40,-20},{36,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowGenerator_SF1.outlet, pHEXSimplified.inletB)
    annotation (Line(
      points={{16,-20},{12,-20},{12,-4.44089e-15}},
      color={28,108,200},
      thickness=0.5));
  connect(pHEXSimplified.outletB, connectorInletOutletFore.inlet) annotation (Line(
      points={{12,20},{12,40},{34,40}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.heatPort, prescribedTemperature.port) annotation (Line(points={{-85.8,10},{-86,10}}, color={191,0,0}));
  connect(conductionElement.outlet, switch.inlet) annotation (Line(
      points={{-76,20},{-76,40},{-16,40}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.outletA, pHEXSimplified.inletA) annotation (Line(
      points={{-4,40},{0,40},{0,20},{1.55431e-15,20}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.outletB, junctionT2_1.inletA) annotation (Line(
      points={{-10,34},{-10,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.outlet, singleSensorSelect.inlet)
    annotation (Line(
      points={{-76,20},{-76,40},{-66,40},{-66,50},{-62,50}},
      color={28,108,200},
      thickness=0.5));
  connect(PID.y, switch.u) annotation (Line(points={{-21.6,60},{-10,60},{-10,44.8}}, color={0,0,127}));
  connect(prescribedTemperature.T, heatScenario.y) annotation (Line(points={{-94.8,10},{-99,10}}, color={0,0,127}));
  connect(pHEXSimplified.outletA, junctionT2_1.inletB) annotation (Line(
      points={{0,-2.66454e-15},{0,-20},{-6,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_1.outlet, reservoir.inlet) annotation (Line(
      points={{-14,-20},{-24,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowGenerator_SF.outlet, conductionElement.inlet) annotation (Line(
      points={{-70,-20},{-76,-20},{-76,0}},
      color={28,108,200},
      thickness=0.5));
  connect(connectorInletOutletFore.outlet, sink.inlet) annotation (Line(
      points={{46,40},{90,40}},
      color={28,108,200},
      thickness=0.5));
  connect(stepoint.y, PID.u_s) annotation (Line(points={{-39.4,60},{-30.8,60}}, color={0,0,127}));
  connect(singleSensorSelect.value_out, PID.u_m) annotation (Line(points={{-42,50},{-26,50},{-26,55.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,80}})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,80}})),
    experiment(
      StopTime=3600,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(
      executeCall(ensureSimulated=true) = {createPlot(
        id=1,
        position={0,0,1614,678},
        y={"solarField_V2.inlet.state.T","solarField_V2.outlet.state.T","solarField_V2.heatTransferElement_Solar_V2.T","weather.T_amb","solarField_V2.heatTransferElement_Solar_V2.T_in_eff",
          "solarField_V2.inlet.m_flow"},
        range={0.0,195.0,-5.0,90.0},
        grid=true,
        colors={{28,108,200},{238,46,47},{217,67,180},{0,140,72},{102,44,145},{0,0,0}},
        timeUnit="h",
        displayUnits={"degC","degC","degC","degC","degC","kg/s"})} "Temp CS",
      executeCall(ensureSimulated=true) = {createPlot(
        id=1,
        position={0,0,1614,697},
        y={"weather.T_amb","solarField_V2.inlet.state.T","solarField_V2.outlet.state.T","solarField_V2.heatTransferElement_Solar_V2.T","solarField_V2.heatTransferElement_Solar_V2.T_in_eff",
          "solarField_V2.inlet.m_flow"},
        range={0.0,195.0,-10.0,90.0},
        grid=true,
        subPlot=101,
        colors={{0,140,72},{28,108,200},{238,46,47},{217,67,180},{102,44,145},{0,0,0}},
        timeUnit="h",
        displayUnits={"degC","degC","degC","degC","degC","kg/s"}),createPlot(
        id=1,
        position={0,0,1614,697},
        y={"stratifiedTank_Diffuser.T_lay[1]","stratifiedTank_Diffuser.T_lay[3]","stratifiedTank_Diffuser.T_lay[5]","stratifiedTank_Diffuser.T_lay[7]","stratifiedTank_Diffuser.T_lay[9]",
          "stratifiedTank_Diffuser.T_lay[11]","stratifiedTank_Diffuser.T_lay[13]","stratifiedTank_Diffuser.T_lay[15]","stratifiedTank_Diffuser.T_lay[17]","stratifiedTank_Diffuser.T_lay[19]",
          "stratifiedTank_Diffuser.T_lay[20]"},
        range={0.0,195.0,10.0,80.0},
        grid=true,
        subPlot=102,
        colors={{28,108,200},{238,46,47},{0,140,72},{217,67,180},{0,0,0},{162,29,33},{244,125,35},{102,44,145},{28,108,200},{238,46,47},{0,140,72}},
        patterns={LinePattern.Solid,LinePattern.Solid,LinePattern.Solid,LinePattern.Solid,LinePattern.Solid,LinePattern.Solid,LinePattern.Solid,
          LinePattern.Solid,LinePattern.Dash,LinePattern.Dash,LinePattern.Dash},
        timeUnit="h",
        displayUnits={"degC","degC","degC","degC","degC","degC","degC","degC","degC","degC","degC"})} "Températures CS et cuve",
      executeCall(ensureSimulated=true) = {createPlot(
        id=1,
        position={0,0,1614,678},
        y={"prod_switch.y","flowGenerator_SF.V_flow_out","flowGenerator_SF.V_flow_sp"},
        range={0.0,700000.0,-5.0,50.0},
        grid=true,
        subPlot=101,
        colors={{0,140,72},{28,108,200},{238,46,47}},
        timeUnit="s",
        displayUnits={"","m3/h","m3/h"}),createPlot(
        id=1,
        position={0,0,1614,678},
        y={"flowGenerator_SF.L"},
        range={0.0,700000.0,-1000000.0,11000000.0},
        grid=true,
        subPlot=202,
        colors={{28,108,200}},
        timeUnit="s",
        displayUnits={"1/m"}),createPlot(
        id=1,
        position={0,0,1614,678},
        y={"flowGenerator_SF.dr","flowGenerator_SF.dr_set"},
        range={0.0,700000.0,-4.0,4.0},
        grid=true,
        subPlot=201,
        colors={{28,108,200},{238,46,47}},
        timeUnit="s",
        displayUnits={"bar","bar"}),createPlot(
        id=1,
        position={0,0,1614,678},
        y={"flowGenerator_SF.p_in","flowGenerator_SF.p_out"},
        range={0.0,700000.0,0.5,4.0},
        grid=true,
        subPlot=102,
        colors={{28,108,200},{238,46,47}},
        timeUnit="s",
        displayUnits={"bar","bar"})} "Inertance analysis"));
end TargetTest_10_NOK;
