within ThermofluidStream.Undirected.Boundaries.Tests;
model TestBoundaries "Tests for the rear and fore boundary"
  extends Modelica.Icons.Example;

  BoundaryRear boundary_rear(
    redeclare package Medium = Media.myMedia.Air.SimpleAir,
    T0_par=293.15,
    p0_par=100000,
    fore(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,40})));
  BoundaryFore boundary_fore(
    redeclare package Medium = Media.myMedia.Air.SimpleAir,
    pressureFromInput=true,
    T0_par=303.15,
    p0_par=110000) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  inner DropOfCommons dropOfCommons(m_flow_reg=0.01)
    annotation (Placement(transformation(extent={{-76,48},{-56,68}})));
  Modelica.Blocks.Sources.Step step(
    height=-100000,
    offset=140000,
    startTime=5)
    annotation (Placement(transformation(extent={{60,40},{48,52}})));
  TerminalRear terminal_rear(redeclare package Medium =
        Media.myMedia.Air.SimpleAir)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  BoundaryFore boundary_fore1(
    redeclare package Medium = Media.myMedia.Air.SimpleAir,
    pressureFromInput=true,
    T0_par=303.15,
    p0_par=110000) annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Blocks.Sources.Step step1(
    height=-100000,
    offset=140000,
    startTime=5)
    annotation (Placement(transformation(extent={{60,-10},{48,2}})));
  BoundaryRear boundary_rear1(
    redeclare package Medium = Media.myMedia.Air.SimpleAir,
    pressureFromInput=true,
    T0_par=293.15,
    p0_par=100000) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,-50})));
  TerminalFore terminal_fore(redeclare package Medium =
        Media.myMedia.Air.SimpleAir)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,-50})));
  Modelica.Blocks.Sources.Step step2(
    height=-100000,
    offset=140000,
    startTime=5)
    annotation (Placement(transformation(extent={{-56,-50},{-44,-38}})));
equation
  connect(step.y, boundary_fore.p0_var)
    annotation (Line(points={{47.4,46},{32,46}},   color={0,0,127}));
  connect(boundary_fore.rear, boundary_rear.fore) annotation (Line(
      points={{20,40},{-20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore1.rear, terminal_rear.fore) annotation (Line(
      points={{20,-10},{-20,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(step1.y, boundary_fore1.p0_var) annotation (Line(points={{47.4,-4},{32,-4}},   color={0,0,127}));
  connect(step2.y, boundary_rear1.p0_var) annotation (Line(points={{-43.4,-44},{-32,-44}}, color={0,0,127}));
  connect(boundary_rear1.fore, terminal_fore.rear) annotation (Line(
      points={{-20,-50},{20,-50}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10, Tolerance=1e-6, Interval=0.01),
    Documentation(info="<html>
<p>Tests for the rear and fore boundary.</p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end TestBoundaries;
