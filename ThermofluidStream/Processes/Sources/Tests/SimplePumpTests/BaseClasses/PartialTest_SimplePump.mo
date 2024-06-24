within ThermofluidStream.Processes.Sources.Tests.SimplePumpTests.BaseClasses;
partial model PartialTest_SimplePump "Basic cooling cycle with a load"
extends Modelica.Icons.Example;

  replaceable package Medium_liquid = ThermofluidStream.Media.myMedia.Water.ConstantPropertyLiquidWater constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Liquid model"
    annotation(choicesAllMatching = true);

  replaceable package Medium_air = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Air model"
    annotation(choicesAllMatching = true);

  ThermofluidStream.HeatExchangers.CounterFlowNTU heatExchanger(
    redeclare package MediumA = Medium_air,
    redeclare package MediumB = Medium_liquid,
    A=10) annotation (Placement(transformation(extent={{80,4},{100,24}})));
  ThermofluidStream.Boundaries.VolumeFlex flexVolume(
    redeclare package Medium = Medium_liquid,
    V_ref=0.02,
    p_start=100000,
    T_start=278.15) annotation (Placement(transformation(extent={{40,10},{20,30}})));
  ThermofluidStream.Processes.ThermalConvectionPipe thermalConvectionPipe(
    redeclare package Medium = Medium_liquid,
    r=0.005,
    l=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-80,50})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium_liquid,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e5))
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    displayInstanceName=false,
    redeclare package Medium = Medium_liquid,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{70,20},{50,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    displayInstanceName=false,
    redeclare package Medium = Medium_liquid,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,20},{-10,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    displayInstanceName=false,
    redeclare package Medium = Medium_liquid,
    digits=2,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-50,20},{-70,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    displayInstanceName=false,
    redeclare package Medium = Medium_liquid,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,90})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium_air,
    T0_par=283.15,
    p0_par=200000)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={18,-10})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    displayInstanceName=false,
    redeclare package Medium = Medium_air,
    temperatureUnit="degC")
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={62,-2})));
  ThermofluidStream.Boundaries.Sink sink(
    redeclare package Medium = Medium_air, p0_par=100000)
                   annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={176,8})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=500, T(start=373.15, fixed=true))
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-150,40},{-130,60}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true,
                                                      displayParameters=true)
    annotation (Placement(transformation(extent={{-200,180},{-180,200}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    displayInstanceName=false,
    redeclare package Medium = Medium_liquid, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={120,30})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm7(
    displayInstanceName=false,
    redeclare package Medium = Medium_air,
    temperatureUnit="degC")
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={120,-2})));
  ThermofluidStream.Utilities.showRealValue showRealValue1(
    use_numberPort=false,
    description="eff",
    number=heatExchanger.effectiveness) annotation (Placement(transformation(extent={{80,26},{100,46}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,5000; 2000,5000;
        2000.01,10000; 4000,10000; 4000.01,25000; 6000,25000; 6000.01,5000; 10000,
        5000])
    annotation (Placement(transformation(extent={{-180,40},{-160,60}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{162,162},{198,198}})));
  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium_air,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e5))
    annotation (Placement(transformation(extent={{140,-2},{160,18}})));
equation
  connect(multiSensor_Tpm1.inlet, heatExchanger.outletB)
    annotation (Line(
      points={{70,20},{80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, flexVolume.inlet) annotation (Line(
      points={{50,20},{40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flexVolume.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{20,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, thermalConvectionPipe.inlet) annotation (
      Line(
      points={{-70,20},{-80,20},{-80,40}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.outlet, multiSensor_Tpm4.inlet) annotation (
      Line(
      points={{-80,60},{-80,80},{-20,80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, multiSensor_Tpm4.outlet) annotation (Line(
      points={{80,80},{0,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, multiSensor_Tpm5.inlet) annotation (Line(
      points={{28,-10},{40,-10},{40,8},{52,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, heatExchanger.inletA)
    annotation (Line(
      points={{72,8},{80,8}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.heatPort, heatCapacitor.port)
    annotation (Line(points={{-90,50},{-110,50}}, color={191,0,0}));
  connect(heatCapacitor.port, prescribedHeatFlow.port)
    annotation (Line(points={{-110,50},{-130,50}}, color={191,0,0}));
  connect(heatExchanger.inletB, multiSensor_Tpm6.outlet)
    annotation (Line(
      points={{100,20},{110,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm6.inlet, flowResistance.outlet) annotation (Line(
      points={{130,20},{140,20},{140,80},{100,80}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchanger.outletA, multiSensor_Tpm7.inlet)
    annotation (Line(
      points={{100,8},{110,8}},
      color={28,108,200},
      thickness=0.5));
  connect(prescribedHeatFlow.Q_flow, combiTimeTable.y[1])
    annotation (Line(points={{-150,50},{-159,50}}, color={0,0,127}));

  connect(multiSensor_Tpm7.outlet, flowResistance1.inlet) annotation (Line(
      points={{130,8},{135,8},{135,8},{140,8}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance1.outlet) annotation (Line(
      points={{166,8},{160,8}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=10000,
      Tolerance=1e-6,
      Interval=10,
      __Dymola_Algorithm="Dassl"), Diagram(coordinateSystem(extent={{-200,-200},{200,200}})));
end PartialTest_SimplePump;
