within ThermofluidStream.HeatExchangers.Tests;
model CrossFlowNTU

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
        origin={-126,0})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = mediumA,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{116,-10},{136,
            10}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
               mediumA,
    temperatureUnit="degC",
    pressureUnit="bar")                                         annotation (
      Placement(transformation(
        extent={{-11,10},{11,-10}},
        rotation=0,
        origin={-43,-10})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               mediumA,
    digits=3,
      outputMassFlowRate=true,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={60,-10})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = mediumB,
    temperatureFromInput=false,
    T0_par=293.15,
    p0_par=100000)
               annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,94})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = mediumB,
    pressureFromInput=true,
    p0_par=100000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-54})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               mediumB,                       outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,-24})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint(y=1)
    annotation (Placement(transformation(extent={{-110,-82},{-90,-62}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               mediumB,                       outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,32})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint1(y=0.3)
    annotation (Placement(transformation(extent={{56,-50},{76,-30}})));
  Modelica.Blocks.Continuous.PI PI(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{-52,-82},{-32,-62}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-82,-62},{-62,-82}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{-24,-78},{-12,-66}})));
  Modelica.Blocks.Continuous.PI PI1(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{118,-50},{138,-30}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{88,-30},{108,-50}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-156,-98},{-136,-78}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{148,-6},{136,6}})));
  HeatExchangers.CrossFlowNTU crossFlowNTU(
    redeclare package MediumA = mediumA,
    redeclare package MediumB = mediumB,
    A=10) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = mediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = mediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,64})));

equation
  connect(sinkA.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{116,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{4.44089e-16,-44},{0,-44},{0,-34}},
      color={28,108,200},
      thickness=0.5));
  connect(PI1.u, feedback1.y)
    annotation (Line(points={{116,-40},{107,-40}}, color={0,0,127}));
  connect(feedback1.u1, airFlow_setPoint1.y)
    annotation (Line(points={{90,-40},{77,-40}}, color={0,0,127}));
  connect(feedback1.u2, multiSensor_Tpm1.m_flow_out)
    annotation (Line(points={{98,-32},{98,-4},{70,-4}},     color={0,0,127}));
  connect(sinkA.p0_var, limiter1.y)
    annotation (Line(points={{128,0},{135.4,0}},     color={0,0,127}));
  connect(PI1.y, limiter1.u) annotation (Line(points={{139,-40},{156,-40},{156,
          0},{149.2,0}},     color={0,0,127}));
  connect(multiSensor_Tpm3.outlet, crossFlowNTU.inletB) annotation (Line(
      points={{0,22},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(crossFlowNTU.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{0,-10},{0,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, crossFlowNTU.inletA) annotation (Line(
      points={{-32,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(crossFlowNTU.outletA, multiSensor_Tpm1.inlet) annotation (Line(
      points={{10,0},{28,0},{28,1.77636e-15},{50,1.77636e-15}},
      color={28,108,200},
      thickness=0.5));
  connect(PI.y, limiter.u)
    annotation (Line(points={{-31,-72},{-25.2,-72}}, color={0,0,127}));
  connect(limiter.y, sinkB.p0_var)
    annotation (Line(points={{-11.4,-72},{0,-72},{0,-56}}, color={0,0,127}));
  connect(PI.u, feedback.y)
    annotation (Line(points={{-54,-72},{-63,-72}}, color={0,0,127}));
  connect(multiSensor_Tpm2.m_flow_out, feedback.u2) annotation (Line(points={{-4,-34},
          {-4,-40},{-72,-40},{-72,-64}},         color={0,0,127}));
  connect(feedback.u1, airFlow_setPoint.y)
    annotation (Line(points={{-80,-72},{-89,-72}}, color={0,0,127}));
  connect(sourceA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{-116,-1.11022e-15},{-104,-1.11022e-15},{-104,0},{-92,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.inlet, flowResistanceA.outlet) annotation (Line(
      points={{-54,0},{-72,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, flowResistanceB.inlet) annotation (Line(
      points={{-6.66134e-16,84},{0,84},{0,74},{6.66134e-16,74}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.inlet, flowResistanceB.outlet) annotation (Line(
      points={{0,42},{0,54},{-6.66134e-16,54}},
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
</html>"));
end CrossFlowNTU;
