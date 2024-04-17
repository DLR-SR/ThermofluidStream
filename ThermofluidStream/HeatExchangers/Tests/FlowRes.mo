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
        origin={-44,36})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumAir,
    pressureFromInput=false,
    p0_par=100000) annotation (Placement(transformation(extent={{-202,26},{-222,46}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
               MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{11,10},{-11,-10}},
        rotation=0,
        origin={-93,26})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-146,26})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=400000,
    h0_par=300e3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-176,48})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 300000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-26,48})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-98,48},{-78,68}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-162,48},{-142,68}})));
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
    annotation (Placement(transformation(extent={{-142,76},{-162,96}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-98,76},{-78,96}})));
  FlowControl.MCV mCV(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    massFlow_set_par=0.2) annotation (Placement(transformation(extent={{-68,38},{-48,58}})));
  FlowControl.MCV mCV1(
    redeclare package Medium = MediumAir,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-186,36})));
  Boundaries.Source sourceA1(
    redeclare package Medium = MediumAir,
    T0_par=303.15,
    p0_par=200000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-48,-64})));
  Boundaries.Sink sinkA1(
    redeclare package Medium = MediumAir,
    pressureFromInput=false,
    p0_par=100000) annotation (Placement(transformation(extent={{-200,-74},{-220,-54}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{11,10},{-11,-10}},
        rotation=0,
        origin={-91,-74})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-144,-74})));
  Boundaries.Source sourceB1(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=400000,
    h0_par=300e3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-180,-52})));
  Boundaries.Sink sinkB1(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 300000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-24,-52})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-96,-52},{-76,-32}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm7(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-160,-52},{-140,-32}})));
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
    massFlow_set_par=0.2) annotation (Placement(transformation(extent={{-66,-62},{-46,-42}})));
  FlowControl.MCV mCV3(
    redeclare package Medium = MediumAir,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-184,-64})));
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
        origin={120,76})));
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
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={114,8})));
  Sensors.SingleSensorSelect singleSensorSelect5(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={108,76})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality4(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={114,-4})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality5(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={96,76})));
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
        origin={28,-72})));
  Boundaries.Sink sinkA3(redeclare package Medium = MediumAir, p0_par=90000)
    annotation (Placement(transformation(extent={{182,-82},{202,-62}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm12(
    redeclare package Medium = MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={81,-62})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm13(
    redeclare package Medium = MediumAir,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={136,-62})));
  Boundaries.Source sourceB3(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=3200000,
    h0_par=450e3)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={170,-20})));
  Boundaries.Sink sinkB3(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 3000000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={38,-100})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm14(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={96,-90})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm15(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={102,-38})));
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
        origin={106,-72})));
  Processes.FlowResistance flowResistanceA1(
    redeclare package Medium = MediumAir,
    m_flow_0=0.5,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{44,-82},{64,-62}})));
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
        origin={70,-100})));
  Sensors.SingleSensorSelect singleSensorSelect6(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={96,-106})));
  Sensors.SingleSensorSelect singleSensorSelect7(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-38})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality6(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={96,-118})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality7(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={78,-38})));
  FlowControl.MCV mCV6(
    redeclare package Medium = MediumAir,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={162,-72})));
  FlowControl.MCV mCV7(
    redeclare package Medium = MediumRefrigerant,
    m_flow_0=1,
    massFlow_set_par=0.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={138,-20})));
