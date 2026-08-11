within ThermofluidStream.Idealized.Tests;
model Icons1
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation (
      choicesAllMatching=true);

  ThermofluidStream.Idealized.Processes.Adiabatic adiabatic(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    iconType=ThermofluidStream.Idealized.Types.Icons.PressureChange.Expansion,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  ThermofluidStream.Boundaries.Sink_m
                                    sink(redeclare package Medium = Medium, m_flow_fixed=1)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Blocks.Sources.CombiTimeTable pressureDifferenceStep(
    table=[0.0,-0.1e5; 0.3,0.0; 0.6,0.1e5],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    offset={0},
    startTime=0) annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  ThermofluidStream.Idealized.Processes.Adiabatic adiabatic1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  inner DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(adiabatic.inlet, source.outlet) annotation (Line(
      points={{-30,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabatic.outlet, adiabatic1.inlet) annotation (Line(
      points={{-10,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabatic1.outlet, sink.inlet) annotation (Line(
      points={{30,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureDifferenceStep.y[1], adiabatic.outletSpec_prescribed) annotation (Line(points={{-39,-40},{-10,-40},{-10,-12}}, color={0,0,127}));
  connect(pressureDifferenceStep.y[1], adiabatic1.outletSpec_prescribed) annotation (Line(points={{-39,-40},{30,-40},{30,-12}}, color={0,0,127}));
  annotation(
    experiment(
      StopTime=1,
      __Dymola_Algorithm="Dassl"));
end Icons1;
