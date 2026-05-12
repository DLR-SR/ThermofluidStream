within ThermofluidStream.Idealized.Tests.Sources;
model Sink_m "Example - mass flow sink"
  import ThermofluidStream;
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)annotation(
    Placement(transformation(extent={{-62,140},{-42,160}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)           annotation(Placement(transformation(extent={{-252,70},{-232,90}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-210,70},{-190,90}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-120,30},{-140,50}})));
  Modelica.Blocks.Sources.Ramp m_flow_ramp(
    height=1,
    duration=1,
    offset=1,
    startTime=0) annotation(Placement(transformation(extent={{-160,-90},{-180,-70}})));
  Modelica.Blocks.Sources.Sine m_flow_sine(
    amplitude=1,
    f=2,
    offset=0) annotation(Placement(transformation(extent={{-160,-50},{-180,-30}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-252,-50},{-232,-30}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-210,-50},{-190,-30}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-252,-90},{-232,-70}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-210,-90},{-190,-70}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-252,30},{-232,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-210,30},{-190,50}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.01, initType=Modelica.Blocks.Types.Init.InitialState) annotation(Placement(transformation(extent={{-160,30},{-180,50}})));
  Modelica.Blocks.Sources.Ramp m_flow_ramp1(
    height=1,
    duration=1,
    offset=1,
    startTime=0) annotation(Placement(transformation(extent={{60,-90},{40,-70}})));
  Modelica.Blocks.Sources.Sine m_flow_sine1(
    amplitude=1,
    f=2,
    offset=0) annotation(Placement(transformation(extent={{60,-50},{40,-30}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=293.15) annotation(Placement(transformation(extent={{-30,-50},{-10,-30}})));
  .ThermofluidStream.Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{10,-50},{30,-30}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=293.15) annotation(Placement(transformation(extent={{-30,-90},{-10,-70}})));
  .ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{10,-90},{30,-70}})));
  Modelica.Blocks.Sources.Pulse p_pulse(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation(Placement(transformation(extent={{-60,-44},{-40,-24}})));
  Modelica.Blocks.Sources.Sine p_sine(
    amplitude=1e5,
    f=1.5,
    offset=2e5) annotation(Placement(transformation(extent={{-60,-84},{-40,-64}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse3(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{100,30},{80,50}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=293.15) annotation(Placement(transformation(extent={{-30,30},{-10,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink8(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{10,30},{30,50}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.01, initType=Modelica.Blocks.Types.Init.InitialState) annotation(Placement(transformation(extent={{60,30},{40,50}})));
  Modelica.Blocks.Sources.Pulse p_pulse1(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation(Placement(transformation(extent={{-60,36},{-40,56}})));
  Modelica.Blocks.Sources.Ramp m_flow_ramp2(
    height=1,
    duration=1,
    offset=1,
    startTime=0) annotation(Placement(transformation(extent={{250,-120},{230,-100}})));
  Modelica.Blocks.Sources.Sine m_flow_sine2(
    amplitude=1,
    f=2,
    offset=0) annotation(Placement(transformation(extent={{250,-40},{230,-20}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    xiFromInput=false,
    setEnthalpy=true,
    enthalpyFromInput=true) annotation(Placement(transformation(extent={{160,-40},{180,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink10(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{200,-40},{220,-20}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    xiFromInput=false,
    setEnthalpy=true,
    enthalpyFromInput=true) annotation(Placement(transformation(extent={{160,-120},{180,-100}})));
  .ThermofluidStream.Boundaries.Sink_m sink11(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{200,-120},{220,-100}})));
  Modelica.Blocks.Sources.Pulse p_pulse3(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation(Placement(transformation(extent={{120,-34},{140,-14}})));
  Modelica.Blocks.Sources.Sine p_sine1(
    amplitude=1e5,
    f=1.5,
    offset=2e5) annotation(Placement(transformation(extent={{120,-114},{140,-94}})));
  Modelica.Blocks.Sources.Ramp h_ramp(
    height=Medium.specificEnthalpy_pT(1e5, 273.15 + 120) - Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    duration=1,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    startTime=0) annotation(Placement(transformation(extent={{120,-70},{140,-50}})));
  Modelica.Blocks.Sources.Pulse h_pulse(
    amplitude=Medium.bubbleEnthalpy(Medium.setSat_p(1e5)) + 0.5*(Medium.dewEnthalpy(Medium.setSat_p(1e5)) - Medium.bubbleEnthalpy(Medium.setSat_p(1e5))) - Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    period=0.5,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    startTime=0.3) annotation(Placement(transformation(extent={{120,-150},{140,-130}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse5(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{280,110},{260,130}})));
  ThermofluidStream.Boundaries.Source source12(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    xiFromInput=false,
    setEnthalpy=true,
    enthalpyFromInput=true) annotation(Placement(transformation(extent={{160,110},{180,130}})));
  .ThermofluidStream.Boundaries.Sink_m sink12(
    redeclare package Medium = Medium,
    neglectInertance=true,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{200,110},{220,130}})));
  Modelica.Blocks.Sources.Pulse p_pulse5(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation(Placement(transformation(extent={{120,116},{140,136}})));
  Modelica.Blocks.Sources.Pulse h_pulse2(
    amplitude=Medium.bubbleEnthalpy(Medium.setSat_p(1e5)) + 0.5*(Medium.dewEnthalpy(Medium.setSat_p(1e5)) - Medium.bubbleEnthalpy(Medium.setSat_p(1e5))) - Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    period=0.5,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    startTime=0.3) annotation(Placement(transformation(extent={{120,84},{140,104}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=0.01, initType=Modelica.Blocks.Types.Init.InitialState) annotation(Placement(transformation(extent={{240,110},{220,130}})));
equation
  connect(source.outlet, sink.inlet) annotation(Line(
      points={{-232,80},{-210,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, sink2.inlet) annotation(Line(
      points={{-232,-40},{-210,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, sink3.inlet) annotation(Line(
      points={{-232,-80},{-210,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.m_flow_prescribed, m_flow_sine.y) annotation(Line(points={{-198,-40},{-181,-40}}, color={0,0,127}));
  connect(m_flow_ramp.y, sink3.m_flow_prescribed) annotation(Line(points={{-181,-80},{-198,-80}}, color={0,0,127}));
  connect(source1.outlet, sink1.inlet) annotation(Line(
      points={{-232,40},{-210,40}},
      color={28,108,200},
      thickness=0.5));
  connect(firstOrder.u, m_flow_pulse.y) annotation(Line(points={{-158,40},{-141,40}}, color={0,0,127}));
  connect(firstOrder.y, sink1.m_flow_prescribed) annotation(Line(points={{-181,40},{-198,40}}, color={0,0,127}));
  connect(p_pulse.y, source6.p0_var) annotation(Line(points={{-39,-34},{-22,-34}}, color={0,0,127}));
  connect(p_sine.y, source7.p0_var) annotation(Line(points={{-39,-74},{-22,-74}}, color={0,0,127}));
  connect(source6.outlet, sink6.inlet) annotation(Line(
      points={{-10,-40},{10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, sink7.inlet) annotation(Line(
      points={{-10,-80},{10,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(sink6.m_flow_prescribed, m_flow_sine1.y) annotation(Line(points={{22,-40},{39,-40}}, color={0,0,127}));
  connect(sink7.m_flow_prescribed, m_flow_ramp1.y) annotation(Line(points={{22,-80},{39,-80}}, color={0,0,127}));
  connect(source8.outlet, sink8.inlet) annotation(Line(
      points={{-10,40},{10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink8.m_flow_prescribed, firstOrder1.y) annotation(Line(points={{22,40},{39,40}}, color={0,0,127}));
  connect(firstOrder1.u, m_flow_pulse3.y) annotation(Line(points={{62,40},{79,40}}, color={0,0,127}));
  connect(p_pulse1.y, source8.p0_var) annotation(Line(points={{-39,46},{-22,46}}, color={0,0,127}));
  connect(p_pulse3.y, source10.p0_var) annotation(Line(points={{141,-24},{168,-24}}, color={0,0,127}));
  connect(p_sine1.y, source11.p0_var) annotation(Line(points={{141,-104},{168,-104}}, color={0,0,127}));
  connect(h_ramp.y, source10.h0_var) annotation(Line(points={{141,-60},{160,-60},{160,-30},{168,-30}}, color={0,0,127}));
  connect(h_pulse.y, source11.h0_var) annotation(Line(points={{141,-140},{160,-140},{160,-110},{168,-110}}, color={0,0,127}));
  connect(source10.outlet, sink10.inlet) annotation(Line(
      points={{180,-30},{200,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source11.outlet, sink11.inlet) annotation(Line(
      points={{180,-110},{200,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(sink10.m_flow_prescribed, m_flow_sine2.y) annotation(Line(points={{212,-30},{229,-30}}, color={0,0,127}));
  connect(sink11.m_flow_prescribed, m_flow_ramp2.y) annotation(Line(points={{212,-110},{229,-110}}, color={0,0,127}));
  connect(source12.outlet, sink12.inlet) annotation(Line(
      points={{180,120},{200,120}},
      color={28,108,200},
      thickness=0.5));
  connect(p_pulse5.y, source12.p0_var) annotation(Line(points={{141,126},{168,126}}, color={0,0,127}));
  connect(h_pulse2.y, source12.h0_var) annotation(Line(points={{141,94},{160,94},{160,120},{168,120}}, color={0,0,127}));
  connect(sink12.m_flow_prescribed, firstOrder2.y) annotation(Line(points={{212,120},{219,120}}, color={0,0,127}));
  connect(firstOrder2.u, m_flow_pulse5.y) annotation(Line(points={{242,120},{259,120}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-280,-160},{280,160}})),
    Documentation(info="<html>
  <p>
    Test model for <code>sink_m</code> with varying p,T,h and m_flow.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Sink_m;
