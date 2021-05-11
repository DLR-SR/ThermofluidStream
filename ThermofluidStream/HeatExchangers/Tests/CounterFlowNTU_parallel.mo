within ThermofluidStream.HeatExchangers.Tests;
model CounterFlowNTU_parallel

  replaceable package mediumA =
      myMedia.Incompressible.Examples.Glycol47
    constrainedby myMedia.Interfaces.PartialMedium            annotation(choicesAllMatching = true);

  replaceable package mediumB = myMedia.Air.DryAirNasa
    constrainedby myMedia.Interfaces.PartialMedium            annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source sourceA(redeclare package Medium =
        mediumA, T0_par=333.15)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-132,-20})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = mediumA,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{110,-30},{130,-10}})));

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
    pressureFromInput=true,
    T0_par=293.15,
    p0_par=100000)
               annotation (Placement(transformation(extent={{130,10},{110,30}})));
  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = mediumB,
    pressureFromInput=false,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-150,10},{-170,30}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               mediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-100,20},{-120,40}})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint(y=1)
    annotation (Placement(transformation(extent={{102,42},{122,62}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               mediumB,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{90,20},{70,40}})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint1(y=0.3)
    annotation (Placement(transformation(extent={{52,-70},{72,-50}})));
  Modelica.Blocks.Continuous.PI PI(
    k=10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{174,10},{154,30}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{126,42},{146,62}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{148,14},{136,26}})));
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
    A=10) annotation (Placement(transformation(extent={{-38,48},{-18,28}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm5(
    redeclare package Medium = mediumA,
    digits=3,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-74,-30})));
  Topology.SplitterT1 splitterT1_1(redeclare package Medium =
        mediumB)
    annotation (Placement(transformation(extent={{56,10},{36,30}})));
  Topology.JunctionT1 junctionT1_1(redeclare package Medium = mediumB)
    annotation (Placement(transformation(extent={{-94,10},{-74,30}})));
  Boundaries.Source                   sourceA2(redeclare package Medium = mediumA, T0_par=
       333.15)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-128,78})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm4(
    redeclare package Medium = mediumA,
    digits=3,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-96,88})));
  Boundaries.Sink                   sinkA2(
    redeclare package Medium = mediumA,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{48,50},{68,70}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm6(
    redeclare package Medium = mediumA,
    digits=3,
    outputMassFlowRate=true,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={18,70})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint2(y=0.3)
    annotation (Placement(transformation(extent={{-10,108},{10,88}})));
  Modelica.Blocks.Continuous.PI PI2(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{52,108},{72,88}})));
  Modelica.Blocks.Math.Feedback feedback2
    annotation (Placement(transformation(extent={{22,88},{42,108}})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{80,54},{68,66}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm7(
    redeclare package Medium = mediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{40,32},{20,52}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm8(
    redeclare package Medium = mediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{40,8},{20,28}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm9(
    redeclare package Medium = mediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-50,32},{-70,52}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm10(
    redeclare package Medium = mediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-50,8},{-70,28}})));
  Processes.FlowResistance flowResistanceB2(
    redeclare package Medium = mediumB,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-126,10},{-146,30}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = mediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{8,22},{-12,42}})));
  Processes.FlowResistance flowResistanceB1(
    redeclare package Medium = mediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{8,-2},{-12,18}})));
  Processes.FlowResistance flowResistanceA2(
    redeclare package Medium = mediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-78,68},{-58,88}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = mediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-112,-30},{-92,-10}})));
