within ThermofluidStream.HeatExchangers.Tests;
model FlowRes

  replaceable package MediumAir = Media.myMedia.Air.MoistAir
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  replaceable package MediumRefrigerant = Media.XRGMedia.R1234yf_ph
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  parameter Integer nCells = 10 "Number of discretization elements in heat exchangers";

  ThermofluidStream.Boundaries.Source sourceA(
    redeclare package Medium = MediumAir,
    T0_par=303.15,
    p0_par=200000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-36,44})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumAir,
    pressureFromInput=false,
    p0_par=100000) annotation (Placement(transformation(extent={{-194,34},{-214,
            54}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
               MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{11,10},{-11,-10}},
        rotation=0,
        origin={-85,34})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-138,34})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=400000,
    h0_par=300e3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-168,56})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 300000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-18,56})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-90,56},{-70,76}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-154,56},{-134,76}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  DiscretizedCounterFlowHEX evaporator(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX (U_nom=4000),
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase (
        U_liq_nom=1000,
        U_vap_nom=1400,
        U_tp_nom=3000),
    nCells=nCells,
    A=10,
    k_wall=250) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-112,50})));

  Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-90,72},{-70,92}})));
  Sensors.SingleSensorSelect singleSensorSelect1(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-134,72},{-154,92}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-134,84},{-154,104}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-90,84},{-70,104}})));
  FlowControl.MCV mCV(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    massFlow_set_par=0.2) annotation (Placement(transformation(extent={{-60,46},
            {-40,66}})));
  FlowControl.MCV mCV1(
    redeclare package Medium = MediumAir,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-178,44})));
  Boundaries.Source sourceA1(
    redeclare package Medium = MediumAir,
    T0_par=303.15,
    p0_par=200000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-40,-68})));
  Boundaries.Sink sinkA1(
    redeclare package Medium = MediumAir,
    pressureFromInput=false,
    p0_par=100000) annotation (Placement(transformation(extent={{-192,-78},{
            -212,-58}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{11,10},{-11,-10}},
        rotation=0,
        origin={-83,-78})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-136,-78})));
  Boundaries.Source sourceB1(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=400000,
    h0_par=300e3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-172,-56})));
  Boundaries.Sink sinkB1(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 300000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-16,-56})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-88,-56},{-68,-36}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm7(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-152,-56},{-132,-36}})));
  DiscretizedCounterFlowHEX_FR evaporator1(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX (U_nom=4000),
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase (
        U_liq_nom=1000,
        U_vap_nom=1400,
        U_tp_nom=3000),
    nCells=nCells,
    A=10,
    k_wall=250) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-110,-62})));
  Sensors.SingleSensorSelect singleSensorSelect2(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-88,-40},{-68,-20}})));
  Sensors.SingleSensorSelect singleSensorSelect3(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-132,-40},{-152,-20}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality2(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-140,-26},{-160,-6}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality3(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-96,-26},{-76,-6}})));
  FlowControl.MCV mCV2(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    massFlow_set_par=0.2) annotation (Placement(transformation(extent={{-58,-66},
            {-38,-46}})));
  FlowControl.MCV mCV3(
    redeclare package Medium = MediumAir,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-176,-68})));
  Boundaries.Source sourceA2(
    redeclare package Medium = MediumAir,
    T0_par=311.15,
    p0_par=100000)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={28,54})));
  Boundaries.Sink sinkA2(redeclare package Medium = MediumAir, p0_par=90000)
    annotation (Placement(transformation(extent={{192,44},{212,64}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm8(
    redeclare package Medium = MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={81,64})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm9(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={146,64})));
  Boundaries.Source sourceB2(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=3200000,
    h0_par=450e3)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={170,106})));
  Boundaries.Sink sinkB2(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 3000000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={38,26})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm10(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={96,36})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm11(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={102,88})));
  DiscretizedCrossFlowHEX condenser(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX,
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=true,
    nCells=nCells,
    k_wall=150) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={112,54})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumAir,
    m_flow_0=0.5,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{44,44},{64,64}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.none,
    m_flow_0=0.3,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,26})));
  Sensors.SingleSensorSelect singleSensorSelect4(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={96,20})));
  Sensors.SingleSensorSelect singleSensorSelect5(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,88})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality4(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={96,8})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality5(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={78,88})));
  FlowControl.MCV mCV4(
    redeclare package Medium = MediumAir,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={174,54})));
  FlowControl.MCV mCV5(
    redeclare package Medium = MediumRefrigerant,
    m_flow_0=1,
    massFlow_set_par=0.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={138,106})));
  Boundaries.Source sourceA3(
    redeclare package Medium = MediumAir,
    T0_par=311.15,
    p0_par=100000)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={28,-64})));
  Boundaries.Sink sinkA3(redeclare package Medium = MediumAir, p0_par=90000)
    annotation (Placement(transformation(extent={{182,-74},{202,-54}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm12(
    redeclare package Medium = MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={81,-54})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm13(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={136,-54})));
  Boundaries.Source sourceB3(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=3200000,
    h0_par=450e3)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={170,-12})));
  Boundaries.Sink sinkB3(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 3000000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={38,-92})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm14(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={96,-82})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm15(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={102,-30})));
  DiscretizedCrossFlowHEX_FR condenser1(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX,
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=true,
    nCells=nCells,
    k_wall=150)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={112,-64})));
  Processes.FlowResistance flowResistanceA1(
    redeclare package Medium = MediumAir,
    m_flow_0=0.5,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{44,-74},{64,-54}})));
  Processes.FlowResistance flowResistanceB1(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.none,
    m_flow_0=0.3,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,-92})));
  Sensors.SingleSensorSelect singleSensorSelect6(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={96,-98})));
  Sensors.SingleSensorSelect singleSensorSelect7(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-30})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality6(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={96,-110})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality7(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={78,-30})));
  FlowControl.MCV mCV6(
    redeclare package Medium = MediumAir,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={162,-64})));
  FlowControl.MCV mCV7(
    redeclare package Medium = MediumRefrigerant,
    m_flow_0=1,
    massFlow_set_par=0.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={138,-12})));
