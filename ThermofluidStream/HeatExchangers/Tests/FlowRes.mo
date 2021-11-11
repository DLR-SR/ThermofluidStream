within ThermofluidStream.HeatExchangers.Tests;
model FlowRes

  replaceable package MediumAir = Media.myMedia.Air.MoistAir
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  replaceable package MediumRefrigerant = TILMediaWrapper.VLEFluidWrapper.R1234yf
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source sourceA(redeclare package Medium =
        MediumAir,
    T0_par=303.15,
    p0_par=200000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={68,52})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumAir,
    pressureFromInput=false,
    p0_par=100000) annotation (Placement(transformation(extent={{-84,42},{-104,62}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
               MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")                                         annotation (
      Placement(transformation(
        extent={{11,10},{-11,-10}},
        rotation=0,
        origin={25,42})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-28,42})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=400000,
    h0_par=300e3)
               annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-64,68})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 300000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={92,68})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{20,68},{40,88}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-44,68},{-24,88}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{132,-64},{152,-44}})));
  DiscretizedCounterFlowHEX evaporator(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX (U_nom=4000),
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase (
        U_liq_nom=1000,
        U_vap_nom=1400,
        U_tp_nom=3000),
    m_flow_0=0,
    nCells=10,
    A=10,
    k_wall=250) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-2,60})));

  Sensors.SingleSensorSelect singleSensorSelect(redeclare package Medium =
        MediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{20,82},{40,102}})));
  Sensors.SingleSensorSelect singleSensorSelect1(redeclare package Medium =
        MediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-24,82},{-44,102}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(redeclare package Medium =
        MediumRefrigerant,                                                                      quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-24,92},{-44,112}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(redeclare package Medium =
        MediumRefrigerant,                                                                       quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{20,92},{40,112}})));
  FlowControl.MCV mCV(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0.2,
    massFlow_set_par=0.2) annotation (Placement(transformation(extent={{50,58},{70,78}})));
  FlowControl.MCV mCV1(
    redeclare package Medium = MediumAir,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=1,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-68,52})));
  Boundaries.Source                   sourceA1(
    redeclare package Medium = MediumAir,
    T0_par=303.15,
    p0_par=200000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,-48})));
  Boundaries.Sink                   sinkA1(
    redeclare package Medium = MediumAir,
    pressureFromInput=false,
    p0_par=100000) annotation (Placement(transformation(extent={{-82,-58},{-102,-38}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm4(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")                                         annotation (
      Placement(transformation(
        extent={{11,10},{-11,-10}},
        rotation=0,
        origin={27,-58})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm5(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-26,-58})));
  Boundaries.Source                   sourceB1(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=400000,
    h0_par=300e3)
               annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-62,-32})));
  Boundaries.Sink                   sinkB1(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 300000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={94,-32})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm6(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{22,-32},{42,-12}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm7(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-42,-32},{-22,-12}})));
  DiscretizedCounterFlowHEX_FR
                            evaporator1(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX (U_nom=4000),
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase (
        U_liq_nom=1000,
        U_vap_nom=1400,
        U_tp_nom=3000),
    m_flow_0=0,
    nCells=10,
    A=10,
    k1A=1000,
    k2A=1000,
    k1B=1000,
    k2B=1000,
    k_wall=250) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,-40})));
  Sensors.SingleSensorSelect singleSensorSelect2(redeclare package Medium = MediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{22,-18},{42,2}})));
  Sensors.SingleSensorSelect singleSensorSelect3(redeclare package Medium = MediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-22,-18},{-42,2}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality2(redeclare package Medium = MediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-22,-8},{-42,12}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality3(redeclare package Medium = MediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{22,-8},{42,12}})));
  FlowControl.MCV mCV2(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0.2,
    massFlow_set_par=0.2) annotation (Placement(transformation(extent={{52,-42},{72,-22}})));
  FlowControl.MCV mCV3(
    redeclare package Medium = MediumAir,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=1,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-66,-48})));
equation
  connect(sourceB.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{-54,68},{-44,68}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, evaporator.inletA)
    annotation (Line(
      points={{14,52},{8,52}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletA, multiSensor_Tpm1.inlet)
    annotation (Line(
      points={{-12.2,52},{-18,52}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{8.2,68},{20,68}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, evaporator.inletB) annotation (Line(
      points={{-24,68},{-12,68}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, evaporator.outletB)
    annotation (Line(
      points={{20,92},{16,92},{16,68},{8.2,68}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, evaporator.inletB)
    annotation (Line(
      points={{-24,92},{-20,92},{-20,68},{-12,68}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, evaporator.inletB)
    annotation (Line(
      points={{-24,102},{-16,102},{-16,68},{-12,68}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, evaporator.outletB)
    annotation (Line(
      points={{20,102},{10,102},{10,68},{8.2,68}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{50,68},{40,68}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, sinkB.inlet) annotation (Line(
      points={{70,68},{82,68}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, multiSensor_Tpm.inlet) annotation (Line(
      points={{58,52},{36,52}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.inlet, mCV1.outlet) annotation (Line(
      points={{-84,52},{-78,52}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{-58,52},{-38,52}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB1.outlet, multiSensor_Tpm7.inlet) annotation (Line(
      points={{-52,-32},{-42,-32}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.outlet, evaporator1.inletA) annotation (Line(
      points={{16,-48},{10,-48}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator1.outletA, multiSensor_Tpm5.inlet)
    annotation (Line(
      points={{-10.2,-48},{-16,-48}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator1.outletB, multiSensor_Tpm6.inlet)
    annotation (Line(
      points={{10.2,-32},{22,-32}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm7.outlet, evaporator1.inletB)
    annotation (Line(
      points={{-22,-32},{-10,-32}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, evaporator1.outletB)
    annotation (Line(
      points={{22,-8},{18,-8},{18,-32},{10.2,-32}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, evaporator1.inletB)
    annotation (Line(
      points={{-22,-8},{-18,-8},{-18,-32},{-10,-32}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality2.inlet, evaporator1.inletB)
    annotation (Line(
      points={{-22,2},{-14,2},{-14,-32},{-10,-32}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality3.inlet, evaporator1.outletB)
    annotation (Line(
      points={{22,2},{12,2},{12,-32},{10.2,-32}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV2.inlet, multiSensor_Tpm6.outlet) annotation (Line(
      points={{52,-32},{42,-32}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV2.outlet, sinkB1.inlet) annotation (Line(
      points={{72,-32},{84,-32}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA1.outlet, multiSensor_Tpm4.inlet) annotation (Line(
      points={{60,-48},{38,-48}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA1.inlet, mCV3.outlet) annotation (Line(
      points={{-82,-48},{-76,-48}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV3.inlet, multiSensor_Tpm5.outlet) annotation (Line(
      points={{-56,-48},{-36,-48}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-160,-100},{160,100}})),
    experiment(
      StopTime=10,
   Tolerance=1e-6,
   Interval=0.01,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end FlowRes;
