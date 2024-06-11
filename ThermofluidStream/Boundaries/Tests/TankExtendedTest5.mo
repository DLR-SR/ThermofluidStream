within ThermofluidStream.Boundaries.Tests;
model TankExtendedTest5
  extends Modelica.Icons.Example;
      package Medium =
      ThermofluidStream.Media.myMedia.GasAndIncompressible.JP8DryAir;
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
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  TankCuboid tank(
    redeclare package Medium = Medium,
    N_inlets=2,
    M_outlets=2,
    p_start=90000,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.001,0.999},
    M_liq_start=700,
    outletTransition=0.001,
    inletPositions={{0,0,0},{0,0,0}},
    outletPositions={{-0.5,0,-1},{0,0,-0.5}},
    tankCenter={-0.5,-0.5,-0.5},
    xLength=1,
    yLength=1,
    zLength=1) annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium =
        Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{88,30},{108,50}})));
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
    annotation (Placement(transformation(extent={{36,30},{56,50}})));
  ThermofluidStream.Processes.FlowResistance flowResistance4(
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
    annotation (Placement(transformation(extent={{38,-10},{58,10}})));
  ThermofluidStream.Boundaries.Sink sink2(redeclare package Medium =
        Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{88,-10},{108,10}})));
  FlowControl.CheckValve checkValve(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{60,-12},{80,8}})));
  Source                              source1(
    redeclare package Medium = Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-106,-34},{-86,-14}})));
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
    annotation (Placement(transformation(extent={{-76,-34},{-56,-14}})));
equation
  connect(flowResistance3.outlet, sink1.inlet) annotation (Line(
      points={{56,40},{88,40}},
      color={28,108,200},
      thickness=0.5));
  connect(tank.outlet[1], flowResistance3.inlet) annotation (Line(
      points={{0,19.5},{0,40},{36,40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.inlet, tank.outlet[2]) annotation (Line(
      points={{38,0},{0,0},{0,20.5}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance2.inlet) annotation (Line(
      points={{-90,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, tank.inlet[1]) annotation (Line(
      points={{-60,20},{-40,20},{-40,19.5},{-20,19.5}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, checkValve.outlet) annotation (Line(
      points={{88,0},{88,-2},{80,-2}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.outlet, checkValve.inlet) annotation (Line(
      points={{58,0},{58,-2},{60,-2}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance1.inlet) annotation (Line(
      points={{-86,-24},{-76,-24}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, tank.inlet[2]) annotation (Line(
      points={{-56,-24},{-38,-24},{-38,-22},{-20,-22},{-20,20.5}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=150, __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end TankExtendedTest5;
