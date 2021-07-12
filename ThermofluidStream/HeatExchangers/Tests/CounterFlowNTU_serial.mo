within ThermofluidStream.HeatExchangers.Tests;
model CounterFlowNTU_serial

  replaceable package mediumA =
      Media.myMedia.Incompressible.Examples.Glycol47
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  replaceable package mediumB = Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source sourceA(redeclare package Medium =
        mediumA, T0_par=333.15)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-140,-20})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = mediumA,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{110,-30},{130,
            -10}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               mediumA,
    digits=3,
      outputMassFlowRate=true,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={80,-30})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = mediumB,
    temperatureFromInput=false,
    T0_par=293.15,
    p0_par=100000)
               annotation (Placement(transformation(extent={{158,10},{138,30}})));
  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = mediumB,
    pressureFromInput=true,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-110,10},{-130,30}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               mediumB,                       outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-70,20},{-90,40}})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint(y=1)
    annotation (Placement(transformation(extent={{-44,50},{-64,70}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               mediumB,                       outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{90,20},{70,40}})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint1(y=0.3)
    annotation (Placement(transformation(extent={{52,-70},{72,-50}})));
  Modelica.Blocks.Continuous.PI PI(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{-112,50},{-132,70}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-84,50},{-104,70}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{-140,54},{-152,66}})));
  Modelica.Blocks.Continuous.PI PI1(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{114,-70},{134,-50}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{84,-50},{104,-70}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-158,-92},{-138,-72}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{142,-26},{130,-14}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU(
    redeclare package MediumA = mediumA,
    redeclare package MediumB = mediumB,
    A=10) annotation (Placement(transformation(extent={{-38,-8},{-18,12}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU1(
    redeclare package MediumA = mediumA,
    redeclare package MediumB = mediumB,
    A=10) annotation (Placement(transformation(extent={{18,-8},{38,12}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm4(
    redeclare package Medium = mediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,8},{-10,28}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm5(
    redeclare package Medium = mediumA,
    digits=3,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-74,-30})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm6(
    redeclare package Medium = mediumA,
    digits=3,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={0,-14})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = mediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-114,-30},{-94,-10}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = mediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{130,10},{110,30}})));
equation
  connect(sinkA.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{110,-20},{90,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-110,20},{-90,20}},
      color={28,108,200},
      thickness=0.5));
  connect(airFlow_setPoint.y, feedback.u1)
    annotation (Line(points={{-65,60},{-86,60}}, color={0,0,127}));
  connect(multiSensor_Tpm2.m_flow_out, feedback.u2)
    annotation (Line(points={{-90,24},{-94,24},{-94,52}}, color={0,0,127}));
  connect(feedback.y, PI.u)
    annotation (Line(points={{-103,60},{-110,60}},color={0,0,127}));
  connect(PI.y, limiter.u)
    annotation (Line(points={{-133,60},{-138.8,60}}, color={0,0,127}));
  connect(limiter.y,sinkB. p0_var) annotation (Line(points={{-152.6,60},{-156,
          60},{-156,20},{-122,20}}, color={0,0,127}));
  connect(PI1.u, feedback1.y)
    annotation (Line(points={{112,-60},{103,-60}}, color={0,0,127}));
  connect(feedback1.u1, airFlow_setPoint1.y)
    annotation (Line(points={{86,-60},{73,-60}}, color={0,0,127}));
  connect(feedback1.u2, multiSensor_Tpm1.m_flow_out)
    annotation (Line(points={{94,-52},{94,-24},{90,-24}},   color={0,0,127}));
  connect(sinkA.p0_var, limiter1.y)
    annotation (Line(points={{122,-20},{129.4,-20}}, color={0,0,127}));
  connect(PI1.y, limiter1.u) annotation (Line(points={{135,-60},{146,-60},{146,
          -20},{143.2,-20}}, color={0,0,127}));
  connect(multiSensor_Tpm4.outlet, counterFlowNTU.inletB) annotation (Line(
      points={{-10,8},{-16.8,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.inlet, counterFlowNTU1.outletB) annotation (Line(
      points={{10,8},{17,8}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletA, multiSensor_Tpm6.inlet) annotation (Line(
      points={{-17,-4},{-10,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU1.inletA, multiSensor_Tpm6.outlet) annotation (Line(
      points={{16.8,-4},{10,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, counterFlowNTU.inletA) annotation (Line(
      points={{-64,-20},{-60,-20},{-60,-4},{-39.2,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-39,8},{-60,8},{-60,20},{-70,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, counterFlowNTU1.inletB) annotation (Line(
      points={{70,20},{60,20},{60,8},{39.2,8}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU1.outletA, multiSensor_Tpm1.inlet) annotation (Line(
      points={{39,-4},{60,-4},{60,-20},{70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{-130,-20},{-114,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.inlet, flowResistanceA.outlet) annotation (Line(
      points={{-84,-20},{-94,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, flowResistanceB.inlet) annotation (Line(
      points={{138,20},{130,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.inlet, flowResistanceB.outlet) annotation (Line(
      points={{90,20},{110,20}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-160,-100},{160,100}})),
    experiment(
      StopTime=100,
   Tolerance=1e-5,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end CounterFlowNTU_serial;
