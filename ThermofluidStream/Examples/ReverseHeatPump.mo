within ThermofluidStream.Examples;
model ReverseHeatPump
  extends Modelica.Icons.Example;

  parameter Boolean switchDuringSimulation = true;
  parameter Boolean heatingMode = false annotation(Dialog(enable = not switchDuringSimulation));

  replaceable package secondaryMedium = myMedia.Air.DryAirNasa
    constrainedby ThermofluidStream.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching=true);

  replaceable package refrigerantMedium = myMedia.R134a.R134a_ph
    constrainedby ThermofluidStream.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching=true);

  Processes.Compressor compressor(
    redeclare package Medium = refrigerantMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.none,
    omega_from_input=true,
    redeclare function dp_tau_compressor =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        eta=0.8,
        kappaFromMedia=false,
        kappa_fixed=1.13))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,14})));
  Undirected.HeatExchangers.DiscretizedHEX discretizedHEX(
    redeclare package MediumAir = secondaryMedium,
    redeclare package MediumRefrigerant = refrigerantMedium,
    initRef=ThermofluidStream.Undirected.HeatExchangers.Internal.InitializationMethodsCondElementHEX.fore,
    nCells=5,
    initializeMassFlow=false,
    m_flow_0=0,
    k_wall=300) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-76,92})));

  Undirected.HeatExchangers.DiscretizedHEX discretizedHEX1(
    redeclare package MediumAir = secondaryMedium,
    redeclare package MediumRefrigerant = refrigerantMedium,
    initRef=ThermofluidStream.Undirected.HeatExchangers.Internal.InitializationMethodsCondElementHEX.rear,
    nCells=5,
    initializeMassFlow=false,
    m_flow_0=0,
    k_wall=300) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={76,90})));

  FlowControl.BasicControlValve               valveCompressorOutletCooling(
    redeclare package Medium = refrigerantMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.none,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.m_flow_set,
    redeclare function valveCharacteristics =
        FlowControl.Internal.ControlValve.linearCharacteristics,
    m_flow_ref_set=0.2) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-26,40})));
  FlowControl.BasicControlValve               valveCompressorOutletHeating(
    redeclare package Medium = refrigerantMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.none,
    invertInput=true,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.m_flow_set,
    redeclare function valveCharacteristics =
        FlowControl.Internal.ControlValve.linearCharacteristics,
    m_flow_ref_set=0.2) annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={26,40})));
  Undirected.Topology.JunctionRRF2 junctionRRF2_1(redeclare package Medium =
        refrigerantMedium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={68,40})));
  FlowControl.BasicControlValve               valveCompressorInletHeating(
    redeclare package Medium = refrigerantMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    invertInput=true,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.m_flow_set,
    redeclare function valveCharacteristics =
        FlowControl.Internal.ControlValve.linearCharacteristics,
    m_flow_ref_set=0.2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-68,-6})));
  FlowControl.BasicControlValve               valveCompressorInletCooling(
    redeclare package Medium = refrigerantMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    invertInput=false,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.m_flow_set,
    redeclare function valveCharacteristics =
        FlowControl.Internal.ControlValve.linearCharacteristics,
    m_flow_ref_set=0.2) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={68,-6})));
  Undirected.Boundaries.BoundaryRear boundaryRear(
    redeclare package Medium = secondaryMedium,
    pressureFromInput=true,
    T0_par=303.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-84,158})));
  Undirected.Boundaries.BoundaryFore boundaryFore(
    redeclare package Medium = secondaryMedium,
    T0_par=311.15,
    p0_par=100000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-142,56})));
  Undirected.Boundaries.BoundaryFore boundaryFore1(
    redeclare package Medium = secondaryMedium,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={84,144})));
  Undirected.Processes.FlowResistance flowResistance1(
    redeclare package Medium = secondaryMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
          material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={84,64})));
  Undirected.Boundaries.BoundaryRear boundaryRear1(
    redeclare package Medium = secondaryMedium,
    T0_par=303.15,
    p0_par=100000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={134,54})));
  Topology.SplitterT1 compressorSplitter(redeclare package Medium =
        refrigerantMedium,                                                             L=1e6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,40})));
  Topology.JunctionT1 junctionT1_1(redeclare package Medium = refrigerantMedium, L=1e6)
                                                                                 annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={0,-38})));
  Undirected.Topology.ConnectRearOutlet connectRearOutlet(redeclare package Medium =
               refrigerantMedium, useDefaultStateAsRear=true) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={68,14})));
  Undirected.FlowControl.BasicControlValve TEVcooling(
    redeclare package Medium = refrigerantMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    invertInput=false,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.m_flow_set,
    redeclare function valveCharacteristics =
        FlowControl.Internal.ControlValve.linearCharacteristics,
    m_flow_ref_set=0.2) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={40,180})));

  Utilities.ReceiverUndirected receiver(
    redeclare package Medium = refrigerantMedium,
    p_start=1000000,
    init_method=ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator.h,
    h_0=260e3,
    V_par=0.005) annotation (Placement(transformation(extent={{-10,170},{10,190}})));
  Undirected.Topology.JunctionRFF junctionRFFleft(redeclare package Medium =
        refrigerantMedium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-68,40})));
  Undirected.FlowControl.BasicControlValve TEVheating(
    redeclare package Medium = refrigerantMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    invertInput=false,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.m_flow_set,
    redeclare function valveCharacteristics =
        FlowControl.Internal.ControlValve.linearCharacteristics,
    m_flow_ref_set=0.2) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-40,180})));

  Undirected.Processes.FlowResistance flowResistance(
    redeclare package Medium = secondaryMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
          material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-84,66})));
  Utilities.Accumulator accumulator(
    redeclare package Medium = refrigerantMedium,
    p_start=200000,
    init_method=ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator.h,
    h_0=380e3,
    V_par=0.002) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-10})));
  inner DropOfCommons dropOfCommons(m_flow_reg=0.001) annotation (Placement(transformation(extent={{96,10},{116,30}})));
  Undirected.Topology.ConnectInletFore connectInletFore(redeclare package Medium =
               refrigerantMedium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-44,40})));
  Undirected.Topology.ConnectInletFore connectInletFore1(redeclare package Medium =
               refrigerantMedium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={46,40})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{104,-64},{160,-8}})));
  Undirected.Topology.ConnectRearOutlet connectRearOutlet1(redeclare package Medium =
               refrigerantMedium, useDefaultStateAsRear=true) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-68,14})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = secondaryMedium,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputMassFlowRate=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={92,114})));
  Modelica.Blocks.Continuous.PI PI1(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={116,162})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={130,124})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{100,156},{88,168}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=1)   annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={130,98})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = secondaryMedium,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputMassFlowRate=true) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-92,126})));
  Modelica.Blocks.Continuous.PI PI2(
    k=10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-124,156})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{-112,172},{-100,184}})));
  Modelica.Blocks.Math.Feedback feedback2
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-124,128})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=1)   annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-124,98})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=0, realFalse=1) annotation (Placement(transformation(extent={{-142,-16},{-122,4}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=heatingMode) annotation (Placement(transformation(extent={{-212,-32},{-192,-12}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=1, initType=Modelica.Blocks.Types.Init.InitialState)
                                                        annotation (Placement(transformation(extent={{-110,-16},{-90,4}})));
  Undirected.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect(
    redeclare package Medium2Phase = refrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K,
    outputValue=true,
    filter_output=true) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,66})));

  Undirected.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect1(
    redeclare package Medium2Phase = refrigerantMedium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K,
    outputValue=true,
    filter_output=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-60,66})));

  Modelica.Blocks.Sources.RealExpression realExpression9(y=(1 - booleanToReal.y)*limiterValve.y + booleanToReal.y)
                                                                annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-12,160})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=booleanToReal.y*(limiterValve.y - 1) + 1)
                                                                annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={12,160})));
  Modelica.Blocks.Continuous.PI PI_Valve(
    k=-10,
    T=3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=0.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={18,118})));
  Modelica.Blocks.Math.Feedback feedback_valve
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=0,
        origin={1,101})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=5)   annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-28,102})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={2,80})));
  Modelica.Blocks.Nonlinear.Limiter limiterValve(uMax=1, uMin=0)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={18,140})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=logicalSwitch.y)
                                                                             annotation (Placement(transformation(extent={{-34,54},{-14,74}})));
  Modelica.Blocks.Sources.RealExpression omega_compr(y=3000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-6})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch annotation (Placement(transformation(extent={{-176,-16},{-156,4}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=switchDuringSimulation)
                                                                             annotation (Placement(transformation(extent={{-212,-16},{-192,4}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=50) annotation (Placement(transformation(extent={{-212,8},{-192,28}})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    redeclare package Medium = secondaryMedium,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputMassFlowRate=false) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-112,64})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = secondaryMedium,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputMassFlowRate=false) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={106,62})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    redeclare package Medium = refrigerantMedium,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputMassFlowRate=false) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-60,120})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    redeclare package Medium = refrigerantMedium,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputMassFlowRate=false) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,120})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(
    redeclare package Medium = refrigerantMedium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-50,-38},{-30,-58}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm7(
    redeclare package Medium = refrigerantMedium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{50,-38},{30,-58}})));
  Sensors.SingleSensorSelect singleSensorSelect(redeclare package Medium =
        refrigerantMedium,                                                                    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-14,14})));
