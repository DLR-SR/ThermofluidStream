within ThermofluidStream.FlowControl;
model FourWaySwitch
  replaceable package Medium =
      ThermofluidStream.Media.myMedia.Interfaces.PartialMedium;

  parameter ThermofluidStream.Utilities.Units.Inertance L = dropOfCommons.L "Inertance of the flow"
    annotation(Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_ref = 0.1 "Reference mass flow";
  parameter SI.Pressure p_ref = 1e5 "Rreference pressurre";
  parameter Real relativeLeakiness(unit="1") = 1e-3 "Imperfection of valve";

  ThermofluidStream.Interfaces.Inlet inletA(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  ThermofluidStream.Interfaces.Inlet inletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={100,-60})));
  ThermofluidStream.Interfaces.Outlet outletA(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{90,50},{110,70}})));
  ThermofluidStream.Interfaces.Outlet outletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-100,-60})));
  Switch switch(
    redeclare package Medium = Medium,
    final m_flow_ref=m_flow_ref,
    final p_ref=p_ref,
    final relativeLeakiness=relativeLeakiness,
    invertInput=true,
    initializeOneMassflowSplit=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,60})));
  Switch switch1(
    redeclare package Medium = Medium,
    final m_flow_ref=m_flow_ref,
    final p_ref=p_ref,
    final relativeLeakiness=relativeLeakiness,
    invertInput=true,
    initializeOneMassflowSplit=true)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={60,-60})));
  ThermofluidStream.Topology.JunctionT2 junctionT2_1(redeclare package Medium
      =                                                                         Medium)
    annotation (Placement(transformation(extent={{-70,-70},{-50,-50}})));
  ThermofluidStream.Topology.JunctionT2 junctionT2_2(redeclare package Medium
      =                                                                         Medium)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={60,60})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));

protected
  outer ThermofluidStream.DropOfCommons dropOfCommons;
  constant Real delta(unit="1") = 0.1;

equation
  connect(switch.inlet, inletA) annotation (Line(
      points={{-70,60},{-100,60}},
      color={28,108,200},
      thickness=0.5));
  connect(inletB, switch1.inlet) annotation (Line(
      points={{100,-60},{70,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.outletB, junctionT2_1.inletA)
    annotation (Line(
      points={{-60,50},{-60,50},{-60,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_1.outlet,outletB)  annotation (Line(
      points={{-70,-60},{-100,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(switch1.outletA, junctionT2_1.inletB) annotation (Line(
      points={{50,-60},{-50,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_2.inletB, switch.outletA) annotation (Line(
      points={{50,60},{-50,60}},
      color={28,108,200},
      thickness=0.5));
  connect(switch1.outletB, junctionT2_2.inletA) annotation (Line(
      points={{60,-50},{60,50},{60,50}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_2.outlet, outletA) annotation (Line(
      points={{70,60},{100,60}},
      color={28,108,200},
      thickness=0.5));
  connect(switch1.u, switch.u) annotation (Line(points={{60,-68},{60,-76},{0,-76},{0,76},{-60,76},{-60,68}}, color={0,0,127}));
  connect(u, switch.u) annotation (Line(points={{0,-100},{0,76},{-60,76},{-60,68}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-76,76},{84,-84}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,-60},{-40,-60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,60},{-40,60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,60},{100,60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,-60},{100,-60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points=DynamicSelect({{-40,60},{40,-60}}, if (u<=delta) then {{-40,60},{-40,-60}}   else if (u>=1-delta) then {{-40,60},{40,60}} else {{-40,60},{40,-60}}),
          color={28,108,200},
          thickness=0.5),
        Line(
          points=DynamicSelect({{-40,-60},{40,60}}, if (u<=delta) then {{40,-60},{40,60}} else if (u>=1-delta) then {{40,-60},{-40,-60}}   else {{-40,-60},{40,60}}),
          color={28,108,200},
          thickness=0.5)}),
        Diagram(coordinateSystem(preserveAspectRatio=false)));
end FourWaySwitch;
