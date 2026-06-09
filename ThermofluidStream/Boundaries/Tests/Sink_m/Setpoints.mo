within ThermofluidStream.Boundaries.Tests.Sink_m;
model Setpoints "Example - mass flow sink"
  import ThermofluidStream;
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{-72,140},{-52,160}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)          annotation(Placement(transformation(extent={{-262,70},{-242,90}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-220,70},{-200,90}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-130,30},{-150,50}})));
  Modelica.Blocks.Sources.Ramp m_flow_ramp(
    height=1,
    duration=1,
    offset=1,
    startTime=0) annotation(Placement(transformation(extent={{-170,-90},{-190,-70}})));
  Modelica.Blocks.Sources.Sine m_flow_sine(
    amplitude=1,
    f=2,
    offset=0) annotation(Placement(transformation(extent={{-170,-50},{-190,-30}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-262,-50},{-242,-30}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-220,-50},{-200,-30}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-262,-90},{-242,-70}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-220,-90},{-200,-70}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-262,30},{-242,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-220,30},{-200,50}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.01, initType=Modelica.Blocks.Types.Init.InitialState) annotation(Placement(transformation(extent={{-170,30},{-190,50}})));
  Modelica.Blocks.Sources.Ramp m_flow_ramp1(
    height=1,
    duration=1,
    offset=1,
    startTime=0) annotation(Placement(transformation(extent={{40,-90},{20,-70}})));
  Modelica.Blocks.Sources.Sine m_flow_sine1(
    amplitude=1,
    f=2,
    offset=0) annotation(Placement(transformation(extent={{40,-50},{20,-30}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=293.15) annotation(Placement(transformation(extent={{-50,-50},{-30,-30}})));
  .ThermofluidStream.Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-10,-50},{10,-30}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=293.15) annotation(Placement(transformation(extent={{-50,-90},{-30,-70}})));
  .ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-10,-90},{10,-70}})));
  Modelica.Blocks.Sources.Pulse p_pulse(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation(Placement(transformation(extent={{-80,-44},{-60,-24}})));
  Modelica.Blocks.Sources.Sine p_sine(
    amplitude=1e5,
    f=1.5,
    offset=2e5) annotation(Placement(transformation(extent={{-80,-84},{-60,-64}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse3(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{80,30},{60,50}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=293.15) annotation(Placement(transformation(extent={{-50,30},{-30,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink8(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.01, initType=Modelica.Blocks.Types.Init.InitialState) annotation(Placement(transformation(extent={{40,30},{20,50}})));
  Modelica.Blocks.Sources.Pulse p_pulse1(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation(Placement(transformation(extent={{-80,36},{-60,56}})));
  Modelica.Blocks.Sources.Ramp m_flow_ramp2(
    height=1,
    duration=1,
    offset=1,
    startTime=0) annotation(Placement(transformation(extent={{240,-120},{220,-100}})));
  Modelica.Blocks.Sources.Sine m_flow_sine2(
    amplitude=1,
    f=2,
    offset=0) annotation(Placement(transformation(extent={{240,-40},{220,-20}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    xiFromInput=false,
    setEnthalpy=true,
    enthalpyFromInput=true) annotation(Placement(transformation(extent={{150,-40},{170,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink10(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{190,-40},{210,-20}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    xiFromInput=false,
    setEnthalpy=true,
    enthalpyFromInput=true) annotation(Placement(transformation(extent={{150,-120},{170,-100}})));
  .ThermofluidStream.Boundaries.Sink_m sink11(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{190,-120},{210,-100}})));
  Modelica.Blocks.Sources.Pulse p_pulse3(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation(Placement(transformation(extent={{110,-34},{130,-14}})));
  Modelica.Blocks.Sources.Sine p_sine1(
    amplitude=1e5,
    f=1.5,
    offset=2e5) annotation(Placement(transformation(extent={{110,-114},{130,-94}})));
  Modelica.Blocks.Sources.Ramp h_ramp(
    height=Medium.specificEnthalpy_pT(1e5, 273.15 + 120) - Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    duration=1,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    startTime=0) annotation(Placement(transformation(extent={{110,-70},{130,-50}})));
  Modelica.Blocks.Sources.Pulse h_pulse(
    amplitude=Medium.bubbleEnthalpy(Medium.setSat_p(1e5)) + 0.5*(Medium.dewEnthalpy(Medium.setSat_p(1e5)) - Medium.bubbleEnthalpy(Medium.setSat_p(1e5))) - Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    period=0.5,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    startTime=0.3) annotation(Placement(transformation(extent={{110,-150},{130,-130}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse5(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{270,110},{250,130}})));
  ThermofluidStream.Boundaries.Source source12(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    xiFromInput=false,
    setEnthalpy=true,
    enthalpyFromInput=true) annotation(Placement(transformation(extent={{150,110},{170,130}})));
  .ThermofluidStream.Boundaries.Sink_m sink12(
    redeclare package Medium = Medium,
    considerInertance=false,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{190,110},{210,130}})));
  Modelica.Blocks.Sources.Pulse p_pulse5(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation(Placement(transformation(extent={{110,116},{130,136}})));
  Modelica.Blocks.Sources.Pulse h_pulse2(
    amplitude=Medium.bubbleEnthalpy(Medium.setSat_p(1e5)) + 0.5*(Medium.dewEnthalpy(Medium.setSat_p(1e5)) - Medium.bubbleEnthalpy(Medium.setSat_p(1e5))) - Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    period=0.5,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    startTime=0.3) annotation(Placement(transformation(extent={{110,84},{130,104}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=0.01, initType=Modelica.Blocks.Types.Init.InitialState) annotation(Placement(transformation(extent={{230,110},{210,130}})));
equation
  connect(source.outlet, sink.inlet) annotation(Line(
      points={{-242,80},{-220,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, sink2.inlet) annotation(Line(
      points={{-242,-40},{-220,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, sink3.inlet) annotation(Line(
      points={{-242,-80},{-220,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.m_flow_prescribed, m_flow_sine.y) annotation(Line(points={{-208,-40},{-191,-40}}, color={0,0,127}));
  connect(m_flow_ramp.y, sink3.m_flow_prescribed) annotation(Line(points={{-191,-80},{-208,-80}}, color={0,0,127}));
  connect(source1.outlet, sink1.inlet) annotation(Line(
      points={{-242,40},{-220,40}},
      color={28,108,200},
      thickness=0.5));
  connect(firstOrder.u, m_flow_pulse.y) annotation(Line(points={{-168,40},{-151,40}}, color={0,0,127}));
  connect(firstOrder.y, sink1.m_flow_prescribed) annotation(Line(points={{-191,40},{-208,40}}, color={0,0,127}));
  connect(p_pulse.y, source6.p0_var) annotation(Line(points={{-59,-34},{-42,-34}}, color={0,0,127}));
  connect(p_sine.y, source7.p0_var) annotation(Line(points={{-59,-74},{-42,-74}}, color={0,0,127}));
  connect(source6.outlet, sink6.inlet) annotation(Line(
      points={{-30,-40},{-10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, sink7.inlet) annotation(Line(
      points={{-30,-80},{-10,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(sink6.m_flow_prescribed, m_flow_sine1.y) annotation(Line(points={{2,-40},{19,-40}},  color={0,0,127}));
  connect(sink7.m_flow_prescribed, m_flow_ramp1.y) annotation(Line(points={{2,-80},{19,-80}},  color={0,0,127}));
  connect(source8.outlet, sink8.inlet) annotation(Line(
      points={{-30,40},{-10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink8.m_flow_prescribed, firstOrder1.y) annotation(Line(points={{2,40},{19,40}},  color={0,0,127}));
  connect(firstOrder1.u, m_flow_pulse3.y) annotation(Line(points={{42,40},{59,40}}, color={0,0,127}));
  connect(p_pulse1.y, source8.p0_var) annotation(Line(points={{-59,46},{-42,46}}, color={0,0,127}));
  connect(p_pulse3.y, source10.p0_var) annotation(Line(points={{131,-24},{158,-24}}, color={0,0,127}));
  connect(p_sine1.y, source11.p0_var) annotation(Line(points={{131,-104},{158,-104}}, color={0,0,127}));
  connect(h_ramp.y, source10.h0_var) annotation(Line(points={{131,-60},{150,-60},{150,-30},{158,-30}}, color={0,0,127}));
  connect(h_pulse.y, source11.h0_var) annotation(Line(points={{131,-140},{150,-140},{150,-110},{158,-110}}, color={0,0,127}));
  connect(source10.outlet, sink10.inlet) annotation(Line(
      points={{170,-30},{190,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source11.outlet, sink11.inlet) annotation(Line(
      points={{170,-110},{190,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(sink10.m_flow_prescribed, m_flow_sine2.y) annotation(Line(points={{202,-30},{219,-30}}, color={0,0,127}));
  connect(sink11.m_flow_prescribed, m_flow_ramp2.y) annotation(Line(points={{202,-110},{219,-110}}, color={0,0,127}));
  connect(source12.outlet, sink12.inlet) annotation(Line(
      points={{170,120},{190,120}},
      color={28,108,200},
      thickness=0.5));
  connect(p_pulse5.y, source12.p0_var) annotation(Line(points={{131,126},{158,126}}, color={0,0,127}));
  connect(h_pulse2.y, source12.h0_var) annotation(Line(points={{131,94},{150,94},{150,120},{158,120}}, color={0,0,127}));
  connect(sink12.m_flow_prescribed, firstOrder2.y) annotation(Line(points={{202,120},{209,120}}, color={0,0,127}));
  connect(firstOrder2.u, m_flow_pulse5.y) annotation(Line(points={{232,120},{249,120}}, color={0,0,127}));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-280,-160},{280,160}})),
    Documentation(info="<html>
  <p>
    Test model for the <a href=\"modelica://ThermofluidStream.Boundaries.Sink_m\">Sink_m</a> model, with varying <code>p,T,h</code> and <code>m_flow</code>.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Setpoints;
