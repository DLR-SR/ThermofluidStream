within ThermofluidStream.Undirected.Boundaries.Tests;
model Tank_upsideDownBottle
  extends Modelica.Icons.Example;
      package Medium =
      ThermofluidStream.Media.myMedia.GasAndIncompressible.JP8DryAir;
  TankCuboid tank(
    redeclare package Medium = Medium,
    chaoticLife=false,
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
    annotation (Placement(transformation(extent={{-10,48},{10,68}})));
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
    annotation (Placement(transformation(extent={{14,-66},{-6,-46}})));
  Processes.FlowResistance flowResistance(
  redeclare package Medium = Medium,
    r=0.03,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=1))
    annotation (Placement(transformation(extent={{-22,-78},{-42,-58}})));
  Processes.FlowResistance flowResistance3(
  redeclare package Medium = Medium,
    r=0.01,
    l=0.02,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=1)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-2,12})));
  BoundaryFore boundaryFore(
  redeclare package Medium = Medium,
    T0_par=293.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-50,-64},{-70,-44}})));
equation
  connect(flowResistance3.rear, tank.fore[1]) annotation (Line(
      points={{-2,22},{-2,44},{18,44},{18,53.4},{9.8,53.4}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.fore, tank1.rear[1]) annotation (Line(
      points={{-2,2},{-2,-42},{22,-42},{22,-60.6},{14,-60.6}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.fore, boundaryFore.rear) annotation (Line(
      points={{-42,-68},{-48,-68},{-48,-60},{-44,-60},{-44,-54},{-50,-54}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.rear, tank1.fore[1]) annotation (Line(
      points={{-22,-68},{-14,-68},{-14,-60.6},{-5.8,-60.6}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2000, __Dymola_Algorithm="Dassl"));
end Tank_upsideDownBottle;
