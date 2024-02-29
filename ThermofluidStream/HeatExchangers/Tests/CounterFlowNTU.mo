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
        extent={{-11,10},{11,-10}},
        rotation=0,
        origin={-45,-30})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package
      Medium = MediumA,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={60,-30})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumB,
    temperatureFromInput=false,
    T0_par=293.15,
    p0_par=100000)
    annotation (Placement(transformation(extent={{136,10},{116,30}})));
  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumB, p0_par=90000)
    annotation (Placement(transformation(extent={{-118,10},{-138,30}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package
      Medium = MediumB,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-74,20},{-94,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package
      Medium = MediumB, outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{66,20},{46,40}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-156,-98},{-136,-78}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU(
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
    annotation (Placement(transformation(extent={{100,10},{80,30}})));
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
        origin={88,-20})));
equation
  connect(sinkB.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-118,20},{-94,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, counterFlowNTU.inletB) annotation (Line(
      points={{46,20},{28,20},{28,8},{11.2,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, counterFlowNTU.inletA) annotation (Line(
      points={{-34,-20},{-28,-20},{-28,-4},{-11.2,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletA, multiSensor_Tpm1.inlet) annotation (Line(
      points={{11,-4},{28,-4},{28,-20},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{-116,-20},{-100,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.inlet, flowResistanceA.outlet) annotation (Line(
      points={{-56,-20},{-80,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, flowResistanceB.inlet) annotation (Line(
      points={{116,20},{100,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.inlet, flowResistanceB.outlet) annotation (Line(
      points={{66,20},{80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletB, mCV.inlet)
    annotation (Line(
      points={{-11,8},{-28,8},{-28,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-60,20},{-74,20}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.inlet, mCV1.outlet) annotation (Line(
      points={{116,-20},{98,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{78,-20},{70,-20}},
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
