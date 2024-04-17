within ThermofluidStream.FlowControl;
model FourWaySwitch

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
    <p>Medium package used in the Component. Make sure it is the same as the components connected to both ports are using.</p>
      </html>"));

  parameter SI.MassFlowRate m_flow_ref = 0.1 "Reference mass flow rate";
  parameter SI.Pressure p_ref = 1e5 "Reference pressure";
  parameter Real relativeLeakiness(unit="1") = 1e-3 "Imperfection of valve";
  parameter ThermofluidStream.Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced"));

  ThermofluidStream.Interfaces.Inlet inletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,40},{-80,80}}), iconTransformation(extent={{-120,40},{-80,80}})));
  ThermofluidStream.Interfaces.Inlet inletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={100,-60}), iconTransformation(
        extent={{-28.2354,51.7646},{11.7646,11.7646}},
        rotation=180,
        origin={91.7646,-28.2354})));
  ThermofluidStream.Interfaces.Outlet outletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,40},{120,80}}), iconTransformation(extent={{80,40},{120,80}})));
  ThermofluidStream.Interfaces.Outlet outletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-100,-60}), iconTransformation(
        extent={{-27.5,52.5},{12.5,12.5}},
        rotation=180,
        origin={-107.5,-27.5})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
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
  ThermofluidStream.Topology.JunctionT2 junctionT2_1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-70,-70},{-50,-50}})));
  ThermofluidStream.Topology.JunctionT2 junctionT2_2(redeclare package Medium = Medium)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={60,60})));
protected
  constant Real delta(unit="1") = 0.1;

equation
  connect(switch.inlet, inletA) annotation (Line(
      points={{-70,60},{-82,60},{-82,60},{-100,60}},
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
  connect(junctionT2_1.outlet,outletB) annotation (Line(
      points={{-50,-60},{-100,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(switch1.outletA, junctionT2_1.inletB) annotation (Line(
      points={{50,-60},{-70,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_2.inletB, switch.outletA) annotation (Line(
      points={{70,60},{-50,60}},
      color={28,108,200},
      thickness=0.5));
  connect(switch1.outletB, junctionT2_2.inletA) annotation (Line(
      points={{60,-50},{60,50},{60,50}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_2.outlet, outletA) annotation (Line(
      points={{50,60},{86,60},{86,60},{100,60}},
      color={28,108,200},
      thickness=0.5));
  connect(switch1.u, switch.u) annotation (Line(points={{60,-72},{60,-76},{0,-76},{0,76},{-60,76},{-60,72}}, color={0,0,127}));
  connect(u, switch.u) annotation (Line(points={{0,-100},{0,76},{-60,76},{-60,72}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
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
        Diagram(coordinateSystem(preserveAspectRatio=true)));
end FourWaySwitch;
