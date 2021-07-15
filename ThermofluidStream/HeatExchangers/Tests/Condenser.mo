within ThermofluidStream.HeatExchangers.Tests;
model Condenser

  replaceable package mediumAir = Media.myMedia.Air.MoistAir
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  replaceable package mediumRefrigerant = Media.myMedia.R134a.R134a_ph
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source sourceA(redeclare package Medium =
        mediumAir,
    T0_par=311.15,
    p0_par=100000)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-142,10})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = mediumAir,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{104,0},{124,20}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
               mediumAir,
    temperatureUnit="degC",
    pressureUnit="bar")                                         annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={-35,20})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               mediumAir,
    digits=3,
      outputMassFlowRate=true,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={54,20})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = mediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    pressureFromInput=true,
    T0_par=283.15,
    p0_par=200000,
    h0_par=450e3)
               annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={82,-54})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = mediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 3000000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-74,-52})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               mediumRefrigerant,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-22,-6},{-42,-26}})));
  Modelica.Blocks.Sources.RealExpression refFlow_setPoint(y=0.3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-12,-88})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               mediumRefrigerant,
    digits=3,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{42,-6},{22,-26}})));
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
        origin={46,-88})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={22,-88})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=35e5, uMin=20e5)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={70,-88})));
  Modelica.Blocks.Continuous.PI PI1(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{162,36},{182,56}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{132,36},{152,56}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{132,-64},{152,-44}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{196,12},{184,24}})));
  ThermofluidStream.HeatExchangers.DiscretizedHEX condenser(
    initializeMassFlow=true,
    m_flow_0=0,
    nCells=20,
    redeclare package MediumAir = mediumAir,
    redeclare package MediumRefrigerant = mediumRefrigerant,
    k_wall=150)                                              annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = mediumAir,
    m_flow_0=0.5,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-82,0},{-62,20}})));

  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = mediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.none,
    m_flow_0=0.3,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-74,-26})));
  Sensors.SingleSensorSelect singleSensorSelect(redeclare package Medium =
        mediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-22,-42},{-42,-22}})));
  Sensors.SingleSensorSelect singleSensorSelect1(redeclare package Medium =
        mediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{24,-40},{44,-20}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(redeclare package Medium =
        mediumRefrigerant,                                                                      quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-22,-54},{-42,-34}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(redeclare package Medium =
        mediumRefrigerant,                                                                       quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{24,-54},{44,-34}})));
equation
  connect(sinkA.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{104,10},{64,10}},
      color={28,108,200},
      thickness=0.5));
  connect(feedback.y, PI.u)
    annotation (Line(points={{31,-88},{34,-88}},  color={0,0,127}));
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
  connect(multiSensor_Tpm3.outlet, condenser.inletRef) annotation (Line(
      points={{22,-6},{14,-6},{14,-6},{10,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletRef, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-10.2,-6},{-14,-6},{-14,-6},{-22,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.inletAir, multiSensor_Tpm.outlet) annotation (Line(
      points={{-10,10},{-16,10},{-16,10},{-24,10}},
      color={28,108,200},
      thickness=0.5));
  connect(condenser.outletAir, multiSensor_Tpm1.inlet) annotation (Line(
      points={{10.2,10},{26,10},{26,10},{44,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, flowResistanceB.outlet) annotation (Line(
      points={{-74,-42},{-74,-36}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-74,-16},{-74,-6},{-42,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{82,-44},{82,-6},{42,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.m_flow_out, feedback.u2)
    annotation (Line(points={{22,-10},{8,-10},{8,-80},{22,-80}},
                                                 color={0,0,127}));
  connect(PI.y, limiter.u)
    annotation (Line(points={{57,-88},{62.8,-88}}, color={0,0,127}));
  connect(refFlow_setPoint.y, feedback.u1)
    annotation (Line(points={{-1,-88},{14,-88}}, color={0,0,127}));
  connect(singleSensorSelect.inlet, condenser.outletRef) annotation (Line(
      points={{-22,-32},{-18,-32},{-18,-6},{-10.2,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, condenser.inletRef) annotation (Line(
      points={{24,-30},{16,-30},{16,-6},{10,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, condenser.outletRef) annotation (Line(
      points={{-22,-44},{-18,-44},{-18,-6},{-10.2,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, condenser.inletRef) annotation (Line(
      points={{24,-44},{16,-44},{16,-6},{10,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(limiter.y, sourceB.p0_var)
    annotation (Line(points={{76.6,-88},{88,-88},{88,-56}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),                                  Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-160,-100},{220,100}})),
    experiment(
      StopTime=10,
   tolerance=1e-6,
   Interval=0.01,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end Condenser;
