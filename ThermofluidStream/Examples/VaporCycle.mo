within ThermofluidStream.Examples;
model VaporCycle
  extends Modelica.Icons.Example;

  replaceable package SecondaryMedium = Media.myMedia.Air.DryAirNasa
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching=true);

  replaceable package RefrigerantMedium = Media.myMedia.R134a.R134a_ph
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching=true);


  HeatExchangers.DiscretizedCounterFlowHEX condenser(
    redeclare package MediumA = SecondaryMedium,
    redeclare package MediumB = RefrigerantMedium,
    redeclare model ConductionElementA =
        HeatExchangers.Internal.ConductionElementHEX,
    redeclare model ConductionElementB =
        HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=true,
    nCells=10,
    A=30,
    V_Hex(displayUnit="m3"),
    k_wall=50) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={2,60})));
  HeatExchangers.DiscretizedCounterFlowHEX evaporator(
    redeclare package MediumA = SecondaryMedium,
    redeclare package MediumB = RefrigerantMedium,
    redeclare model ConductionElementA =
        HeatExchangers.Internal.ConductionElementHEX,
    redeclare model ConductionElementB =
        HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=false,
    nCells=10,
    A=30,
    V_Hex(displayUnit="m3"),
    k_wall=50) annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,-52})));
  Utilities.Receiver receiver(
    redeclare package Medium = RefrigerantMedium,
    V_par(displayUnit="l") = 0.002,
    p_start=2000000,
    init_method=ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator.h,
    h_0=3.1e5)
    annotation (Placement(transformation(extent={{-24,44},{-44,64}})));
  FlowControl.BasicControlValve controlValve(
    redeclare package Medium = RefrigerantMedium,
    redeclare function valveCharacteristics =
        FlowControl.Internal.ControlValve.linearCharacteristics,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.m_flow_set,
    Kvs=0.5,
    m_flow_ref_set=0.2) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-64,0})));

  Boundaries.Source source(redeclare package Medium = SecondaryMedium,
    temperatureFromInput=true,
    T0_par=283.15)
    annotation (Placement(transformation(extent={{-94,56},{-74,76}})));
  Boundaries.Sink sink(
    redeclare package Medium = SecondaryMedium,
    pressureFromInput=true)
    annotation (Placement(transformation(extent={{70,56},{90,76}})));
  Boundaries.Source source1(
    redeclare package Medium = SecondaryMedium,
    T0_par=303.15)
    annotation (Placement(transformation(extent={{110,-68},{90,-48}})));
  Boundaries.Sink sink1(
    redeclare package Medium = SecondaryMedium,
    pressureFromInput=true)
    annotation (Placement(transformation(extent={{-74,-68},{-94,-48}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{168,76},{148,56}})));
  Modelica.Blocks.Continuous.PI PI(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{138,56},{118,76}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{106,60},{94,72}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = SecondaryMedium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e4))
    annotation (Placement(transformation(extent={{-66,56},{-46,76}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(
    redeclare package Medium = SecondaryMedium,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{36,66},{56,86}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = SecondaryMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e4))
    annotation (Placement(transformation(extent={{82,-68},{62,-48}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = SecondaryMedium,
    outputTemperature=true,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-26,-58},{-46,-78}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{-110,-64},{-98,-52}})));
  Modelica.Blocks.Continuous.PI PI1(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{-142,-68},{-122,-48}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{-174,-68},{-154,-48}})));
  Modelica.Blocks.Sources.RealExpression refFlow_setPoint1(y=1)
    annotation (Placement(transformation(extent={{-204,-68},{-184,-48}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = SecondaryMedium,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{50,-58},{30,-78}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    redeclare package Medium = SecondaryMedium,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-38,66},{-18,86}})));
  Sensors.MultiSensor_Tp multiSensor_Tp(
    redeclare package Medium = RefrigerantMedium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{18,-26},{38,-6}})));
  Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = RefrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{18,-36},{38,-16}})));
  Sensors.MultiSensor_Tp multiSensor_Tp1(
    redeclare package Medium = RefrigerantMedium,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputPressure=true,
    filter_output=true) annotation (Placement(transformation(extent={{96,16},{116,36}})));
  Sensors.SingleSensorSelect singleSensorSelect1(
    redeclare package Medium = RefrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{80,6},{60,26}})));
  Sensors.MultiSensor_Tp multiSensor_Tp2(
    redeclare package Medium = RefrigerantMedium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-18,16},{-38,36}})));
  Sensors.SingleSensorSelect singleSensorSelect2(
    redeclare package Medium = RefrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-18,6},{-38,26}})));
  Sensors.MultiSensor_Tp multiSensor_Tp3(
    redeclare package Medium = RefrigerantMedium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-84,28},{-104,48}})));
  Sensors.SingleSensorSelect singleSensorSelect3(
    redeclare package Medium = RefrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-84,16},{-104,36}})));
  Sensors.MultiSensor_Tp multiSensor_Tp4(
    redeclare package Medium = RefrigerantMedium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-20,-26},{-40,-6}})));
  Sensors.SingleSensorSelect singleSensorSelect4(
    redeclare package Medium = RefrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-20,-36},{-40,-16}})));
  Sensors.SingleFlowSensor singleFlowSensor(
    redeclare package Medium = RefrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={90,42})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(
    redeclare package Medium = RefrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-20,-46},{-40,-26}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(
    redeclare package Medium = RefrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{18,-46},{38,-26}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality2(
    redeclare package Medium = RefrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{18,36},{38,56}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality3(
    redeclare package Medium = RefrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-18,-6},{-38,14}})));
  Modelica.Blocks.Sources.RealExpression superheating_setpoint1(y=sensorEvaporatorSuperheating.value)
    annotation (Placement(transformation(extent={{-190,-28},{-170,-8}})));
  Sensors.TwoPhaseSensorSelect sensorEvaporatorSuperheating(
    redeclare package Medium = RefrigerantMedium,
    outputValue=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K)
    annotation (Placement(transformation(extent={{18,-12},{38,8}})));
  Sensors.TwoPhaseSensorSelect sensorCondenserSubcooling(
    redeclare package Medium = RefrigerantMedium,
    outputValue=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K)
    annotation (Placement(transformation(extent={{-18,30},{-38,50}})));
  Processes.Compressor compressor(
    redeclare package Medium = RefrigerantMedium,
    omega_from_input=true,
    redeclare function dp_tau_compressor =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        kappaFromMedia=false,
        kappa_fixed=1.13,
        eta=0.8))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,0})));
  Modelica.Blocks.Continuous.PI PI_Valve(
    k=-0.1,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=-5,
    y_start=0.15)
    annotation (Placement(transformation(extent={{-130,-10},{-110,10}})));
  Modelica.Blocks.Math.Feedback feedback_valve
    annotation (Placement(transformation(extent={{-162,-10},{-142,10}})));
  Modelica.Blocks.Sources.RealExpression superheating_setpoint2(y=5)
    annotation (Placement(transformation(extent={{-190,-10},{-170,10}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderValve(
    k=1,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0.15) annotation (Placement(transformation(extent={{-102,-6},{-90,6}})));
  ThermofluidStream.Utilities.showRealValue coolingPower(
    use_numberPort=false,
    description="Cooling Power",
    number=evaporator.inletB.m_flow*(evaporator.outletB.state.h - evaporator.inletB.state.h))
    annotation (Placement(transformation(extent={{-164,-134},{-22,-98}})));
  ThermofluidStream.Utilities.showRealValue compressorPower(
    use_numberPort=false,
    description="power",
    number=compressor.W_t) annotation (Placement(transformation(extent={{46,-12},{80,8}})));
  ThermofluidStream.Utilities.showRealValue COP(
    use_numberPort=false,
    description="COP",
    number=(evaporator.inletB.m_flow*(evaporator.outletB.state.h - evaporator.inletB.state.h))/compressor.W_t,
    significantDigits=3) annotation (Placement(transformation(extent={{-104,-134},{38,-98}})));
  ThermofluidStream.Utilities.showRealValue superheating(
    use_numberPort=false,
    description="Superheating",
    number=sensorEvaporatorSuperheating.value,
    significantDigits=3) annotation (Placement(transformation(extent={{-44,-134},{98,-98}})));
  ThermofluidStream.Utilities.showRealValue subcooling(
    use_numberPort=false,
    description="Subcooling",
    number=sensorCondenserSubcooling.value,
    significantDigits=3) annotation (Placement(transformation(extent={{16,-134},{158,-98}})));
  Sensors.SingleSensorSelect singleSensorSelect5(
    redeclare package Medium = RefrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{52,-46},{72,-26}})));
  Modelica.Blocks.Continuous.LimPID PI_CompressorTemperature(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=300,
    Ti=3,
    yMax=-0.001,
    yMin=-38,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=-4)
    annotation (Placement(transformation(extent={{204,-10},{184,10}})));
  Modelica.Blocks.Math.Gain gain(k=1)
    annotation (Placement(transformation(extent={{120,-6},{108,6}})));
  Modelica.Blocks.Sources.Step step(
    height=-15,
    offset=25 + 273.15,
    startTime=500) annotation (Placement(transformation(extent={{-170,56},{-150,76}})));
  Modelica.Blocks.Sources.Step step1(
    height=1,
    offset=1,
    startTime=1200)
    annotation (Placement(transformation(extent={{202,56},{182,76}})));
  Modelica.Blocks.Sources.Step target_step(
    height=-7,
    offset=7,
    startTime=900) annotation (Placement(transformation(extent={{238,-10},{218,10}})));
  Modelica.Blocks.Continuous.LimPID PI_CompressorPressure(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2,
    Ti=0.3,
    yMax=10000,
    yMin=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=3000)
    annotation (Placement(transformation(extent={{148,10},{128,-10}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{172,-6},{160,6}})));
  inner DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{-180,-128},{-160,-108}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{182,-158},{238,-102}})));
