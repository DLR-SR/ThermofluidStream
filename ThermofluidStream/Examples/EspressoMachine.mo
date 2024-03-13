within ThermofluidStream.Examples;
model EspressoMachine "Get your simulated coffee!"
  extends Modelica.Icons.Example;

  package Water = Media.myMedia.Water.StandardWater
    "Medium Model for Water"
    annotation (Documentation(info="<html>
<p>
Medium model for water.
</p>
</html>"));

  Utilities.BoilerEspresso boiler(
    redeclare package Medium = Water,
    p_0=3e3,
    V(displayUnit="l") = 0.001,
    x_0=0.001)
    annotation (Placement(transformation(extent={{-80,-10},{-40,30}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Water,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.003,
    l=0.3,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=3e8,
      k2=0))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-60})));
  FlowControl.TanValve tanValve(
    redeclare package Medium = Water,
    invertInput=false,
    relativeLeakiness=1e-8)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-30})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heating_element
    annotation (Placement(transformation(extent={{-110,0},{-90,20}})));
  FlowControl.TanValve tanValve1(redeclare package Medium = Water,
      relativeLeakiness=1e-6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,150})));
  Utilities.SteamSink steamSink1(
    redeclare package Medium = Water,
    p0_par=100000,
    m_flow_animate=1e-3)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,70})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Water,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.003,
    l=0.3,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e7,
      k2=0))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-52,138})));
  Modelica.Blocks.Sources.Pulse steam_valve(
    width=100,
    period=100,
    nperiod=1,
    offset=0,
    startTime=1200)
    annotation (Placement(transformation(extent={{50,140},{30,160}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(
    k=1,
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,150})));
  Boundaries.Volume hex(
    redeclare package Medium = Water,
    useHeatport=true,
    A=0.1,
    p_start=100000,
    V_par(displayUnit="l") = 0.0001,
    medium(h(start=1e4))) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-20,10})));
  Boundaries.Source source1(
    redeclare package Medium = Water,
    T0_par=298.15,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,-120})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Water,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.003,
    l=0.3,
    computeL=true,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e7,
      k2=0))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-60})));
  Utilities.CupSink Tasse(redeclare package Medium = Water)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={130,-170})));
  Utilities.CoffeeStrainer coffeeStrainer(redeclare package Medium = Water)
    annotation (Placement(transformation(
        extent={{-17,-18},{17,18}},
        rotation=270,
        origin={110,-115})));
  Sensors.SingleFlowSensor singleFlowSensor(
    redeclare package Medium = Water,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,-50})));
  FlowControl.TanValve tanValve2(
    redeclare package Medium = Water,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    relativeLeakiness=1e-7)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={110,-80})));
  Modelica.Blocks.Sources.Pulse espressoValve(
    amplitude=1,
    width=30,
    period=100,
    nperiod=2,
    offset=0,
    startTime=1000)
    annotation (Placement(transformation(extent={{26,-90},{46,-70}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{56,-90},{76,-70}})));
  Sensors.MultiSensor_Tp multiSensor_Tp(
    redeclare package Medium = Water,
    outputTemperature=true,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor brewing_head(
    C=500,
    T(start=298.15, fixed=true))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={140,30})));
  Processes.ConductionElement conductionElement1(
    redeclare package Medium = Water,
    V(displayUnit="l") = 1e-05,
    T_0=298.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={110,20})));
  Topology.SplitterT2 splitterT2_1(redeclare package Medium = Water)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={110,-20})));
  Topology.JunctionT2 junctionT2_1(redeclare package Medium = Water)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-20,-20})));
  Processes.Pump pump(
    redeclare package Medium = Water,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_from_input=true,
    omegaStateSelect=StateSelect.never,
    redeclare function dp_tau_pump = Processes.Internal.TurboComponent.dp_tau_nominal_flow (
      k_fric_input=0))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={10,-20})));

  Modelica.Blocks.Continuous.PI PI(
    k=1e2,
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Modelica.Blocks.Math.Gain gain(k=10e-4)
    annotation (Placement(transformation(extent={{34,28},{46,40}})));
  Sensors.SingleFlowSensor singleFlowSensor1(
    redeclare package Medium = Water,
    digits=3,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,-20})));
  Sensors.MultiSensor_Tp multiSensor_Tp1(
    redeclare package Medium = Water,
    outputTemperature=false,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{126,-106},{146,-86}})));
  Processes.Pump pump1(
    J_p=1e-3,redeclare package Medium = Water,
    redeclare function dp_tau_pump =
        Processes.Internal.TurboComponent.dp_tau_nominal_flow (
        parametrizeByDesignPoint=false,
        V_r_input(displayUnit="m3") = 0.1,
        k_p_input=1e6,
        k_fric_input=0),
    enableOutput=false,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initPhi=false,
    omegaStateSelect=StateSelect.default,
    omega_from_input=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-110,-120})));

  Topology.SplitterT2 splitterT2_2(redeclare package Medium = Water)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-60,-120})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={170,20})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature environment(T=298.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={200,20})));
  Sensors.MultiSensor_Tp multiSensor_Tp2(
    redeclare package Medium = Water,
    outputTemperature=false,
    outputPressure=true,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-94,-84},{-114,-64}})));
  Sensors.SingleFlowSensor singleFlowSensor2(
    redeclare package Medium = Water,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,120})));
  Modelica.Blocks.Continuous.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=2,
    yMax=3000,
    yMin=0,
    y_start=0)
    annotation (Placement(transformation(extent={{-150,20},{-130,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=1.25e5)
    annotation (Placement(transformation(extent={{-180,0},{-160,20}})));
  Modelica.Blocks.Continuous.LimPID PID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=1,
    yMax=0.005,
    yMin=0.00001,
    y_start=0)
    annotation (Placement(transformation(extent={{-150,-20},{-130,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=0.3)
    annotation (Placement(transformation(extent={{-180,-40},{-160,-20}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder3(
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-100,-30})));
  Modelica.Blocks.Continuous.LimPID PID3(
    Ti=3,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=.Modelica.Blocks.Types.Init.NoInit,
    k=100,
    yMax=5000,
    yMin=0,
    y_start=0)
    annotation (Placement(transformation(extent={{-170,-90},{-150,-110}})));

  Modelica.Blocks.Sources.RealExpression realExpression3(y=8.5)
    annotation (Placement(transformation(extent={{-200,-90},{-180,-110}})));
  FlowControl.TanValve tanValve6(
    redeclare package Medium = Water,
      relativeLeakiness=1e-6)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-88,150})));
  Utilities.WaterSink waterSink(
    redeclare package Medium = Water,
    p0_par=100000,
    m_flow_animate=2.5e-3)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-88,70})));
  Processes.FlowResistance flowResistance5(
    redeclare package Medium = Water,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.003,
    l=0.3,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e7,
      k2=0))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,138})));
  Modelica.Blocks.Sources.Pulse steam_valve1(
    width=100,
    period=100,
    nperiod=1,
    offset=0,
    startTime=1350)
    annotation (Placement(transformation(extent={{-160,140},{-140,160}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder7(
    k=1,
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{-130,140},{-110,160}})));
  Sensors.SingleFlowSensor singleFlowSensor3(
    redeclare package Medium = Water,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-88,120})));
  Sensors.MultiSensor_Tp multiSensor_Tp3(
    redeclare package Medium = Water,
    outputTemperature=false,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-24,94},{-4,114}})));
  Sensors.MultiSensor_Tp multiSensor_Tp4(
    redeclare package Medium = Water,
    outputTemperature=false,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-96,94},{-116,114}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(
    redeclare package Medium = Water,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-96,84},{-116,104}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(
    redeclare package Medium = Water,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-24,84},{-4,104}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality2(
    redeclare package Medium = Water,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{126,-116},{146,-96}})));
  Sensors.SingleFlowSensor singleFlowSensor5(
    redeclare package Medium = Water,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-60,-90})));
  inner DropOfCommons dropOfCommons(
    assertionLevel = AssertionLevel.warning,
    m_flow_reg=0.5e-5,
    p_min(displayUnit="Pa") = 700)
    annotation (Placement(transformation(extent={{182,82},{202,102}})));
  Topology.SplitterT1 splitterT1_1(redeclare package Medium = Water)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,-140})));
  Utilities.CupSink Tasse1(
    redeclare package Medium = Water, flowResistance(
      initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state))
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={90,-170})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = Water,
    r(displayUnit="mm") = 0.003,
    l=0.2,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e4))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,-20})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{162,142},{218,198}})));
