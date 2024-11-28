within ThermofluidStream.Undirected.Boundaries.Tests;
model Tank_selfDraining
  extends Modelica.Icons.Example;
      package Medium =
      ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir;
  TankCuboid tank(
    redeclare package Medium = Medium,
    N_inlets=0,
    initialize_energy=true,
    T_start=293.15,
    initialize_Xi=false,
    Xi_0={0.001,0.999},
    M_liq_start=600,
    outletTransition=0.001,
    N_outlets=0,
    tankCenter={0.5,0.5,0.5},
    rearPositions={{0,0,0.8},{0,0,1}},
    forePositions={{0,0,0.5},{0,0,0.1}},
    xLength=1,
    yLength=1,
    zLength=1) annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  inner ThermofluidStream.Boundaries.AccelerationBoundary acceleration(
                               az=-dropOfCommons.g*10)
    annotation (Placement(transformation(extent={{-78,-86},{-58,-66}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=
        AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-58,-82},{-38,-62}})));
  BoundaryFore boundaryFore(redeclare package Medium = Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{58,-36},{78,-16}})));
  BoundaryRear boundaryRear(redeclare package Medium = Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-96,12},{-76,32}})));
  Processes.FlowResistance flowResistance3(redeclare package Medium = Medium,
    r=0.03,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=1))
    annotation (Placement(transformation(extent={{-56,10},{-36,30}})));
  BoundaryFore boundaryFore1(redeclare package Medium = Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{68,-54},{88,-34}})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium,
    r=0.03,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=1))
    annotation (Placement(transformation(extent={{-52,-22},{-32,-2}})));
  Processes.FlowResistance flowResistance5(
    redeclare package Medium = Medium,
    r=0.03,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=1))
    annotation (Placement(transformation(extent={{30,-54},{50,-34}})));
  Processes.FlowResistance flowResistance6(
    redeclare package Medium = Medium,
    r=0.03,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=1))
    annotation (Placement(transformation(extent={{26,-34},{46,-14}})));
  BoundaryRear boundaryRear1(
    redeclare package Medium = Medium,
    T0_par=295.15,
    p0_par=100000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-94,-20},{-74,0}})));
equation
  connect(boundaryRear1.fore, flowResistance4.rear) annotation (Line(
      points={{-74,-10},{-60,-10},{-60,-12},{-52,-12}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear.fore, flowResistance3.rear) annotation (Line(
      points={{-76,22},{-64,22},{-64,20},{-56,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.fore, tank.rear[1]) annotation (Line(
      points={{-36,20},{-22,20},{-22,-4},{-10,-4},{-10,-2.6}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.fore, tank.rear[2]) annotation (Line(
      points={{-32,-12},{-32,-4},{-10,-4},{-10,-2.6}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.fore, boundaryFore.rear) annotation (Line(
      points={{46,-24},{46,-26},{58,-26}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.fore, boundaryFore1.rear) annotation (Line(
      points={{50,-44},{68,-44}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.rear, tank.fore[1]) annotation (Line(
      points={{26,-24},{16,-24},{16,-10},{18,-10},{18,-2.6},{9.8,-2.6}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.rear, tank.fore[2]) annotation (Line(
      points={{30,-44},{16,-44},{16,-10},{18,-10},{18,-2.6},{9.8,-2.6}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=40, __Dymola_Algorithm="Dassl"), Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end Tank_selfDraining;
