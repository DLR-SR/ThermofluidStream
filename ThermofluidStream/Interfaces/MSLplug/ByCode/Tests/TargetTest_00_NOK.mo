within ThermofluidStream.Interfaces.MSLplug.ByCode.Tests;
model TargetTest_00_NOK
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

  HeatExchangers.CounterFlowNTU pHEXSimplified(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=10)              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,2})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=101300)
    annotation (Placement(transformation(extent={{56,30},{76,50}})));

  ThermofluidStream.FlowControl.MCV mCV(
    redeclare package Medium = Medium, massFlow_set_par=1)
          annotation (Placement(transformation(extent={{50,-10},{30,-30}})));
  ThermofluidStream.FlowControl.MCV flowGenerator_SF(
    redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=1,
    massFlow_set_par=1,
    dp_int(fixed=false))
          annotation (Placement(transformation(extent={{-30,-10},{-50,-30}})));

  ThermofluidStream.Boundaries.Source source(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{76,-30},{56,-10}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Processes.ThermalConvectionPipe thermalConvectionPipe(
    redeclare package Medium = Medium,
    r=0.01,
    l=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,10})));
  Boundaries.Reservoir reservoir(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{0,-30},{-20,-10}})));
  Processes.FlowResistance                   flowResistance(
    redeclare package Medium = Medium,
    r=0.1,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=10))
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=500, T(start=373.15, fixed=true))
    annotation (Placement(transformation(extent={{-84,10},{-74,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-92,6},{-84,14}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,5000; 2000,5000; 2000.01,10000; 4000,10000; 4000.01,25000; 6000,25000; 6000.01,5000; 10000,5000])
    annotation (Placement(transformation(extent={{-120,0},{-100,20}})));

equation

  connect(mCV.outlet, pHEXSimplified.inletB) annotation (Line(
      points={{30,-20},{26,-20},{26,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.inlet, source.outlet) annotation (Line(
      points={{50,-20},{56,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(pHEXSimplified.outletA, reservoir.inlet) annotation (Line(
      points={{14,-8},{14,-20},{0,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(pHEXSimplified.outletB, sink.inlet) annotation (Line(
      points={{26,12},{26,40},{56,40}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.outlet, flowResistance.inlet) annotation (Line(
      points={{-60,20},{-60,40},{-40,40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, pHEXSimplified.inletA) annotation (Line(
      points={{-20,40},{14,40},{14,12}},
      color={28,108,200},
      thickness=0.5));
  connect(reservoir.outlet, flowGenerator_SF.inlet) annotation (Line(
      points={{-20,-20},{-30,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowGenerator_SF.outlet, thermalConvectionPipe.inlet) annotation (Line(
      points={{-50,-20},{-60,-20},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.heatPort,heatCapacitor. port)
    annotation (Line(points={{-70,10},{-79,10}},  color={191,0,0}));
  connect(heatCapacitor.port,prescribedHeatFlow. port)
    annotation (Line(points={{-79,10},{-84,10}},   color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow,combiTimeTable. y[1])
    annotation (Line(points={{-92,10},{-99,10}},   color={0,0,127}));
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
end TargetTest_00_NOK;
