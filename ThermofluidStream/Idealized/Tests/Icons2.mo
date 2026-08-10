within ThermofluidStream.Idealized.Tests;
model Icons2
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation (
      choicesAllMatching=true);

  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic2(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    iconType=ThermofluidStream.Idealized.Types.Icons.PressureChange.Expansion,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic3(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    iconType=ThermofluidStream.Idealized.Types.Icons.PressureChange.Expansion,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Sources.CombiTimeTable pressureDifferenceStep(
    table=[0.0,-0.1e5; 0.3,0.0; 0.6,0.1e5],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    offset={0},
    startTime=0) annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  ThermofluidStream.Boundaries.Sink_m
                                    sink(redeclare package Medium = Medium, m_flow_fixed=1)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  inner DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{80,80},{100,100}})));

equation
  connect(polytropic.inlet, source1.outlet) annotation (Line(
      points={{-60,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic1.outlet, polytropic2.inlet) annotation (Line(
      points={{30,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic.outlet, polytropic3.inlet) annotation (Line(
      points={{-40,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic3.outlet, polytropic1.inlet) annotation (Line(
      points={{-10,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic2.outlet, sink.inlet) annotation (Line(
      points={{60,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureDifferenceStep.y[1], polytropic.outletSpec_prescribed) annotation (Line(points={{-59,-40},{-40,-40},{-40,-12}}, color={0,0,127}));
  connect(pressureDifferenceStep.y[1], polytropic3.outletSpec_prescribed) annotation (Line(points={{-59,-40},{-10,-40},{-10,-12}}, color={0,0,127}));
  connect(pressureDifferenceStep.y[1], polytropic1.outletSpec_prescribed) annotation (Line(points={{-59,-40},{30,-40},{30,-12}}, color={0,0,127}));
  connect(pressureDifferenceStep.y[1], polytropic2.outletSpec_prescribed) annotation (Line(points={{-59,-40},{60,-40},{60,-12}}, color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      __Dymola_Algorithm="Dassl"));
end Icons2;
