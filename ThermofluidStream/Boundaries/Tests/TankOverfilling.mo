within ThermofluidStream.Boundaries.Tests;
model TankOverfilling
extends Modelica.Icons.Example;
  import ThermofluidStream;
      package Medium =
      ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir;
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium =
        Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
  inner AccelerationBoundary                  acceleration
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=
        AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium =
        Medium,
    l=1,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.03,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
        zeta=1,
        fromGeometry=true,
        A=0.00005))
    annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
  ThermofluidStream.Processes.FlowResistance flowResistance2(
    redeclare package Medium =
        Medium,
    l=1,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.03,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
        zeta=1,
        fromGeometry=true,
        A=0.00005))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={50,10})));
  ThermofluidStream.Boundaries.TankCuboid tank1(
    redeclare package Medium = Medium,
    K=30000000,
    N_inlets=2,
    M_outlets=1,
    useHeatport=false,
    initialize_pressure=true,
    p_start=100000,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.001,0.999},
    M_liq_start=750,
    outletTransition=0.0001,
    inletPositions={{-0.1,0,0},{0,0,0}},
    outletPositions={{0,0,0}},
    tankCenter={-0.5,-0.5,-0.5},
    xLength=1,
    yLength=1,
    zLength=1)
    annotation (Placement(transformation(extent={{12,-40},{-8,-20}})));
  Processes.FlowResistance                   flowResistance3(
    redeclare package Medium = Medium,
    l=1,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.03,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.zetaPressureLoss (
        zeta=1,
        fromGeometry=true,
        A=0.00005))
    annotation (Placement(transformation(extent={{-20,-40},{-40,-20}})));
  Sink sink(redeclare package Medium =
        Medium,p0_par=100000)
    annotation (Placement(transformation(extent={{-58,-40},{-78,-20}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    T0_par=295.15,
    p0_par=101000,
    Xi0_par={0,1})
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,58})));
  ThermofluidStream.FlowControl.CheckValve checkValve(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={30,-50})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{80,-70},{60,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, sink.inlet) annotation (Line(
      points={{-40,-30},{-58,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, tank1.inlet[1]) annotation (Line(
      points={{50,0},{50,-30.5},{12,-30.5}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance2.inlet) annotation (Line(
      points={{50,48},{50,20}},
      color={28,108,200},
      thickness=0.5));
  connect(tank1.outlet[1], flowResistance3.inlet) annotation (Line(
      points={{-8,-30},{-20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, checkValve.inlet) annotation (Line(
      points={{40,-70},{30,-70},{30,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(checkValve.outlet, tank1.inlet[2]) annotation (Line(
      points={{30,-40},{30,-29.5},{12,-29.5}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000, __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end TankOverfilling;
