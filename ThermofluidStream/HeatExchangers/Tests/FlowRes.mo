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
        origin={-50,34})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumAir,
    pressureFromInput=false,
    p0_par=100000) annotation (Placement(transformation(extent={{-202,24},{-222,44}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package
      Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{11,10},{-11,-10}},
        rotation=0,
        origin={-93,24})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package
      Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-146,24})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=400000,
    h0_par=300e3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-182,50})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 300000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-26,50})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package
      Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-98,50},{-78,70}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package
      Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-162,50},{-142,70}})));
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
        origin={-120,42})));

  Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-98,64},{-78,84}})));
  Sensors.SingleSensorSelect singleSensorSelect1(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-142,64},{-162,84}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-142,74},{-162,94}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-98,74},{-78,94}})));
  FlowControl.MCV mCV(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    massFlow_set_par=0.2) annotation (Placement(transformation(extent={{-68,40},{-48,60}})));
  FlowControl.MCV mCV1(
    redeclare package Medium = MediumAir,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-186,34})));
  Boundaries.Source sourceA1(
    redeclare package Medium = MediumAir,
    T0_par=303.15,
    p0_par=200000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-48,-66})));
  Boundaries.Sink sinkA1(
    redeclare package Medium = MediumAir,
    pressureFromInput=false,
    p0_par=100000) annotation (Placement(transformation(extent={{-200,-76},{-220,-56}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{11,10},{-11,-10}},
        rotation=0,
        origin={-91,-76})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-144,-76})));
  Boundaries.Source sourceB1(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=400000,
    h0_par=300e3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-180,-50})));
  Boundaries.Sink sinkB1(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 300000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-24,-50})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-96,-50},{-76,-30}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm7(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-160,-50},{-140,-30}})));
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
        origin={-118,-58})));
  Sensors.SingleSensorSelect singleSensorSelect2(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-96,-36},{-76,-16}})));
  Sensors.SingleSensorSelect singleSensorSelect3(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-140,-36},{-160,-16}})));
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
    massFlow_set_par=0.2) annotation (Placement(transformation(extent={{-66,-60},{-46,-40}})));
  FlowControl.MCV mCV3(
    redeclare package Medium = MediumAir,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-184,-66})));
  Boundaries.Source sourceA2(
    redeclare package Medium = MediumAir,
    T0_par=311.15,
    p0_par=100000)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={46,42})));
  Boundaries.Sink sinkA2(redeclare package Medium = MediumAir, p0_par=90000)
    annotation (Placement(transformation(extent={{200,32},{220,52}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm8(
    redeclare package Medium = MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={99,52})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm9(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={154,52})));
  Boundaries.Source sourceB2(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=3200000,
    h0_par=450e3)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={188,94})));
  Boundaries.Sink sinkB2(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 3000000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={56,14})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm10(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={114,24})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm11(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={122,76})));
  DiscretizedCrossFlowHEX condenser(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX,
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=true,
    nCells=nCells,
    k_wall=150) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={124,42})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumAir,
    m_flow_0=0.5,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{62,32},{82,52}})));
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
        origin={88,14})));
  Sensors.SingleSensorSelect singleSensorSelect4(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={150,22})));
  Sensors.SingleSensorSelect singleSensorSelect5(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={108,76})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality4(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={150,14})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality5(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,76})));
  FlowControl.MCV mCV4(
    redeclare package Medium = MediumAir,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={180,42})));
  FlowControl.MCV mCV5(
    redeclare package Medium = MediumRefrigerant,
    m_flow_0=1,
    massFlow_set_par=0.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={156,94})));
  Boundaries.Source sourceA3(
    redeclare package Medium = MediumAir,
    T0_par=311.15,
    p0_par=100000)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={28,-62})));
  Boundaries.Sink sinkA3(redeclare package Medium = MediumAir, p0_par=90000)
    annotation (Placement(transformation(extent={{182,-72},{202,-52}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm12(
    redeclare package Medium = MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={81,-52})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm13(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={136,-52})));
  Boundaries.Source sourceB3(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=3200000,
    h0_par=450e3)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={170,-10})));
  Boundaries.Sink sinkB3(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 3000000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={38,-90})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm14(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={96,-80})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm15(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={104,-28})));
  DiscretizedCrossFlowHEX_FR condenser1(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX,
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=true,
    nCells=nCells,
    k_wall=150)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={106,-62})));
  Processes.FlowResistance flowResistanceA1(
    redeclare package Medium = MediumAir,
    m_flow_0=0.5,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{44,-72},{64,-52}})));
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
        origin={70,-90})));
  Sensors.SingleSensorSelect singleSensorSelect6(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={132,-82})));
  Sensors.SingleSensorSelect singleSensorSelect7(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-28})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality6(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={132,-90})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality7(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={82,-28})));
  FlowControl.MCV mCV6(
    redeclare package Medium = MediumAir,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={162,-62})));
  FlowControl.MCV mCV7(
    redeclare package Medium = MediumRefrigerant,
    m_flow_0=1,
    massFlow_set_par=0.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={138,-10})));
