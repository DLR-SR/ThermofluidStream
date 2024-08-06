within ThermofluidStream.Processes.Pumps.Tests.BaseClasses;
model PartialTest_CentrifugalPump "Basic cooling cycle with a load"
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
    A=10) annotation (Placement(transformation(extent={{80,74},{100,94}})));
  ThermofluidStream.Boundaries.VolumeFlex flexVolume(
    redeclare package Medium = Medium_liquid,
    V_ref=0.02,
    p_start=100000,
    T_start=278.15) annotation (Placement(transformation(extent={{40,80},{20,100}})));
  ThermofluidStream.Processes.ThermalConvectionPipe thermalConvectionPipe(
    redeclare package Medium = Medium_liquid,
    r=0.005,
    l=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-80,120})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium_liquid,
    r=0.02,
    l=100,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{80,140},{100,160}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    displayInstanceName=false,
    redeclare package Medium = Medium_liquid,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{70,90},{50,110}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    displayInstanceName=false,
    redeclare package Medium = Medium_liquid,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,90},{-10,110}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    displayInstanceName=false,
    redeclare package Medium = Medium_liquid,
    digits=3,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-48,90},{-68,110}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    displayInstanceName=false,
    redeclare package Medium = Medium_liquid,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,160})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium_air,
    T0_par=283.15,
    p0_par=200000)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={18,60})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    displayInstanceName=false,
    redeclare package Medium = Medium_air,
    temperatureUnit="degC")
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={62,68})));
  ThermofluidStream.Boundaries.Sink sink(
    redeclare package Medium = Medium_air, p0_par=100000)
                   annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={176,78})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=500, T(start=373.15, fixed=true))
    annotation (Placement(transformation(extent={{-120,120},{-100,140}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-150,110},{-130,130}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true,
                                                      displayParameters=true)
    annotation (Placement(transformation(extent={{-200,180},{-180,200}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    displayInstanceName=false,
    redeclare package Medium = Medium_liquid, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={120,100})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm7(
    displayInstanceName=false,
    redeclare package Medium = Medium_air,
    temperatureUnit="degC")
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={120,68})));
  ThermofluidStream.Utilities.showRealValue showRealValue1(
    use_numberPort=false,
    description="eff",
    number=heatExchanger.effectiveness) annotation (Placement(transformation(extent={{80,100},{100,120}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,5000; 2000,5000;
        2000.01,10000; 4000,10000; 4000.01,25000; 6000,25000; 6000.01,5000; 10000,
        5000])
    annotation (Placement(transformation(extent={{-180,110},{-160,130}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{162,162},{198,198}})));
  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium_air,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e5))
    annotation (Placement(transformation(extent={{140,68},{160,88}})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU heatExchanger1(
    redeclare package MediumA = Medium_air,
    redeclare package MediumB = Medium_liquid,
    A=10) annotation (Placement(transformation(extent={{80,-116},{100,-96}})));
  ThermofluidStream.Boundaries.VolumeFlex flexVolume3(
    redeclare package Medium = Medium_liquid,
    V_ref=0.02,
    p_start=100000,
    T_start=278.15) annotation (Placement(transformation(extent={{40,-110},{20,-90}})));
  ThermofluidStream.Processes.ThermalConvectionPipe thermalConvectionPipe1(
    redeclare package Medium = Medium_liquid,
    r=0.005,
    l=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-80,-70})));
  ThermofluidStream.Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium_liquid,
    r=0.02,
    l=100,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm11(
    displayInstanceName=false,                                redeclare package Medium = Medium_liquid, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{70,-100},{50,-80}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm12(
    displayInstanceName=false,
    redeclare package Medium = Medium_liquid,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,-100},{-10,-80}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm13(
    displayInstanceName=false,
    redeclare package Medium = Medium_liquid,
    digits=3,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-46,-100},{-66,-80}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm14(
    displayInstanceName=false,                                redeclare package Medium = Medium_liquid, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,-30})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium_air,
    T0_par=283.15,
    p0_par=200000)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={18,-130})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm15(
    displayInstanceName=false,                                redeclare package Medium = Medium_air, temperatureUnit="degC")
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={62,-122})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = Medium_air, p0_par=100000)
                   annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={176,-112})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C=500, T(start=373.15, fixed=true))
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{-150,-80},{-130,-60}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm16(
    displayInstanceName=false,                                redeclare package Medium = Medium_liquid, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={120,-90})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm17(
    displayInstanceName=false,                                redeclare package Medium = Medium_air, temperatureUnit="degC")
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={120,-122})));
  ThermofluidStream.Utilities.showRealValue showRealValue4(
    use_numberPort=false,
    description="eff",
    number=heatExchanger.effectiveness) annotation (Placement(transformation(extent={{80,-92},{100,-72}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(table=[0,5000; 2000,5000; 2000.01,10000; 4000,10000; 4000.01,25000; 6000,25000; 6000.01,5000; 10000,5000])
    annotation (Placement(transformation(extent={{-180,-80},{-160,-60}})));
  ThermofluidStream.Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium_air,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e5))
    annotation (Placement(transformation(extent={{140,-122},{160,-102}})));
equation
  connect(multiSensor_Tpm1.inlet, heatExchanger.outletB)
    annotation (Line(
      points={{70,90},{80,90}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, flexVolume.inlet) annotation (Line(
      points={{50,90},{40,90}},
      color={28,108,200},
      thickness=0.5));
  connect(flexVolume.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{20,90},{10,90}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, thermalConvectionPipe.inlet) annotation (
      Line(
      points={{-68,90},{-80,90},{-80,110}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.outlet, multiSensor_Tpm4.inlet) annotation (
      Line(
      points={{-80,130},{-80,150},{-20,150}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, multiSensor_Tpm4.outlet) annotation (Line(
      points={{80,150},{0,150}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, multiSensor_Tpm5.inlet) annotation (Line(
      points={{28,60},{40,60},{40,78},{52,78}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, heatExchanger.inletA)
    annotation (Line(
      points={{72,78},{80,78}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.heatPort, heatCapacitor.port)
    annotation (Line(points={{-90,120},{-110,120}},
                                                  color={191,0,0}));
  connect(heatCapacitor.port, prescribedHeatFlow.port)
    annotation (Line(points={{-110,120},{-130,120}},
                                                   color={191,0,0}));
  connect(heatExchanger.inletB, multiSensor_Tpm6.outlet)
    annotation (Line(
      points={{100,90},{110,90}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm6.inlet, flowResistance.outlet) annotation (Line(
      points={{130,90},{140,90},{140,150},{100,150}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchanger.outletA, multiSensor_Tpm7.inlet)
    annotation (Line(
      points={{100,78},{110,78}},
      color={28,108,200},
      thickness=0.5));
  connect(prescribedHeatFlow.Q_flow, combiTimeTable.y[1])
    annotation (Line(points={{-150,120},{-159,120}},
                                                   color={0,0,127}));

  connect(multiSensor_Tpm7.outlet, flowResistance1.inlet) annotation (Line(
      points={{130,78},{140,78}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance1.outlet) annotation (Line(
      points={{166,78},{160,78}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm11.inlet, heatExchanger1.outletB)
    annotation (Line(
      points={{70,-100},{80,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm11.outlet, flexVolume3.inlet) annotation (Line(
      points={{50,-100},{40,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(flexVolume3.outlet,multiSensor_Tpm12. inlet) annotation (Line(
      points={{20,-100},{10,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm13.outlet,thermalConvectionPipe1. inlet) annotation (Line(
      points={{-66,-100},{-80,-100},{-80,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe1.outlet,multiSensor_Tpm14. inlet) annotation (Line(
      points={{-80,-60},{-80,-40},{-20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.inlet,multiSensor_Tpm14. outlet) annotation (Line(
      points={{80,-40},{0,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet,multiSensor_Tpm15. inlet) annotation (Line(
      points={{28,-130},{40,-130},{40,-112},{52,-112}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm15.outlet, heatExchanger1.inletA)
    annotation (Line(
      points={{72,-112},{80,-112}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe1.heatPort,heatCapacitor1. port) annotation (Line(points={{-90,-70},{-110,-70}},
                                                                                                             color={191,0,0}));
  connect(heatCapacitor1.port,prescribedHeatFlow1. port) annotation (Line(points={{-110,-70},{-130,-70}},
                                                                                                      color={191,0,0}));
  connect(heatExchanger1.inletB, multiSensor_Tpm16.outlet)
    annotation (Line(
      points={{100,-100},{110,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm16.inlet,flowResistance2. outlet) annotation (Line(
      points={{130,-100},{140,-100},{140,-40},{100,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchanger1.outletA, multiSensor_Tpm17.inlet)
    annotation (Line(
      points={{100,-112},{110,-112}},
      color={28,108,200},
      thickness=0.5));
  connect(prescribedHeatFlow1.Q_flow,combiTimeTable1. y[1]) annotation (Line(points={{-150,-70},{-159,-70}},
                                                                                                         color={0,0,127}));
  connect(multiSensor_Tpm17.outlet,flowResistance3. inlet) annotation (Line(
      points={{130,-112},{140,-112}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet,flowResistance3. outlet) annotation (Line(
      points={{166,-112},{160,-112}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=10000,
      Tolerance=1e-6,
      Interval=10,
      __Dymola_Algorithm="Dassl"), Diagram(coordinateSystem(extent={{-200,-200},{200,200}}),
                                           graphics={
        Text(
          extent={{-60,140},{80,120}},
          textColor={28,108,200},
          textString="Pump based on measurements"),
        Text(
          extent={{-48,-52},{70,-72}},
          textColor={28,108,200},
          textString="Pump based on coefficients")}));
end PartialTest_CentrifugalPump;
