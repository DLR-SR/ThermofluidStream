within ThermofluidStream.Boundaries.Tests;
model TankChaoticLife_Test8_upsideDownTank
extends Modelica.Icons.Example;
  import ThermofluidStream;
      package Medium =
      ThermofluidStream.Media.myMedia.GasAndIncompressible.JP8DryAir;
  ThermofluidStream.Boundaries.TankCuboid tank(
    redeclare package Medium = Medium,
    gasBubbleVolume=0.001,
    tankCenter={0.5,0.5,0.5},
    N_inlets=1,
    M_outlets=1,
    useHeatport=false,
    p_start=99000,
    initialize_energy=true,
    T_start=293.15,
    Xi_0={0.01,0.99},
    M_liq_start=750,
    outletTransition=0.001,
    chaoticLife=true,
    inletPositions={{0,0,0}},
    outletPositions={{0,0,0}},
    xLength=1,
    yLength=1,
    zLength=1) annotation (Placement(transformation(extent={{-10,48},{10,68}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium =
        Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{98,-88},{78,-68}})));
  inner AccelerationBoundary                  acceleration
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
    annotation (Placement(transformation(extent={{64,-88},{44,-68}})));
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
  ThermofluidStream.Boundaries.TankCuboid tank1(
    redeclare package Medium = Medium,
    N_inlets=2,
    M_outlets=2,
    useHeatport=false,
    initialize_pressure=true,
    p_start=100000,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.001,0.999},
    M_liq_start=0,
    outletTransition=0.001,
    inletPositions={{-0.1,0,0},{0,0,0}},
    outletPositions={{-0.1,0,0},{0,0,0}},
    tankCenter={-0.5,-0.5,-0.5},
    xLength=1,
    yLength=1,
    zLength=1)
    annotation (Placement(transformation(extent={{14,-66},{-6,-46}})));
  Processes.FlowResistance                   flowResistance1(
    redeclare package Medium = Medium,
    l=1,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.03,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.zetaPressureLoss (
        zeta=1,
        fromGeometry=true,
        A=0.00005))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-42,12})));
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
    annotation (Placement(transformation(extent={{-14,-94},{-34,-74}})));
  Sink sink(redeclare package Medium =
        Medium,p0_par=100000)
    annotation (Placement(transformation(extent={{-40,-94},{-60,-74}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{78,-78},{64,-78}},
      color={28,108,200},
      thickness=0.5));
  connect(tank.outlet[1], flowResistance2.inlet) annotation (Line(
      points={{10,58},{58,58},{58,24}},
      color={28,108,200},
      thickness=0.5));
  connect(tank1.outlet[1], flowResistance1.inlet) annotation (Line(
      points={{-6,-56.5},{-42,-56.5},{-42,2}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.inlet, tank1.outlet[2]) annotation (Line(
      points={{-14,-84},{-6,-84},{-6,-70},{-14,-70},{-14,-55.5},{-6,-55.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, sink.inlet) annotation (Line(
      points={{-34,-84},{-40,-84}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, tank1.inlet[2]) annotation (Line(
      points={{44,-78},{28,-78},{28,-55.5},{14,-55.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, tank1.inlet[1]) annotation (Line(
      points={{58,4},{58,-56},{50,-56},{50,-56.5},{14,-56.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, tank.inlet[1]) annotation (Line(
      points={{-42,22},{-42,58},{-10,58}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=200, __Dymola_Algorithm="Dassl"));
end TankChaoticLife_Test8_upsideDownTank;