equation
  connect(sourceB.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{-172,50},{-162,50}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, evaporator.inletA)
    annotation (Line(
      points={{-104,34},{-110,34}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletA, multiSensor_Tpm1.inlet)
    annotation (Line(
      points={{-130.2,34},{-136,34}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-109.8,50},{-98,50}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, evaporator.inletB) annotation (Line(
      points={{-142,50},{-130,50}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, evaporator.outletB)
    annotation (Line(
      points={{-98,74},{-102,74},{-102,50},{-109.8,50}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, evaporator.inletB)
    annotation (Line(
      points={{-142,74},{-138,74},{-138,50},{-130,50}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, evaporator.inletB)
    annotation (Line(
      points={{-142,84},{-134,84},{-134,50},{-130,50}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, evaporator.outletB)
    annotation (Line(
      points={{-98,84},{-108,84},{-108,50},{-109.8,50}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-68,50},{-78,50}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, sinkB.inlet) annotation (Line(
      points={{-48,50},{-36,50}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, multiSensor_Tpm.inlet) annotation (Line(
      points={{-60,34},{-82,34}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.inlet, mCV1.outlet) annotation (Line(
      points={{-202,34},{-196,34}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{-176,34},{-156,34}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB1.outlet, multiSensor_Tpm7.inlet) annotation (Line(
      points={{-170,-50},{-160,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.outlet, evaporator1.inletA) annotation (Line(
      points={{-102,-66},{-108,-66}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator1.outletA, multiSensor_Tpm5.inlet)
    annotation (Line(
      points={{-128.2,-66},{-134,-66}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator1.outletB, multiSensor_Tpm6.inlet)
    annotation (Line(
      points={{-107.8,-50},{-96,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm7.outlet, evaporator1.inletB)
    annotation (Line(
      points={{-140,-50},{-128,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, evaporator1.outletB)
    annotation (Line(
      points={{-96,-26},{-100,-26},{-100,-50},{-107.8,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, evaporator1.inletB)
    annotation (Line(
      points={{-140,-26},{-136,-26},{-136,-50},{-128,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality2.inlet, evaporator1.inletB)
    annotation (Line(
      points={{-140,-16},{-132,-16},{-132,-50},{-128,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality3.inlet, evaporator1.outletB)
    annotation (Line(
      points={{-96,-16},{-106,-16},{-106,-50},{-107.8,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV2.inlet, multiSensor_Tpm6.outlet) annotation (Line(
      points={{-66,-50},{-76,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV2.outlet, sinkB1.inlet) annotation (Line(
      points={{-46,-50},{-34,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA1.outlet, multiSensor_Tpm4.inlet) annotation (Line(
      points={{-58,-66},{-80,-66}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA1.inlet, mCV3.outlet) annotation (Line(
      points={{-200,-66},{-194,-66}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV3.inlet, multiSensor_Tpm5.outlet) annotation (Line(
      points={{-174,-66},{-154,-66}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA2.outlet, flowResistanceA.inlet) annotation (Line(
      points={{56,42},{62,42}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm8.inlet, flowResistanceA.outlet) annotation (Line(
      points={{88,42},{82,42}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB2.inlet, flowResistanceB.outlet) annotation (Line(
      points={{66,14},{78,14}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB.inlet, multiSensor_Tpm10.outlet)
    annotation (Line(
      points={{98,14},{104,14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect5.inlet, multiSensor_Tpm11.inlet)
    annotation (Line(
      points={{108,86},{108,92},{132,92},{132,86}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality5.inlet, multiSensor_Tpm11.inlet)
    annotation (Line(
      points={{100,86},{100,92},{132,92},{132,86}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality4.inlet, multiSensor_Tpm10.inlet)
    annotation (Line(
      points={{140,14},{124,14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect4.inlet, multiSensor_Tpm10.inlet)
    annotation (Line(
      points={{140,22},{132,22},{132,14},{124,14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm8.outlet, condenser.inletA) annotation (Line(
      points={{110,42},{114,42}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletA,multiSensor_Tpm9. inlet)
    annotation (Line(
      points={{134,42},{144,42}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletB, multiSensor_Tpm10.inlet)
    annotation (Line(
      points={{132,31.8},{132,14},{124,14}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.inletB, multiSensor_Tpm11.outlet) annotation (Line(
      points={{132,52},{132,66}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB2.outlet, mCV5.inlet) annotation (Line(
      points={{178,94},{166,94}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV5.outlet, multiSensor_Tpm11.inlet)
    annotation (Line(
      points={{146,94},{132,94},{132,86}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA2.inlet, mCV4.outlet) annotation (Line(
      points={{200,42},{190,42}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV4.inlet, multiSensor_Tpm9.outlet) annotation (Line(
      points={{170,42},{164,42}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA3.outlet, flowResistanceA1.inlet) annotation (Line(
      points={{38,-62},{44,-62}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm12.inlet, flowResistanceA1.outlet)
    annotation (Line(
      points={{70,-62},{64,-62}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB3.inlet, flowResistanceB1.outlet) annotation (Line(
      points={{48,-90},{60,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB1.inlet, multiSensor_Tpm14.outlet)
    annotation (Line(
      points={{80,-90},{86,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect7.inlet, multiSensor_Tpm15.inlet)
    annotation (Line(
      points={{90,-18},{90,-12},{114,-12},{114,-18}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality7.inlet, multiSensor_Tpm15.inlet)
    annotation (Line(
      points={{82,-18},{82,-12},{114,-12},{114,-18}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality6.inlet, multiSensor_Tpm14.inlet)
    annotation (Line(
      points={{122,-90},{106,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect6.inlet, multiSensor_Tpm14.inlet)
    annotation (Line(
      points={{122,-82},{114,-82},{114,-90},{106,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm12.outlet, condenser1.inletA) annotation (Line(
      points={{92,-62},{96,-62}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser1.outletA, multiSensor_Tpm13.inlet)
    annotation (Line(
      points={{116,-62},{120,-62},{120,-62},{126,-62}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser1.outletB, multiSensor_Tpm14.inlet)
    annotation (Line(
      points={{114,-72.2},{114,-90},{106,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser1.inletB, multiSensor_Tpm15.outlet)
    annotation (Line(
      points={{114,-52},{114,-38}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB3.outlet, mCV7.inlet) annotation (Line(
      points={{160,-10},{148,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV7.outlet, multiSensor_Tpm15.inlet)
    annotation (Line(
      points={{128,-10},{114,-10},{114,-18}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA3.inlet, mCV6.outlet) annotation (Line(
      points={{182,-62},{172,-62}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV6.inlet, multiSensor_Tpm13.outlet) annotation (Line(
      points={{152,-62},{146,-62}},
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