equation
  connect(sourceB.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{-158,56},{-154,56}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, evaporator.inletA)
    annotation (Line(
      points={{-96,44},{-102,44}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletA, multiSensor_Tpm1.inlet)
    annotation (Line(
      points={{-122,44},{-128,44}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-102,56},{-90,56}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, evaporator.inletB) annotation (Line(
      points={{-134,56},{-122,56}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, evaporator.outletB)
    annotation (Line(
      points={{-90,82},{-94,82},{-94,56},{-102,56}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, evaporator.inletB)
    annotation (Line(
      points={{-134,82},{-130,82},{-130,56},{-122,56}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, evaporator.inletB)
    annotation (Line(
      points={{-134,94},{-130,94},{-130,56},{-122,56}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, evaporator.outletB)
    annotation (Line(
      points={{-90,94},{-94,94},{-94,56},{-102,56}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-60,56},{-70,56}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, sinkB.inlet) annotation (Line(
      points={{-40,56},{-28,56}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, multiSensor_Tpm.inlet) annotation (Line(
      points={{-46,44},{-74,44}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.inlet, mCV1.outlet) annotation (Line(
      points={{-194,44},{-188,44}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{-168,44},{-148,44}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB1.outlet, multiSensor_Tpm7.inlet) annotation (Line(
      points={{-162,-56},{-152,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.outlet, evaporator1.inletA) annotation (Line(
      points={{-94,-68},{-100,-68}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator1.outletA, multiSensor_Tpm5.inlet)
    annotation (Line(
      points={{-120,-68},{-126,-68}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator1.outletB, multiSensor_Tpm6.inlet)
    annotation (Line(
      points={{-100,-56},{-88,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm7.outlet, evaporator1.inletB)
    annotation (Line(
      points={{-132,-56},{-120,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, evaporator1.outletB)
    annotation (Line(
      points={{-88,-30},{-92,-30},{-92,-56},{-100,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, evaporator1.inletB)
    annotation (Line(
      points={{-132,-30},{-128,-30},{-128,-56},{-120,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality2.inlet, evaporator1.inletB)
    annotation (Line(
      points={{-140,-16},{-124,-16},{-124,-56},{-120,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality3.inlet, evaporator1.outletB)
    annotation (Line(
      points={{-96,-16},{-98,-16},{-98,-56},{-100,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV2.inlet, multiSensor_Tpm6.outlet) annotation (Line(
      points={{-58,-56},{-68,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV2.outlet, sinkB1.inlet) annotation (Line(
      points={{-38,-56},{-26,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA1.outlet, multiSensor_Tpm4.inlet) annotation (Line(
      points={{-50,-68},{-72,-68}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA1.inlet, mCV3.outlet) annotation (Line(
      points={{-192,-68},{-186,-68}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV3.inlet, multiSensor_Tpm5.outlet) annotation (Line(
      points={{-166,-68},{-146,-68}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA2.outlet, flowResistanceA.inlet) annotation (Line(
      points={{38,54},{44,54}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm8.inlet, flowResistanceA.outlet) annotation (Line(
      points={{70,54},{64,54}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB2.inlet, flowResistanceB.outlet) annotation (Line(
      points={{48,26},{60,26}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB.inlet, multiSensor_Tpm10.outlet)
    annotation (Line(
      points={{80,26},{86,26}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect5.inlet, multiSensor_Tpm11.inlet)
    annotation (Line(
      points={{90,98},{90,106},{112,106},{112,98}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality5.inlet, multiSensor_Tpm11.inlet)
    annotation (Line(
      points={{78,98},{78,106},{112,106},{112,98}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality4.inlet, multiSensor_Tpm10.inlet)
    annotation (Line(
      points={{106,8},{112,8},{112,26},{106,26}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect4.inlet, multiSensor_Tpm10.inlet)
    annotation (Line(
      points={{106,20},{112,20},{112,26},{106,26}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm8.outlet, condenser.inletA) annotation (Line(
      points={{92,54},{102,54}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletA,multiSensor_Tpm9. inlet)
    annotation (Line(
      points={{122,54},{136,54}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletB, multiSensor_Tpm10.inlet)
    annotation (Line(
      points={{112,44},{112,26},{106,26}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.inletB, multiSensor_Tpm11.outlet) annotation (Line(
      points={{112,64},{112,78}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB2.outlet, mCV5.inlet) annotation (Line(
      points={{160,106},{148,106}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV5.outlet, multiSensor_Tpm11.inlet)
    annotation (Line(
      points={{128,106},{112,106},{112,98}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA2.inlet, mCV4.outlet) annotation (Line(
      points={{192,54},{184,54}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV4.inlet, multiSensor_Tpm9.outlet) annotation (Line(
      points={{164,54},{156,54}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA3.outlet, flowResistanceA1.inlet) annotation (Line(
      points={{38,-64},{44,-64}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm12.inlet, flowResistanceA1.outlet)
    annotation (Line(
      points={{70,-64},{64,-64}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB3.inlet, flowResistanceB1.outlet) annotation (Line(
      points={{48,-92},{60,-92}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB1.inlet, multiSensor_Tpm14.outlet)
    annotation (Line(
      points={{80,-92},{86,-92}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect7.inlet, multiSensor_Tpm15.inlet)
    annotation (Line(
      points={{90,-20},{90,-12},{112,-12},{112,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality7.inlet, multiSensor_Tpm15.inlet)
    annotation (Line(
      points={{78,-20},{78,-12},{112,-12},{112,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality6.inlet, multiSensor_Tpm14.inlet)
    annotation (Line(
      points={{106,-110},{112,-110},{112,-92},{106,-92}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect6.inlet, multiSensor_Tpm14.inlet)
    annotation (Line(
      points={{106,-98},{112,-98},{112,-92},{106,-92}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm12.outlet, condenser1.inletA) annotation (Line(
      points={{92,-64},{102,-64}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser1.outletA, multiSensor_Tpm13.inlet)
    annotation (Line(
      points={{122,-64},{126,-64}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser1.outletB, multiSensor_Tpm14.inlet)
    annotation (Line(
      points={{112,-74},{112,-92},{106,-92}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser1.inletB, multiSensor_Tpm15.outlet)
    annotation (Line(
      points={{112,-54},{112,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB3.outlet, mCV7.inlet) annotation (Line(
      points={{160,-12},{148,-12}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV7.outlet, multiSensor_Tpm15.inlet)
    annotation (Line(
      points={{128,-12},{112,-12},{112,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA3.inlet, mCV6.outlet) annotation (Line(
      points={{182,-64},{172,-64}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV6.inlet, multiSensor_Tpm13.outlet) annotation (Line(
      points={{152,-64},{146,-64}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
                   extent={{-220,-120},{220,120}},
        grid={2,2})),
    experiment(
      StopTime=10,
   Tolerance=1e-6,
   Interval=0.01,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end FlowRes;
