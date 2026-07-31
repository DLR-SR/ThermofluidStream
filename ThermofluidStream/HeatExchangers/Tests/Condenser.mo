within ThermofluidStream.HeatExchangers.Tests;
model Condenser

  replaceable package MediumAir = Media.myMedia.Air.MoistAir
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  replaceable package MediumRefrigerant = Media.myMedia.R134a.R134a_ph
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source sourceA(
    redeclare package Medium = MediumAir,
    T0_par=311.15,
    p0_par=100000)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-108,0})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumAir, p0_par=90000)
    annotation (Placement(transformation(extent={{138,-10},{158,10}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
               MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={-1,10})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               MediumAir,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={84,10})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=3200000,
    h0_par=450e3)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={44,100})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 3000000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={44,-90})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               MediumRefrigerant,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={34,-34})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               MediumRefrigerant,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={34,36})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{190,78},{210,98}})));
  DiscretizedCrossFlowHEX condenser(
    redeclare model ConductionElementA = Internal.ConductionElementHEX,
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase,
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    initializeMassFlow=true,
    k_wall=150,
    nCells=20) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={44,0})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumAir,
    m_flow_0=0.5,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));

  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.none,
    m_flow_0=0.3,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={44,-64})));
  Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={22,-34})));
  Sensors.SingleSensorSelect singleSensorSelect1(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={22,36})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={10,-34})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,36})));
  FlowControl.MCV mCV(
    redeclare package Medium = MediumAir,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={118,0})));
  FlowControl.MCV mCV1(
    redeclare package Medium = MediumRefrigerant,
    m_flow_0=1,
    massFlow_set_par=0.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={44,74})));
equation
  connect(sourceA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{-98,0},{-48,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.inlet, flowResistanceA.outlet) annotation (Line(
      points={{-12,0},{-28,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, flowResistanceB.outlet) annotation (Line(
      points={{44,-80},{44,-74}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{44,-54},{44,-44}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, multiSensor_Tpm3.inlet)
    annotation (Line(
      points={{22,46},{22,50},{44,50},{44,46}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, multiSensor_Tpm3.inlet)
    annotation (Line(
      points={{10,46},{10,50},{44,50},{44,46}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, multiSensor_Tpm2.inlet)
    annotation (Line(
      points={{10,-24},{44,-24}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, multiSensor_Tpm2.inlet)
    annotation (Line(
      points={{22,-24},{44,-24}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, condenser.inletA) annotation (Line(
      points={{10,0},{34,0}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletA, multiSensor_Tpm1.inlet)
    annotation (Line(
      points={{54,0},{74,0}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{44,-10},{44,-24}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.inletB, multiSensor_Tpm3.outlet) annotation (Line(
      points={{44,10},{44,26}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, mCV1.inlet) annotation (Line(
      points={{44,90},{44,84}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{44,64},{44,46}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.inlet, mCV.outlet) annotation (Line(
      points={{138,0},{128,0}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{108,0},{94,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-160,-100},{220,100}})),
    experiment(
      StopTime=10,
   Tolerance=1e-6,
   Interval=0.01,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end Condenser;
