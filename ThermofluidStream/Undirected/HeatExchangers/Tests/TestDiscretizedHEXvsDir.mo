within ThermofluidStream.Undirected.HeatExchangers.Tests;
model TestDiscretizedHEXvsDir

  extends Modelica.Icons.Example;

  replaceable package MediumAir = Media.myMedia.Air.DryAirNasa
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (
      choicesAllMatching=true,
      Dialog(group = "Medium definitions"));

  replaceable package MediumRefrigerant = Media.myMedia.R134a.R134a_ph
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (
      choicesAllMatching=true,
      Dialog(group = "Medium definitions"));

  Boundaries.BoundaryRear boundary_rear(
    redeclare package Medium = MediumAir,
    pressureFromInput=true,
    T0_par=311.15) annotation (Placement(transformation(extent={{-114,210},{-94,
            230}})));
  Boundaries.BoundaryFore boundary_fore(
    redeclare package Medium = MediumAir,
    pressureFromInput=true,
    T0_par=303.15,
    p0_par=100000) annotation (Placement(transformation(extent={{62,196},{82,216}})));
  Boundaries.BoundaryFore boundary_fore1(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    pressureFromInput=true,
    h0_par=300e3,
    T0_par=278.15,
    p0_par=400000) annotation (Placement(transformation(extent={{-94,184},{-114,204}})));
  Boundaries.BoundaryRear boundary_rear1(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    pressureFromInput=true,
    h0_par=450e3,
    T0_par=268.15) annotation (Placement(transformation(extent={{96,184},{76,204}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium = MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-50,220},{-30,240}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium = MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputMassFlowRate=true)
    annotation (Placement(transformation(extent={{20,206},{40,226}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumAir,
    m_flow_0=0,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-86,210},{-66,230}})));
  Modelica.Blocks.Sources.Ramp rampPressure(
    height=1e5,
    duration=1,
    offset=1e5,
    startTime=15) annotation (Placement(transformation(extent={{-164,222},{-144,
            242}})));
  inner DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{76,258},{96,278}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-0.5,
    duration=1,
    offset=0.3,
    startTime=15) annotation (Placement(transformation(extent={{-34,126},{-14,146}})));
  DiscretizedCounterFlowHEX discretizedHEXUndir(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX,
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase,
    nCells=10,
    V_Hex(displayUnit="m3"),
    initializeMassFlow=true,
    k_wall=300,
    calculate_efficiency=true)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-2,200})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = MediumRefrigerant,
    m_flow_0=0,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-66,184},{-86,204}})));
  Modelica.Blocks.Continuous.PI PI1(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{96,230},{116,250}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{126,206},{114,218}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{40,230},{60,250}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = MediumRefrigerant,
    temperatureUnit="degC",
    outputMassFlowRate=true)
    annotation (Placement(transformation(extent={{40,194},{20,174}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    redeclare package Medium = MediumRefrigerant, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-30,194},{-50,174}})));
  Modelica.Blocks.Continuous.PI PI(
    k=10000,
    T=0.001,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=300,
    y_start=30e5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={52,136})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={10,136})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=35e5, uMin=1e5)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={86,136})));
  Modelica.Blocks.Sources.Ramp ramp3(
    height=-26e5,
    duration=1,
    offset=30e5,
    startTime=15) annotation (Placement(transformation(extent={{-164,190},{-144,210}})));
  ThermofluidStream.Boundaries.Source sourceA(
    redeclare package Medium = MediumAir,
    T0_par=303.15,
    p0_par=200000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={112,-62})));
  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumAir,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{-46,-72},{-66,-52}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{11,10},{-11,-10}},
        rotation=0,
        origin={31,-72})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    redeclare package Medium = MediumAir,
    digits=3,
    outputMassFlowRate=true,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,-72})));
  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    pressureFromInput=true,
    T0_par=283.15,
    p0_par=200000,
    h0_par=300e3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-58,-20})));
  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 400000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={64,2})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Blocks.Sources.RealExpression refFlow_setPoint1(y=0.2)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=0,
        origin={26,16})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm7(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint2(y=1)
    annotation (Placement(transformation(extent={{-180,-72},{-160,-52}})));
  Modelica.Blocks.Continuous.PI PI2(
    k=10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=40,
    y_start=4e5)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-32,16})));
  Modelica.Blocks.Math.Feedback feedback2
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-4,16})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=10e5, uMin=1e5)
    annotation (Placement(transformation(extent={{6,6},{-6,-6}},
        rotation=90,
        origin={-52,-2})));
  Modelica.Blocks.Continuous.PI PI3(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{-112,-72},{-92,-52}})));
  Modelica.Blocks.Math.Feedback feedback3
    annotation (Placement(transformation(extent={{-140,-72},{-120,-52}})));
  Modelica.Blocks.Nonlinear.Limiter limiter3(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{-76,-68},{-64,-56}})));
  ThermofluidStream.HeatExchangers.DiscretizedCounterFlowHEX evaporator(
    redeclare model ConductionElementB =
        ThermofluidStream.HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    initializeMassFlow=true,
    nCells=10,
    k_wall=300,
    calculate_efficiency=true)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,-56})));
  ThermofluidStream.Processes.FlowResistance flowResistanceA1(
    redeclare package Medium = MediumAir,
    m_flow_0=1,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{90,-72},{70,-52}})));
  ThermofluidStream.Processes.FlowResistance flowResistanceB1(
    redeclare package Medium = MediumRefrigerant,
    m_flow_0=0.3,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={64,-26})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{20,-34},{40,-14}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect1(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-20,-34},{-40,-14}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect sensorVaporQuality(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-20,-22},{-40,-2}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect sensorVaporQuality1(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{20,-22},{40,-2}})));
  ThermofluidStream.Boundaries.Source sourceA1(
    redeclare package Medium = MediumAir,
    T0_par=311.15,
    p0_par=100000)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-112,-168})));
  ThermofluidStream.Boundaries.Sink sinkA1(
    redeclare package Medium = MediumAir,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{102,-178},{122,-158}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm8(
    redeclare package Medium = MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={-37,-158})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm9(
    redeclare package Medium = MediumAir,
    digits=3,
    outputMassFlowRate=true,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={52,-158})));
  ThermofluidStream.Boundaries.Source sourceB1(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    pressureFromInput=true,
    T0_par=283.15,
    p0_par=200000,
    h0_par=450e3)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={80,-206})));
  ThermofluidStream.Boundaries.Sink sinkB1(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 3000000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-76,-228})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm10(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-24,-180},{-44,-200}})));
  Modelica.Blocks.Sources.RealExpression refFlow_setPoint2(y=0.3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-28,-244})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm11(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{40,-180},{20,-200}})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint3(y=1)
    annotation (Placement(transformation(extent={{8,-140},{28,-120}})));
  Modelica.Blocks.Continuous.PI PI4(
    k=10000,
    T=0.001,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=300,
    y_start=30e5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={44,-244})));
  Modelica.Blocks.Math.Feedback feedback4
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={6,-244})));
  Modelica.Blocks.Nonlinear.Limiter limiter4(uMax=35e5, uMin=20e5)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={70,-244})));
  Modelica.Blocks.Continuous.PI PI5(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{108,-140},{128,-120}})));
  Modelica.Blocks.Math.Feedback feedback5
    annotation (Placement(transformation(extent={{68,-140},{88,-120}})));
  Modelica.Blocks.Nonlinear.Limiter limiter5(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{140,-174},{128,-162}})));
  ThermofluidStream.HeatExchangers.DiscretizedCounterFlowHEX condenser(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementB =
        ThermofluidStream.HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=true,
    nCells=10,
    k_wall=300,
    calculate_efficiency=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-2,-174})));
  ThermofluidStream.Processes.FlowResistance flowResistanceA2(
    redeclare package Medium = MediumAir,
    m_flow_0=0.5,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-84,-178},{-64,-158}})));
  ThermofluidStream.Processes.FlowResistance flowResistanceB2(
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
        origin={-76,-202})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect2(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-24,-218},{-44,-198}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect3(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{22,-216},{42,-196}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect sensorVaporQuality2(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-24,-230},{-44,-210}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect sensorVaporQuality3(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{22,-230},{42,-210}})));
  Modelica.Blocks.Sources.Ramp rampMassflow(
    height=-2,
    duration=1,
    offset=1,
    startTime=15) annotation (Placement(transformation(extent={{-6,230},{14,250}})));
