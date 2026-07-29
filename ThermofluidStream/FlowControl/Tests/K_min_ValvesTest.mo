within ThermofluidStream.FlowControl.Tests;
model K_min_ValvesTest "Test to investigate k_min for basic and specific valve"
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
    annotation (Placement(transformation(extent={{-162,148},{-142,168}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-118,96},{-98,116}})));
  FlowControl.BasicControlValve valveLinear(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    k_min=1e-6,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.Kvs,
    Kvs=5,
    redeclare function valveCharacteristics =
        ThermofluidStream.FlowControl.Internal.ControlValve.linearCharacteristics)
    annotation (Placement(transformation(extent={{-12,96},{8,116}})));

  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{94,96},{114,116}})));
  Modelica.Blocks.Sources.Step step(
    height=-1,
    offset=1,
    startTime=5)
    annotation (Placement(transformation(extent={{214,56},{194,76}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-118,36},{-98,56}})));
  FlowControl.BasicControlValve valveParabolic(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    invertInput=false,
    k_min=1e-6,
    Kvs=5,
    redeclare function valveCharacteristics =
        Internal.ControlValve.parabolicCharacteristics,
    m_flow_ref_set=0.1)
    annotation (Placement(transformation(extent={{-12,36},{8,56}})));

  ThermofluidStream.Boundaries.Sink sink2(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{94,36},{114,56}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-118,-24},{-98,-4}})));
  FlowControl.BasicControlValve valveEqualPercentage(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    k_min=1e-6,
    Kvs=5,
    redeclare function valveCharacteristics =
        Internal.ControlValve.equalPercentageCharacteristics)
    annotation (Placement(transformation(extent={{-12,-24},{8,-4}})));

  ThermofluidStream.Boundaries.Sink sink3(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{94,-24},{114,-4}})));
  Modelica.Blocks.Sources.Constant const2(k=1.1e5)
    annotation (Placement(transformation(extent={{-172,42},{-152,62}})));
  Boundaries.Source                   source3(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-118,-112},{-98,-92}})));
  ThermofluidStream.FlowControl.SpecificValveType SpecificValveType(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    k_min=1e-6,
    Kvs=5) annotation (Placement(transformation(extent={{-12,-112},{8,-92}})));
  Boundaries.Sink                   sink4(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{94,-112},{114,-92}})));
  Modelica.Blocks.Continuous.FirstOrder
                               firstOrder(T=1)
    annotation (Placement(transformation(extent={{176,56},{156,76}})));
equation
  connect(source2.p0_var, const2.y) annotation (Line(points={{-110,-8},{-142,-8},
          {-142,52},{-151,52}}, color={0,0,127}));
  connect(source.p0_var, const2.y) annotation (Line(points={{-110,112},{-110,
          106},{-142,106},{-142,52},{-151,52}}, color={0,0,127}));
  connect(const2.y, source1.p0_var) annotation (Line(points={{-151,52},{-110,52}},
                               color={0,0,127}));
  connect(source3.p0_var, const2.y) annotation (Line(points={{-110,-96},{-142,
          -96},{-142,52},{-151,52}}, color={0,0,127}));
  connect(source3.outlet, SpecificValveType.inlet) annotation (Line(
      points={{-98,-102},{-12,-102}},
      color={28,108,200},
      thickness=0.5));
  connect(SpecificValveType.outlet, sink4.inlet) annotation (Line(
      points={{8,-102},{94,-102}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, valveEqualPercentage.inlet) annotation (Line(
      points={{-98,-14},{-12,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(valveEqualPercentage.outlet, sink3.inlet) annotation (Line(
      points={{8,-14},{94,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, valveParabolic.inlet) annotation (Line(
      points={{-98,46},{-12,46}},
      color={28,108,200},
      thickness=0.5));
  connect(valveParabolic.outlet, sink2.inlet) annotation (Line(
      points={{8,46},{94,46}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, valveLinear.inlet) annotation (Line(
      points={{-98,106},{-12,106}},
      color={28,108,200},
      thickness=0.5));
  connect(valveLinear.outlet, sink1.inlet) annotation (Line(
      points={{8,106},{94,106}},
      color={28,108,200},
      thickness=0.5));
  connect(firstOrder.u, step.y)
    annotation (Line(points={{178,66},{193,66}}, color={0,0,127}));
  connect(firstOrder.y, valveLinear.u_in) annotation (Line(points={{155,66},{
          122,66},{122,122},{-2,122},{-2,114}}, color={0,0,127}));
  connect(firstOrder.y, valveParabolic.u_in)
    annotation (Line(points={{155,66},{-2,66},{-2,54}}, color={0,0,127}));
  connect(firstOrder.y, valveEqualPercentage.u_in) annotation (Line(points={{
          155,66},{120,66},{120,2},{-2,2},{-2,-6}}, color={0,0,127}));
  connect(firstOrder.y, SpecificValveType.u_in) annotation (Line(points={{155,
          66},{142,66},{142,-76},{14,-76},{14,-94},{-2,-94}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-180,-120},{180,180}}, grid={2,
            2}), graphics={
        Rectangle(extent={{-124,142},{126,-36}}, lineColor={28,108,200}),
        Text(
          extent={{-126,156},{0,144}},
          textColor={28,108,200},
          textString="Basic valve: until 1e-9"),
        Text(
          extent={{-134,-66},{-8,-78}},
          textColor={28,108,200},
          textString="Specific valve: until 1e-9")}),
    experiment(
      StopTime=20,
      Interval=0.02,
   Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>Test for the BasicControlValve.</p>
<p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end K_min_ValvesTest;
