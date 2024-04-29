within ThermofluidStream.Boundaries.Tests;
model Tank_Test10_overfilling
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
  ThermofluidStream.Boundaries.TankCuboid tank1(
    redeclare package Medium = Medium,
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
    annotation (Placement(transformation(extent={{14,-66},{-6,-46}})));
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
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    T0_par=295.15,
    p0_par=101000,
    Xi0_par={0,1})
    annotation (Placement(transformation(extent={{100,26},{80,46}})));
  ThermofluidStream.FlowControl.CheckValve checkValve(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{62,-88},{42,-68}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{102,-78},{88,-78}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, sink.inlet) annotation (Line(
      points={{-34,-84},{-40,-84}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, tank1.inlet[1]) annotation (Line(
      points={{58,4},{58,-56},{50,-56},{50,-56.5},{14,-56.5}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance2.inlet) annotation (Line(
      points={{80,36},{70,36},{70,38},{58,38},{58,24}},
      color={28,108,200},
      thickness=0.5));
  connect(tank1.outlet[1], flowResistance3.inlet) annotation (Line(
      points={{-6,-56},{-14,-56},{-14,-70},{-6,-70},{-6,-84},{-14,-84}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, checkValve.inlet) annotation (Line(
      points={{68,-78},{62,-78}},
      color={28,108,200},
      thickness=0.5));
  connect(checkValve.outlet, tank1.inlet[2]) annotation (Line(
      points={{42,-78},{30,-78},{30,-76},{14,-76},{14,-55.5}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000, __Dymola_Algorithm="Dassl"));
end Tank_Test10_overfilling;
