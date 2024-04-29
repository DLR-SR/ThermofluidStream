within ThermofluidStream.Boundaries.Tests;
model TankExtendedTest7_fillingClosedTank
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
    outletTransition=0.001,
    inletPositions={{0,0,1},{0,1,0}},
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
    useHeatport=false,
    initialize_pressure=true,
    p_start=100000,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.001,0.999},
    M_liq_start=500,
    outletTransition=0.001,
    inletPositions={{0,0,-0.7}},
    outletPositions={{0,0,-0.7}},
    tankCenter={-0.5,-0.5,-0.5},
    xLength=1,
    yLength=1,
    zLength=1)
    annotation (Placement(transformation(extent={{38,-48},{58,-28}})));
  Processes.StaticHead staticHead(redeclare package Medium = Medium, fromPosition={0,1,0}, toPosition={0,0,-0.7})
    annotation (Placement(transformation(extent={{4,-8},{24,12}})));
  Processes.FlowResistance                   flowResistance1(
    redeclare package Medium = Medium,
    l=1,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.03,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.zetaPressureLoss (
        zeta=1,
        fromGeometry=false,
        A=0.0028))
    annotation (Placement(transformation(extent={{30,-60},{10,-40}})));
  Processes.StaticHead staticHead1(redeclare package Medium = Medium,fromPosition={0,0,-0.7}, toPosition={0,1,0})
    annotation (Placement(transformation(extent={{-6,-60},{-26,-40}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-90,20},{-76,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, tank.inlet[1]) annotation (Line(
      points={{-56,20},{-56,10},{-60,10},{-60,1.5},{-52,1.5}},
      color={28,108,200},
      thickness=0.5));
  connect(tank.outlet[1], flowResistance2.inlet) annotation (Line(
      points={{-32,2},{-24,2}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, staticHead.inlet) annotation (Line(
      points={{-4,2},{4,2}},
      color={28,108,200},
      thickness=0.5));
  connect(staticHead.outlet, tank1.inlet[1]) annotation (Line(
      points={{24,2},{32,2},{32,-30},{30,-30},{30,-38},{38,-38}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, staticHead1.inlet) annotation (Line(
      points={{10,-50},{-6,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(tank1.outlet[1], flowResistance1.inlet) annotation (Line(
      points={{58,-38},{58,-56},{30,-56},{30,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(staticHead1.outlet, tank.inlet[2]) annotation (Line(
      points={{-26,-50},{-44,-50},{-44,-44},{-52,-44},{-52,2.5}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=20, __Dymola_Algorithm="Dassl"));
end TankExtendedTest7_fillingClosedTank;
