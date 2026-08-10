within ThermofluidStream.Idealized.Tests;
model Icons3
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation (
      choicesAllMatching=true);

  ThermofluidStream.Idealized.Processes.Isobaric  isobaric(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric  isobaric1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaric2(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Cooling) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaric3(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Cooling) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  ThermofluidStream.Boundaries.Sink_m
                                    sink(redeclare package Medium = Medium, m_flow_fixed=1)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Sources.CombiTimeTable temperatureDifferenceStep(
    table=[0.0,-10; 0.3,0.0; 0.6,10],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    offset={0},
    startTime=0) annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  inner DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{80,80},{100,100}})));

equation
  connect(isobaric.inlet, source.outlet) annotation (Line(
      points={{-60,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric1.outlet, isobaric2.inlet) annotation (Line(
      points={{30,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric.outlet, isobaric3.inlet) annotation (Line(
      points={{-40,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric3.outlet, isobaric1.inlet) annotation (Line(
      points={{-10,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric2.outlet, sink.inlet) annotation (Line(
      points={{60,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureDifferenceStep.y[1], isobaric.outletSpec_prescribed) annotation (Line(points={{-59,-40},{-40,-40},{-40,-12}}, color={0,0,127}));
  connect(temperatureDifferenceStep.y[1], isobaric3.outletSpec_prescribed) annotation (Line(points={{-59,-40},{-10,-40},{-10,-12}}, color={0,0,127}));
  connect(temperatureDifferenceStep.y[1], isobaric1.outletSpec_prescribed) annotation (Line(points={{-59,-40},{30,-40},{30,-12}}, color={0,0,127}));
  connect(temperatureDifferenceStep.y[1], isobaric2.outletSpec_prescribed) annotation (Line(points={{-59,-40},{60,-40},{60,-12}}, color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      __Dymola_Algorithm="Dassl"));
end Icons3;
