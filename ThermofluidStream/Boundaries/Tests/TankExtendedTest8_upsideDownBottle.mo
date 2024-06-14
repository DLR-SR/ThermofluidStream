within ThermofluidStream.Boundaries.Tests;
model TankExtendedTest8_upsideDownBottle
  extends Modelica.Icons.Example;
      package Medium =
      ThermofluidStream.Media.myMedia.GasAndIncompressible.JP8DryAir;
  TankCuboid tank(
    redeclare package Medium = Medium,
    chaoticLife=false,
    N_inlets=1,
    M_outlets=1,
    useHeatport=false,
    p_start=99000,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.01,0.99},
    M_liq_start=0.38,
    outletTransition=0.001,
    inletPositions={{0,0,0}},
    outletPositions={{0,0,0}},
    tankCenter={0.025,0.025,0.1},
    xLength=0.05,
    yLength=0.05,
    zLength=0.2)
               annotation (Placement(transformation(extent={{-10,48},{10,68}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium =
        Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{90,-80},{70,-60}})));
  inner AccelerationBoundary                  acceleration
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=
        AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-82,40},{-62,60}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium =
        Medium,
    l=1,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.03,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
        zeta=1,
        fromGeometry=false,
        A=0.0028))
    annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
  ThermofluidStream.Processes.FlowResistance flowResistance2(
    redeclare package Medium =
        Medium,
    l=0.02,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.01,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
        zeta=1,
        fromGeometry=false,
        A=0.0003))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,10})));
  TankCuboid tank1(
    redeclare package Medium = Medium,
    N_inlets=2,
    M_outlets=2,
    useHeatport=false,
    initialize_pressure=true,
    p_start=100000,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.001,0.999},
    M_liq_start=0.1,
    outletTransition=0.001,
    inletPositions={{-0.01,0,0},{0,0,0}},
    outletPositions={{-0.01,0,0},{0,0,0}},
    tankCenter={-0.05,-0.05,-0.1},
    xLength=0.1,
    yLength=0.1,
    zLength=0.2)
    annotation (Placement(transformation(extent={{10,-60},{-10,-40}})));
  Processes.FlowResistance                   flowResistance1(
    redeclare package Medium = Medium,
    l=0.02,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.01,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.zetaPressureLoss (
        zeta=1,
        fromGeometry=false,
        A=0.0003))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,12})));
  Processes.FlowResistance                   flowResistance3(
    redeclare package Medium = Medium,
    l=1,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.03,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.zetaPressureLoss (
        zeta=1,
        fromGeometry=false,
        A=0.0028))
    annotation (Placement(transformation(extent={{-30,-80},{-50,-60}})));
  Sink sink(redeclare package Medium =
        Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-60,-80},{-80,-60}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{70,-70},{60,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(tank.outlet[1], flowResistance2.inlet) annotation (Line(
      points={{10,58},{40,58},{40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(tank1.outlet[1], flowResistance1.inlet) annotation (Line(
      points={{-10,-50.5},{-40,-50.5},{-40,2}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.inlet, tank1.outlet[2]) annotation (Line(
      points={{-30,-70},{-20,-70},{-20,-49.5},{-10,-49.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, sink.inlet) annotation (Line(
      points={{-50,-70},{-60,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, tank1.inlet[2]) annotation (Line(
      points={{40,-70},{24,-70},{24,-49.5},{10,-49.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, tank1.inlet[1]) annotation (Line(
      points={{40,0},{40,-50.5},{10,-50.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, tank.inlet[1]) annotation (Line(
      points={{-40,22},{-40,58},{-10,58}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2000, __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end TankExtendedTest8_upsideDownBottle;
