within ThermofluidStream.FlowControl.Tests;
model SpecificValveType "Test for SpecificValveType"
  extends Modelica.Icons.Example;

  replaceable package medium = ThermofluidStream.Media.myMedia.Water.ConstantPropertyLiquidWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium package"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-170,94},{-150,114}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,50},{-96,70}})));
  FlowControl.SpecificValveType slideValve(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypes.Kvs,
    redeclare record zetaValueRecord = Internal.Curves.SlideValveZetaCurve,
    Kvs=5) annotation (Placement(transformation(extent={{-10,50},{10,70}})));

  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,50},{116,70}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{26,60},{46,80}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=10,
    offset=0,
    startTime=5)
    annotation (Placement(transformation(extent={{174,10},{154,30}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,-10},{-96,10}})));
  FlowControl.SpecificValveType slideValveInverse(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    invertInput=true,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypes.Kvs,
    redeclare record zetaValueRecord = Internal.Curves.SlideValveZetaCurve,
    d_valve=0.005,
    Kvs=5,
    m_flow_ref_set=0.1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  ThermofluidStream.Boundaries.Sink sink2(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm4(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm5(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{26,0},{46,20}})));

  Modelica.Blocks.Sources.Constant const2(k=1.1e5)
    annotation (Placement(transformation(extent={{-170,-4},{-150,16}})));
  Processes.FlowResistance flowResistance6(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{66,50},{86,70}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{68,-10},{88,10}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
equation
  connect(slideValve.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-10,60},{-20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.inlet, slideValve.outlet) annotation (Line(
      points={{26,60},{10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-60,60},{-40,60}},
      color={28,108,200},
      thickness=0.5));
  connect(slideValveInverse.inlet, multiSensor_Tpm4.outlet) annotation (Line(
      points={{-10,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.inlet, slideValveInverse.outlet) annotation (Line(
      points={{26,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp.y, slideValveInverse.u_in)
    annotation (Line(points={{153,20},{0,20},{0,8}}, color={0,0,127}));
  connect(source.p0_var, const2.y) annotation (Line(points={{-108,66},{-108,60},{-140,60},{-140,6},{-149,6}},
                                                color={0,0,127}));
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-96,60},{-80,60}},
      color={28,108,200},
      thickness=0.5));
  connect(const2.y, source1.p0_var) annotation (Line(points={{-149,6},{-108,6}},
                               color={0,0,127}));
  connect(multiSensor_Tpm3.outlet, flowResistance6.inlet) annotation (Line(
      points={{46,60},{66,60}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance6.outlet) annotation (Line(
      points={{96,60},{86,60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, flowResistance1.inlet) annotation (Line(
      points={{46,0},{68,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, flowResistance1.outlet) annotation (Line(
      points={{96,0},{88,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance2.inlet) annotation (Line(
      points={{-96,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.inlet, flowResistance2.outlet) annotation (Line(
      points={{-40,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(slideValve.u_in, ramp.y) annotation (Line(points={{0,68},{0,90},{120,
          90},{120,20},{153,20}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-180,-100},{180,120}})),
    experiment(
      StopTime=20,
      Interval=0.02,
   Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem),
    Documentation(info="<html>
<p>Test for the SpecificValveType.</p>
<p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end SpecificValveType;
