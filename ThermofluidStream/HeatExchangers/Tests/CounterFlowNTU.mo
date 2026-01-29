within ThermofluidStream.HeatExchangers.Tests;
model CounterFlowNTU

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
        origin={-126,-20})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumA, p0_par=MediumA.p_default - 1e4)
    annotation (Placement(transformation(extent={{116,-30},{136,-10}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package
      Medium = MediumA,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={-51,-10})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package
      Medium = MediumA,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={50,-10})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumB,
    temperatureFromInput=false,
    T0_par=293.15,
    p0_par=100000)
    annotation (Placement(transformation(extent={{136,10},{116,30}})));
  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumB, p0_par=90000)
    annotation (Placement(transformation(extent={{-116,10},{-136,30}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package
      Medium = MediumB,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-80,20},{-100,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package
      Medium = MediumB, outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{60,20},{40,40}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-158,-98},{-138,-78}})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU counterFlowNTU(
    redeclare package MediumA = MediumA,
    redeclare package MediumB = MediumB,
    A=10) annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = MediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{102,10},{82,30}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));

  FlowControl.MCV mCV(
    redeclare package Medium = MediumB,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(extent={{-40,10},{-60,30}})));
  FlowControl.MCV mCV1(
    redeclare package Medium = MediumA,
    m_flow_0=1,
    massFlow_set_par=0.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={90,-20})));
equation
  connect(sinkB.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-116,20},{-100,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, counterFlowNTU.inletB) annotation (Line(
      points={{40,20},{20,20},{20,8},{10,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, counterFlowNTU.inletA) annotation (Line(
      points={{-40,-20},{-20,-20},{-20,-4},{-10,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletA, multiSensor_Tpm1.inlet) annotation (Line(
      points={{10,-4},{20,-4},{20,-20},{40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{-116,-20},{-100,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.inlet, flowResistanceA.outlet) annotation (Line(
      points={{-62,-20},{-80,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, flowResistanceB.inlet) annotation (Line(
      points={{116,20},{102,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.inlet, flowResistanceB.outlet) annotation (Line(
      points={{60,20},{82,20}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletB, mCV.inlet) annotation (Line(
      points={{-10,8},{-20,8},{-20,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-60,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.inlet, mCV1.outlet) annotation (Line(
      points={{116,-20},{100,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{80,-20},{60,-20}},
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
end CounterFlowNTU;
