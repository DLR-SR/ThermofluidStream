within ThermofluidStream.Examples.Utilities.Tests;
model BoilerEspresso "Test for the espresso boiler"
  extends Modelica.Icons.Example;

  package Water = Media.myMedia.Water.StandardWater
                                              "Medium Model"
    annotation (Documentation(info="<html>
<p>Typicaly some sort of water, since we want to make espresso with it.</p>
</html>"));

  Utilities.BoilerEspresso boilerEspresso(
    redeclare package Medium = Water,
    p_0=3e3,
    V(displayUnit="l") = 0.001,
    x_0=0.001)
    annotation (Placement(transformation(extent={{-10,-20},{30,20}})));
  inner DropOfCommons dropOfCommons(stopOnFailedAssert=false)
    annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
  Boundaries.Source source(
    redeclare package Medium = Water,
    T0_par=298.15,
    p0_par=300000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-100})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Water,
    r(displayUnit="mm") = 0.003,
    l=0.3,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e8,
          k2=0))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-40})));
  FlowControl.TanValve     tanValve(
    redeclare package Medium = Water, relativeLeakiness=1e-5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-70})));

  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=0.25,
    uHigh=0.30,
    pre_y_start=false)
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=0.0, realFalse=1.0)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=1)
    annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(
    uLow=1.1e5,
    uHigh=1.2e5,
    pre_y_start=false)
    annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1(realTrue=0.0, realFalse=1000.0)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={52,8})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=-300)
    annotation (Placement(transformation(extent={{62,-24},{82,-4}})));
  FlowControl.TanValve     tanValve1(redeclare package Medium = Water,
      relativeLeakiness=1e-5)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={30,70})));
  Boundaries.Sink sink(redeclare package Medium = Water, p0_par=100000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,100})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Water,
    r(displayUnit="mm") = 0.003,
    l=0.3,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e7,
          k2=0))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,40})));
  Modelica.Blocks.Sources.Pulse pulse(
    width=70,
    period=100,
    nperiod=1,
    offset=0,
    startTime=350)
    annotation (Placement(transformation(extent={{100,60},{80,80}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=1)
    annotation (Placement(transformation(extent={{70,60},{50,80}})));
  FlowControl.TanValve     tanValve2(redeclare package Medium = Water,
      relativeLeakiness=1e-5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,70})));
  Boundaries.Sink sink1(redeclare package Medium = Water, p0_par=100000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,100})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Water,
    r(displayUnit="mm") = 0.003,
    l=0.3,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e7,
          k2=0))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,40})));
  Modelica.Blocks.Sources.Pulse pulse1(
    width=70,
    period=100,
    nperiod=1,
    offset=0,
    startTime=550)
    annotation (Placement(transformation(extent={{-82,60},{-62,80}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=1)
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
equation
  connect(boilerEspresso.inlet, flowResistance.outlet) annotation (Line(
      points={{10,-20},{10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, tanValve.inlet) annotation (Line(
      points={{10,-90},{10,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve.outlet, flowResistance.inlet) annotation (Line(
      points={{10,-60},{10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(booleanToReal.u, hysteresis.y)
    annotation (Line(points={{-62,-70},{-69,-70}},   color={255,0,255}));
  connect(booleanToReal.y, firstOrder.u)
    annotation (Line(points={{-39,-70},{-32,-70}},   color={0,0,127}));
  connect(boilerEspresso.heatport_heat, prescribedHeatFlow.port) annotation (
      Line(points={{-2,0},{-20,0}},                      color={191,0,0}));
  connect(booleanToReal1.u, hysteresis1.y)
    annotation (Line(points={{-72,0},{-81,0}},     color={255,0,255}));
  connect(booleanToReal1.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-49,0},{-40,0}},
                                                color={0,0,127}));
  connect(boilerEspresso.p_out, hysteresis1.u) annotation (Line(points={{-10,12},{-30,12},{-30,20},{-110,20},{-110,0},{-104,0}},
                                                            color={0,0,127}));

  connect(tanValve.u, firstOrder.y)
    annotation (Line(points={{2,-70},{-9,-70}},              color={0,0,127}));
  connect(prescribedHeatFlow1.port, boilerEspresso.heatport_HX)
    annotation (Line(points={{42,8},{32,8},{32,0},{22,0}},
                                               color={191,0,0}));
  connect(realExpression.y, prescribedHeatFlow1.Q_flow)
    annotation (Line(points={{83,-14},{94,-14},{94,8},{62,8}},
                                                             color={0,0,127}));
  connect(tanValve1.outlet, sink.inlet) annotation (Line(
      points={{30,80},{30,90}},
      color={28,108,200},
      thickness=0.5));
  connect(boilerEspresso.steam_out, flowResistance1.inlet) annotation (Line(
      points={{18,20},{18,26},{30,26},{30,30}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve1.inlet, flowResistance1.outlet) annotation (Line(
      points={{30,60},{30,50}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve1.u, firstOrder1.y)
    annotation (Line(points={{38,70},{49,70}},    color={0,0,127}));
  connect(firstOrder1.u, pulse.y)
    annotation (Line(points={{72,70},{79,70}},     color={0,0,127}));
  connect(tanValve2.outlet, sink1.inlet) annotation (Line(
      points={{-10,80},{-10,90}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve2.inlet,flowResistance2. outlet) annotation (Line(
      points={{-10,60},{-10,50},{-8,50}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve2.u,firstOrder2. y)
    annotation (Line(points={{-18,70},{-29,70}},  color={0,0,127}));
  connect(firstOrder2.u, pulse1.y)
    annotation (Line(points={{-52,70},{-61,70}},     color={0,0,127}));
  connect(flowResistance2.inlet, boilerEspresso.water_out) annotation (Line(
      points={{-8,30},{-8,26},{2,26},{2,20}},
      color={28,108,200},
      thickness=0.5));
  connect(boilerEspresso.y_out, hysteresis.u) annotation (Line(points={{-10,-12},{-30,-12},{-30,-40},{-100,-40},{-100,-70},{-92,-70}},
        color={0,0,127}));
  annotation(experiment(StopTime=1000), Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"),
    Diagram(coordinateSystem(extent={{-120,-100},{120,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end BoilerEspresso;
