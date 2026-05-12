within ThermofluidStream.Idealized.Tests.Sources.LoopBreaker;
model NeglectInertance "Example - Loop breaker"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconInertanceNeglect;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{140,100},{160,120}})));

  .ThermofluidStream.Idealized.Sources.LoopBreaker loopBreaker(
    redeclare package Medium = Medium,
    considerInertance=false,

    p_out_fixed=100000,
    T_out_fixed=293.15) annotation(Placement(transformation(extent={{-66,20},{-86,40}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-140,-10},{-120,10}})));
  .ThermofluidStream.Idealized.Sources.LoopBreaker loopBreaker1(
    redeclare package Medium = Medium,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    considerInertance=false,

    p_out_fixed=100000) annotation(Placement(transformation(extent={{34,20},{14,40}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse2(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.RealExpression h_const(y=Medium.dewEnthalpy(Medium.setSat_p(1e5))) annotation(
    Placement(transformation(extent={{-6,-40},{14,-20}})));
  .ThermofluidStream.Idealized.Sources.LoopBreaker loopBreaker2(
    redeclare package Medium = Medium,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    considerInertance=false,

    p_out_fixed=100000) annotation(Placement(transformation(extent={{146,20},{126,40}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse4(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{66,-10},{86,10}})));
  Modelica.Blocks.Sources.Ramp h_ramp_subcooling_superheating(
    height=Medium.specificEnthalpy_pT(1e5, 273.15 + 120),
    duration=1,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    startTime=0) annotation(Placement(transformation(extent={{106,-40},{126,-20}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateSource(
    redeclare package Medium = Medium,
    considerInertance=false,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-100,20},{-120,40}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateSource1(
    redeclare package Medium = Medium,
    considerInertance=false,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{0,20},{-20,40}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateSource2(
    redeclare package Medium = Medium,
    considerInertance=false,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{106,20},{86,40}})));
equation
  connect(loopBreaker.outlet, massFlowRateSource.inlet) annotation(Line(
      points={{-86,30},{-100,30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource.outlet, loopBreaker.inlet) annotation(Line(
      points={{-120,30},{-128,30},{-128,46},{-60,46},{-60,30},{-66,30}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_pulse.y, massFlowRateSource.m_flow_prescribed) annotation(Line(points={{-119,0},{-110,0},{-110,22}}, color={0,0,127}));
  connect(m_flow_pulse4.y,massFlowRateSource2. m_flow_prescribed) annotation(
    Line(points={{87,0},{96,0},{96,22}},      color={0,0,127}));
  connect(massFlowRateSource2.inlet,loopBreaker2. outlet) annotation(
    Line(
      points={{106,30},{126,30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource2.outlet,loopBreaker2. inlet) annotation(Line(
      points={{86,30},{80,30},{80,46},{152,46},{152,30},{146,30}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_pulse2.y,massFlowRateSource1. m_flow_prescribed) annotation(
    Line(points={{-19,0},{-10,0},{-10,22}},         color={0,0,127}));
  connect(massFlowRateSource1.inlet,loopBreaker1. outlet) annotation(
    Line(
      points={{0,30},{14,30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource1.outlet,loopBreaker1. inlet) annotation(Line(
      points={{-20,30},{-26,30},{-26,46},{40,46},{40,30},{34,30}},
      color={28,108,200},
      thickness=0.5));
  connect(h_const.y, loopBreaker1.h_out_prescribed) annotation(Line(points={{15,-30},{22,-30},{22,18}}, color={0,0,127}));
  connect(h_ramp_subcooling_superheating.y, loopBreaker2.h_out_prescribed) annotation(Line(points={{127,-30},{134,-30},{134,18}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-120},{160,120}}), graphics={
        Polygon(
          points={{-160,60},{-120,60},{-120,80},{-140,80},{-140,120},{-160,120},{-160,60}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-130,110},{-50,90}},
          textColor={238,46,47},
          textString="requires considerInertance = false
see User's Guide",
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(info="<html>
  <p>
    Non differentiable mass flow rates require <code>considerInertance = false</code>.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end NeglectInertance;