equation
  connect(boiler.heatport_heat, heating_element.port)
    annotation (Line(points={{-72,10},{-90,10}}, color={191,0,0}));
  connect(boiler.steam_out, flowResistance1.inlet) annotation (Line(
      points={{-52,30},{-52,128}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve1.inlet, flowResistance1.outlet) annotation (Line(
      points={{-30,160},{-30,170},{-52,170},{-52,148}},
      color={28,108,200},
      thickness=0.5));
  connect(boiler.heatport_HX, hex.heatPort)
    annotation (Line(points={{-48,10},{-28,10}}, color={191,0,0}));
  connect(singleFlowSensor.outlet, tanValve2.inlet) annotation (Line(
      points={{110,-60},{110,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve2.outlet, coffeeStrainer.inlet) annotation (Line(
      points={{110,-90},{110,-108.2}},
      color={28,108,200},
      thickness=0.5));
  connect(espressoValve.y, firstOrder2.u)
    annotation (Line(points={{47,-80},{54,-80}}, color={0,0,127}));
  connect(tanValve2.u, firstOrder2.y)
    annotation (Line(points={{102,-80},{77,-80}},color={0,0,127}));
  connect(multiSensor_Tp.inlet, hex.outlet) annotation (Line(
      points={{0,30},{-20,30},{-20,20}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletB, singleFlowSensor.inlet) annotation (Line(
      points={{110,-30},{110,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, junctionT2_1.inletB) annotation (Line(
      points={{-20,-50},{-20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(hex.inlet, junctionT2_1.outlet) annotation (Line(
      points={{-20,0},{-20,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, junctionT2_1.inletA) annotation (Line(
      points={{0,-20},{-10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(PI.y, pump.omega_input)
    annotation (Line(points={{19,0},{10,0},{10,-8}},  color={0,0,127}));
  connect(multiSensor_Tp.T_out, gain.u) annotation (Line(points={{18,34},{32.8,34}}, color={0,0,127}));
  connect(feedback.u2, singleFlowSensor1.value_out) annotation (Line(points={{60,-8},{60,-14},{72,-14}}, color={0,0,127}));
  connect(brewing_head.port, conductionElement1.heatPort) annotation (Line(points={{140,20},{120,20}},   color={191,0,0}));
  connect(splitterT2_1.inlet, conductionElement1.outlet)
    annotation (Line(
      points={{110,-10},{110,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp1.inlet, coffeeStrainer.inlet) annotation (Line(
      points={{126,-96},{110,-96},{110,-108.2}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, tanValve.inlet)
    annotation (Line(
      points={{-60,-50},{-60,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(boiler.inlet, tanValve.outlet) annotation (Line(
      points={{-60,-10},{-60,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(gain.y, feedback.u1) annotation (Line(points={{46.6,34},{78,34},{78,0},{68,0}}, color={0,0,127}));
  connect(tanValve1.u, firstOrder1.y) annotation (Line(points={{-22,150},{-11,150}},
                                     color={0,0,127}));
  connect(thermalResistor.port_a, brewing_head.port)
    annotation (Line(points={{160,20},{140,20}}, color={191,0,0}));
  connect(environment.port, thermalResistor.port_b)
    annotation (Line(points={{190,20},{180,20}}, color={191,0,0}));
  connect(tanValve1.outlet, singleFlowSensor2.inlet) annotation (Line(
      points={{-30,140},{-30,130}},
      color={28,108,200},
      thickness=0.5));
  connect(steamSink1.inlet, singleFlowSensor2.outlet) annotation (Line(
      points={{-30,80},{-30,110}},
      color={28,108,200},
      thickness=0.5));
  connect(steam_valve.y, firstOrder1.u)
    annotation (Line(points={{29,150},{12,150}}, color={0,0,127}));
  connect(PI.u, feedback.y)
    annotation (Line(points={{42,0},{51,0}}, color={0,0,127}));
  connect(pump1.outlet, splitterT2_2.inlet) annotation (Line(
      points={{-100,-120},{-70,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.inlet, splitterT2_2.outletB) annotation (Line(
      points={{-20,-70},{-20,-120},{-50,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(heating_element.Q_flow, PID1.y)
    annotation (Line(points={{-110,10},{-129,10}},
                                              color={0,0,127}));
  connect(boiler.p_out, PID1.u_m) annotation (Line(points={{-80,22},{-100,22},{-100,30},{-140,30},{-140,22}},
                                  color={0,0,127}));
  connect(PID1.u_s, realExpression1.y)
    annotation (Line(points={{-152,10},{-159,10}},
                                               color={0,0,127}));
  connect(realExpression2.y, PID2.u_s)
    annotation (Line(points={{-159,-30},{-152,-30}},
                                                  color={0,0,127}));
  connect(PID2.u_m, boiler.y_out)
    annotation (Line(points={{-140,-18},{-140,-10},{-100,-10},{-100,-2},{-80,-2}},
                                                        color={0,0,127}));
  connect(PID2.y, firstOrder3.u)
    annotation (Line(points={{-129,-30},{-112,-30}},
                                                 color={0,0,127}));
  connect(tanValve.u, firstOrder3.y)
    annotation (Line(points={{-68,-30},{-89,-30}},
                                                 color={0,0,127}));
  connect(realExpression3.y, PID3.u_s)
    annotation (Line(points={{-179,-100},{-172,-100}},
                                                     color={0,0,127}));
  connect(PID3.u_m, multiSensor_Tp2.p_out) annotation (Line(points={{-160,-88},{-160,-78},{-112.2,-78}},
                                 color={0,0,127}));
  connect(source1.outlet, pump1.inlet) annotation (Line(
      points={{-130,-120},{-120,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve6.inlet,flowResistance5. outlet) annotation (Line(
      points={{-88,160},{-88,170},{-68,170},{-68,148}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve6.u,firstOrder7. y) annotation (Line(points={{-96,150},{-109,150}},
                                     color={0,0,127}));
  connect(tanValve6.outlet,singleFlowSensor3. inlet) annotation (Line(
      points={{-88,140},{-88,130}},
      color={28,108,200},
      thickness=0.5));
  connect(waterSink.inlet, singleFlowSensor3.outlet) annotation (Line(
      points={{-88,80},{-88,110}},
      color={28,108,200},
      thickness=0.5));
  connect(steam_valve1.y, firstOrder7.u)
    annotation (Line(points={{-139,150},{-132,150}},
                                                 color={0,0,127}));
  connect(flowResistance5.inlet, boiler.water_out) annotation (Line(
      points={{-68,128},{-68,30}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp3.inlet, singleFlowSensor2.outlet) annotation (Line(
      points={{-24,104},{-30,104},{-30,110}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp4.inlet, singleFlowSensor3.outlet) annotation (Line(
      points={{-96,104},{-88,104},{-88,110}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, singleFlowSensor3.outlet) annotation (Line(
      points={{-96,94},{-88,94},{-88,110}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality2.inlet, coffeeStrainer.inlet) annotation (Line(
      points={{126,-106},{122,-106},{122,-96},{110,-96},{110,-108.2}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, singleFlowSensor2.outlet) annotation (Line(
      points={{-24,94},{-30,94},{-30,110}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_2.outletA, singleFlowSensor5.inlet) annotation (Line(
      points={{-60,-110},{-60,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(coffeeStrainer.outlet, splitterT1_1.inlet) annotation (Line(
      points={{110,-121.8},{110,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.outletB, Tasse1.inlet) annotation (Line(
      points={{100,-140},{90,-140},{90,-150}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.outletA, Tasse.inlet) annotation (Line(
      points={{120,-140},{130,-140},{130,-150}},
      color={28,108,200},
      thickness=0.5));
  connect(PID3.y, pump1.omega_input) annotation (Line(points={{-149,-100},{-110,-100},{-110,-108}},
                                                                                                 color={0,0,127}));
  connect(multiSensor_Tp2.inlet, splitterT2_2.inlet)
    annotation (Line(
      points={{-94,-74},{-90,-74},{-90,-120},{-70,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor5.outlet, flowResistance.inlet)
    annotation (Line(
      points={{-60,-80},{-60,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletA, singleFlowSensor1.inlet)
    annotation (Line(
      points={{100,-20},{90,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.inlet, flowResistance4.outlet) annotation (Line(
      points={{20,-20},{40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.inlet, singleFlowSensor1.outlet)
    annotation (Line(
      points={{60,-20},{70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement1.inlet, hex.outlet)
    annotation (Line(
      points={{110,30},{110,44},{-20,44},{-20,20}},
      color={28,108,200},
      thickness=0.5));
  annotation(experiment(
      StopTime=1500,
      Tolerance=1e-6,
      Interval=1.5,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-220,-200},{220,200}}), graphics={
        Text(
          extent={{-21,3},{21,-3}},
          textColor={28,108,200},
          origin={-71,83},
          rotation=90,
          textString="boiling water"),
        Text(
          extent={{-20,3},{20,-3}},
          textColor={28,108,200},
          textString="Steam",
          origin={-56,77},
          rotation=90),
        Rectangle(extent={{96,52},{218,-86}}, lineColor={28,108,200}),
        Text(
          extent={{152,-72},{218,-84}},
          textColor={28,108,200},
          textString="Brewing head"),
        Text(
          extent={{66,-172},{158,-184}},
          textColor={28,108,200},
          textString="Coffee strainer and Cups"),
        Rectangle(extent={{62,-110},{162,-184}}, lineColor={28,108,200}),
        Rectangle(extent={{-210,48},{-6,-48}}, lineColor={28,108,200}),
        Text(
          extent={{-208,46},{-116,34}},
          textColor={28,108,200},
          textString="Boiler and Heat Exchanger"),
        Rectangle(extent={{-210,-62},{-80,-148}},lineColor={28,108,200}),
        Text(
          extent={{-116,-134},{-80,-146}},
          textColor={28,108,200},
          textString="Pump"),
        Rectangle(extent={{-176,188},{60,52}}, lineColor={28,108,200}),
        Text(
          extent={{-174,184},{-68,174}},
          textColor={28,108,200},
          textString="Water and Steam Valves")}),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>An espresso in the morning drives out sorrow and concerns. </p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end EspressoMachine;
