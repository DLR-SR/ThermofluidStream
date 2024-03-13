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
    annotation (Placement(transformation(extent={{80,-66},{100,-46}})));
  Boundaries.Source source(redeclare package Medium = Medium1, p0_par=200000)
    annotation (Placement(transformation(extent={{-100,64},{-80,84}})));
  Boundaries.Source source1(
    redeclare package Medium = Medium2,
    T0_par=394.15,
    p0_par=200000)
    annotation (Placement(transformation(extent={{-100,-24},{-80,-4}})));
  Boundaries.Sink sink(redeclare package Medium = Medium2)
    annotation (Placement(transformation(extent={{80,-24},{100,-4}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium1, p0_par=100000)
    annotation (Placement(transformation(extent={{96,44},{116,64}})));
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
    annotation (Placement(transformation(extent={{-10,64},{10,84}})));
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
    annotation (Placement(transformation(extent={{-74,132},{-54,152}})));
  SingleSensorSelect singleSensorSelect1(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{-74,120},{-54,140}})));
  SingleSensorSelect singleSensorSelect2(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa)
    annotation (Placement(transformation(extent={{-74,108},{-54,128}})));
  SingleSensorSelect singleSensorSelect3(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar)
    annotation (Placement(transformation(extent={{-74,96},{-54,116}})));
  SingleSensorSelect singleSensorSelect4(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa)
    annotation (Placement(transformation(extent={{-74,84},{-54,104}})));
  SingleSensorSelect singleSensorSelect5(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar)
    annotation (Placement(transformation(extent={{-74,72},{-54,92}})));
  SingleSensorSelect singleSensorSelect6(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa)
    annotation (Placement(transformation(extent={{-74,60},{-54,80}})));
  SingleSensorSelect singleSensorSelect7(redeclare package Medium = Medium1,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar)
    annotation (Placement(transformation(extent={{-74,48},{-54,68}})));
  SingleSensorSelect singleSensorSelect8(
    redeclare package Medium = Medium1,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-74,36},{-54,56}})));
  SingleSensorSelect singleSensorSelect9(
    redeclare package Medium = Medium2,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
    annotation (Placement(transformation(extent={{-84,16},{-104,36}})));
  SingleSensorSelect singleSensorSelect10(redeclare package Medium = Medium2,
    outputValue=true,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    filter_output=true)
    annotation (Placement(transformation(extent={{-74,20},{-54,40}})));
  SingleSensorSelect singleSensorSelect11(
    redeclare package Medium = Medium2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg,
    outputValue=true,
    filter_output=true,
    init=ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor.state,
    value_0=1) annotation (Placement(transformation(extent={{-74,8},{-54,28}})));
  SingleSensorSelect singleSensorSelect12(redeclare package Medium = Medium2,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK)
    annotation (Placement(transformation(extent={{-74,-4},{-54,16}})));
  SingleSensorSelect singleSensorSelect13(redeclare package Medium = Medium2,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK)
    annotation (Placement(transformation(extent={{-74,-16},{-54,4}})));
  SingleSensorSelect singleSensorSelect14(
    redeclare package Medium = Medium2,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
    annotation (Placement(transformation(extent={{-84,28},{-104,48}})));
  MultiSensor_Tp multiSensor_Tp(
    redeclare package Medium = Medium2,
    digits=2,
    outputTemperature=true,
    outputPressure=true) annotation (Placement(transformation(extent={{-74,-32},{-54,-12}})));
  MultiSensor_Tp multiSensor_Tp1(
    redeclare package Medium = Medium2,
    digits=1,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-74,-46},{-54,-26}})));
  DifferenceSensorSelect differenceSensorSelect(
    redeclare package MediumA = Medium1,
    redeclare package MediumB = Medium1,
    digits=2,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,106})));
  DifferenceSensorSelect differenceSensorSelect1(
    redeclare package MediumA = Medium2,
    redeclare package MediumB = Medium1,
    digits=3,
    outputValue=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-38,46})));
  DifferenceTwoPhaseSensorSensorSelect differenceSensorVaporQuality(
    redeclare package MediumA = Medium2,
    redeclare package MediumB = Medium2,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg,
    outputValue=true)
    annotation (Placement(transformation(extent={{-2,-40},{-22,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        353.15)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=90,
        origin={0,-76})));
  Processes.ConductionElement conductionElement(
    redeclare package Medium = Medium2, V=1)
    annotation (Placement(transformation(extent={{-10,-24},{10,-4}})));
  DifferenceSensor_Tp differenceSensor_Tp(
    redeclare package MediumA = Medium1,
    redeclare package MediumB = Medium2,
    digits=2,
    outputTemperature=true,
    outputPressure=true,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-4,30},{16,50}})));
  MultiSensor_Tpm multiSensor_Tpm(
    redeclare package Medium = Medium2,
    digits=2,
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true,
    temperatureUnit="degC",
    pressureUnit="Pa")
    annotation (Placement(transformation(extent={{54,-14},{74,6}})));
  SingleFlowSensor singleFlowSensor(
    redeclare package Medium = Medium1,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps) annotation (Placement(transformation(extent={{20,64},{40,84}})));
  SingleFlowSensor singleFlowSensor1(
    redeclare package Medium = Medium1,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps) annotation (Placement(transformation(extent={{44,64},{64,84}})));
  SingleFlowSensor singleFlowSensor2(redeclare package Medium = Medium1, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs,
    outputValue=true,
    filter_output=true)
    annotation (Placement(transformation(extent={{20,44},{40,64}})));
  SingleFlowSensor singleFlowSensor3(
    redeclare package Medium = Medium1,
    digits=5,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps,
    filter_output=true,
    init=ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor.state) annotation (Placement(transformation(extent={{44,44},{64,64}})));
  SingleFlowSensor singleFlowSensor4(
    redeclare package Medium = Medium1,
    digits=5,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin)
    annotation (Placement(transformation(extent={{68,44},{88,64}})));
  SingleFlowSensor singleFlowSensor5(
    redeclare package Medium = Medium1,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps) annotation (Placement(transformation(extent={{68,64},{88,84}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-74,-58},{-54,-38}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect1(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa)
    annotation (Placement(transformation(extent={{-74,-70},{-54,-50}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect2(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar)
    annotation (Placement(transformation(extent={{-74,-82},{-54,-62}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect3(
    redeclare package Medium = Medium2,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K)
    annotation (Placement(transformation(extent={{-74,-94},{-54,-74}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect4(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C)
    annotation (Placement(transformation(extent={{-50,-56},{-30,-36}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect5(
    redeclare package Medium = Medium2,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K)
    annotation (Placement(transformation(extent={{-50,-68},{-30,-48}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect6(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa)
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  TwoPhaseSensorSelect twoPhaseSensorSelect7(
    redeclare package Medium = Medium2,
    digits=3,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar,
    filter_output=true) annotation (Placement(transformation(extent={{-50,-92},{-30,-72}})));
  DifferenceTwoPhaseSensorSensorSelect
                               differenceSensorVaporQuality1(
    redeclare package MediumA = Medium2,
    redeclare package MediumB = Medium2,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg,
    outputValue=true,
    filter_output=true)
    annotation (Placement(transformation(extent={{-2,-54},{-22,-34}})));
  MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = Medium2,
    digits=2,
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true,
    temperatureUnit="degC",
    pressureUnit="Pa",
    filter_output=true)
    annotation (Placement(transformation(extent={{24,-14},{44,6}})));
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
        origin={-38,34})));
  DifferenceSensor_Tp differenceSensor_Tp1(
    redeclare package MediumA = Medium1,
    redeclare package MediumB = Medium2,
    digits=2,
    outputTemperature=true,
    outputPressure=true,
    temperatureUnit="degC",
    pressureUnit="bar",
    filter_output=true,
    init=ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor.state) annotation (Placement(transformation(extent={{-4,8},{16,28}})));
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
        origin={0,92})));
  Boundaries.Source source2(
    redeclare package Medium = Medium3,
    T0_par=394.15,
    p0_par=200000,
    Xi0_par={0.1,0.15,0.25,0.01,0.21,0.28})
    annotation (Placement(transformation(extent={{-100,-110},{-80,-90}})));
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
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Boundaries.Sink sink2(redeclare package Medium = Medium3)
    annotation (Placement(transformation(extent={{80,-110},{100,-90}})));
  SensorState sensorState(redeclare package Medium = Medium3) annotation (Placement(transformation(extent={{-56,-120},{-36,-100}})));
  SingleSensorX singleSensorX(redeclare package Medium = Medium3) annotation (Placement(transformation(extent={{4,-118},{24,-98}})));
  SingleSensorX singleSensorX1(redeclare package Medium = Medium3, row=2) annotation (Placement(transformation(extent={{4,-130},{24,-110}})));
  SingleSensorX singleSensorX2(
    redeclare package Medium = Medium3,
    outputValue=true,
    filter_output=true,
    row=3) annotation (Placement(transformation(extent={{4,-142},{24,-122}})));
equation
  connect(flowResistance.inlet, source.outlet) annotation (Line(
      points={{-10,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance1.inlet) annotation (Line(
      points={{-80,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect9.inlet, source1.outlet) annotation (Line(
      points={{-84,26},{-78,26},{-78,-14},{-80,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect13.inlet, source1.outlet) annotation (Line(
      points={{-74,-6},{-78,-6},{-78,-14},{-80,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect12.inlet, source1.outlet) annotation (Line(
      points={{-74,6},{-78,6},{-78,-14},{-80,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect11.inlet, source1.outlet) annotation (Line(
      points={{-74,18},{-78,18},{-78,-14},{-80,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect10.inlet, source1.outlet) annotation (Line(
      points={{-74,30},{-78,30},{-78,-14},{-80,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect8.inlet, source.outlet) annotation (Line(
      points={{-74,46},{-78,46},{-78,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect7.inlet, source.outlet) annotation (Line(
      points={{-74,58},{-78,58},{-78,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect6.inlet, source.outlet) annotation (Line(
      points={{-74,70},{-78,70},{-78,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect5.inlet, source.outlet) annotation (Line(
      points={{-74,82},{-78,82},{-78,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect4.inlet, source.outlet) annotation (Line(
      points={{-74,94},{-78,94},{-78,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, source.outlet) annotation (Line(
      points={{-74,106},{-78,106},{-78,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, source.outlet) annotation (Line(
      points={{-74,118},{-78,118},{-78,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, source.outlet) annotation (Line(
      points={{-74,130},{-78,130},{-78,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, source.outlet) annotation (Line(
      points={{-74,142},{-78,142},{-78,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp.inlet, flowResistance1.inlet) annotation (Line(
      points={{-74,-22},{-78,-22},{-78,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp1.inlet, flowResistance1.inlet) annotation (Line(
      points={{-74,-36},{-78,-36},{-78,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect.inletB, source.outlet) annotation (Line(
      points={{-10,106},{-18,106},{-18,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect1.inletA, flowResistance1.inlet) annotation (
      Line(
      points={{-48,46},{-52,46},{-52,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect1.inletB, source.outlet) annotation (Line(
      points={{-28,46},{-24,46},{-24,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorVaporQuality.inletB, flowResistance1.inlet)
    annotation (Line(
      points={{-22,-30},{-48,-30},{-48,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, conductionElement.inlet)
    annotation (Line(
      points={{-20,-14},{-10,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.heatPort, fixedTemperature.port) annotation (Line(points={{0,-24},{0,-47},{3.88578e-16,-47},{3.88578e-16,-70}},
                                                                                                                   color={191,0,0}));
  connect(differenceSensor_Tp.inletA, source.outlet) annotation (Line(
      points={{-4,46},{-18,46},{-18,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp.inletB, conductionElement.inlet)
    annotation (Line(
      points={{-4,34},{-14,34},{-14,-14},{-10,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect.inletA, flowResistance.outlet) annotation (
      Line(
      points={{10,106},{16,106},{16,74},{10,74}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, sink.inlet) annotation (Line(
      points={{74,-14},{80,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorVaporQuality.inletA, conductionElement.outlet)
    annotation (Line(
      points={{-2,-30},{16,-30},{16,-14},{10,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor.outlet, singleFlowSensor1.inlet) annotation (Line(
      points={{40,74},{44,74}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor2.outlet, singleFlowSensor3.inlet) annotation (Line(
      points={{40,54},{44,54}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor.inlet, flowResistance.outlet) annotation (Line(
      points={{20,74},{10,74}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor3.outlet, singleFlowSensor4.inlet) annotation (Line(
      points={{64,54},{68,54}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, singleFlowSensor4.outlet) annotation (Line(
      points={{96,54},{88,54}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor1.outlet, singleFlowSensor5.inlet) annotation (Line(
      points={{64,74},{68,74}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor5.outlet, singleFlowSensor2.inlet) annotation (Line(
      points={{88,74},{94,74},{94,70},{14,70},{14,54},{20,54}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect.inlet, flowResistance1.inlet) annotation (Line(
      points={{-74,-48},{-78,-48},{-78,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect3.inlet, flowResistance1.inlet) annotation (Line(
      points={{-74,-84},{-78,-84},{-78,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect2.inlet, flowResistance1.inlet) annotation (Line(
      points={{-74,-72},{-78,-72},{-78,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect1.inlet, flowResistance1.inlet) annotation (Line(
      points={{-74,-60},{-78,-60},{-78,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect4.inlet, flowResistance1.inlet) annotation (Line(
      points={{-50,-46},{-54,-46},{-54,-44},{-78,-44},{-78,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect5.inlet, flowResistance1.inlet) annotation (Line(
      points={{-50,-58},{-54,-58},{-54,-44},{-78,-44},{-78,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect7.inlet, flowResistance1.inlet) annotation (Line(
      points={{-50,-82},{-54,-82},{-54,-44},{-78,-44},{-78,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect6.inlet, flowResistance1.inlet) annotation (Line(
      points={{-50,-70},{-54,-70},{-54,-44},{-78,-44},{-78,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorVaporQuality1.inletA, conductionElement.outlet)
    annotation (Line(
      points={{-2,-44},{16,-44},{16,-14},{10,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorVaporQuality1.inletB, flowResistance1.inlet)
    annotation (Line(
      points={{-22,-44},{-32,-44},{-32,-30},{-48,-30},{-48,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.inlet, multiSensor_Tpm1.outlet)
    annotation (Line(
      points={{54,-14},{44,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.inlet, conductionElement.outlet)
    annotation (Line(
      points={{24,-14},{10,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect2.inletB, source.outlet)
    annotation (Line(
      points={{-28,34},{-24,34},{-24,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect2.inletA, flowResistance1.inlet)
    annotation (Line(
      points={{-48,34},{-52,34},{-52,-14},{-40,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp1.inletA, source.outlet)
    annotation (Line(
      points={{-4,24},{-18,24},{-18,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp1.inletB, conductionElement.inlet)
    annotation (Line(
      points={{-4,12},{-14,12},{-14,-14},{-10,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect3.inletA, flowResistance.outlet)
    annotation (Line(
      points={{10,92},{16,92},{16,74},{10,74}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensorSelect3.inletB, source.outlet)
    annotation (Line(
      points={{-10,92},{-18,92},{-18,74},{-80,74}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, sink2.inlet) annotation (Line(
      points={{70,-100},{80,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, flowResistance2.inlet) annotation (Line(
      points={{-80,-100},{50,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorState.inlet, flowResistance2.inlet)
    annotation (Line(
      points={{-56,-110},{-60,-110},{-60,-100},{50,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorX.inlet, flowResistance2.inlet)
    annotation (Line(
      points={{4,-108},{0,-108},{0,-100},{50,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorX1.inlet, flowResistance2.inlet)
    annotation (Line(
      points={{4,-120},{0,-120},{0,-100},{50,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorX2.inlet, flowResistance2.inlet)
    annotation (Line(
      points={{4,-132},{0,-132},{0,-100},{50,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect14.inlet, source1.outlet) annotation (Line(
      points={{-84,38},{-78,38},{-78,-14},{-80,-14}},
      color={28,108,200},
      thickness=0.5));
  annotation (experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
  Documentation(info="<html>
<p>This model should test all sensors with all selecable quantities.</p>

<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-140},{100,140}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end TestSensors;
