within ThermofluidStream.Sensors.Tests;
model TestSensors "Test model for all sensors."
  extends Modelica.Icons.Example;

  replaceable package Medium1 = Media.myMedia.Water.ConstantPropertyLiquidWater
    constrainedby Media.myMedia.Interfaces.PartialMedium "Medium Model 1"
    annotation (Documentation(
        info="<html>
<p>Medium Model for the upper stream. It can be anything. </p>
</html>"));
  replaceable package Medium2 = Media.myMedia.Water.StandardWater
    constrainedby Media.myMedia.Interfaces.PartialTwoPhaseMedium "Medium Model 2"
    annotation (Documentation(info="<html>
<p>Medium Model for the lower stream. It must be a TwoPhaseMedium to test the vapor quantity sensors.</p>
</html>"));
  replaceable package Medium3 =  Media.myMedia.IdealGases.MixtureGases.FlueGasSixComponents
    constrainedby Media.myMedia.Interfaces.PartialMedium "Medium Model 3"
    annotation (Documentation(info="<html>
<p>Medium Model for the lower stream. It must be a TwoPhaseMedium to test the vapor quantity sensors.</p>
</html>"));

  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{80,140},{100,160}})));
  Boundaries.Source source(redeclare package Medium = Medium1, p0_par=200000)
    annotation (Placement(transformation(extent={{-136,80},{-116,100}})));
  Boundaries.Source source1(
    redeclare package Medium = Medium2,
    T0_par=394.15,
    p0_par=200000)
    annotation (Placement(transformation(extent={{-136,-24},{-116,-4}})));
  Boundaries.Sink sink(redeclare package Medium = Medium2)
    annotation (Placement(transformation(extent={{110,-24},{130,-4}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium1, p0_par=100000)
    annotation (Placement(transformation(extent={{120,40},{140,60}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium1,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.015,
    l=2,
    L_value=1000,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.galvanizedIron))
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium2,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.015,
    l=2,
    L_value=100000,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.galvanizedIron))
    annotation (Placement(transformation(extent={{-40,-24},{-20,-4}})));
  SingleSensorSelect singleSensorSelect(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K)
    annotation (Placement(transformation(extent={{-62,140},{-42,160}})));
  SingleSensorSelect singleSensorSelect1(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{-78,140},{-98,160}})));
  SingleSensorSelect singleSensorSelect2(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa)
    annotation (Placement(transformation(extent={{-62,128},{-42,148}})));
  SingleSensorSelect singleSensorSelect3(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar)
    annotation (Placement(transformation(extent={{-78,128},{-98,148}})));
  SingleSensorSelect singleSensorSelect4(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa)
    annotation (Placement(transformation(extent={{-62,116},{-42,136}})));
  SingleSensorSelect singleSensorSelect5(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar)
    annotation (Placement(transformation(extent={{-78,116},{-98,136}})));
  SingleSensorSelect singleSensorSelect6(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa)
    annotation (Placement(transformation(extent={{-62,104},{-42,124}})));
  SingleSensorSelect singleSensorSelect7(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar)
    annotation (Placement(transformation(extent={{-78,104},{-98,124}})));
  SingleSensorSelect singleSensorSelect8(
    redeclare package Medium = Medium1,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-62,92},{-42,112}})));
  SingleSensorSelect singleSensorSelect9(
    redeclare package Medium = Medium2,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
    annotation (Placement(transformation(extent={{-98,30},{-118,50}})));
  SingleSensorSelect singleSensorSelect10(redeclare package Medium = Medium2,
    outputValue=true,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    filter_output=true)
    annotation (Placement(transformation(extent={{-88,42},{-68,62}})));
  SingleSensorSelect singleSensorSelect11(
    redeclare package Medium = Medium2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg,
    outputValue=true,
    filter_output=true,
    init=ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor.state,
    value_0=1) annotation (Placement(transformation(extent={{-88,30},{-68,50}})));
  SingleSensorSelect singleSensorSelect12(redeclare package Medium = Medium2,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK)
    annotation (Placement(transformation(extent={{-88,18},{-68,38}})));
  SingleSensorSelect singleSensorSelect13(redeclare package Medium = Medium2,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK)
    annotation (Placement(transformation(extent={{-88,6},{-68,26}})));
  SingleSensorSelect singleSensorSelect14(
    redeclare package Medium = Medium2,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
    annotation (Placement(transformation(extent={{-98,42},{-118,62}})));
  MultiSensor_Tp multiSensor_Tp(
    redeclare package Medium = Medium2,
    digits=2,
    outputTemperature=true,
    outputPressure=true) annotation (Placement(transformation(extent={{-84,-32},{-64,-12}})));
  MultiSensor_Tp multiSensor_Tp1(
    redeclare package Medium = Medium2,
    digits=1,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-84,-46},{-64,-26}})));
  DifferenceSensorSelect differenceSensorSelect(
    redeclare package MediumA = Medium1,
    redeclare package MediumB = Medium1,
    digits=2,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,136})));
  DifferenceSensorSelect differenceSensorSelect1(
    redeclare package MediumA = Medium2,
    redeclare package MediumB = Medium1,
    digits=3,
    outputValue=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-44,46})));
  DifferenceTwoPhaseSensorSensorSelect differenceSensorVaporQuality(
    redeclare package MediumA = Medium2,
    redeclare package MediumB = Medium2,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg,
    outputValue=true)
    annotation (Placement(transformation(extent={{10,-60},{-10,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        353.15)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-14,-34})));
  Processes.ConductionElement conductionElement(
    redeclare package Medium = Medium2, V=1)
    annotation (Placement(transformation(extent={{0,-24},{20,-4}})));
  DifferenceSensor_Tp differenceSensor_Tp(
    redeclare package MediumA = Medium1,
    redeclare package MediumB = Medium2,
    digits=2,
    outputTemperature=true,
    outputPressure=true,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-4,46},{16,66}})));
  MultiSensor_Tpm multiSensor_Tpm(
    redeclare package Medium = Medium2,
    digits=2,
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true,
    temperatureUnit="degC",
    pressureUnit="Pa")
    annotation (Placement(transformation(extent={{72,-14},{92,6}})));
  SingleFlowSensor singleFlowSensor(
    redeclare package Medium = Medium1,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps) annotation (Placement(transformation(extent={{26,80},
            {46,100}})));
  SingleFlowSensor singleFlowSensor1(
    redeclare package Medium = Medium1,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps) annotation (Placement(transformation(extent={{54,80},
            {74,100}})));
  SingleFlowSensor singleFlowSensor2(redeclare package Medium = Medium1, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs,
    outputValue=true,
    filter_output=true)
    annotation (Placement(transformation(extent={{42,40},{62,60}})));
  SingleFlowSensor singleFlowSensor3(
    redeclare package Medium = Medium1,
    digits=5,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps,
    filter_output=true,
    init=ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor.state) annotation (Placement(transformation(extent={{66,40},
            {86,60}})));
  SingleFlowSensor singleFlowSensor4(
    redeclare package Medium = Medium1,
    digits=5,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin)
    annotation (Placement(transformation(extent={{90,40},{110,60}})));
  SingleFlowSensor singleFlowSensor5(
    redeclare package Medium = Medium1,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_JpKs)
                                                                                     annotation (Placement(transformation(extent={{40,60},
            {60,80}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-84,-58},{-64,-38}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect1(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa)
    annotation (Placement(transformation(extent={{-84,-70},{-64,-50}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect2(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar)
    annotation (Placement(transformation(extent={{-84,-82},{-64,-62}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect3(
    redeclare package Medium = Medium2,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K)
    annotation (Placement(transformation(extent={{-84,-94},{-64,-74}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect4(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C)
    annotation (Placement(transformation(extent={{-102,-58},{-122,-38}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect5(
    redeclare package Medium = Medium2,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K)
    annotation (Placement(transformation(extent={{-102,-70},{-122,-50}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect6(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa)
    annotation (Placement(transformation(extent={{-102,-82},{-122,-62}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect7(
    redeclare package Medium = Medium2,
    digits=3,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar,
    filter_output=true) annotation (Placement(transformation(extent={{-102,-94},{-122,-74}})));
  DifferenceTwoPhaseSensorSensorSelect
                               differenceSensorVaporQuality1(
    redeclare package MediumA = Medium2,
    redeclare package MediumB = Medium2,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg,
    outputValue=true,
    filter_output=true)
    annotation (Placement(transformation(extent={{10,-76},{-10,-56}})));
  MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = Medium2,
    digits=2,
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true,
    temperatureUnit="degC",
    pressureUnit="Pa",
    filter_output=true)
    annotation (Placement(transformation(extent={{42,-14},{62,6}})));
  DifferenceSensorSelect differenceSensorSelect2(
    redeclare package MediumA = Medium2,
    redeclare package MediumB = Medium1,
    digits=3,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C,
    filter_output=true)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-44,34})));
  DifferenceSensor_Tp differenceSensor_Tp1(
    redeclare package MediumA = Medium1,
    redeclare package MediumB = Medium2,
    digits=2,
    outputTemperature=true,
    outputPressure=true,
    temperatureUnit="degC",
    pressureUnit="bar",
    filter_output=true,
    init=ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor.state) annotation (Placement(transformation(extent={{-4,24},
            {16,44}})));
  DifferenceSensorSelect differenceSensorSelect3(
    redeclare package MediumA = Medium1,
    redeclare package MediumB = Medium1,
    digits=2,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar,
    filter_output=true)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,116})));
  Boundaries.Source source2(
    redeclare package Medium = Medium3,
    T0_par=394.15,
    p0_par=200000,
    Xi0_par={0.1,0.15,0.25,0.01,0.21,0.28})
    annotation (Placement(transformation(extent={{-110,-130},{-90,-110}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium3,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.015,
    l=2,
    L_value=100000,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.galvanizedIron))
    annotation (Placement(transformation(extent={{40,-130},{60,-110}})));
  Boundaries.Sink sink2(redeclare package Medium = Medium3)
    annotation (Placement(transformation(extent={{70,-130},{90,-110}})));
  SensorState sensorState(redeclare package Medium = Medium3) annotation (Placement(transformation(extent={{-66,-120},{-46,
            -100}})));
  SingleSensorX singleSensorX(redeclare package Medium = Medium3) annotation (Placement(transformation(extent={{-6,-98},
            {14,-78}})));
  SingleSensorX singleSensorX1(redeclare package Medium = Medium3, row=2) annotation (Placement(transformation(extent={{-6,-110},
            {14,-90}})));
  SingleSensorX singleSensorX2(
    redeclare package Medium = Medium3,
    outputValue=true,
    filter_output=true,
    row=3) annotation (Placement(transformation(extent={{-6,-122},{14,-102}})));
  SingleSensorSelect singleSensorSelect15(
    redeclare package Medium = Medium1,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_kJpkg)
    annotation (Placement(transformation(extent={{-78,92},{-98,112}})));
  SingleSensorSelect singleSensorSelect16(
    redeclare package Medium = Medium2,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_kJpkgK)
    annotation (Placement(transformation(extent={{-98,18},{-118,38}})));
  SingleSensorSelect singleSensorSelect17(redeclare package Medium = Medium1, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol)
    annotation (Placement(transformation(extent={{-62,152},{-42,172}})));
  SingleSensorSelect singleSensorSelect18(
    redeclare package Medium = Medium1,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpkmol)
    annotation (Placement(transformation(extent={{-78,152},{-98,172}})));
  SingleFlowSensor singleFlowSensor6(
    redeclare package Medium = Medium1,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_kW)  annotation (Placement(transformation(extent={{80,80},
            {100,100}})));
  SingleFlowSensor singleFlowSensor7(
    redeclare package Medium = Medium1,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_kWpK)
                                                                                     annotation (Placement(transformation(extent={{66,60},
            {86,80}})));
  SingleFlowSensor singleFlowSensor8(
    redeclare package Medium = Medium1,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_MW)  annotation (Placement(transformation(extent={{108,80},
            {128,100}})));
  SingleFlowSensor singleFlowSensor9(
    redeclare package Medium = Medium1,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_MWpK)
                                                                                     annotation (Placement(transformation(extent={{94,60},
            {114,80}})));
  SingleSensorSelect singleSensorSelect19(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1)
    annotation (Placement(transformation(extent={{-98,6},{-118,26}})));
equation
  connect(flowResistance.inlet, source.outlet) annotation (Line(
      points={{-10,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance1.inlet) annotation (Line(
      points={{-116,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect9.inlet, source1.outlet) annotation (Line(
      points={{-98,40},{-92,40},{-92,-14},{-116,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect13.inlet, source1.outlet) annotation (Line(
      points={{-88,16},{-92,16},{-92,-14},{-116,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect12.inlet, source1.outlet) annotation (Line(
      points={{-88,28},{-92,28},{-92,-14},{-116,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect11.inlet, source1.outlet) annotation (Line(
      points={{-88,40},{-92,40},{-92,-14},{-116,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect10.inlet, source1.outlet) annotation (Line(
      points={{-88,52},{-92,52},{-92,-14},{-116,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect8.inlet, source.outlet) annotation (Line(
      points={{-62,102},{-70,102},{-70,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect7.inlet, source.outlet) annotation (Line(
      points={{-78,114},{-70,114},{-70,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect6.inlet, source.outlet) annotation (Line(
      points={{-62,114},{-70,114},{-70,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect5.inlet, source.outlet) annotation (Line(
      points={{-78,126},{-70,126},{-70,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect4.inlet, source.outlet) annotation (Line(
      points={{-62,126},{-70,126},{-70,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, source.outlet) annotation (Line(
      points={{-78,138},{-70,138},{-70,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, source.outlet) annotation (Line(
      points={{-62,138},{-70,138},{-70,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, source.outlet) annotation (Line(
      points={{-78,150},{-70,150},{-70,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, source.outlet) annotation (Line(
      points={{-62,150},{-70,150},{-70,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp.inlet, flowResistance1.inlet) annotation (Line(
      points={{-84,-22},{-92,-22},{-92,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp1.inlet, flowResistance1.inlet) annotation (Line(
      points={{-84,-36},{-92,-36},{-92,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect.inletB, source.outlet) annotation (Line(
      points={{-10,136},{-20,136},{-20,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect1.inletA, flowResistance1.inlet) annotation (
      Line(
      points={{-54,46},{-58,46},{-58,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect1.inletB, source.outlet) annotation (Line(
      points={{-34,46},{-26,46},{-26,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorVaporQuality.inletB, flowResistance1.inlet)
    annotation (Line(
      points={{-10,-50},{-48,-50},{-48,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, conductionElement.inlet)
    annotation (Line(
      points={{-20,-14},{0,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.heatPort, fixedTemperature.port) annotation (Line(points={{10,-24},{10,-34},{-8,-34}}, color={191,0,0}));
  connect(differenceSensor_Tp.inletA, source.outlet) annotation (Line(
      points={{-4,60},{-20,60},{-20,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp.inletB, conductionElement.inlet)
    annotation (Line(
      points={{-4,52},{-14,52},{-14,-14},{0,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect.inletA, flowResistance.outlet) annotation (
      Line(
      points={{10,136},{16,136},{16,90},{10,90}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, sink.inlet) annotation (Line(
      points={{92,-14},{110,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorVaporQuality.inletA, conductionElement.outlet)
    annotation (Line(
      points={{10,-50},{26,-50},{26,-14},{20,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor.outlet, singleFlowSensor1.inlet) annotation (Line(
      points={{46,90},{54,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor2.outlet, singleFlowSensor3.inlet) annotation (Line(
      points={{62,50},{66,50}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor.inlet, flowResistance.outlet) annotation (Line(
      points={{26,90},{10,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor3.outlet, singleFlowSensor4.inlet) annotation (Line(
      points={{86,50},{90,50}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, singleFlowSensor4.outlet) annotation (Line(
      points={{120,50},{110,50}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect.inlet, flowResistance1.inlet) annotation (Line(
      points={{-84,-48},{-92,-48},{-92,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect3.inlet, flowResistance1.inlet) annotation (Line(
      points={{-84,-84},{-92,-84},{-92,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect2.inlet, flowResistance1.inlet) annotation (Line(
      points={{-84,-72},{-92,-72},{-92,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect1.inlet, flowResistance1.inlet) annotation (Line(
      points={{-84,-60},{-92,-60},{-92,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect4.inlet, flowResistance1.inlet) annotation (Line(
      points={{-102,-48},{-92,-48},{-92,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect5.inlet, flowResistance1.inlet) annotation (Line(
      points={{-102,-60},{-92,-60},{-92,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect7.inlet, flowResistance1.inlet) annotation (Line(
      points={{-102,-84},{-92,-84},{-92,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect6.inlet, flowResistance1.inlet) annotation (Line(
      points={{-102,-72},{-92,-72},{-92,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorVaporQuality1.inletA, conductionElement.outlet)
    annotation (Line(
      points={{10,-66},{26,-66},{26,-14},{20,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorVaporQuality1.inletB, flowResistance1.inlet)
    annotation (Line(
      points={{-10,-66},{-48,-66},{-48,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.inlet, multiSensor_Tpm1.outlet)
    annotation (Line(
      points={{72,-14},{62,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.inlet, conductionElement.outlet)
    annotation (Line(
      points={{42,-14},{20,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect2.inletB, source.outlet)
    annotation (Line(
      points={{-34,34},{-26,34},{-26,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect2.inletA, flowResistance1.inlet)
    annotation (Line(
      points={{-54,34},{-58,34},{-58,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp1.inletA, source.outlet)
    annotation (Line(
      points={{-4,38},{-20,38},{-20,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp1.inletB, conductionElement.inlet)
    annotation (Line(
      points={{-4,30},{-14,30},{-14,-14},{0,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect3.inletA, flowResistance.outlet)
    annotation (Line(
      points={{10,116},{16,116},{16,90},{10,90}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect3.inletB, source.outlet)
    annotation (Line(
      points={{-10,116},{-20,116},{-20,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, sink2.inlet) annotation (Line(
      points={{60,-120},{70,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, flowResistance2.inlet) annotation (Line(
      points={{-90,-120},{40,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorState.inlet, flowResistance2.inlet)
    annotation (Line(
      points={{-66,-110},{-72,-110},{-72,-120},{40,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorX.inlet, flowResistance2.inlet)
    annotation (Line(
      points={{-6,-88},{-16,-88},{-16,-120},{40,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorX1.inlet, flowResistance2.inlet)
    annotation (Line(
      points={{-6,-100},{-16,-100},{-16,-120},{40,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorX2.inlet, flowResistance2.inlet)
    annotation (Line(
      points={{-6,-112},{-16,-112},{-16,-120},{40,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect14.inlet, source1.outlet) annotation (Line(
      points={{-98,52},{-92,52},{-92,-14},{-116,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect15.inlet, source.outlet)
    annotation (Line(
      points={{-78,102},{-70,102},{-70,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect16.inlet, source1.outlet)
    annotation (Line(
      points={{-98,28},{-92,28},{-92,-14},{-116,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect17.inlet, source.outlet)
    annotation (Line(
      points={{-62,162},{-70,162},{-70,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect18.inlet, source.outlet)
    annotation (Line(
      points={{-78,162},{-70,162},{-70,90},{-116,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor1.outlet, singleFlowSensor6.inlet)
    annotation (Line(
      points={{74,90},{80,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor8.inlet, singleFlowSensor6.outlet)
    annotation (Line(
      points={{108,90},{100,90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor5.outlet, singleFlowSensor7.inlet)
    annotation (Line(
      points={{60,70},{66,70}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor7.outlet, singleFlowSensor9.inlet)
    annotation (Line(
      points={{86,70},{94,70}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor8.outlet, singleFlowSensor5.inlet) annotation (Line(
      points={{128,90},{134,90},{134,86},{34,86},{34,70},{40,70}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor9.outlet, singleFlowSensor2.inlet) annotation (Line(
      points={{114,70},{120,70},{120,66},{34,66},{34,50},{42,50}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect19.inlet, source1.outlet)
    annotation (Line(
      points={{-98,16},{-92,16},{-92,-14},{-116,-14}},
      color={28,108,200},
      thickness=0.5));
  annotation (experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
  Documentation(info="<html>
<p>This model should test all sensors with all selecable quantities.</p>

<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"),
    Diagram(coordinateSystem(extent={{-140,-140},{140,180}})),
    Icon(coordinateSystem(grid={2,2})));
end TestSensors;
