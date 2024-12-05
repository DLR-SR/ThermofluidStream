within ThermofluidStream.Undirected.Boundaries.Tests;
model Tank_fillingClosedTank
  extends Modelica.Icons.Example;
      package Medium =
      ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir;
  TankCuboid tank(
    redeclare package Medium = Medium,
    N_inlets=1,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.01,0.99},
    M_liq_start=750,
    outletTransition=0.001,
    N_outlets=0,
    N_rears=0,
    N_fores=1,
    inletPositions={{0,0,1}},
    tankCenter={0.5,0.5,0.5},
    forePositions={{0,1,0}},
    xLength=1,
    yLength=1,
    zLength=1)
    annotation (Placement(transformation(extent={{-40,-6},{-20,14}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium =
        Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-104,-2},{-84,18}})));
  inner ThermofluidStream.Boundaries.AccelerationBoundary acceleration
    annotation (Placement(transformation(extent={{-88,-86},{-68,-66}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=
        AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-58,-82},{-38,-62}})));
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
    annotation (Placement(transformation(extent={{-70,-2},{-50,18}})));
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
    M_liq_start=500,
    outletTransition=0.001,
    N_outlets=0,
    N_rears=1,
    N_fores=0,
    tankCenter={-0.5,-0.5,-0.5},
    rearPositions={{0,0,-0.7}},
    xLength=1,
    yLength=1,
    zLength=1)
    annotation (Placement(transformation(extent={{66,-6},{86,14}})));
  Processes.StaticHead staticHead2(redeclare package Medium = Medium,forePosition={0,0,-0.7}, rearPosition={0,0,1})
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Processes.FlowResistance flowResistance3(redeclare package Medium = Medium,
    r=0.03,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=1))
    annotation (Placement(transformation(extent={{34,-10},{54,10}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-84,8},{-70,8}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, tank.inlet[1]) annotation (Line(
      points={{-50,8},{-39.8,8}},
      color={28,108,200},
      thickness=0.5));
  connect(tank.fore[1], staticHead2.rear) annotation (Line(
      points={{-20.2,-0.6},{-18,0},{0,0}},
      color={28,108,200},
      thickness=0.5));
  connect(staticHead2.fore, flowResistance3.rear) annotation (Line(
      points={{20,0},{34,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.fore, tank1.rear[1]) annotation (Line(
      points={{54,0},{52,0},{52,-0.6},{66,-0.6}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=20, __Dymola_Algorithm="Dassl"),Documentation( revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end Tank_fillingClosedTank;
