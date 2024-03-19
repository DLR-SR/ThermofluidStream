within ThermofluidStream.HeatExchangers.Tests;
model CounterFlowNTU_parallel

  replaceable package MediumA =
      Media.myMedia.Incompressible.Examples.Glycol47
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  replaceable package MediumB = Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source sourceA(
    redeclare package Medium = MediumA,
    T0_par=333.15)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-142,-4})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumA, p0_par=MediumA.p_default - 1e4)
    annotation (Placement(transformation(extent={{80,-14},{100,6}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               MediumA,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={56,-14})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumB,
    temperatureFromInput=false,
    T0_par=293.15,
    p0_par=150000)
    annotation (Placement(transformation(extent={{158,10},{138,30}})));
  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumB,
    pressureFromInput=false,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-160,10},{-180,30}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               MediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-112,20},{-132,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               MediumB,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{132,20},{112,40}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-158,-92},{-138,-72}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU(
    redeclare package MediumA = MediumA,
    redeclare package MediumB = MediumB,
    A=10) annotation (Placement(transformation(extent={{-40,-8},{-20,12}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU1(
    redeclare package MediumA = MediumA,
    redeclare package MediumB = MediumB,
    A=10) annotation (Placement(transformation(extent={{-38,48},{-18,28}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    redeclare package Medium = MediumA,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-70,-14})));
  Topology.SplitterT1 splitterT1_1(
    redeclare package Medium = MediumB)
    annotation (Placement(transformation(extent={{80,10},{60,30}})));
  Topology.JunctionT1 junctionT1_1(redeclare package Medium = MediumB)
    annotation (Placement(transformation(extent={{-88,10},{-108,30}})));
  Boundaries.Source sourceA2(redeclare package Medium = MediumA, T0_par=
       333.15)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-142,44})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = MediumA,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-106,54})));
  Boundaries.Sink sinkA2(
    redeclare package Medium = MediumA, p0_par=MediumA.p_default - 1e4)
    annotation (Placement(transformation(extent={{80,34},{100,54}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    redeclare package Medium = MediumA,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={12,54})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm7(
    redeclare package Medium = MediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{66,32},{46,12}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm8(
    redeclare package Medium = MediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{44,8},{24,28}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm9(
    redeclare package Medium = MediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-72,32},{-92,12}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm10(
    redeclare package Medium = MediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-48,8},{-68,28}})));
  Processes.FlowResistance flowResistanceB2(
    redeclare package Medium = MediumB,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-136,10},{-156,30}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = MediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{20,22},{0,42}})));
  Processes.FlowResistance flowResistanceB1(
    redeclare package Medium = MediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{12,-2},{-8,18}})));
  Processes.FlowResistance flowResistanceA2(
    redeclare package Medium = MediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-78,34},{-58,54}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-116,-14},{-96,6}})));
  FlowControl.MCV mCV(
    redeclare package Medium = MediumB,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(extent={{106,10},{86,30}})));
  FlowControl.MCV mCV1(
    redeclare package Medium = MediumA,
    m_flow_0=1,
    massFlow_set_par=0.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={24,-4})));
  FlowControl.MCV mCV2(
    redeclare package Medium = MediumA,
    m_flow_0=1,
    massFlow_set_par=0.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={42,44})));
equation
  connect(sinkA.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{80,-4},{66,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{138,20},{132,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, counterFlowNTU.inletA) annotation (Line(
      points={{-60,-4},{-40,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.inlet, junctionT1_1.outlet) annotation (Line(
      points={{-112,20},{-108,20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA2.outlet, multiSensor_Tpm4.inlet) annotation (Line(
      points={{-132,44},{-116,44}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU1.outletA, multiSensor_Tpm6.inlet) annotation (Line(
      points={{-18,44},{2,44}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.outletA, multiSensor_Tpm7.inlet) annotation (Line(
      points={{70,30},{70,32},{66,32}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.outletB, multiSensor_Tpm8.inlet) annotation (Line(
      points={{70,10},{70,8},{44,8}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU1.outletB, multiSensor_Tpm9.inlet) annotation (Line(
      points={{-38,32},{-72,32}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT1_1.inletA, multiSensor_Tpm9.outlet) annotation (Line(
      points={{-98,30},{-98,32},{-92,32}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletB, multiSensor_Tpm10.inlet) annotation (Line(
      points={{-40,8},{-48,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm10.outlet, junctionT1_1.inletB) annotation (Line(
      points={{-68,8},{-98,8},{-98,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, flowResistanceB2.outlet) annotation (Line(
      points={{-160,20},{-156,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.outlet, flowResistanceB2.inlet) annotation (Line(
      points={{-132,20},{-136,20}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU1.inletB, flowResistanceB.outlet) annotation (Line(
      points={{-18,32},{0,32}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm7.outlet,flowResistanceB. inlet) annotation (Line(
      points={{46,32},{20,32}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.inletB, flowResistanceB1.outlet) annotation (Line(
      points={{-20,8},{-8,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm8.outlet, flowResistanceB1.inlet) annotation (Line(
      points={{24,8},{12,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.outlet, flowResistanceA2.inlet) annotation (Line(
      points={{-96,44},{-78,44}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceA2.outlet, counterFlowNTU1.inletA) annotation (Line(
      points={{-58,44},{-38,44}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet,flowResistanceA. inlet) annotation (Line(
      points={{-132,-4},{-116,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.inlet,flowResistanceA. outlet) annotation (Line(
      points={{-80,-4},{-96,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletA, mCV1.inlet)
    annotation (Line(
      points={{-20,-4},{14,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.outlet, multiSensor_Tpm1.inlet) annotation (Line(
      points={{34,-4},{46,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA2.inlet, mCV2.outlet) annotation (Line(
      points={{80,44},{52,44}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV2.inlet, multiSensor_Tpm6.outlet) annotation (Line(
      points={{32,44},{22,44}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, mCV.inlet) annotation (Line(
      points={{112,20},{106,20}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, splitterT1_1.inlet) annotation (Line(
      points={{86,20},{80,20}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-160,-100},{160,100}})),
    experiment(
      StopTime=100,
   Tolerance=1e-6,
   Interval=0.1,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end CounterFlowNTU_parallel;
