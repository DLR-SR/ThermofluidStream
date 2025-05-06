within ThermofluidStream.Undirected.Boundaries.Tests;
model Tank_upsideDownBottle
  extends Modelica.Icons.Example;
      package Medium =
      ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir;
  TankCuboid tank(
    redeclare package Medium = Medium,
    N_inlets=0,
    useHeatport=false,
    p_start=99000,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.01,0.99},
    M_liq_start=0.38,
    outletTransition=0.001,
    N_outlets=0,
    N_rears=0,
    N_fores=1,
    tankCenter={0.025,0.025,0.1},
    forePositions={{0,0,0}},
    xLength=0.05,
    yLength=0.05,
    zLength=0.2)
    annotation (Placement(transformation(extent={{0,38},{20,58}})));
  inner ThermofluidStream.Boundaries.AccelerationBoundary acceleration
    annotation (Placement(transformation(extent={{-88,-86},{-68,-66}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=
        AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-96,-54},{-76,-34}})));
  TankCuboid tank1(
    redeclare package Medium = Medium,
    N_inlets=0,
    useHeatport=false,
    initialize_pressure=true,
    p_start=100000,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.001,0.999},
    M_liq_start=0.1,
    outletTransition=0.001,
    N_outlets=0,
    N_rears=1,
    N_fores=1,
    tankCenter={-0.05,-0.05,-0.1},
    rearPositions={{0,0,0}},
    forePositions={{-0.01,0,0}},
    xLength=0.1,
    yLength=0.1,
    zLength=0.2)
    annotation (Placement(transformation(extent={{34,-76},{14,-56}})));
  Processes.FlowResistance flowResistance(
  redeclare package Medium = Medium,
    r=0.03,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=1))
    annotation (Placement(transformation(extent={{0,-80},{-20,-60}})));
  Processes.FlowResistance flowResistance3(
  redeclare package Medium = Medium,
    r=0.01,
    l=0.02,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=1)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={42,0})));
  BoundaryFore boundaryFore(
  redeclare package Medium = Medium,
    T0_par=293.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-40,-80},{-60,-60}})));
equation
  connect(flowResistance3.rear, tank.fore[1]) annotation (Line(
      points={{42,10},{42,43.4},{19.8,43.4}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.fore, tank1.rear[1]) annotation (Line(
      points={{42,-10},{42,-70.6},{34,-70.6}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.fore, boundaryFore.rear) annotation (Line(
      points={{-20,-70},{-40,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.rear, tank1.fore[1]) annotation (Line(
      points={{0,-70},{0,-70.6},{14.2,-70.6}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2000, __Dymola_Algorithm="Dassl"),Documentation( revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end Tank_upsideDownBottle;
