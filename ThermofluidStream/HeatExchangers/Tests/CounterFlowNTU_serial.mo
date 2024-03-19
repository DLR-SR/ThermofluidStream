within ThermofluidStream.HeatExchangers.Tests;
model CounterFlowNTU_serial

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
        origin={-140,-4})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumA, p0_par=MediumA.p_default - 1e4)
    annotation (Placement(transformation(extent={{130,-14},{150,6}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               MediumA,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={70,-14})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumB,
    temperatureFromInput=false,
    T0_par=293.15,
    p0_par=100000)
    annotation (Placement(transformation(extent={{166,-2},{146,18}})));
  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumB, p0_par=90000)
    annotation (Placement(transformation(extent={{-110,-2},{-130,18}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               MediumB,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-50,8},{-70,28}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               MediumB, outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{80,8},{60,28}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-158,-92},{-138,-72}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU(
    redeclare package MediumA = MediumA,
    redeclare package MediumB = MediumB,
    A=10) annotation (Placement(transformation(extent={{-38,-8},{-18,12}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU1(
    redeclare package MediumA = MediumA,
    redeclare package MediumB = MediumB,
    A=10) annotation (Placement(transformation(extent={{18,-8},{38,12}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = MediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,8},{-10,28}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    redeclare package Medium = MediumA,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,-14})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    redeclare package Medium = MediumA,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={0,-14})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-112,-14},{-92,6}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = MediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{130,-2},{110,18}})));
  FlowControl.MCV mCV(
    redeclare package Medium = MediumB,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(extent={{-78,-2},{-98,18}})));
  FlowControl.MCV mCV1(
    redeclare package Medium = MediumA,
    m_flow_0=1,
    massFlow_set_par=0.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={100,-4})));
equation
  connect(multiSensor_Tpm4.outlet, counterFlowNTU.inletB) annotation (Line(
      points={{-10,8},{-18,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.inlet, counterFlowNTU1.outletB) annotation (Line(
      points={{10,8},{18,8}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletA, multiSensor_Tpm6.inlet) annotation (Line(
      points={{-18,-4},{-10,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU1.inletA, multiSensor_Tpm6.outlet) annotation (Line(
      points={{18,-4},{10,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, counterFlowNTU.inletA) annotation (Line(
      points={{-50,-4},{-38,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-38,8},{-50,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, counterFlowNTU1.inletB) annotation (Line(
      points={{60,8},{38,8}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU1.outletA, multiSensor_Tpm1.inlet) annotation (Line(
      points={{38,-4},{60,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{-130,-4},{-112,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.inlet, flowResistanceA.outlet) annotation (Line(
      points={{-70,-4},{-92,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, flowResistanceB.inlet) annotation (Line(
      points={{146,8},{130,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.inlet, flowResistanceB.outlet) annotation (Line(
      points={{80,8},{110,8}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.inlet, mCV1.outlet) annotation (Line(
      points={{130,-4},{110,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{90,-4},{85,-4},{85,-4},{80,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, mCV.outlet) annotation (Line(
      points={{-110,8},{-98,8}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-78,8},{-70,8}},
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
end CounterFlowNTU_serial;
