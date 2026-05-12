within ThermofluidStream.Idealized.Tests.Sources;
model Sink_m_NeglectInertance "Example - mass flow sink with neglect inertance"
  import ThermofluidStream;
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{60,100},{80,120}})));

  Modelica.Blocks.Sources.Pulse m_flow_pulse1(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation (Placement(transformation(extent={{60,40},{40,60}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    neglectInertance=true,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  .ThermofluidStream.Idealized.Sink_m sink4(
    redeclare package Medium = Medium,
    neglectInertance=true,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse2(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    neglectInertance=true,
    T0_par=293.15) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  .ThermofluidStream.Idealized.Sink_m sink5(
    redeclare package Medium = Medium,
    neglectInertance=true,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Sources.Pulse p_pulse2(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation (Placement(transformation(extent={{-60,-4},{-40,16}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse4(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    neglectInertance=true,
    xiFromInput=false,
    setEnthalpy=true,
    enthalpyFromInput=true) annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
  .ThermofluidStream.Idealized.Sink_m sink9(
    redeclare package Medium = Medium,
    neglectInertance=true,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
  Modelica.Blocks.Sources.Pulse p_pulse4(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation (Placement(transformation(extent={{-70,-54},{-50,-34}})));
  Modelica.Blocks.Sources.Pulse h_pulse1(
    amplitude=Medium.bubbleEnthalpy(Medium.setSat_p(1e5)) + 0.5*(Medium.dewEnthalpy(Medium.setSat_p(1e5)) - Medium.bubbleEnthalpy(Medium.setSat_p(1e5))) - Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    period=0.5,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    startTime=0.3) annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
equation
  connect(source4.outlet, sink4.inlet) annotation (Line(
      points={{-10,50},{10,50}},
      color={28,108,200},
      thickness=0.5));
  connect(sink4.m_flow_prescribed, m_flow_pulse1.y) annotation (Line(points={{22,50},{39,50}},   color={0,0,127}));
  connect(source5.outlet, sink5.inlet) annotation (Line(
      points={{-10,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink5.m_flow_prescribed, m_flow_pulse2.y) annotation (Line(points={{22,0},{39,0}}, color={0,0,127}));
  connect(p_pulse2.y, source5.p0_var) annotation (Line(points={{-39,6},{-22,6}}, color={0,0,127}));
  connect(source9.outlet, sink9.inlet) annotation (Line(
      points={{-10,-50},{10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(sink9.m_flow_prescribed, m_flow_pulse4.y) annotation (Line(points={{22,-50},{39,-50}}, color={0,0,127}));
  connect(p_pulse4.y, source9.p0_var) annotation (Line(points={{-49,-44},{-22,-44}},
                                                                                   color={0,0,127}));
  connect(h_pulse1.y, source9.h0_var) annotation (Line(points={{-49,-80},{-34.5,-80},{-34.5,-50},{-22,-50}},
                                                                                                     color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-100,-100},{-20,-100},{-20,-60},{-60,-60},{-60,20},{-100,20},{-100,-100}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None)}),                           Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-120},{100,120}}), graphics={
        Polygon(
          points={{-80,60},{-40,60},{-40,80},{-60,80},{-60,120},{-80,120},{-80,60}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-50,110},{30,90}},
          textColor={238,46,47},
          textString="requires neglectInertance = true
see User's Guide",
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(info="<html>
  <p>
    Non differentiable mass flow rates require <code>neglectInertance = true</code>.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Sink_m_NeglectInertance;
