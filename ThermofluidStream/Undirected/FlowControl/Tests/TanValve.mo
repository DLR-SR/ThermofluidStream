within ThermofluidStream.Undirected.FlowControl.Tests;
model TanValve "Test for undirected TanValve"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium package"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{52,-82},{72,-62}})));
  Boundaries.BoundaryRear boundary_rear(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300) annotation (Placement(transformation(extent={{-106,-10},{-86,10}})));
  Boundaries.BoundaryFore boundary_fore(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  FlowControl.TanValve tanValve(redeclare package Medium = Medium, invertInput=false)
    annotation (Placement(transformation(extent={{16,26},{36,46}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss =
      ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss(
        material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
  Boundaries.BoundaryFore boundary_fore1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{96,26},{116,46}})));
  Topology.JunctionRFF2 junctionRFF2_1(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-24,-10},{-4,10}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-78,-2},{-58,18}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{26,-2},{46,18}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-12,34},{8,54}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{42,34},{62,54}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=2,
    offset=0,
    startTime=50)
    annotation (Placement(transformation(extent={{-12,64},{8,84}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss(
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{68,26},{88,46}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss(
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{64,-10},{84,10}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=4e4,
    period=10,
    offset=0.8e5)
    annotation (Placement(transformation(extent={{-138,-10},{-118,10}})));
equation
  connect(ramp.y, tanValve.u)
    annotation (Line(points={{9,74},{26,74},{26,44}}, color={0,0,127}));
  connect(flowResistance1.rear, multiSensor_Tpm3.fore) annotation (Line(
      points={{68,36},{62,36}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore1.rear, flowResistance1.fore) annotation (Line(
      points={{96,36},{88,36}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore.rear, flowResistance2.fore) annotation (Line(
      points={{96,0},{84,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.rear, multiSensor_Tpm1.fore) annotation (Line(
      points={{64,0},{46,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.rear, junctionRFF2_1.foreB) annotation (Line(
      points={{26,0},{-4,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.fore, tanValve.rear) annotation (Line(
      points={{8,36},{16,36}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.rear, junctionRFF2_1.foreA)
    annotation (Line(
      points={{-12,36},{-14,36},{-14,10}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionRFF2_1.rear, flowResistance.fore) annotation (Line(
      points={{-24,0},{-32,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.rear, multiSensor_Tpm.fore) annotation (Line(
      points={{-52,0},{-58,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.rear, boundary_rear.fore) annotation (Line(
      points={{-78,0},{-86,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.rear, tanValve.fore) annotation (Line(
      points={{42,36},{36,36}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse.y, boundary_rear.p0_var) annotation (Line(points={{-117,0},{-108,0},{-108,6},{-98,6}},
                                                                                     color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-120,-100},{120,100}})),
    experiment(StopTime=100, Tolerance=1e-6, Interval=0.1, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end TanValve;
