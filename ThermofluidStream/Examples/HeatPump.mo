within ThermofluidStream.Examples;
model HeatPump
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.XRGMedia.R1234yf_ph constrainedby Media.myMedia.Interfaces.PartialMedium
                                           "Refrigerant Medium"
    annotation(choicesAllMatching=true);
  replaceable package Air = Media.myMedia.Air.DryAirNasa constrainedby Media.myMedia.Interfaces.PartialMedium
                                           "Air Medium"
    annotation(choicesAllMatching=true);

  HeatExchangers.DiscretizedCounterFlowHEX condenser(
    redeclare package MediumA = Air,
    redeclare package MediumB = Medium,
    redeclare model ConductionElementA =
        HeatExchangers.Internal.ConductionElementHEX,
    redeclare model ConductionElementB =
        HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=false,
    nCells=10,
    A=10,
    V_Hex(displayUnit="l"),
    k_wall=150) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-80,82})));
  HeatExchangers.DiscretizedCounterFlowHEX evaporator(
    redeclare package MediumA = Air,
    redeclare package MediumB = Medium,
    redeclare model ConductionElementA =
        HeatExchangers.Internal.ConductionElementHEX,
    redeclare model ConductionElementB =
        HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=false,
    nCells=10,
    A=10,
    V_Hex(displayUnit="l") = 0.001,
    k_wall=150) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,-80})));
  Processes.Compressor compressor(
    redeclare package Medium = Medium,
    L=1e6,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    omega_from_input=false,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initPhi=true,
    redeclare function dp_tau_compressor =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=200,
        m_flow_ref=1e-2,
        eta=0.8))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));
  FlowControl.BasicControlValve controlValve(
    redeclare package Medium = Medium,
    L=5000,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    invertInput=true,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.Kvs,
    Kvs(displayUnit="m3/s") = 0.18,
    m_flow_ref_set=0.001)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-160,0})));
  Utilities.Receiver receiver(
    redeclare package Medium = Medium,
    V_par(displayUnit="l") = 0.01,
    p_start=420000,
    init_method=ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator.h,
    h_0=220e3)
    annotation (Placement(transformation(extent={{-120,66},{-140,86}})));
  Boundaries.Sink sink(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{-20,78},{0,98}})));
  Boundaries.Source source(redeclare package Medium = Air,
    T0_par=293.15,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-160,86},{-140,106}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Air,
    r=1,
    l=0.5,
    L_value=100,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.galvanizedIron))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,96})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Air,
    r=1,
    l=0.5,
    L_value=100,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.galvanizedIron))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-40,-120})));
  Processes.Fan fan(
    redeclare package Medium = Air,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_from_input=true,
    redeclare function dp_tau_fan =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (omega_ref=100))
    annotation (Placement(transformation(extent={{-60,98},{-40,78}})));
  Processes.Fan fan1(
    redeclare package Medium = Air,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_from_input=true,
    redeclare function dp_tau_fan =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (omega_ref=100)) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-110,-86})));
  Boundaries.Source source1(
    redeclare package Medium = Air,
    temperatureFromInput=true,
    T0_par=268.15,
    p0_par=100000) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-120})));
  Boundaries.Sink sink1(
    redeclare package Medium = Air) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-150,-86})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=250)
    annotation (Placement(transformation(extent={{-70,-120},{-90,-100}})));
  Modelica.Blocks.Sources.Step step1(
    height=-200,
    offset=250,
    startTime=800)
    annotation (Placement(transformation(extent={{-122,130},{-102,150}})));
  inner DropOfCommons dropOfCommons(
    assertionLevel = AssertionLevel.warning,
    m_flow_reg=0.001)
    annotation (Placement(transformation(extent={{152,130},{172,150}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-62,-74},{-42,-54}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality2(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-56,34},{-36,54}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality3(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-104,34},{-84,54}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality4(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-144,34},{-124,54}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality6(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-114,-74},{-94,-54}})));
  Sensors.SingleFlowSensor singleFlowSensor(
    redeclare package Medium = Medium,
    digits=4,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps) annotation (Placement(transformation(extent={{-20,86},{-40,66}})));
  Sensors.MultiSensor_Tp multiSensor_Tp(
    redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-114,-64},{-94,-44}})));
  Sensors.MultiSensor_Tp multiSensor_Tp1(
    redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-144,44},{-124,64}})));
  Sensors.MultiSensor_Tp multiSensor_Tp2(
    redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-104,44},{-84,64}})));
  Sensors.MultiSensor_Tp multiSensor_Tp3(
    redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-56,44},{-36,64}})));
  Sensors.MultiSensor_Tp multiSensor_Tp4(
    redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-62,-64},{-42,-44}})));
  Utilities.Accumulator accumulator(
    redeclare package Medium = Medium,
    useHeatport=true,
    U=300,
    V_par(displayUnit="l") = 0.001,
    p_start=420000,
    init_method=ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator.l,
    l_0=0)
    annotation (Placement(transformation(extent={{-40,-84},{-20,-64}})));
  Sensors.MultiSensor_Tp multiSensor_Tp5(
    redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{4,-64},{24,-44}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{4,-74},{24,-54}})));
  Sensors.SingleSensorSelect singleSensorSelect2(
    redeclare package Medium = Air,
    digits=1,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C) annotation (Placement(transformation(extent={{-10,100},{10,120}})));
  Sensors.SingleSensorSelect singleSensorSelect3(
    redeclare package Medium = Air,
    digits=1,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C) annotation (Placement(transformation(extent={{-120,
            108},{-100,128}})));
  Sensors.SingleSensorSelect singleSensorSelect4(
    redeclare package Medium = Air,
    digits=1,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C) annotation (Placement(transformation(extent={{-12,-150},{8,-130}})));
  Sensors.SingleSensorSelect singleSensorSelect5(
    redeclare package Medium = Air,
    digits=1,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C) annotation (Placement(transformation(extent={{-124,-128},{-104,-108}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
    C=5,
    T(start=283.53),
    der_T(fixed=true))
    annotation (Placement(transformation(extent={{-40,-90},{-20,-110}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality8(
    redeclare package Medium = Medium,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K,
    filter_output=true) annotation (Placement(transformation(extent={{-62,-50},{-42,-30}})));
  Modelica.Blocks.Continuous.LimPID PI(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=0.3,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1)
    annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
  Modelica.Blocks.Sources.Constant const(k=5) annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
  Modelica.Blocks.Continuous.LimPID PI1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.005,
    Ti=20,
    yMax=1,
    yMin=0.0001,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    y_start=0.0001)
    annotation (Placement(transformation(extent={{124,10},{104,-10}})));
  Modelica.Blocks.Sources.Step step(
    height=10,
    offset=25,
    startTime=500) annotation (Placement(transformation(extent={{168,-10},{148,10}})));
  Modelica.Blocks.Continuous.LimPID PI2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=10,
    Ti=0.5,
    yMax=10,
    yMin=-10,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    y_start=0) annotation (Placement(transformation(extent={{82,-10},{62,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(transformation(extent={{44,-10},{24,10}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(
    k=1,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(transformation(extent={{-78,130},{-58,150}})));
  Modelica.Blocks.Sources.Step step2(
    height=-35,
    offset=10 + 273.15,
    startTime=300) annotation (Placement(transformation(extent={{62,-136},{42,-116}})));
  ThermofluidStream.Utilities.showRealValue showRealValue(
    use_numberPort=false,
    description="COP",
    number=condenser.Q_flow_A/max(0.00001, compressor.W_t)) annotation (Placement(transformation(extent={{80,-94},{154,-56}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{142,-158},{198,-102}})));
equation
  connect(source1.outlet, flowResistance2.inlet) annotation (Line(
      points={{-10,-120},{-30,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, evaporator.inletA)
    annotation (Line(
      points={{-50,-120},{-60,-120},{-60,-86},{-70,-86}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletA, fan1.inlet) annotation (Line(
      points={{-90,-86},{-100,-86}},
      color={28,108,200},
      thickness=0.5));
  connect(fan1.outlet, sink1.inlet) annotation (Line(
      points={{-120,-86},{-140,-86}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance1.inlet) annotation (Line(
      points={{-140,96},{-120,96}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, condenser.inletA) annotation (Line(
      points={{-100,96},{-94,96},{-94,88},{-90,88}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletA, fan.inlet) annotation (Line(
      points={{-70,88},{-60,88}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.outlet, sink.inlet) annotation (Line(
      points={{-40,88},{-20,88}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression2.y, fan1.omega_input)
    annotation (Line(points={{-91,-110},{-110,-110},{-110,-98}},
                                                            color={0,0,127}));
  connect(condenser.outletB, receiver.inlet) annotation (Line(
      points={{-90,76},{-120,76}},
      color={28,108,200},
      thickness=0.5));
  connect(receiver.outlet, controlValve.inlet) annotation (Line(
      points={{-140,76},{-160,76},{-160,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality3.inlet, receiver.inlet) annotation (Line(
      points={{-104,44},{-110,44},{-110,76},{-120,76}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality4.inlet, controlValve.inlet) annotation (Line(
      points={{-144,44},{-150,44},{-150,54},{-160,54},{-160,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp1.inlet, controlValve.inlet) annotation (Line(
      points={{-144,54},{-160,54},{-160,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp2.inlet, receiver.inlet) annotation (Line(
      points={{-104,54},{-110,54},{-110,76},{-120,76}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.inletB, singleFlowSensor.outlet) annotation (Line(
      points={{-70,76},{-40,76}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletB, accumulator.inlet) annotation (Line(
      points={{-70,-74},{-40,-74}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp3.inlet, singleFlowSensor.outlet) annotation (Line(
      points={{-56,54},{-62,54},{-62,76},{-40,76}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality2.inlet, singleFlowSensor.outlet) annotation (Line(
      points={{-56,44},{-62,44},{-62,76},{-40,76}},
      color={28,108,200},
      thickness=0.5));
  connect(accumulator.outlet, compressor.inlet) annotation (Line(
      points={{-20,-74},{0,-74},{0,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, accumulator.inlet) annotation (Line(
      points={{-62,-64},{-66,-64},{-66,-74},{-40,-74}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp4.inlet, accumulator.inlet) annotation (Line(
      points={{-62,-54},{-66,-54},{-66,-74},{-40,-74}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, compressor.inlet) annotation (Line(
      points={{4,-64},{0,-64},{0,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp5.inlet, compressor.inlet) annotation (Line(
      points={{4,-54},{0,-54},{0,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, sink.inlet)
    annotation (Line(
      points={{-10,110},{-28,110},{-28,88},{-20,88}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, flowResistance1.inlet)
    annotation (Line(
      points={{-120,118},{-126,118},{-126,96},{-120,96}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect4.inlet, flowResistance2.inlet)
    annotation (Line(
      points={{-12,-140},{-24,-140},{-24,-120},{-30,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect5.inlet, sink1.inlet)
    annotation (Line(
      points={{-124,-118},{-130,-118},{-130,-86},{-140,-86}},
      color={28,108,200},
      thickness=0.5));
  connect(heatCapacitor.port, accumulator.heatPort) annotation (Line(points={{-30,-90},{-30,-82}}, color={191,0,0}));
  connect(sensorVaporQuality8.inlet, accumulator.inlet)
    annotation (Line(
      points={{-62,-40},{-66,-40},{-66,-74},{-40,-74}},
      color={28,108,200},
      thickness=0.5));
  connect(const.y, PI.u_s) annotation (Line(points={{-71,0},{-88,0}}, color={0,0,127}));
  connect(multiSensor_Tp.inlet, evaporator.inletB)
    annotation (Line(
      points={{-114,-54},{-120,-54},{-120,-74},{-90,-74}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality6.inlet, evaporator.inletB)
    annotation (Line(
      points={{-114,-64},{-120,-64},{-120,-74},{-90,-74}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, singleFlowSensor.inlet)
    annotation (Line(
      points={{0,10},{0,76},{-20,76}},
      color={28,108,200},
      thickness=0.5));
  connect(controlValve.outlet, evaporator.inletB)
    annotation (Line(
      points={{-160,-10},{-160,-74},{-90,-74}},
      color={28,108,200},
      thickness=0.5));
  connect(PI.y, controlValve.u_in) annotation (Line(points={{-111,0},{-152,0}}, color={0,0,127}));
  connect(step.y, PI1.u_s) annotation (Line(points={{147,0},{126,0}}, color={0,0,127}));
  connect(torque.flange, compressor.flange) annotation (Line(points={{24,0},{10,0}}, color={0,0,0}));
  connect(PI2.y, torque.tau) annotation (Line(points={{61,0},{46,0}}, color={0,0,127}));
  connect(compressor.output_val, PI2.u_m) annotation (Line(points={{11,6},{26,6},{26,-26},{72,-26},{72,-12}},   color={0,0,127}));
  connect(PI2.u_s, PI1.y) annotation (Line(points={{84,0},{103,0}}, color={0,0,127}));
  connect(step1.y, firstOrder2.u) annotation (Line(points={{-101,140},{-80,140}},
                                                                               color={0,0,127}));
  connect(fan.omega_input, firstOrder2.y) annotation (Line(points={{-50,100},{-50,140},{-57,140}},
                                                                                                color={0,0,127}));
  connect(step2.y, source1.T0_var) annotation (Line(points={{41,-126},{22,-126},{22,-120},{2,-120}},
                                                                                 color={0,0,127}));
  connect(singleSensorSelect2.value_out, PI1.u_m) annotation (Line(points={{8.2,110},{114,110},{114,12}},color={0,0,127}));
  connect(sensorVaporQuality8.value_out, PI.u_m) annotation (Line(points={{-44,-40},{-36,-40},{-36,-18},{-100,-18},{-100,-12}},
                                                                                                            color={0,0,127}));
  annotation (experiment(StopTime=2500, Tolerance=1e-6, Interval=2.5),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-160},{200,160}})),
    Documentation(info="<html>
      <p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
      </html>"));
end HeatPump;
