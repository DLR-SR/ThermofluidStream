within ThermofluidStream.Boundaries.Tests;
model TankSelfDraining2
  extends Modelica.Icons.Example;
      package Medium =
      ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir;
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium =
        Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  inner AccelerationBoundary                  acceleration
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=
        AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  ThermofluidStream.Processes.FlowResistance flowResistance2(
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
    annotation (Placement(transformation(extent={{-58,10},{-38,30}})));
  TankCuboid tank(
    redeclare package Medium = Medium,
    N_inlets=2,
    M_outlets=2,
    p_start=90000,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.001,0.999},
    M_liq_start=700,
    outletTransition=0.001,
    inletPositions={{0,0,0},{0,0,0}},
    outletPositions={{-0.5,0,-1},{0,0,-0.5}},
    tankCenter={-0.5,-0.5,-0.5},
    xLength=1,
    yLength=1,
    zLength=1) annotation (Placement(transformation(extent={{-8,10},{12,30}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium =
        Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  ThermofluidStream.Processes.FlowResistance flowResistance3(
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
    annotation (Placement(transformation(extent={{50,30},{70,50}})));
  ThermofluidStream.Processes.FlowResistance flowResistance4(
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
    annotation (Placement(transformation(extent={{32,-10},{52,10}})));
  ThermofluidStream.Boundaries.Sink sink2(redeclare package Medium =
        Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  FlowControl.CheckValve checkValve(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{62,-10},{82,10}})));
  Source                              source1(
    redeclare package Medium = Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-102,-30},{-82,-10}})));
  Processes.FlowResistance                   flowResistance1(
    redeclare package Medium = Medium,
    l=1,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.03,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.zetaPressureLoss (
        zeta=1,
        fromGeometry=false,
        A=0.0028))
    annotation (Placement(transformation(extent={{-58,-30},{-38,-10}})));
equation
  connect(flowResistance3.outlet, sink1.inlet) annotation (Line(
      points={{70,40},{90,40}},
      color={28,108,200},
      thickness=0.5));
  connect(tank.outlet[1], flowResistance3.inlet) annotation (Line(
      points={{12,19.5},{20,19.5},{20,40},{50,40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.inlet, tank.outlet[2]) annotation (Line(
      points={{32,0},{20,0},{20,20.5},{12,20.5}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance2.inlet) annotation (Line(
      points={{-80,20},{-58,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, tank.inlet[1]) annotation (Line(
      points={{-38,20},{-36,19.5},{-8,19.5}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, checkValve.outlet) annotation (Line(
      points={{90,0},{82,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.outlet, checkValve.inlet) annotation (Line(
      points={{52,0},{62,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance1.inlet) annotation (Line(
      points={{-82,-20},{-58,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, tank.inlet[2]) annotation (Line(
      points={{-38,-20},{-22,-20},{-22,20.5},{-8,20.5}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=150, __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end TankSelfDraining2;
