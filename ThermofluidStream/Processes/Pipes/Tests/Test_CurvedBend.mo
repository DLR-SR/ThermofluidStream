within ThermofluidStream.Processes.Pipes.Tests;
model Test_CurvedBend
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching = true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true,
      displayParameters=true)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,32})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    p0_par=200000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Processes.Pipes.CurvedBend curvedBend(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    d=1e-2,
    delta=1.5707963267949,
    R=15e-2,
    ks=1e-6)       annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Sine pressure_sine(
    amplitude=0.4e5,
    f=3,
    offset=1.5e5,
    startTime=0.1) annotation (Placement(transformation(extent={{-78,-4},{-58,16}})));
equation
  connect(source.outlet, curvedBend.inlet)
    annotation (Line(
      points={{-20,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, curvedBend.outlet) annotation (Line(
      points={{-5.55112e-16,22},{-5.55112e-16,16},{0,16},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(pressure_sine.y, source.p0_var) annotation (Line(points={{-57,6},{-32,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_CurvedBend;
