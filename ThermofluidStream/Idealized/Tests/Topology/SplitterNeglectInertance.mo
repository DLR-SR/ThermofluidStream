within ThermofluidStream.Idealized.Tests.Topology;
model SplitterNeglectInertance "Example - Splitter requiring neglectInertance = true"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{100,-120},{120,-100}})));

  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15,
    neglectInertance=true) annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sinkB3(redeclare package Medium = Medium, neglectInertance=true) annotation (Placement(transformation(extent={{-30,80},{-10,100}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sinkA3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  ThermofluidStream.Topology.SplitterT1 splitter4(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    neglectInertance=true) annotation (Placement(transformation(extent={{-90,80},{-70,60}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateB2(
    redeclare package Medium = Medium,
    neglectInertance=true,
    m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-60,100},{-40,80}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse3(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation (Placement(transformation(extent={{-100,100},{-80,120}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse4(
    amplitude=-2,
    period=0.5,
    offset=1,
    startTime=0.1) annotation (Placement(transformation(extent={{-110,20},{-90,40}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15,
    neglectInertance=true) annotation (Placement(transformation(extent={{10,70},{30,90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sinkB1(redeclare package Medium = Medium, neglectInertance=true) annotation (Placement(transformation(extent={{100,70},{120,90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sinkA1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{100,30},{120,50}})));
  ThermofluidStream.Topology.SplitterT2 splitter1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    neglectInertance=true) annotation (Placement(transformation(extent={{40,90},{60,70}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{70,30},{90,50}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateB1(
    redeclare package Medium = Medium,
    neglectInertance=true,
    m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{70,90},{90,70}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse1(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation (Placement(transformation(extent={{20,100},{40,120}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse2(
    amplitude=-2,
    period=0.5,
    offset=1,
    startTime=0.1) annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation (Placement(transformation(extent={{50,10},{70,30}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15,
    neglectInertance=true) annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  ThermofluidStream.Idealized.Sources.Sink_free sinkB2(redeclare package Medium = Medium, neglectInertance=true) annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  ThermofluidStream.Idealized.Sources.Sink_free sinkA2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
  ThermofluidStream.Topology.SplitterX splitterX1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    neglectInertance=true) annotation (Placement(transformation(extent={{-80,-70},{-60,-90}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-50,-120},{-30,-100}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateB4(
    redeclare package Medium = Medium,
    neglectInertance=true,
    m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-50,-30},{-30,-50}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse5(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse6(
    amplitude=-2,
    period=0.5,
    offset=1,
    startTime=0.1) annotation (Placement(transformation(extent={{-100,-140},{-80,-120}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation (Placement(transformation(extent={{-70,-140},{-50,-120}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateC4(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-50,-70},{-30,-90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sinkC4(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampC4(
    height=1,
    duration=1,
    offset=1) annotation (Placement(transformation(extent={{30,-70},{10,-50}})));
equation
  connect(source3.outlet, splitter4.inlet) annotation (Line(
      points={{-100,70},{-90,70}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter4.outletA, massFlowRateA3.inlet) annotation (Line(
      points={{-80,60},{-80,50},{-60,50}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA3.outlet, sinkA3.inlet) annotation (Line(
      points={{-40,50},{-30,50}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB2.outlet, sinkB3.inlet) annotation (Line(
      points={{-40,90},{-30,90}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter4.outletB, massFlowRateB2.inlet) annotation (Line(
      points={{-80,80},{-80,90},{-60,90}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_pulse4.y, firstOrder4.u) annotation (Line(points={{-89,30},{-82,30}},   color={0,0,127}));
  connect(firstOrder4.y, massFlowRateA3.m_flow_prescribed) annotation (Line(points={{-59,30},{-50,30},{-50,42}},   color={0,0,127}));
  connect(m_flow_pulse3.y, massFlowRateB2.m_flow_prescribed) annotation (Line(points={{-79,110},{-50,110},{-50,98}},
                                                                                                            color={0,0,127}));
  connect(source1.outlet,splitter1. inlet) annotation (Line(
      points={{30,80},{40,80}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter1.outletA,massFlowRateA1. inlet) annotation (Line(
      points={{50,70},{50,40},{70,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA1.outlet,sinkA1. inlet) annotation (Line(
      points={{90,40},{100,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB1.outlet,sinkB1. inlet) annotation (Line(
      points={{90,80},{100,80}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter1.outletB,massFlowRateB1. inlet) annotation (Line(
      points={{60,80},{70,80}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_pulse2.y,firstOrder1. u) annotation (Line(points={{41,20},{48,20}},     color={0,0,127}));
  connect(firstOrder1.y,massFlowRateA1. m_flow_prescribed) annotation (Line(points={{71,20},{80,20},{80,32}},       color={0,0,127}));
  connect(m_flow_pulse1.y,massFlowRateB1. m_flow_prescribed) annotation (Line(points={{41,110},{80,110},{80,88}},  color={0,0,127}));
  connect(source2.outlet,splitterX1. inlet) annotation (Line(
      points={{-90,-80},{-80,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterX1.outletA,massFlowRateA2. inlet) annotation (Line(
      points={{-70,-90},{-70,-110},{-50,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA2.outlet,sinkA2. inlet) annotation (Line(
      points={{-30,-110},{-20,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB4.outlet,sinkB2. inlet) annotation (Line(
      points={{-30,-40},{-20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterX1.outletB,massFlowRateB4. inlet) annotation (Line(
      points={{-70,-70},{-70,-40},{-50,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_pulse6.y,firstOrder2. u) annotation (Line(points={{-79,-130},{-72,-130}},
                                                                                         color={0,0,127}));
  connect(firstOrder2.y,massFlowRateA2. m_flow_prescribed) annotation (Line(points={{-49,-130},{-40,-130},{-40,-118}},
                                                                                                             color={0,0,127}));
  connect(m_flow_pulse5.y,massFlowRateB4. m_flow_prescribed) annotation (Line(points={{-69,-20},{-40,-20},{-40,-32}},
                                                                                                            color={0,0,127}));
  connect(splitterX1.outletC,massFlowRateC4. inlet) annotation (Line(
      points={{-60,-80},{-50,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateC4.outlet,sinkC4. inlet) annotation (Line(
      points={{-30,-80},{-20,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRampC4.y,massFlowRateC4. m_flow_prescribed) annotation (Line(points={{9,-60},{-40,-60},{-40,-72}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-140,-140},{160,120}}), graphics={
        Polygon(
          points={{50,-80},{90,-80},{90,-60},{70,-60},{70,-20},{50,-20},{50,-80}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{80,-30},{160,-50}},
          textColor={238,46,47},
          textString="requires neglectInertance = true
see User's Guide",
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Non differentiable mass flow rates require <code>neglectInertance = true</code>.
  </p>
</html>"));
end SplitterNeglectInertance;
