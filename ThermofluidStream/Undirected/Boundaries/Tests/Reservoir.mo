within ThermofluidStream.Undirected.Boundaries.Tests;
model Reservoir "Test for Reservoir"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.CompressibleLiquids.LinearColdWater
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium Model"
      annotation(choicesAllMatching=true, Documentation(info="<html>
<p>Medium Model for the test. Be aware that the Component is mainly meant for liquids with low compressablility.</p>
</html>"));

  ThermofluidStream.Undirected.Boundaries.Reservoir reservoir(
    redeclare package Medium = Medium,
    pEnvFromInput=true,
    A_surf=0.01,
    T_start=293.15,
    height_0=0.1)
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  BoundaryRear boundary_rear(redeclare package Medium = Medium, p0_par=101200) annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  BoundaryFore boundary_fore(redeclare package Medium = Medium, p0_par=101000) annotation (Placement(transformation(extent={{58,-80},{78,-60}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=2e2,
    duration=0.1,
    offset=1e5,
    startTime=3)
    annotation (Placement(transformation(extent={{-66,-42},{-46,-22}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
         k=100))
    annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
         k=100))
    annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
  ThermofluidStream.Boundaries.Reservoir reservoir2(
    redeclare package Medium = Medium,
    pEnvFromInput=true,
    A_surf=0.01,
    T_start=293.15,
    height_0=0.1)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  ThermofluidStream.Boundaries.Source source1(redeclare package Medium = Medium,
      p0_par=101200)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = Medium,
      p0_par=101000)
    annotation (Placement(transformation(extent={{58,20},{78,40}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=2e2,
    duration=0.1,
    offset=1e5,
    startTime=3)
    annotation (Placement(transformation(extent={{-66,58},{-46,78}})));
  ThermofluidStream.Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
         k=100))
    annotation (Placement(transformation(extent={{-32,20},{-12,40}})));
  ThermofluidStream.Processes.FlowResistance flowResistance5(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
         k=100))
    annotation (Placement(transformation(extent={{30,20},{50,40}})));
  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
equation

  connect(reservoir2.inlet, flowResistance4.outlet) annotation (Line(
      points={{0,30},{-12,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance4.inlet) annotation (Line(
      points={{-40,30},{-32,30}},
      color={28,108,200},
      thickness=0.5));
  connect(reservoir2.outlet, flowResistance5.inlet) annotation (Line(
      points={{20,30},{30,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance5.outlet) annotation (Line(
      points={{58,30},{50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.rear, boundary_rear.fore) annotation (Line(
      points={{-30,-70},{-40,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.fore, reservoir.rear) annotation (Line(
      points={{-10,-70},{0,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(reservoir.fore, flowResistance2.rear) annotation (Line(
      points={{20,-70},{30,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.fore, boundary_fore.rear) annotation (Line(
      points={{50,-70},{58,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(reservoir.pEnv_input, ramp1.y) annotation (Line(points={{10,-58},{10,-32},{-45,-32}}, color={0,0,127}));
  connect(reservoir2.pEnv_input, ramp.y) annotation (Line(points={{10,41.9},{10,68},{-45,68}},
                                                                                             color={0,0,127}));

annotation (
  experiment(StopTime=10, Tolerance=1e-6, Interval=0.01),
  Documentation(info="<html>
    <p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
    </html>"));
end Reservoir;