equation
  connect(sinkA.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{110,-20},{90,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{110,20},{90,20}},
      color={28,108,200},
      thickness=0.5));
  connect(PI.y, limiter.u)
    annotation (Line(points={{153,20},{149.2,20}},   color={0,0,127}));
  connect(PI1.u, feedback1.y)
    annotation (Line(points={{112,-60},{103,-60}}, color={0,0,127}));
  connect(feedback1.u1, airFlow_setPoint1.y)
    annotation (Line(points={{86,-60},{73,-60}}, color={0,0,127}));
  connect(feedback1.u2, multiSensor_Tpm1.m_flow_out)
    annotation (Line(points={{94,-52},{94,-24},{90,-24}},   color={0,0,127}));
  connect(sinkA.p0_var, limiter1.y)
    annotation (Line(points={{122,-20},{129.4,-20}}, color={0,0,127}));
  connect(PI1.y, limiter1.u) annotation (Line(points={{135,-60},{146,-60},{146,-20},{143.2,
          -20}},             color={0,0,127}));
  connect(multiSensor_Tpm5.outlet, counterFlowNTU.inletA) annotation (Line(
      points={{-64,-20},{-60,-20},{-60,-4},{-39.2,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, splitterT1_1.inlet) annotation (Line(
      points={{70,20},{56,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.inlet, junctionT1_1.outlet) annotation (Line(
      points={{-100,20},{-94,20}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletA, multiSensor_Tpm1.inlet) annotation (Line(
      points={{-17,-4},{16,-4},{16,-20},{70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA2.outlet, multiSensor_Tpm4.inlet) annotation (Line(
      points={{-118,78},{-106,78}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA2.inlet, multiSensor_Tpm6.outlet) annotation (Line(
      points={{48,60},{28,60}},
      color={28,108,200},
      thickness=0.5));
  connect(PI2.u,feedback2. y)
    annotation (Line(points={{50,98},{41,98}},     color={0,0,127}));
  connect(feedback2.u1,airFlow_setPoint2. y)
    annotation (Line(points={{24,98},{11,98}},   color={0,0,127}));
  connect(feedback2.u2,multiSensor_Tpm6. m_flow_out)
    annotation (Line(points={{32,90},{30,90},{30,64},{28,64}},
                                                            color={0,0,127}));
  connect(sinkA2.p0_var, limiter2.y)
    annotation (Line(points={{60,60},{67.4,60}}, color={0,0,127}));
  connect(PI2.y,limiter2. u) annotation (Line(points={{73,98},{90,98},{90,60},{
          81.2,60}},         color={0,0,127}));
  connect(counterFlowNTU1.outletA, multiSensor_Tpm6.inlet) annotation (Line(
      points={{-17,44},{-2,44},{-2,60},{8,60}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.outletA, multiSensor_Tpm7.inlet) annotation (Line(
      points={{46,30},{46,32},{40,32}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.outletB, multiSensor_Tpm8.inlet) annotation (Line(
      points={{46,10},{46,8},{40,8}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU1.outletB, multiSensor_Tpm9.inlet) annotation (Line(
      points={{-39,32},{-50,32}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT1_1.inletA, multiSensor_Tpm9.outlet) annotation (Line(
      points={{-84,30},{-84,32},{-70,32}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletB, multiSensor_Tpm10.inlet) annotation (Line(
      points={{-39,8},{-50,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm10.outlet, junctionT1_1.inletB) annotation (Line(
      points={{-70,8},{-84,8},{-84,10}},
      color={28,108,200},
      thickness=0.5));
  connect(limiter.y, sourceB.p0_var) annotation (Line(points={{135.4,20},{128,20},{128,20},{122,20}},
                     color={0,0,127}));
  connect(feedback.u1, airFlow_setPoint.y)
    annotation (Line(points={{128,52},{123,52}}, color={0,0,127}));
  connect(multiSensor_Tpm3.m_flow_out, feedback.u2) annotation (Line(points={{70,24},
          {64,24},{64,40},{136,40},{136,44}},
                                      color={0,0,127}));
  connect(feedback.y, PI.u)
    annotation (Line(points={{145,52},{186,52},{186,20},{176,20}}, color={0,0,127}));
  connect(sinkB.inlet, flowResistanceB2.outlet) annotation (Line(
      points={{-150,20},{-146,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.outlet, flowResistanceB2.inlet) annotation (Line(
      points={{-120,20},{-126,20}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU1.inletB, flowResistanceB.outlet) annotation (Line(
      points={{-16.8,32},{-12,32}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm7.outlet,flowResistanceB. inlet) annotation (Line(
      points={{20,32},{8,32}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.inletB, flowResistanceB1.outlet) annotation (Line(
      points={{-16.8,8},{-12,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm8.outlet, flowResistanceB1.inlet) annotation (Line(
      points={{20,8},{8,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.outlet, flowResistanceA2.inlet) annotation (Line(
      points={{-86,78},{-78,78}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceA2.outlet, counterFlowNTU1.inletA) annotation (Line(
      points={{-58,78},{-50,78},{-50,44},{-39.2,44}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet,flowResistanceA. inlet) annotation (Line(
      points={{-122,-20},{-112,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.inlet,flowResistanceA. outlet) annotation (Line(
      points={{-84,-20},{-92,-20}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-160,-100},{160,100}})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end CounterFlowNTU_parallel;
