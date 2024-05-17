within ThermofluidStream.Undirected.Boundaries.Tests;
model Tank_overfilling
extends Modelica.Icons.Example;
  import ThermofluidStream;
      package Medium =
      ThermofluidStream.Media.myMedia.GasAndIncompressible.JP8DryAir;
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium =
        Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{122,-88},{102,-68}})));
  inner ThermofluidStream.Boundaries.AccelerationBoundary acceleration
    annotation (Placement(transformation(extent={{-88,-86},{-68,-66}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=
        AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-96,-54},{-76,-34}})));
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
    annotation (Placement(transformation(extent={{88,-88},{68,-68}})));
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
        origin={58,14})));
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
    annotation (Placement(transformation(extent={{14,-66},{-6,-46}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    T0_par=295.15,
    p0_par=500000,
    Xi0_par={0,1})
    annotation (Placement(transformation(extent={{100,26},{80,46}})));
  ThermofluidStream.FlowControl.CheckValve checkValve(redeclare package Medium
      =                                                                          Medium)
    annotation (Placement(transformation(extent={{62,-88},{42,-68}})));
  ThermofluidStream.Undirected.Boundaries.BoundaryFore
               boundaryFore1(
    redeclare package Medium = Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-56,-44},{-76,-24}})));
  ThermofluidStream.Undirected.Processes.FlowResistance
                           flowResistance5(
    redeclare package Medium = Medium,
    r=0.03/1.4,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=1))
    annotation (Placement(transformation(extent={{-24,-44},{-44,-24}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{102,-78},{88,-78}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, tank1.inlet[1]) annotation (Line(
      points={{58,4},{58,-56},{50,-56},{50,-52.5},{13.8,-52.5}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance2.inlet) annotation (Line(
      points={{80,36},{70,36},{70,38},{58,38},{58,24}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, checkValve.inlet) annotation (Line(
      points={{68,-78},{62,-78}},
      color={28,108,200},
      thickness=0.5));
  connect(checkValve.outlet, tank1.inlet[2]) annotation (Line(
      points={{42,-78},{30,-78},{30,-52},{13.8,-52},{13.8,-51.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.fore,boundaryFore1. rear) annotation (Line(
      points={{-44,-34},{-56,-34}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.rear, tank1.fore[1]) annotation (Line(
      points={{-24,-34},{-22,-34},{-22,-60.6},{-5.8,-60.6}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000, __Dymola_Algorithm="Dassl"));
end Tank_overfilling;
