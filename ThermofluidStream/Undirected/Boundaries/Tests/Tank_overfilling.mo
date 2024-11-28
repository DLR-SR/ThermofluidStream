within ThermofluidStream.Undirected.Boundaries.Tests;
model Tank_overfilling
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
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  inner ThermofluidStream.Boundaries.AccelerationBoundary acceleration
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
        fromGeometry=true,
        A=0.00005))
    annotation (Placement(transformation(extent={{66,-40},{46,-20}})));
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
        origin={30,10})));
  ThermofluidStream.Undirected.Boundaries.TankCuboid
                                          tank1(
    redeclare package Medium = Medium,
    chaoticLife=false,
    K=20000000,
    N_inlets=2,
    useHeatport=false,
    initialize_pressure=true,
    p_start=100000,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.001,0.999},
    M_liq_start=750,
    outletTransition=0.0001,
    N_outlets=0,
    N_rears=0,
    N_fores=1,
    inletPositions={{-0.1,0,0},{0,0,0}},
    tankCenter={-0.5,-0.5,-0.5},
    forePositions={{0,0,0}},
    xLength=1,
    yLength=1,
    zLength=1)
    annotation (Placement(transformation(extent={{-6,-20},{-26,0}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    T0_par=295.15,
    p0_par=500000,
    Xi0_par={0,1})
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,50})));
  ThermofluidStream.FlowControl.CheckValve checkValve(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
  ThermofluidStream.Undirected.Boundaries.BoundaryFore
               boundaryFore1(
    redeclare package Medium = Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-80,-24},{-100,-4}})));
  ThermofluidStream.Undirected.Processes.FlowResistance
                           flowResistance5(
    redeclare package Medium = Medium,
    r=0.03/1.4,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=1))
    annotation (Placement(transformation(extent={{-46,-24},{-66,-4}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{80,-30},{66,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, tank1.inlet[1]) annotation (Line(
      points={{30,0},{30,-8},{8,-8},{8,-6.5},{-6.2,-6.5}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance2.inlet) annotation (Line(
      points={{30,40},{30,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, checkValve.inlet) annotation (Line(
      points={{46,-30},{40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(checkValve.outlet, tank1.inlet[2]) annotation (Line(
      points={{20,-30},{8,-30},{8,-5.5},{-6.2,-5.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.fore,boundaryFore1. rear) annotation (Line(
      points={{-66,-14},{-80,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.rear, tank1.fore[1]) annotation (Line(
      points={{-46,-14},{-34,-14},{-34,-14.6},{-25.8,-14.6}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000, __Dymola_Algorithm="Dassl"),Documentation( revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end Tank_overfilling;
