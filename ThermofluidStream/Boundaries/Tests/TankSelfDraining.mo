within ThermofluidStream.Boundaries.Tests;
model TankSelfDraining
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
    Xi_0={0.001,0.999},
    M_liq_start=600,
    outletTransition=0.001,
    inletPositions={{0,0,1},{0,0,1}},
    outletPositions={{0,1,0}},
    tankCenter={0.5,0.5,0.5},
    xLength=1,
    yLength=1,
    zLength=1) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium =
        Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium =
        Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  inner AccelerationBoundary                  acceleration(
              az=-dropOfCommons.g*10)
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=
        AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-58,-82},{-38,-62}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium =
        Medium,
    T0_par=293.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
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
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
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
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  ThermofluidStream.Processes.FlowResistance flowResistance2(
    redeclare package Medium =
        Medium,
    l=1,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.03/10,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=1))
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-60,30},{-40,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, tank.inlet[1]) annotation (Line(
      points={{-20,30},{-10,30},{-10,-0.5},{0,-0.5}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance1.inlet) annotation (Line(
      points={{-60,-30},{-40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, tank.inlet[2]) annotation (Line(
      points={{-20,-30},{-10,-30},{-10,0.5},{0,0.5}},
      color={28,108,200},
      thickness=0.5));
  connect(tank.outlet[1], flowResistance2.inlet) annotation (Line(
      points={{20,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, sink.inlet) annotation (Line(
      points={{50,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5000, __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end TankSelfDraining;
