within ThermofluidStream.Idealized.Tests.Sources.Sink_free;
model Setpoints "Example - free sink"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{220,122},{240,142}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)          annotation(Placement(transformation(extent={{-200,92},{-180,112}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-140,92},{-120,112}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-230,10},{-210,30}})));
  Modelica.Blocks.Sources.Ramp m_flow_ramp(
    height=1,
    duration=1,
    offset=1,
    startTime=0) annotation(Placement(transformation(extent={{-200,-150},{-180,-130}})));
  Modelica.Blocks.Sources.Sine m_flow_sine(
    amplitude=1,
    f=2,
    offset=0) annotation(Placement(transformation(extent={{-200,-70},{-180,-50}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-200,50},{-180,70}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink1(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-140,50},{-120,70}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-200,-30},{-180,-10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink2(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-140,-30},{-120,-10}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-200,-110},{-180,-90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink3(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-140,-110},{-120,-90}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=293.15) annotation(Placement(transformation(extent={{-40,50},{-20,70}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{20,50},{40,70}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=293.15) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink5(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{20,-30},{40,-10}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=293.15) annotation(Placement(transformation(extent={{-40,-110},{-20,-90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink6(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{20,-110},{40,-90}})));
  Modelica.Blocks.Sources.Pulse p_pulse(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation(Placement(transformation(extent={{-80,-24},{-60,-4}})));
  Modelica.Blocks.Sources.Sine p_sine(
    amplitude=1e5,
    f=1.5,
    offset=2e5) annotation(Placement(transformation(extent={{-80,-104},{-60,-84}})));
  Modelica.Blocks.Sources.Ramp p_ramp(
    height=1e5,
    duration=1,
    offset=1e5,
    startTime=0) annotation(Placement(transformation(extent={{-80,56},{-60,76}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    xiFromInput=false,
    setEnthalpy=true,
    enthalpyFromInput=true) annotation(Placement(transformation(extent={{120,50},{140,70}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink7(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{180,50},{200,70}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    xiFromInput=false,
    setEnthalpy=true,
    enthalpyFromInput=true) annotation(Placement(transformation(extent={{120,-30},{140,-10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink8(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{180,-30},{200,-10}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    xiFromInput=false,
    setEnthalpy=true,
    enthalpyFromInput=true) annotation(Placement(transformation(extent={{120,-110},{140,-90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink9(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{180,-110},{200,-90}})));
  Modelica.Blocks.Sources.Pulse p_pulse1(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation(Placement(transformation(extent={{80,-24},{100,-4}})));
  Modelica.Blocks.Sources.Sine p_sine1(
    amplitude=1e5,
    f=1.5,
    offset=2e5) annotation(Placement(transformation(extent={{80,-104},{100,-84}})));
  Modelica.Blocks.Sources.Ramp p_ramp1(
    height=1e5,
    duration=1,
    offset=1e5,
    startTime=0) annotation(Placement(transformation(extent={{80,56},{100,76}})));
  Modelica.Blocks.Sources.Ramp h_ramp(
    height=Medium.specificEnthalpy_pT(1e5, 273.15 + 120) - Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    duration=1,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    startTime=0) annotation(Placement(transformation(extent={{78,-54},{98,-34}})));
  Modelica.Blocks.Sources.Pulse h_pulse(
    amplitude=Medium.bubbleEnthalpy(Medium.setSat_p(1e5)) + 0.5*(Medium.dewEnthalpy(Medium.setSat_p(1e5)) -
        Medium.bubbleEnthalpy(Medium.setSat_p(1e5))) - Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    period=0.5,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    startTime=0.3) annotation(Placement(transformation(extent={{80,-134},{100,-114}})));
  Modelica.Blocks.Sources.Sine h_sine(
    amplitude=(Medium.specificEnthalpy_pT(1e5, 273.15 + 200) - Medium.specificEnthalpy_pT(1e5, 273.15 + 120)),
    f=1,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 120)) annotation(
    Placement(transformation(extent={{80,26},{100,46}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-170,92},{-150,112}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-170,50},{-150,70}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-170,-30},{-150,-10}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-170,-110},{-150,-90}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate4(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-10,50},{10,70}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate5(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-10,-30},{10,-10}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate6(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate7(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{150,50},{170,70}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate8(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{150,-30},{170,-10}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate9(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{150,-110},{170,-90}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation(Placement(transformation(extent={{-200,10},{-180,30}})));

equation
  connect(p_ramp.y, source4.p0_var) annotation(Line(points={{-59,66},{-32,66}},   color={0,0,127}));
  connect(p_pulse.y, source5.p0_var) annotation(Line(points={{-59,-14},{-32,-14}}, color={0,0,127}));
  connect(p_ramp1.y, source7.p0_var) annotation(Line(points={{101,66},{128,66}},   color={0,0,127}));
  connect(p_pulse1.y, source8.p0_var) annotation(Line(points={{101,-14},{128,-14}}, color={0,0,127}));
  connect(p_sine1.y, source9.p0_var) annotation(Line(points={{101,-94},{128,-94}},   color={0,0,127}));
  connect(h_sine.y, source7.h0_var) annotation(Line(points={{101,36},{114,36},{114,60},{128,60}},   color={0,0,127}));
  connect(h_ramp.y, source8.h0_var) annotation(Line(points={{99,-44},{120,-44},{120,-20},{128,-20}}, color={0,0,127}));
  connect(h_pulse.y, source9.h0_var) annotation(Line(points={{101,-124},{120,-124},{120,-100},{128,-100}}, color={0,0,127}));
  connect(source.outlet, massFlowRate.inlet) annotation(Line(
      points={{-180,102},{-170,102}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, massFlowRate.outlet) annotation(Line(
      points={{-140,102},{-150,102}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, massFlowRate1.inlet) annotation(Line(
      points={{-180,60},{-170,60}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate1.outlet, sink1.inlet) annotation(Line(
      points={{-150,60},{-140,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, massFlowRate2.inlet) annotation(Line(
      points={{-180,-20},{-170,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate2.outlet, sink2.inlet) annotation(Line(
      points={{-150,-20},{-140,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, massFlowRate3.inlet) annotation(Line(
      points={{-180,-100},{-170,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate3.outlet, sink3.inlet) annotation(Line(
      points={{-150,-100},{-140,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_sine.y, massFlowRate2.m_flow_prescribed) annotation(Line(points={{-179,-60},{-160,-60},{-160,-28}}, color={0,0,127}));
  connect(m_flow_ramp.y, massFlowRate3.m_flow_prescribed) annotation(Line(points={{-179,-140},{-160,-140},{-160,-108}}, color={0,0,127}));
  connect(source4.outlet, massFlowRate4.inlet) annotation(Line(
      points={{-20,60},{-10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate4.outlet, sink4.inlet) annotation(Line(
      points={{10,60},{20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(p_sine.y, source6.p0_var) annotation(Line(points={{-59,-94},{-32,-94}},   color={0,0,127}));
  connect(source5.outlet, massFlowRate5.inlet) annotation(Line(
      points={{-20,-20},{-10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate5.outlet, sink5.inlet) annotation(Line(
      points={{10,-20},{20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate5.m_flow_prescribed, m_flow_sine.y) annotation(Line(points={{0,-28},{0,-60},{-179,-60}}, color={0,0,127}));
  connect(source6.outlet, massFlowRate6.inlet) annotation(Line(
      points={{-20,-100},{-10,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate6.outlet, sink6.inlet) annotation(Line(
      points={{10,-100},{20,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate6.m_flow_prescribed, m_flow_ramp.y) annotation(Line(points={{0,-108},{0,-140},{-179,-140}}, color={0,0,127}));
  connect(massFlowRate7.outlet, sink7.inlet) annotation(Line(
      points={{170,60},{180,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, massFlowRate7.inlet) annotation(Line(
      points={{140,60},{150,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, massFlowRate8.inlet) annotation(Line(
      points={{140,-20},{150,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate8.outlet, sink8.inlet) annotation(Line(
      points={{170,-20},{180,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate8.m_flow_prescribed, m_flow_sine.y) annotation(Line(points={{160,-28},{160,-60},{-179,-60}}, color={0,0,127}));
  connect(source9.outlet, massFlowRate9.inlet) annotation(Line(
      points={{140,-100},{150,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate9.outlet, sink9.inlet) annotation(Line(
      points={{170,-100},{180,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate9.m_flow_prescribed, m_flow_ramp.y) annotation(Line(points={{160,-108},{160,-140},{-179,-140}}, color={0,0,127}));
  connect(m_flow_pulse.y, firstOrder.u) annotation(Line(points={{-209,20},{-202,20}}, color={0,0,127}));
  connect(firstOrder.y, massFlowRate1.m_flow_prescribed) annotation(Line(points={{-179,20},{-160,20},{-160,52}},  color={0,0,127}));
  connect(firstOrder.y, massFlowRate4.m_flow_prescribed) annotation(Line(points={{-179,20},{0,20},{0,52}},  color={0,0,127}));
  connect(massFlowRate7.m_flow_prescribed, firstOrder.y) annotation(Line(points={{160,52},{160,20},{-179,20}},  color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-240,-160},{240,160}})),
    Documentation(
      info="<html>
  <p>
    Test model for the <a href=\"modelica://ThermofluidStream.Idealized.Sources.Sink_free\">Sink_free</a> model with varying <code>p,T,h</code> and <code>m_flow</code>.
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
end Setpoints;
