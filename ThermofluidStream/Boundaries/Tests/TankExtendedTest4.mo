within ThermofluidStream.Boundaries.Tests;
model TankExtendedTest4
  extends Modelica.Icons.Example;
      package Medium =
      ThermofluidStream.Media.myMedia.GasAndIncompressible.JP8DryAir;
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
    annotation (Placement(transformation(extent={{-52,-8},{-32,12}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium =
        Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
  inner AccelerationBoundary                  acceleration
    annotation (Placement(transformation(extent={{-88,-86},{-68,-66}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=
        AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-58,-82},{-38,-62}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium =
        Medium,
    T0_par=293.15,
    p0_par=103000,
    Xi0_par={0,1})
    annotation (Placement(transformation(extent={{-104,-18},{-84,2}})));
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
    annotation (Placement(transformation(extent={{-76,10},{-56,30}})));
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
    annotation (Placement(transformation(extent={{-74,-22},{-54,-2}})));
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
    annotation (Placement(transformation(extent={{-24,-8},{-4,12}})));
  TankCuboid tank1(
    redeclare package Medium = Medium,
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
    annotation (Placement(transformation(extent={{38,-48},{58,-28}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium =
        Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{116,-54},{136,-34}})));
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
    annotation (Placement(transformation(extent={{90,-54},{110,-34}})));
  ThermofluidStream.Processes.StaticHead staticHead(
    redeclare package Medium =
        Medium,
    fromPosition={0,1,0},
    toPosition={0,0,-0.5},
    displayPositions=true)
    annotation (Placement(transformation(extent={{6,-8},{26,12}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
    Q_flow=50000,
    T_ref=318.15,
    alpha=1)
    annotation (Placement(transformation(extent={{22,-88},{42,-68}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-90,20},{-76,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, tank.inlet[1]) annotation (Line(
      points={{-56,20},{-56,10},{-60,10},{-60,1.5},{-52,1.5}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance1.inlet) annotation (Line(
      points={{-84,-8},{-84,-12},{-74,-12}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, tank.inlet[2]) annotation (Line(
      points={{-54,-12},{-52,-12},{-52,2.5}},
      color={28,108,200},
      thickness=0.5));
  connect(tank.outlet[1], flowResistance2.inlet) annotation (Line(
      points={{-32,2},{-24,2}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, sink1.inlet) annotation (Line(
      points={{110,-44},{116,-44}},
      color={28,108,200},
      thickness=0.5));
  connect(tank1.outlet[1], flowResistance3.inlet) annotation (Line(
      points={{58,-38},{80,-38},{80,-44},{90,-44}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, staticHead.inlet) annotation (Line(
      points={{-4,2},{6,2}},
      color={28,108,200},
      thickness=0.5));
  connect(staticHead.outlet, tank1.inlet[1]) annotation (Line(
      points={{26,2},{36,2},{36,-24},{30,-24},{30,-38},{38,-38}},
      color={28,108,200},
      thickness=0.5));
  connect(tank1.heatPort, fixedHeatFlow.port)
    annotation (Line(points={{48,-46},{48,-78},{42,-78}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2000, __Dymola_Algorithm="Dassl"));
end TankExtendedTest4;