equation
  connect(sourceB.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{-166,48},{-162,48}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, evaporator.inletA)
    annotation (Line(
      points={{-104,36},{-110,36}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletA, multiSensor_Tpm1.inlet)
    annotation (Line(
      points={{-130,36},{-136,36}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-110,48},{-98,48}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, evaporator.inletB) annotation (Line(
      points={{-142,48},{-130,48}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, evaporator.outletB)
    annotation (Line(
      points={{-98,74},{-102,74},{-102,48},{-110,48}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, evaporator.inletB)
    annotation (Line(
      points={{-142,74},{-138,74},{-138,48},{-130,48}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, evaporator.inletB)
    annotation (Line(
      points={{-142,86},{-138,86},{-138,48},{-130,48}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, evaporator.outletB)
    annotation (Line(
      points={{-98,86},{-102,86},{-102,48},{-110,48}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-68,48},{-78,48}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, sinkB.inlet) annotation (Line(
      points={{-48,48},{-36,48}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, multiSensor_Tpm.inlet) annotation (Line(
      points={{-54,36},{-82,36}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.inlet, mCV1.outlet) annotation (Line(
      points={{-202,36},{-196,36}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{-176,36},{-156,36}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB1.outlet, multiSensor_Tpm7.inlet) annotation (Line(
      points={{-170,-52},{-160,-52}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.outlet, evaporator1.inletA) annotation (Line(
      points={{-102,-64},{-108,-64}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator1.outletA, multiSensor_Tpm5.inlet)
    annotation (Line(
      points={{-128,-64},{-134,-64}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator1.outletB, multiSensor_Tpm6.inlet)
    annotation (Line(
      points={{-108,-52},{-96,-52}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm7.outlet, evaporator1.inletB)
    annotation (Line(
      points={{-140,-52},{-128,-52}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, evaporator1.outletB)
    annotation (Line(
      points={{-96,-26},{-100,-26},{-100,-52},{-108,-52}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, evaporator1.inletB)
    annotation (Line(
      points={{-140,-26},{-136,-26},{-136,-52},{-128,-52}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality2.inlet, evaporator1.inletB)
    annotation (Line(
      points={{-140,-16},{-132,-16},{-132,-52},{-128,-52}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality3.inlet, evaporator1.outletB)
    annotation (Line(
      points={{-96,-16},{-106,-16},{-106,-52},{-108,-52}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV2.inlet, multiSensor_Tpm6.outlet) annotation (Line(
      points={{-66,-52},{-76,-52}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV2.outlet, sinkB1.inlet) annotation (Line(
      points={{-46,-52},{-34,-52}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA1.outlet, multiSensor_Tpm4.inlet) annotation (Line(
      points={{-58,-64},{-80,-64}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA1.inlet, mCV3.outlet) annotation (Line(
      points={{-200,-64},{-194,-64}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV3.inlet, multiSensor_Tpm5.outlet) annotation (Line(
      points={{-174,-64},{-154,-64}},
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
      points={{108,86},{108,94},{130,94},{130,86}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality5.inlet, multiSensor_Tpm11.inlet)
    annotation (Line(
      points={{96,86},{96,94},{130,94},{130,86}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality4.inlet, multiSensor_Tpm10.inlet)
    annotation (Line(
      points={{124,-4},{130,-4},{130,14},{124,14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect4.inlet, multiSensor_Tpm10.inlet)
    annotation (Line(
      points={{124,8},{130,8},{130,14},{124,14}},
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
      points={{130,32},{130,14},{124,14}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.inletB, multiSensor_Tpm11.outlet) annotation (Line(
      points={{130,52},{130,66}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB2.outlet, mCV5.inlet) annotation (Line(
      points={{178,94},{166,94}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV5.outlet, multiSensor_Tpm11.inlet)
    annotation (Line(
      points={{146,94},{130,94},{130,86}},
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
      points={{38,-72},{44,-72}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm12.inlet, flowResistanceA1.outlet)
    annotation (Line(
      points={{70,-72},{64,-72}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB3.inlet, flowResistanceB1.outlet) annotation (Line(
      points={{48,-100},{60,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB1.inlet, multiSensor_Tpm14.outlet)
    annotation (Line(
      points={{80,-100},{86,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect7.inlet, multiSensor_Tpm15.inlet)
    annotation (Line(
      points={{90,-28},{90,-20},{112,-20},{112,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality7.inlet, multiSensor_Tpm15.inlet)
    annotation (Line(
      points={{78,-28},{78,-20},{112,-20},{112,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality6.inlet, multiSensor_Tpm14.inlet)
    annotation (Line(
      points={{106,-118},{112,-118},{112,-100},{106,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect6.inlet, multiSensor_Tpm14.inlet)
    annotation (Line(
      points={{106,-106},{112,-106},{112,-100},{106,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm12.outlet, condenser1.inletA) annotation (Line(
      points={{92,-72},{96,-72}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser1.outletA, multiSensor_Tpm13.inlet)
    annotation (Line(
      points={{116,-72},{126,-72}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser1.outletB, multiSensor_Tpm14.inlet)
    annotation (Line(
      points={{112,-82},{112,-100},{106,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser1.inletB, multiSensor_Tpm15.outlet)
    annotation (Line(
      points={{112,-62},{112,-48}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB3.outlet, mCV7.inlet) annotation (Line(
      points={{160,-20},{148,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV7.outlet, multiSensor_Tpm15.inlet)
    annotation (Line(
      points={{128,-20},{112,-20},{112,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA3.inlet, mCV6.outlet) annotation (Line(
      points={{182,-72},{172,-72}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV6.inlet, multiSensor_Tpm13.outlet) annotation (Line(
      points={{152,-72},{146,-72}},
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