equation


  connect(compressor.outlet, compressorSplitter.inlet)
    annotation (Line(
      points={{0,24},{0,30}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT1_1.outlet, accumulator.inlet) annotation (Line(
      points={{0,-28},{0,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(connectInletFore.inlet, valveCompressorOutletCooling.outlet)
    annotation (Line(
      points={{-41,40},{-36,40}},
      color={28,108,200},
      thickness=0.5));
  connect(valveCompressorOutletCooling.inlet, compressorSplitter.outletA)
    annotation (Line(
      points={{-16,40},{-10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(connectInletFore.fore, junctionRFFleft.rear)
    annotation (Line(
      points={{-47,40},{-58,40}},
      color={28,108,200},
      thickness=0.5));
  connect(valveCompressorOutletHeating.inlet, compressorSplitter.outletB)
    annotation (Line(
      points={{16,40},{10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(connectInletFore1.inlet, valveCompressorOutletHeating.outlet)
    annotation (Line(
      points={{43,40},{36,40}},
      color={28,108,200},
      thickness=0.5));
  connect(connectInletFore1.fore, junctionRRF2_1.rearA) annotation (Line(
      points={{49,40},{58,40}},
      color={28,108,200},
      thickness=0.5));
  connect(accumulator.outlet, compressor.inlet) annotation (Line(
      points={{0,0},{0,4}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.rear, discretizedHEX.foreAir) annotation (Line(
      points={{-84,76},{-84,82}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.fore, discretizedHEX1.rearAir) annotation (Line(
      points={{84,74},{84,80}},
      color={28,108,200},
      thickness=0.5));
  connect(TEVcooling.rear, receiver.fore) annotation (Line(
      points={{30,180},{10,180}},
      color={28,108,200},
      thickness=0.5));
  connect(receiver.rear, TEVheating.fore) annotation (Line(
      points={{-10,180},{-30,180}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearOutlet.rear, junctionRRF2_1.fore) annotation (Line(
      points={{68,17},{68,30}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearOutlet.outlet, valveCompressorInletCooling.inlet)
    annotation (Line(
      points={{68,11},{68,4}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionRFFleft.foreA, connectRearOutlet1.rear)
    annotation (Line(
      points={{-68,30},{-68,17}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearOutlet1.outlet, valveCompressorInletHeating.inlet)
    annotation (Line(
      points={{-68,11},{-68,4}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX1.foreAir, multiSensor_Tpm2.rear)
    annotation (Line(
      points={{84,100},{84,104}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.fore, boundaryFore1.rear)
    annotation (Line(
      points={{84,124},{84,134}},
      color={28,108,200},
      thickness=0.5));
  connect(limiter1.u,PI1. y) annotation (Line(points={{101.2,162},{105,162}},        color={0,0,127}));
  connect(multiSensor_Tpm2.m_flow_out,feedback1. u2)
    annotation (Line(points={{88,124},{122,124}},                                    color={0,0,127}));
  connect(PI1.u,feedback1. y) annotation (Line(points={{128,162},{130,162},{130,133}},
                                                                           color={0,0,127}));
  connect(feedback1.u1,realExpression5. y) annotation (Line(points={{130,116},{130,109}},        color={0,0,127}));
  connect(limiter1.y, boundaryFore1.p0_var) annotation (Line(points={{87.4,162},{78,162},{78,146}},
                                                                                             color={0,0,127}));
  connect(boundaryRear.fore, multiSensor_Tpm1.rear)
    annotation (Line(
      points={{-84,148},{-84,136}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.fore, discretizedHEX.rearAir)
    annotation (Line(
      points={{-84,116},{-84,102}},
      color={28,108,200},
      thickness=0.5));
  connect(limiter2.u,PI2. y) annotation (Line(points={{-113.2,178},{-124,178},{-124,167}},color={0,0,127}));
  connect(PI2.u,feedback2. y) annotation (Line(points={{-124,144},{-124,137}},
                                                                             color={0,0,127}));
  connect(feedback2.u2, multiSensor_Tpm1.m_flow_out) annotation (Line(points={{-116,128},{-112,128},{-112,116},{-88,116}},
                                                                                                            color={0,0,127}));
  connect(feedback2.u1,realExpression4. y) annotation (Line(points={{-124,120},{-124,109}},
                                                                                          color={0,0,127}));
  connect(limiter2.y, boundaryRear.p0_var) annotation (Line(points={{-99.4,178},{-78,178},{-78,160}},               color={0,0,127}));
  connect(booleanToReal.y, firstOrder.u) annotation (Line(points={{-121,-6},{-112,-6}},
                                                                                      color={0,0,127}));
  connect(firstOrder.y, valveCompressorInletHeating.u_in) annotation (Line(points={{-89,-6},{-76,-6}},color={0,0,127}));
  connect(firstOrder.y, valveCompressorOutletCooling.u_in)
    annotation (Line(points={{-89,-6},{-84,-6},{-84,-24},{-26,-24},{-26,32}},  color={0,0,127}));
  connect(firstOrder.y, valveCompressorOutletHeating.u_in) annotation (Line(points={{-89,-6},{-84,-6},{-84,-24},{26,-24},{26,32}},  color={0,0,127}));
  connect(firstOrder.y, valveCompressorInletCooling.u_in)
    annotation (Line(points={{-89,-6},{-84,-6},{-84,-24},{40,-24},{40,-6},{60,-6}},color={0,0,127}));
  connect(discretizedHEX.rearRef, twoPhaseSensorSelect1.fore)
    annotation (Line(
      points={{-68,82},{-68,76}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionRFFleft.foreB, twoPhaseSensorSelect1.rear)
    annotation (Line(
      points={{-68,50},{-68,56}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX1.foreRef, twoPhaseSensorSelect.rear)
    annotation (Line(
      points={{68,80},{68,76}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionRRF2_1.rearB, twoPhaseSensorSelect.fore)
    annotation (Line(
      points={{68,50},{68,56}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression8.y, TEVcooling.u_in) annotation (Line(points={{23,160},{40,160},{40,172}}, color={0,0,127}));
  connect(realExpression9.y, TEVheating.u_in) annotation (Line(points={{-23,160},{-40,160},{-40,172}}, color={0,0,127}));
  connect(switch1.y,feedback_valve. u2) annotation (Line(points={{2,86.6},{2,95.4},{1,95.4}},    color={0,0,127}));
  connect(feedback_valve.u1,realExpression6. y) annotation (Line(points={{-4.6,101},{-4,101},{-4,102},{-17,102}},
                                                                                                            color={0,0,127}));
  connect(twoPhaseSensorSelect1.value_out, switch1.u1) annotation (Line(points={{-60,76},{-18,76},{-18,72.8},{-2.8,72.8}}, color={0,0,127}));
  connect(booleanExpression1.y, switch1.u2) annotation (Line(points={{-13,64},{2,64},{2,72.8}}, color={255,0,255}));
  connect(twoPhaseSensorSelect.value_out, switch1.u3) annotation (Line(points={{60,56},{6.8,56},{6.8,72.8}}, color={0,0,127}));
  connect(PI_Valve.y, limiterValve.u) annotation (Line(points={{18,129},{18,132.8}}, color={0,0,127}));
  connect(feedback_valve.y, PI_Valve.u) annotation (Line(points={{7.3,101},{18,101},{18,106}}, color={0,0,127}));
  connect(omega_compr.y, compressor.omega_input) annotation (Line(points={{20,5},{20,14},{10,14}}, color={0,0,127}));
  connect(booleanToReal.u, logicalSwitch.y) annotation (Line(points={{-144,-6},{-155,-6}}, color={255,0,255}));
  connect(logicalSwitch.u3, booleanExpression.y) annotation (Line(points={{-178,-14},{-184,-14},{-184,-22},{-191,-22}}, color={255,0,255}));
  connect(logicalSwitch.u2, booleanExpression2.y) annotation (Line(points={{-178,-6},{-191,-6}}, color={255,0,255}));
  connect(booleanStep.y, logicalSwitch.u1) annotation (Line(points={{-191,18},{-184,18},{-184,2},{-178,2}}, color={255,0,255}));
  connect(boundaryFore.rear, multiSensor_Tpm3.fore) annotation (Line(
      points={{-132,56},{-122,56}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.rear, flowResistance.fore) annotation (Line(
      points={{-102,56},{-84,56}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear1.fore, multiSensor_Tpm4.rear) annotation (Line(
      points={{124,54},{116,54}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.rear, multiSensor_Tpm4.fore) annotation (Line(
      points={{84,54},{96,54}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX.foreRef, multiSensor_Tpm5.rear)
    annotation (Line(
      points={{-68,102},{-68,110}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.fore, TEVheating.rear)
    annotation (Line(
      points={{-68,130},{-68,180},{-50,180}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX1.rearRef, multiSensor_Tpm6.fore)
    annotation (Line(
      points={{68,100},{68,110}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm6.rear, TEVcooling.fore)
    annotation (Line(
      points={{68,130},{68,180},{50,180}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT1_1.inletB, multiSensor_Tpm.outlet)
    annotation (Line(
      points={{-10,-38},{-30,-38}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.inlet, valveCompressorInletHeating.outlet)
    annotation (Line(
      points={{-50,-38},{-68,-38},{-68,-16}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT1_1.inletA, multiSensor_Tpm7.outlet) annotation (Line(
      points={{10,-38},{30,-38}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm7.inlet, valveCompressorInletCooling.outlet)
    annotation (Line(
      points={{50,-38},{68,-38},{68,-16}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, compressor.outlet) annotation (Line(
      points={{-14,24},{0,24}},
      color={28,108,200},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(extent={{-260,-80},{180,220}}), graphics={
        Polygon(
          points={{48,42},{48,160},{140,210},{140,42},{48,42}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{48,160},{40,160},{140,216},{140,210},{48,160}},
          pattern=LinePattern.None,
          fillColor={162,29,33},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(extent={{-180,206},{-74,42}}, lineColor={28,108,200}),
        Text(
          extent={{-172,202},{-122,190}},
          lineColor={28,108,200},
          textString="Ambient Air")}),
    Icon(coordinateSystem),
    experiment_X(StopTime=100, __Dymola_Algorithm="Dassl"),
    experiment(StopTime=200, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Example of a reversible heatpump for residential air conditioning.  The speciality of this system is, that the direction of the refrigerant flow can be reversed. This means that the heat exchangers can act as evaporator or condenser according to the current cycle operation. Two separate metering devices and a undirected receiver allow to control the superheating temperature after the evaporator in both operating modes. </p>
<p>The flow direction is controlled by a system of valves and undirected junctions. In the parameter settings it can be chosen between &quot;switching during simulation&quot; or manually switching between cooling and heating mode prior to the simulation.</p>
<p><img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Examples.ReverseHeatPump.png\"/></p>
<p>Fig. 1: Reversible heat pump</p>
<p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end ReverseHeatPump;
