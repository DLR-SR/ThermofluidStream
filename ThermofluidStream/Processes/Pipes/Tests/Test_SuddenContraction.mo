within ThermofluidStream.Processes.Pipes.Tests;
model Test_SuddenContraction
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching = true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true,
      displayParameters=true)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  ThermofluidStream.Processes.Pipes.SuddenContraction suddenContraction(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    d_1=1e-2,
    d_2=0.5e-2) annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    p0_par=200000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium,                                         p0_par=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={32,0})));
  Modelica.Blocks.Sources.Sine pressure_sine(
    amplitude=0.4e5,
    f=3,
    offset=1.5e5,
    startTime=0.1) annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));
equation
  connect(suddenContraction.outlet, sink.inlet)
    annotation (Line(
      points={{12,0},{22,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, suddenContraction.inlet)
    annotation (Line(
      points={{-18,0},{-8,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pressure_sine.y, source.p0_var) annotation (Line(points={{-59,6},{-30,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_SuddenContraction;
