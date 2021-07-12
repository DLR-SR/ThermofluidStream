within ThermofluidStream.HeatExchangers.Tests;
model CounterFlowNTU

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
        origin={-126,-20})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = mediumA,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{116,-30},{136,-10}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
               mediumA,
    temperatureUnit="degC",
    pressureUnit="bar")                                         annotation (
      Placement(transformation(
        extent={{-11,10},{11,-10}},
        rotation=0,
        origin={-45,-30})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               mediumA,
    digits=3,
      outputMassFlowRate=true,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={60,-30})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = mediumB,
    temperatureFromInput=false,
    T0_par=293.15,
    p0_par=100000)
               annotation (Placement(transformation(extent={{136,10},{116,30}})));
  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = mediumB,
    pressureFromInput=true,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-118,10},{-138,30}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               mediumB,                       outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-56,20},{-76,40}})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint(y=1)
    annotation (Placement(transformation(extent={{-42,50},{-62,70}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               mediumB,                       outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{66,20},{46,40}})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint1(y=0.3)
    annotation (Placement(transformation(extent={{56,-70},{76,-50}})));
  Modelica.Blocks.Continuous.PI PI(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{-102,50},{-122,70}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-72,50},{-92,70}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{-132,54},{-144,66}})));
  Modelica.Blocks.Continuous.PI PI1(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{118,-70},{138,-50}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{88,-50},{108,-70}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-156,-98},{-136,-78}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{148,-26},{136,-14}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU(
    redeclare package MediumA = mediumA,
    redeclare package MediumB = mediumB,
    A=10) annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = mediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{100,10},{80,30}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = mediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));

equation
  connect(sinkA.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{116,-20},{70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-118,20},{-76,20}},
      color={28,108,200},
      thickness=0.5));
  connect(airFlow_setPoint.y, feedback.u1)
    annotation (Line(points={{-63,60},{-74,60}}, color={0,0,127}));
  connect(multiSensor_Tpm2.m_flow_out, feedback.u2)
    annotation (Line(points={{-76,24},{-82,24},{-82,52}}, color={0,0,127}));
  connect(feedback.y, PI.u)
    annotation (Line(points={{-91,60},{-100,60}}, color={0,0,127}));
  connect(PI.y, limiter.u)
    annotation (Line(points={{-123,60},{-130.8,60}}, color={0,0,127}));
  connect(limiter.y,sinkB. p0_var) annotation (Line(points={{-144.6,60},{-152,
          60},{-152,20},{-130,20}}, color={0,0,127}));
  connect(PI1.u, feedback1.y)
    annotation (Line(points={{116,-60},{107,-60}}, color={0,0,127}));
  connect(feedback1.u1, airFlow_setPoint1.y)
    annotation (Line(points={{90,-60},{77,-60}}, color={0,0,127}));
  connect(feedback1.u2, multiSensor_Tpm1.m_flow_out)
    annotation (Line(points={{98,-52},{98,-24},{70,-24}},   color={0,0,127}));
  connect(sinkA.p0_var, limiter1.y)
    annotation (Line(points={{128,-20},{135.4,-20}}, color={0,0,127}));
  connect(PI1.y, limiter1.u) annotation (Line(points={{139,-60},{156,-60},{156,
          -20},{149.2,-20}}, color={0,0,127}));
  connect(multiSensor_Tpm3.outlet, counterFlowNTU.inletB) annotation (Line(
      points={{46,20},{28,20},{28,8},{11.2,8}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-11,8},{-28,8},{-28,20},{-56,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, counterFlowNTU.inletA) annotation (Line(
      points={{-34,-20},{-28,-20},{-28,-4},{-11.2,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletA, multiSensor_Tpm1.inlet) annotation (Line(
      points={{11,-4},{28,-4},{28,-20},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{-116,-20},{-100,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.inlet, flowResistanceA.outlet) annotation (Line(
      points={{-56,-20},{-80,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, flowResistanceB.inlet) annotation (Line(
      points={{116,20},{100,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.inlet, flowResistanceB.outlet) annotation (Line(
      points={{66,20},{80,20}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-160,-100},{160,100}})),
    experiment(
      StopTime=100,
   tolerance=1e-6,
   Interval=0.1,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"),
    __Dymola_experimentSetupOutput(
      derivatives=false,
      inputs=false,
      outputs=true,
      auxiliaries=false,
      events=false));
end CounterFlowNTU;
