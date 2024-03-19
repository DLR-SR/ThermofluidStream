within ThermofluidStream.FlowControl.Tests;
model TanValve "Test for TanValve"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium "Medium package"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{52,-82},{72,-62}})));
  Boundaries.Source source(redeclare package Medium=Medium,
    pressureFromInput=true, T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-106,-10},{-86,10}})));
  Boundaries.Sink sink(redeclare package Medium=Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
  FlowControl.TanValve tanValve(redeclare package Medium = Medium, invertInput=false)
    annotation (Placement(transformation(extent={{16,26},{36,46}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{96,26},{116,46}})));
  Topology.SplitterT2 splitterT2_1(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-24,-10},{-4,10}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-78,0},{-58,20}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{26,0},{46,20}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-12,36},{8,56}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{44,36},{64,56}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=2,
    offset=0,
    startTime=50)
    annotation (Placement(transformation(extent={{-12,64},{8,84}})));
  Modelica.Blocks.Sources.Constant const(k=1.2e5)
    annotation (Placement(transformation(extent={{-126,20},{-106,40}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{68,26},{88,46}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{64,-10},{84,10}})));
equation
  connect(flowResistance.outlet, splitterT2_1.inlet) annotation (Line(
      points={{-32,0},{-24,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, multiSensor_Tpm.inlet) annotation (Line(
      points={{-86,0},{-78,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, multiSensor_Tpm.outlet) annotation (Line(
      points={{-52,0},{-58,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletB, multiSensor_Tpm1.inlet) annotation (Line(
      points={{-4,0},{26,0}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{16,36},{8,36}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletA, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-14,10},{-14,36},{-12,36}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.inlet, tanValve.outlet) annotation (Line(
      points={{44,36},{36,36}},
      color={28,108,200},
      thickness=0.5));
  connect(source.p0_var, const.y) annotation (Line(points={{-98,6},{-102,6},{-102,30},{-105,30}},
                          color={0,0,127}));
  connect(sink1.inlet, flowResistance1.outlet) annotation (Line(
      points={{96,36},{88,36}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, flowResistance1.inlet) annotation (Line(
      points={{64,36},{68,36}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, flowResistance2.inlet) annotation (Line(
      points={{46,0},{64,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance2.outlet) annotation (Line(
      points={{98,0},{84,0}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp.y, tanValve.u)
    annotation (Line(points={{9,74},{26,74},{26,44}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-120,-100},{120,100}})),
    experiment(StopTime=100, Tolerance=1e-6, Interval=0.1, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Test for the TanValve.</p>
<p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end TanValve;
