within ThermofluidStream.Boundaries.Tests;
model TankHeating
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
    outletTransition=0.00001,
    inletPositions={{0,0,1},{0,0,0.5}},
    outletPositions={{0,1,0}},
    tankCenter={0.5,0.5,0.5},
    xLength=1,
    yLength=1,
    zLength=1)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium =
        Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  inner AccelerationBoundary                  acceleration
    annotation (Placement(transformation(extent={{-92,-80},{-72,-60}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=
        AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium =
        Medium,
    T0_par=293.15,
    p0_par=103000,
    Xi0_par={0,1})
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
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
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  ThermofluidStream.Processes.FlowResistance flowResistance1(
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
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
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
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  TankCuboid tank1(
    redeclare package Medium = Medium,
    A=10,
    U=1000,
    N_inlets=1,
    M_outlets=1,
    useHeatport=true,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=true,
    Xi_0={0.001,0.999},
    outletTransition=0.00001,
    inletPositions={{0,0,-0.5}},
    outletPositions={{-0.5,0,-1.3}},
    tankCenter={-0.5,-0.5,-1},
    xLength=1,
    yLength=1,
    zLength=1)
    annotation (Placement(transformation(extent={{10,-40},{-10,-20}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium =
        Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-80,-40},{-100,-20}})));
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
    annotation (Placement(transformation(extent={{-40,-40},{-60,-20}})));
  ThermofluidStream.Processes.StaticHead staticHead(
    redeclare package Medium = Medium,
    fromPosition={0,1,0},
    toPosition={0,0,-0.5},
    displayPositions=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={62,0})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
    Q_flow=12000,
    T_ref=318.15,
    alpha=1)
    annotation (Placement(transformation(extent={{-30,-78},{-10,-58}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-80,60},{-60,60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, tank.inlet[1]) annotation (Line(
      points={{-40,60},{-20,60},{-20,39.5},{-10,39.5}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance1.inlet) annotation (Line(
      points={{-80,20},{-60,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, tank.inlet[2]) annotation (Line(
      points={{-40,20},{-20,20},{-20,40.5},{-10,40.5}},
      color={28,108,200},
      thickness=0.5));
  connect(tank.outlet[1], flowResistance2.inlet) annotation (Line(
      points={{10,40},{20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, sink1.inlet) annotation (Line(
      points={{-60,-30},{-80,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(tank1.outlet[1], flowResistance3.inlet) annotation (Line(
      points={{-10,-30},{-40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, staticHead.inlet) annotation (Line(
      points={{40,40},{62,40},{62,10}},
      color={28,108,200},
      thickness=0.5));
  connect(staticHead.outlet, tank1.inlet[1]) annotation (Line(
      points={{62,-10},{62,-30},{10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(tank1.heatPort, fixedHeatFlow.port)
    annotation (Line(points={{0,-38},{0,-68},{-10,-68}},  color={191,0,0}));
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
end TankHeating;
