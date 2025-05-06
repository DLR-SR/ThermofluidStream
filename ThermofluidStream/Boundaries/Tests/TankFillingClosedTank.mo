within ThermofluidStream.Boundaries.Tests;
model TankFillingClosedTank
  extends Modelica.Icons.Example;
      package Medium =
      ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir;
  TankCuboid tank(
    redeclare package Medium = Medium,
    N_inlets=2,
    M_outlets=1,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.01,0.99},
    M_liq_start=750,
    outletTransition=0.001,
    inletPositions={{0,0,1},{0,1,0}},
    outletPositions={{0,1,0}},
    tankCenter={0.5,0.5,0.5},
    xLength=1,
    yLength=1,
    zLength=1)
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium =
        Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  inner AccelerationBoundary                  acceleration
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=
        AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
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
    annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
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
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  TankCuboid tank1(
    redeclare package Medium = Medium,
    N_inlets=1,
    M_outlets=1,
    useHeatport=false,
    initialize_pressure=true,
    p_start=100000,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.001,0.999},
    M_liq_start=500,
    outletTransition=0.001,
    inletPositions={{0,0,-0.7}},
    outletPositions={{0,0,-0.7}},
    tankCenter={-0.5,-0.5,-0.5},
    xLength=1,
    yLength=1,
    zLength=1)
    annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
  Processes.StaticHead staticHead(
    redeclare package Medium = Medium,
    fromPosition={0,1,0},
    toPosition={0,0,-0.7})
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
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
    annotation (Placement(transformation(extent={{20,-40},{0,-20}})));
  Processes.StaticHead staticHead1(
    redeclare package Medium = Medium,
    fromPosition={0,0,-0.7},
    toPosition={0,1,0})
    annotation (Placement(transformation(extent={{-10,-40},{-30,-20}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-80,30},{-72,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, tank.inlet[1]) annotation (Line(
      points={{-52,30},{-50,29.5},{-30,29.5}},
      color={28,108,200},
      thickness=0.5));
  connect(tank.outlet[1], flowResistance2.inlet) annotation (Line(
      points={{-10,30},{0,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, staticHead.inlet) annotation (Line(
      points={{20,30},{40,30}},
      color={28,108,200},
      thickness=0.5));
  connect(staticHead.outlet, tank1.inlet[1]) annotation (Line(
      points={{60,30},{70,30},{70,-30},{60,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, staticHead1.inlet) annotation (Line(
      points={{0,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(tank1.outlet[1], flowResistance1.inlet) annotation (Line(
      points={{40,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(staticHead1.outlet, tank.inlet[2]) annotation (Line(
      points={{-30,-30},{-38,-30},{-38,30.5},{-30,30.5}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=20, __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end TankFillingClosedTank;