equation
  connect(boundary_fore1.rear, flowResistanceB.fore) annotation (Line(
      points={{-94,194},{-86,194}},
      color={28,108,200},
      thickness=0.5));
  connect(PI1.y,limiter1. u) annotation (Line(points={{117,240},{138,240},{138,212},{127.2,212}},
                             color={0,0,127}));
  connect(boundary_fore.p0_var, limiter1.y) annotation (Line(points={{74,212},{113.4,212}},
                                                                                          color={0,0,127}));
  connect(multiSensor_Tpm1.m_flow_out, feedback1.u2) annotation (Line(points={{38.2,210},{50,210},{50,232}},
                                                                                                        color={0,0,127}));
  connect(feedback1.y, PI1.u) annotation (Line(points={{59,240},{94,240}},
                                                                         color={0,0,127}));
  connect(boundary_rear1.fore, multiSensor_Tpm2.rear)
    annotation (Line(
      points={{76,194},{40,194}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.fore, flowResistanceB.rear) annotation (Line(
      points={{-50,194},{-66,194}},
      color={28,108,200},
      thickness=0.5));
  connect(feedback.y,PI. u)
    annotation (Line(points={{19,136},{40,136}}, color={0,0,127}));
  connect(PI.y,limiter. u)
    annotation (Line(points={{63,136},{78.8,136}}, color={0,0,127}));
  connect(limiter.y, boundary_rear1.p0_var) annotation (Line(points={{92.6,136},{114,136},{114,200},{88,200}},color={0,0,127}));
  connect(multiSensor_Tpm2.m_flow_out, feedback.u2) annotation (Line(points={{21.8,190},{10,190},{10,144}},
                                                                                                    color={0,0,127}));
  connect(multiSensor_Tpm1.fore, boundary_fore.rear) annotation (Line(
      points={{40,206},{62,206}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear.fore, flowResistanceA.rear) annotation (Line(
      points={{-94,220},{-86,220}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.rear, flowResistanceA.fore) annotation (Line(
      points={{-50,220},{-66,220}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp1.y, feedback.u1) annotation (Line(points={{-13,136},{2,136}}, color={0,0,127}));
  connect(boundary_fore1.p0_var, ramp3.y) annotation (Line(points={{-106,200},{-143,200}},                       color={0,0,127}));
  connect(sinkA.inlet,multiSensor_Tpm5. outlet) annotation (Line(
      points={{-46,-62},{-40,-62}},
      color={28,108,200},
      thickness=0.5));
  connect(feedback2.y, PI2.u) annotation (Line(points={{-13,16},{-20,16}}, color={0,0,127}));
  connect(PI3.u,feedback3. y)
    annotation (Line(points={{-114,-62},{-121,-62}},
                                                   color={0,0,127}));
  connect(feedback3.u1,airFlow_setPoint2. y)
    annotation (Line(points={{-138,-62},{-159,-62}},
                                                 color={0,0,127}));
  connect(PI3.y,limiter3. u) annotation (Line(points={{-91,-62},{-77.2,-62}},
                             color={0,0,127}));
  connect(sourceA.outlet, flowResistanceA1.inlet) annotation (Line(
      points={{102,-62},{90,-62}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.inlet, flowResistanceA1.outlet)
    annotation (Line(
      points={{42,-62},{70,-62}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, flowResistanceB1.outlet) annotation (Line(
      points={{64,-8},{64,-16}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB1.inlet, multiSensor_Tpm6.outlet)
    annotation (Line(
      points={{64,-36},{64,-50},{40,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet,multiSensor_Tpm7. inlet) annotation (Line(
      points={{-58,-30},{-58,-40},{-44,-40},{-44,-50},{-40,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(PI2.y, limiter2.u) annotation (Line(points={{-43,16},{-52,16},{-52,5.2}}, color={0,0,127}));
  connect(multiSensor_Tpm4.outlet, evaporator.inletA) annotation (Line(
      points={{20,-62},{10,-62}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletA, multiSensor_Tpm5.inlet)
    annotation (Line(
      points={{-10,-62},{-20,-62}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.p0_var,limiter3. y)
    annotation (Line(points={{-58,-62},{-63.4,-62}},
                                                   color={0,0,127}));
  connect(multiSensor_Tpm5.m_flow_out,feedback3. u2) annotation (Line(points={{-38.2,-66},{-42,-66},{-42,-82},{-130,-82},{-130,-70}},
                                                           color={0,0,127}));
  connect(evaporator.outletB, multiSensor_Tpm6.inlet) annotation (Line(
      points={{10,-50},{20,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm7.outlet, evaporator.inletB) annotation (Line(
      points={{-20,-50},{-10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm7.m_flow_out, feedback2.u2) annotation (Line(points={{-21.8,-46},{-4,-46},{-4,8}},
                                                                                                          color={0,0,127}));
  connect(feedback2.u1, refFlow_setPoint1.y) annotation (Line(points={{4,16},{15,16}}, color={0,0,127}));
  connect(sourceB.p0_var, limiter2.y) annotation (Line(points={{-52,-18},{-52,-8.6}}, color={0,0,127}));
  connect(singleSensorSelect.inlet, evaporator.outletB)
    annotation (Line(
      points={{20,-24},{20,-50},{10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, evaporator.inletB)
    annotation (Line(
      points={{-20,-24},{-14,-24},{-14,-50},{-10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, evaporator.inletB)
    annotation (Line(
      points={{-20,-12},{-14,-12},{-14,-50},{-10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, evaporator.outletB)
    annotation (Line(
      points={{20,-12},{20,-50},{10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA1.inlet, multiSensor_Tpm9.outlet) annotation (Line(
      points={{102,-168},{62,-168}},
      color={28,108,200},
      thickness=0.5));
  connect(feedback4.y, PI4.u) annotation (Line(points={{15,-244},{32,-244}}, color={0,0,127}));
  connect(PI5.u,feedback5. y)
    annotation (Line(points={{106,-130},{87,-130}},color={0,0,127}));
  connect(feedback5.u1,airFlow_setPoint3. y)
    annotation (Line(points={{70,-130},{29,-130}},
                                                 color={0,0,127}));
  connect(feedback5.u2,multiSensor_Tpm9. m_flow_out)
    annotation (Line(points={{78,-138},{78,-164},{60.2,-164}},
                                                            color={0,0,127}));
  connect(sinkA1.p0_var, limiter5.y) annotation (Line(points={{114,-168},{127.4,-168}}, color={0,0,127}));
  connect(PI5.y,limiter5. u) annotation (Line(points={{129,-130},{146,-130},{146,-168},{141.2,-168}},
                             color={0,0,127}));
  connect(sourceA1.outlet, flowResistanceA2.inlet) annotation (Line(
      points={{-102,-168},{-84,-168}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm8.inlet, flowResistanceA2.outlet)
    annotation (Line(
      points={{-48,-168},{-64,-168}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm11.outlet, condenser.inletB) annotation (Line(
      points={{20,-180},{8,-180}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletB, multiSensor_Tpm10.inlet)
    annotation (Line(
      points={{-12,-180},{-24,-180}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.inletA, multiSensor_Tpm8.outlet)
    annotation (Line(
      points={{-12,-168},{-26,-168}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletA, multiSensor_Tpm9.inlet) annotation (Line(
      points={{8,-168},{42,-168}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB1.inlet, flowResistanceB2.outlet) annotation (Line(
      points={{-76,-218},{-76,-212}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB2.inlet, multiSensor_Tpm10.outlet)
    annotation (Line(
      points={{-76,-192},{-76,-180},{-44,-180}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB1.outlet, multiSensor_Tpm11.inlet)
    annotation (Line(
      points={{80,-196},{80,-180},{40,-180}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm11.m_flow_out, feedback4.u2) annotation (Line(points={{21.8,-184},{6,-184},{6,-236}},         color={0,0,127}));
  connect(PI4.y, limiter4.u) annotation (Line(points={{55,-244},{62.8,-244}}, color={0,0,127}));
  connect(refFlow_setPoint2.y, feedback4.u1) annotation (Line(points={{-17,-244},{-2,-244}},color={0,0,127}));
  connect(singleSensorSelect2.inlet, condenser.outletB)
    annotation (Line(
      points={{-24,-208},{-20,-208},{-20,-180},{-12,-180}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, condenser.inletB)
    annotation (Line(
      points={{22,-206},{14,-206},{14,-180},{8,-180}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality2.inlet, condenser.outletB)
    annotation (Line(
      points={{-24,-220},{-20,-220},{-20,-180},{-12,-180}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality3.inlet, condenser.inletB)
    annotation (Line(
      points={{22,-220},{14,-220},{14,-180},{8,-180}},
      color={28,108,200},
      thickness=0.5));
  connect(limiter4.y, sourceB1.p0_var) annotation (Line(points={{76.6,-244},{86,-244},{86,-208}}, color={0,0,127}));
  connect(rampPressure.y, boundary_rear.p0_var) annotation (Line(points={{-143,
          232},{-120,232},{-120,226},{-106,226}},                                                                   color={0,0,127}));
  connect(feedback1.u1, rampMassflow.y) annotation (Line(points={{42,240},{15,240}},                   color={0,0,127}));
  connect(discretizedHEXUndir.rearA, multiSensor_Tpm.fore) annotation (Line(
      points={{-12,206},{-12,208},{-30,208},{-30,220}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEXUndir.foreB, multiSensor_Tpm3.rear) annotation (Line(
      points={{-12,194},{-30,194}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEXUndir.rearB, multiSensor_Tpm2.fore) annotation (Line(
      points={{8,194},{20,194}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEXUndir.foreA, multiSensor_Tpm1.rear) annotation (Line(
      points={{8,206},{20,206}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(StopTime=30, Tolerance=1e-6, Interval=0.03, __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-280,-300},{260,300}}),
      graphics={
        Rectangle(extent={{-208,-104},{170,-280}}, lineColor={28,108,200}),
        Text(
          extent={{-192,-106},{-106,-128}},
          textColor={28,108,200},
          textString="Condenser"),
        Text(
          extent={{-192,80},{-106,58}},
          textColor={28,108,200},
          textString="Evaporator"),
        Rectangle(extent={{-208,82},{170,-94}}, lineColor={28,108,200}),
        Text(
          extent={{-192,274},{-106,252}},
          textColor={28,108,200},
          textString="Undirected"),
        Rectangle(extent={{-208,276},{170,100}}, lineColor={28,108,200})}),
    Documentation(info="<html>
<p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end TestDiscretizedHEXvsDir;
