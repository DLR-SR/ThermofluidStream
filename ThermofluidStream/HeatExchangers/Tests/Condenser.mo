within ThermofluidStream.HeatExchangers.Tests;
model Condenser

  replaceable package MediumAir = Media.myMedia.Air.MoistAir
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  replaceable package MediumRefrigerant = Media.myMedia.R134a.R134a_ph
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source sourceA(redeclare package Medium =
        MediumAir,
    T0_par=311.15,
    p0_par=100000)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-142,10})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumAir,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{104,0},{124,20}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
               MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar")                                         annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={-35,20})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               MediumAir,
    digits=3,
      outputMassFlowRate=true,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={54,20})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    pressureFromInput=true,
    T0_par=283.15,
    p0_par=200000,
    h0_par=450e3)
               annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,78})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 3000000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,-80})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               MediumRefrigerant,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={20,-24})));
  Modelica.Blocks.Sources.RealExpression refFlow_setPoint(y=0.3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-108,86})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               MediumRefrigerant,
    digits=3,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,44})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint1(y=1)
    annotation (Placement(transformation(extent={{100,36},{120,56}})));
  Modelica.Blocks.Continuous.PI PI(
    k=10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=300,
    y_start=30e5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,86})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-74,86})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=35e5, uMin=20e5)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-26,86})));
  Modelica.Blocks.Continuous.PI PI1(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{162,36},{182,56}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{132,36},{152,56}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{212,-94},{232,-74}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{196,12},{184,24}})));
  DiscretizedCrossFlowHEX   condenser(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX,
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=true,
    m_flow_0=0,
    nCells=20,
    k_wall=150) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={2,10})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumAir,
    m_flow_0=0.5,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-82,0},{-62,20}})));

  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.none,
    m_flow_0=0.3,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,-54})));
  Sensors.SingleSensorSelect singleSensorSelect(redeclare package Medium =
        MediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={42,-24})));
  Sensors.SingleSensorSelect singleSensorSelect1(redeclare package Medium =
        MediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-14,44})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(redeclare package Medium =
        MediumRefrigerant,                                                                      quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={34,-24})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(redeclare package Medium =
        MediumRefrigerant,                                                                       quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-22,44})));
equation
  connect(sinkA.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{104,10},{64,10}},
      color={28,108,200},
      thickness=0.5));
  connect(feedback.y, PI.u)
    annotation (Line(points={{-65,86},{-62,86}},  color={0,0,127}));
  connect(PI1.u, feedback1.y)
    annotation (Line(points={{160,46},{151,46}},   color={0,0,127}));
  connect(feedback1.u1, airFlow_setPoint1.y)
    annotation (Line(points={{134,46},{121,46}}, color={0,0,127}));
  connect(feedback1.u2, multiSensor_Tpm1.m_flow_out)
    annotation (Line(points={{142,38},{142,14},{64,14}},    color={0,0,127}));
  connect(sinkA.p0_var, limiter1.y)
    annotation (Line(points={{116,10},{180,10},{180,18},{183.4,18}},
                                                     color={0,0,127}));
  connect(PI1.y, limiter1.u) annotation (Line(points={{183,46},{200,46},{200,18},
          {197.2,18}},       color={0,0,127}));
  connect(sourceA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{-132,10},{-82,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.inlet, flowResistanceA.outlet) annotation (Line(
      points={{-46,10},{-62,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, flowResistanceB.outlet) annotation (Line(
      points={{10,-70},{10,-64}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{10,-44},{10,-34}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{10,68},{10,54}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.m_flow_out, feedback.u2)
    annotation (Line(points={{6,34},{-74,34},{-74,78}},
                                                 color={0,0,127}));
  connect(PI.y, limiter.u)
    annotation (Line(points={{-39,86},{-33.2,86}}, color={0,0,127}));
  connect(refFlow_setPoint.y, feedback.u1)
    annotation (Line(points={{-97,86},{-82,86}}, color={0,0,127}));
  connect(limiter.y, sourceB.p0_var)
    annotation (Line(points={{-19.4,86},{4,86},{4,80}},     color={0,0,127}));
  connect(singleSensorSelect1.inlet, multiSensor_Tpm3.inlet)
    annotation (Line(
      points={{-14,54},{-14,60},{10,60},{10,54}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, multiSensor_Tpm3.inlet)
    annotation (Line(
      points={{-22,54},{-22,60},{10,60},{10,54}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, multiSensor_Tpm2.inlet)
    annotation (Line(
      points={{34,-14},{34,-6},{10,-6},{10,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, multiSensor_Tpm2.inlet)
    annotation (Line(
      points={{42,-14},{42,-6},{10,-6},{10,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, condenser.inletA) annotation (Line(
      points={{-24,10},{-8,10}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletA, multiSensor_Tpm1.inlet)
    annotation (Line(
      points={{12,10},{28.2,10},{28.2,10},{44,10}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{10,-0.2},{10,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.inletB, multiSensor_Tpm3.outlet) annotation (Line(
      points={{10,20},{10,34}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),                                  Diagram(coordinateSystem(preserveAspectRatio=
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
