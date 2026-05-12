within ThermofluidStream.Idealized.Tests.Topology;
model SplitterX "Example - SplitterX"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{240,130},{260,150}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-170,60},{-150,80}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sinkB(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-80,100},{-60,120}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampB(
    height=1,
    duration=1,
    offset=1) annotation(Placement(transformation(extent={{-130,122},{-110,142}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sinkA(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-80,30},{-60,50}})));
  ThermofluidStream.Topology.SplitterX splitterX(displayInstanceName=true, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-140,80},{-120,60}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampA(
    height=-3,
    duration=1,
    offset=2) annotation(Placement(transformation(extent={{-130,10},{-110,30}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateB(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-110,120},{-90,100}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{10,60},{30,80}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sinkB1(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{130,100},{150,120}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRamp1(
    height=1,
    duration=1,
    offset=1) annotation(Placement(transformation(extent={{10,90},{30,110}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sinkA1(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{130,30},{150,50}})));
  ThermofluidStream.Topology.SplitterX splitterX2(displayInstanceName=true, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{70,80},{90,60}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampA1(
    height=-2,
    duration=1,
    offset=1) annotation(Placement(transformation(extent={{80,10},{100,30}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{40,80},{60,60}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-170,-100},{-150,-80}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sinkB2(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-80,-68},{-60,-48}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sinkA2(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-80,-140},{-60,-120}})));
  ThermofluidStream.Topology.SplitterX splitterX3(displayInstanceName=true, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-140,-80},{-120,-100}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-110,-140},{-90,-120}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateB2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-110,-48},{-90,-68}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation(Placement(transformation(extent={{-130,-48},{-110,-28}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse2(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-160,-48},{-140,-28}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse1(
    amplitude=-2,
    period=0.5,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-160,-160},{-140,-140}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation(Placement(transformation(extent={{-130,-160},{-110,-140}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateC1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-110,80},{-90,60}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sinkC1(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampC1(
    height=1,
    duration=1,
    offset=1) annotation(Placement(transformation(extent={{-30,80},{-50,100}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sinkC2(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{130,60},{150,80}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateB1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{100,120},{120,100}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampB1(
    height=1,
    duration=1,
    offset=1) annotation(Placement(transformation(extent={{80,122},{100,142}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateC3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-112,-80},{-92,-100}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sinkC3(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-82,-100},{-62,-80}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampC3(
    height=1,
    duration=1,
    offset=1) annotation(Placement(transformation(extent={{-34,-84},{-54,-64}})));
equation
  connect(source.outlet, splitterX.inlet) annotation(Line(
      points={{-150,70},{-140,70}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterX.outletA, massFlowRateA.inlet) annotation(Line(
      points={{-130,60},{-130,40},{-110,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA.outlet, sinkA.inlet) annotation(Line(
      points={{-90,40},{-80,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRampA.y, massFlowRateA.m_flow_prescribed) annotation(Line(points={{-109,20},{-100,20},{-100,32}}, color={0,0,127}));
  connect(massFlowRateB.outlet, sinkB.inlet) annotation(Line(
      points={{-90,110},{-80,110}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterX.outletB, massFlowRateB.inlet) annotation(Line(
      points={{-130,80},{-130,110},{-110,110}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRampB.y, massFlowRateB.m_flow_prescribed) annotation(Line(points={{-109,132},{-100,132},{-100,118}}, color={0,0,127}));
  connect(splitterX2.outletA, massFlowRateA1.inlet) annotation(Line(
      points={{80,60},{80,40},{100,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA1.outlet, sinkA1.inlet) annotation(Line(
      points={{120,40},{130,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRampA1.y, massFlowRateA1.m_flow_prescribed) annotation(Line(points={{101,20},{110,20},{110,32}}, color={0,0,127}));
  connect(source1.outlet, massFlowRate1.inlet) annotation(Line(
      points={{30,70},{40,70}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterX2.inlet, massFlowRate1.outlet) annotation(Line(
      points={{70,70},{60,70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRamp1.y, massFlowRate1.m_flow_prescribed) annotation(Line(points={{31,100},{50,100},{50,78}}, color={0,0,127}));
  connect(source2.outlet, splitterX3.inlet) annotation(Line(
      points={{-150,-90},{-140,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterX3.outletA, massFlowRateA2.inlet) annotation(Line(
      points={{-130,-100},{-130,-130},{-110,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA2.outlet, sinkA2.inlet) annotation(Line(
      points={{-90,-130},{-80,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB2.outlet, sinkB2.inlet) annotation(Line(
      points={{-90,-58},{-80,-58}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterX3.outletB, massFlowRateB2.inlet) annotation(Line(
      points={{-130,-80},{-130,-58},{-110,-58}},
      color={28,108,200},
      thickness=0.5));
  connect(firstOrder1.y, massFlowRateB2.m_flow_prescribed) annotation(Line(points={{-109,-38},{-100,-38},{-100,-50}},            color={0,0,127}));
  connect(m_flow_pulse2.y, firstOrder1.u) annotation(Line(points={{-139,-38},{-132,-38}}, color={0,0,127}));
  connect(m_flow_pulse1.y, firstOrder2.u) annotation(Line(points={{-139,-150},{-132,-150}}, color={0,0,127}));
  connect(firstOrder2.y, massFlowRateA2.m_flow_prescribed) annotation(Line(points={{-109,-150},{-100,-150},{-100,-138}}, color={0,0,127}));
  connect(splitterX.outletC, massFlowRateC1.inlet) annotation(Line(
      points={{-120,70},{-110,70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateC1.outlet, sinkC1.inlet) annotation(Line(
      points={{-90,70},{-80,70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRampC1.y, massFlowRateC1.m_flow_prescribed) annotation(Line(points={{-51,90},{-100,90},{-100,78}}, color={0,0,127}));
  connect(splitterX2.outletC, sinkC2.inlet) annotation(Line(
      points={{90,70},{130,70}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterX2.outletB, massFlowRateB1.inlet) annotation(Line(
      points={{80,80},{80,110},{100,110}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB1.outlet, sinkB1.inlet) annotation(Line(
      points={{120,110},{130,110}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRampB1.y, massFlowRateB1.m_flow_prescribed) annotation(Line(points={{101,132},{110,132},{110,118}}, color={0,0,127}));
  connect(splitterX3.outletC, massFlowRateC3.inlet) annotation(Line(
      points={{-120,-90},{-112,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateC3.outlet, sinkC3.inlet) annotation(Line(
      points={{-92,-90},{-82,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateC3.m_flow_prescribed, massFlowRateRampC3.y) annotation(Line(points={{-102,-82},{-102,-74},{-55,-74}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-180},{200,160}})),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    SplitterT2 test model for differentiable mass flow rates.
  </p>
</html>"));
end SplitterX;
