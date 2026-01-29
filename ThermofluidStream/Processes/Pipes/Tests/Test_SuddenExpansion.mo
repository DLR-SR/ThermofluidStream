within ThermofluidStream.Processes.Pipes.Tests;
model Test_SuddenExpansion
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching = true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true,
      displayParameters=true)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  ThermofluidStream.Processes.Pipes.SuddenExpansion suddenExpansion(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    d_1=1e-2,
    d_2=2e-2) annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    p0_par=200000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={28,0})));
  Modelica.Blocks.Sources.Sine pressure_sine(
    amplitude=0.4e5,
    f=3,
    offset=1.5e5,
    startTime=0.1) annotation (Placement(transformation(extent={{-82,-4},{-62,16}})));
equation
  connect(pressure_sine.y, source.p0_var) annotation (Line(points={{-61,6},{-34,6}}, color={0,0,127}));
  connect(suddenExpansion.inlet, source.outlet)
    annotation (Line(
      points={{-12,0},{-22,0}},
      color={28,108,200},
      thickness=0.5));
  connect(suddenExpansion.outlet, sink.inlet)
    annotation (Line(
      points={{8,0},{18,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_SuddenExpansion;
