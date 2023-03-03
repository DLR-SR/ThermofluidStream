within ThermofluidStream.Undirected.Processes.Tests;
model TransportDelay "Test for transport delay"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium "Medium Model"
    annotation (Documentation(info="<html>
<p>
Medium model for the test. Can be anything.
</p>
</html>"));

  ThermofluidStream.Processes.TransportDelay transportDelay(
    redeclare package Medium = Medium,
    l=100,
    r(displayUnit="mm") = 0.015)
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=100,
    l(displayUnit="mm") = 0.008,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e4))
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{70,30},{90,50}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    temperatureFromInput=true,
    pressureFromInput=true)
    annotation (Placement(transformation(extent={{-48,30},{-28,50}})));
  Modelica.Blocks.Sources.Trapezoid
                               trapezoid(
    amplitude=-6e3,
    rising=0.2,
    width=0.2,
    falling=0.2,
    period=0.8,
    offset=1.04e5,
    startTime=0.2)
    annotation (Placement(transformation(extent={{-94,10},{-74,30}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=20,
    duration=1.5,
    offset=273,
    startTime=0.3)
    annotation (Placement(transformation(extent={{-94,50},{-74,70}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));

  ThermofluidStream.Undirected.Processes.TransportDelay transportDelay1(
    redeclare package Medium = Medium,
    l=100,
    r(displayUnit="mm") = 0.015)
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=100,
    l(displayUnit="mm") = 0.008,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e4))
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Boundaries.BoundaryFore boundary_fore(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  Boundaries.BoundaryRear boundary_rear(
    redeclare package Medium = Medium,
    temperatureFromInput=true,
    pressureFromInput=true) annotation (Placement(transformation(extent={{-48,-50},{-28,-30}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=-6e3,
    rising=0.2,
    width=0.2,
    falling=0.2,
    period=0.8,
    offset=1.04e5,
    startTime=0.2)
    annotation (Placement(transformation(extent={{-94,-70},{-74,-50}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=20,
    duration=1.5,
    offset=273,
    startTime=0.3)
    annotation (Placement(transformation(extent={{-94,-30},{-74,-10}})));
equation
  connect(ramp1.y, source.T0_var) annotation (Line(points={{-73,60},{-60,60},{-60,40},{-40,40}},
                           color={0,0,127}));
  connect(trapezoid.y, source.p0_var) annotation (Line(points={{-73,20},{-60,20},{-60,46},{-40,46}},
                                  color={0,0,127}));
  connect(flowResistance.inlet, source.outlet) annotation (Line(
      points={{-10,40},{-28,40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, transportDelay.inlet) annotation (Line(
      points={{10,40},{30,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transportDelay.outlet, sink.inlet) annotation (Line(
      points={{50,40},{70,40}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp2.y, boundary_rear.T0_var) annotation (Line(points={{-73,-20},{-60,-20},{-60,-40},{-40,-40}},
                                          color={0,0,127}));
  connect(trapezoid1.y, boundary_rear.p0_var) annotation (Line(points={{-73,-60},{-60,-60},{-60,-34},{-40,-34}},
                                               color={0,0,127}));
  connect(flowResistance1.rear, boundary_rear.fore) annotation (Line(
      points={{-10,-40},{-28,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.fore, transportDelay1.rear) annotation (Line(
      points={{10,-40},{30,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(transportDelay1.fore, boundary_fore.rear) annotation (Line(
      points={{50,-40},{62,-40},{62,-40},{70,-40}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=2.5,
      Tolerance=1e-6,
      Interval=0.0025,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Test for use Transport Delay to delay the thermodynamic state of the flow. </p>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end TransportDelay;