equation
  connect(condenser.outletB, receiver.inlet) annotation (Line(
      points={{-8,54},{-24,54}},
      color={28,108,200},
      thickness=0.5));
  connect(controlValve.inlet, receiver.outlet) annotation (Line(
      points={{-64,10},{-64,54},{-44,54}},
      color={28,108,200},
      thickness=0.5));
  connect(controlValve.outlet, evaporator.inletB)
    annotation (Line(
      points={{-64,-10},{-64,-46},{-10,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-74,66},{-66,66}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletA, multiSensor_Tpm.inlet) annotation (Line(
      points={{12,66},{36,66}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, multiSensor_Tpm.outlet) annotation (Line(
      points={{70,66},{56,66}},
      color={28,108,200},
      thickness=0.5));
  connect(limiter.y, sink.p0_var)
    annotation (Line(points={{93.4,66},{82,66}}, color={0,0,127}));
  connect(limiter.u, PI.y)
    annotation (Line(points={{107.2,66},{117,66}}, color={0,0,127}));
  connect(feedback.y, PI.u)
    annotation (Line(points={{149,66},{140,66}}, color={0,0,127}));
  connect(feedback.u2, multiSensor_Tpm.m_flow_out) annotation (Line(points={{158,74},{158,88},{64,88},{64,70},{54.2,70}},
                                                 color={0,0,127}));
  connect(source1.outlet, flowResistance1.inlet) annotation (Line(
      points={{90,-58},{82,-58}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{-74,-58},{-46,-58}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletA, multiSensor_Tpm1.inlet)
    annotation (Line(
      points={{-10,-58},{-26,-58}},
      color={28,108,200},
      thickness=0.5));
  connect(limiter1.y, sink1.p0_var)
    annotation (Line(points={{-97.4,-58},{-86,-58}}, color={0,0,127}));
  connect(limiter1.u, PI1.y)
    annotation (Line(points={{-111.2,-58},{-121,-58}}, color={0,0,127}));
  connect(PI1.u, feedback1.y)
    annotation (Line(points={{-144,-58},{-155,-58}}, color={0,0,127}));
  connect(feedback1.u1, refFlow_setPoint1.y)
    annotation (Line(points={{-172,-58},{-183,-58}}, color={0,0,127}));
  connect(feedback1.u2, multiSensor_Tpm1.m_flow_out) annotation (Line(points={{-164,-66},{-164,-80},{-54,-80},{-54,-62},{-44.2,-62}},
                                                               color={0,0,127}));
  connect(evaporator.inletA, multiSensor_Tpm2.outlet) annotation (Line(
      points={{10,-58},{30,-58}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{62,-58},{50,-58}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.inletA, multiSensor_Tpm3.outlet) annotation (Line(
      points={{-8,66},{-18,66}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{-46,66},{-38,66}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp.inlet, evaporator.outletB)
    annotation (Line(
      points={{18,-16},{14,-16},{14,-46},{10,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, evaporator.outletB)
    annotation (Line(
      points={{18,-26},{14,-26},{14,-46},{10,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp2.inlet, condenser.outletB)
    annotation (Line(
      points={{-18,26},{-14,26},{-14,54},{-8,54}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, condenser.outletB)
    annotation (Line(
      points={{-18,16},{-14,16},{-14,54},{-8,54}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, controlValve.inlet) annotation (Line(
      points={{-84,26},{-64,26},{-64,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp3.inlet, controlValve.inlet) annotation (Line(
      points={{-84,38},{-64,38},{-64,10}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect4.inlet, evaporator.inletB)
    annotation (Line(
      points={{-20,-26},{-14,-26},{-14,-46},{-10,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp4.inlet, evaporator.inletB)
    annotation (Line(
      points={{-20,-16},{-14,-16},{-14,-46},{-10,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, evaporator.inletB)
    annotation (Line(
      points={{-20,-36},{-14,-36},{-14,-46},{-10,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, evaporator.outletB)
    annotation (Line(
      points={{18,-36},{14,-36},{14,-46},{10,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality2.inlet, condenser.inletB)
    annotation (Line(
      points={{18,46},{14,46},{14,54},{12,54}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality3.inlet, condenser.outletB)
    annotation (Line(
      points={{-18,4},{-14,4},{-14,54},{-8,54}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorEvaporatorSuperheating.inlet, evaporator.outletB)
    annotation (Line(
      points={{18,-2},{14,-2},{14,-46},{10,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorCondenserSubcooling.inlet, condenser.outletB)
    annotation (Line(
      points={{-18,40},{-14,40},{-14,54},{-8,54}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp1.inlet, singleFlowSensor.inlet)
    annotation (Line(
      points={{96,26},{90,26},{90,32}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, singleFlowSensor.inlet) annotation (Line(
      points={{90,10},{90,32}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, compressor.outlet)
    annotation (Line(
      points={{80,16},{90,16},{90,10}},
      color={28,108,200},
      thickness=0.5));
  connect(feedback_valve.y, PI_Valve.u) annotation (Line(points={{-143,0},{-132,0}}, color={0,0,127}));
  connect(superheating_setpoint2.y, feedback_valve.u1) annotation (Line(points={{-169,0},{-160,0}}, color={0,0,127}));
  connect(superheating_setpoint1.y, feedback_valve.u2) annotation (Line(points={{-169,-18},{-152,-18},{-152,-8}}, color={0,0,127}));
  connect(firstOrderValve.u, PI_Valve.y) annotation (Line(points={{-103.2,0},{-109,0}}, color={0,0,127}));
  connect(PI_CompressorTemperature.u_m, multiSensor_Tpm1.T_out)
    annotation (Line(points={{194,-12},{194,-90},{-46,-90},{-46,-74},{-44.2,-74}},
                                                                       color={0,0,127}));
  connect(step.y, source.T0_var) annotation (Line(points={{-149,66},{-86,66}}, color={0,0,127}));
  connect(firstOrderValve.y, controlValve.u_in) annotation (Line(points={{-89.4,0},{-72,0}}, color={0,0,127}));
  connect(singleFlowSensor.outlet, condenser.inletB) annotation (Line(
      points={{90,52},{90,54},{12,54}},
      color={28,108,200},
      thickness=0.5));
  connect(gain.u, PI_CompressorPressure.y) annotation (Line(points={{121.2,0},{127,0}}, color={0,0,127}));
  connect(compressor.omega_input, gain.y) annotation (Line(points={{102,-5.55112e-16},{104,-5.55112e-16},{104,0},{107.4,0}}, color={0,0,127}));
  connect(multiSensor_Tp1.p_out, PI_CompressorPressure.u_m) annotation (Line(points={{114.2,22},{138,22},{138,12}},
                                                                                                                  color={0,0,127}));
  connect(PI_CompressorPressure.u_s, gain1.y) annotation (Line(points={{150,0},{159.4,0}}, color={0,0,127}));
  connect(PI_CompressorTemperature.y, gain1.u) annotation (Line(points={{183,0},{173.2,0}}, color={0,0,127}));
  connect(target_step.y, PI_CompressorTemperature.u_s) annotation (Line(points={{217,0},{206,0}}, color={0,0,127}));
  connect(feedback.u1, step1.y) annotation (Line(points={{166,66},{181,66}}, color={0,0,127}));
  connect(compressor.inlet, evaporator.outletB)
    annotation (Line(
      points={{90,-10},{90,-46},{10,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect5.inlet, evaporator.outletB)
    annotation (Line(
      points={{52,-36},{48,-36},{48,-46},{10,-46}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=1500,
      Tolerance=1e-6,
      Interval=1.5,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-220,-160},{240,100}})),
    Documentation(info="<html>
<p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end VaporCycle;
