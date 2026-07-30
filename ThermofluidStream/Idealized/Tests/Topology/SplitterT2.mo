within ThermofluidStream.Idealized.Tests.Topology;
model SplitterT2 "Example - SplitterT2"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{120,100},{140,120}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-120,70},{-100,90}})));
  .ThermofluidStream.Idealized.Boundaries.Sink_free sinkB(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampB(
    height=1,
    duration=1,
    offset=1) annotation(Placement(transformation(extent={{-80,100},{-60,120}})));
  .ThermofluidStream.Idealized.Boundaries.Sink_free sinkA(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  ThermofluidStream.Topology.SplitterT2 splitter1(displayInstanceName=true, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-90,90},{-70,70}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateA(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampA(
    height=-3,
    duration=1,
    offset=2) annotation(Placement(transformation(extent={{-80,10},{-60,30}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateB(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-60,90},{-40,70}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{0,70},{20,90}})));
  .ThermofluidStream.Idealized.Boundaries.Sink_free sinkB1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{120,70},{140,90}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRamp1(
    height=1,
    duration=1,
    offset=1) annotation(Placement(transformation(extent={{80,100},{60,120}})));
  .ThermofluidStream.Idealized.Boundaries.Sink_free sinkA1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{120,30},{140,50}})));
  ThermofluidStream.Topology.SplitterT2 splitter2(displayInstanceName=true, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{60,90},{80,70}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateA1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampA1(
    height=-2,
    duration=1,
    offset=1) annotation(Placement(transformation(extent={{70,10},{90,30}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRate1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{30,90},{50,70}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-110,-70},{-90,-50}})));
  .ThermofluidStream.Idealized.Boundaries.Sink_free sinkB2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  .ThermofluidStream.Idealized.Boundaries.Sink_free sinkA2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-20,-110},{0,-90}})));
  ThermofluidStream.Topology.SplitterT2 splitter3(displayInstanceName=true, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-80,-50},{-60,-70}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateA2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateB1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-50,-50},{-30,-70}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation(Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse2(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse1(
    amplitude=-2,
    period=0.5,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-100,-130},{-80,-110}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation(Placement(transformation(extent={{-70,-130},{-50,-110}})));

equation
  connect(source.outlet, splitter1.inlet) annotation(Line(
      points={{-100,80},{-90,80}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter1.outletA, massFlowRateA.inlet) annotation(Line(
      points={{-80,70},{-80,40},{-60,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA.outlet, sinkA.inlet) annotation(Line(
      points={{-40,40},{-30,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRampA.y, massFlowRateA.m_flow_prescribed) annotation(Line(points={{-59,20},{-50,20},{-50,32}}, color={0,0,127}));
  connect(massFlowRateB.outlet, sinkB.inlet) annotation(Line(
      points={{-40,80},{-30,80}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter1.outletB, massFlowRateB.inlet) annotation(Line(
      points={{-70,80},{-60,80}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRampB.y, massFlowRateB.m_flow_prescribed) annotation(Line(points={{-59,110},{-50,110},{-50,88}}, color={0,0,127}));
  connect(splitter2.outletA, massFlowRateA1.inlet) annotation(Line(
      points={{70,70},{70,40},{90,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA1.outlet, sinkA1.inlet) annotation(Line(
      points={{110,40},{120,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRampA1.y, massFlowRateA1.m_flow_prescribed) annotation(Line(points={{91,20},{100,20},{100,32}}, color={0,0,127}));
  connect(source1.outlet, massFlowRate1.inlet) annotation(Line(
      points={{20,80},{30,80}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter2.inlet, massFlowRate1.outlet) annotation(Line(
      points={{60,80},{50,80}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRamp1.y, massFlowRate1.m_flow_prescribed) annotation(Line(points={{59,110},{40,110},{40,88}}, color={0,0,127}));
  connect(splitter2.outletB, sinkB1.inlet) annotation(Line(
      points={{80,80},{120,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, splitter3.inlet) annotation(Line(
      points={{-90,-60},{-80,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter3.outletA, massFlowRateA2.inlet) annotation(Line(
      points={{-70,-70},{-70,-100},{-50,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA2.outlet, sinkA2.inlet) annotation(Line(
      points={{-30,-100},{-20,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB1.outlet, sinkB2.inlet) annotation(Line(
      points={{-30,-60},{-20,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter3.outletB, massFlowRateB1.inlet) annotation(Line(
      points={{-60,-60},{-50,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(firstOrder1.y, massFlowRateB1.m_flow_prescribed) annotation(Line(points={{-49,-30},{-40,-30},{-40,-52}}, color={0,0,127}));
  connect(m_flow_pulse2.y, firstOrder1.u) annotation(Line(points={{-79,-30},{-72,-30}}, color={0,0,127}));
  connect(m_flow_pulse1.y, firstOrder2.u) annotation(Line(points={{-79,-120},{-72,-120}}, color={0,0,127}));
  connect(firstOrder2.y, massFlowRateA2.m_flow_prescribed) annotation(Line(points={{-49,-120},{-40,-120},{-40,-108}}, color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-140,-140},{140,120}})),
    Documentation(
      info="<html>
  <p>
    <a href=\"modelica://ThermofluidStream.Topology.SplitterT2\">SplitterT2</a> test model.<br>
    The model is not part of <a href=\"modelica://ThermofluidStream.Idealized.Topology\">Idealized.Topology</a>.<br>
    Differentiable mass flow rates.
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end SplitterT2;
