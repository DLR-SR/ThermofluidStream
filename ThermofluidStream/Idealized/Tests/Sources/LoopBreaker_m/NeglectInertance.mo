within ThermofluidStream.Idealized.Tests.Sources.LoopBreaker_m;
model NeglectInertance "Example - mass flow loop breaker"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)annotation(
    Placement(transformation(extent={{120,40},{140,60}})));

  .ThermofluidStream.Idealized.Sources.LoopBreaker_m loopBreaker1(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    considerInertance=false,

    p_out_fixed=100000,
    T_out_fixed=293.15) annotation(Placement(transformation(extent={{-90,-10},{-110,10}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-60,-30},{-80,-10}})));
  .ThermofluidStream.Idealized.Sources.LoopBreaker_m loopBreaker4(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    considerInertance=false,

    p_out_fixed=100000) annotation(Placement(transformation(extent={{10,-10},{-10,10}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse2(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{40,-30},{20,-10}})));
  Modelica.Blocks.Sources.RealExpression h_const(y=Medium.dewEnthalpy(Medium.setSat_p(1e5)))annotation(
    Placement(transformation(extent={{-40,-30},{-20,-10}})));
  .ThermofluidStream.Idealized.Sources.LoopBreaker_m loopBreaker9(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    considerInertance=false,

    p_out_fixed=100000) annotation(Placement(transformation(extent={{110,-10},{90,10}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse4(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{140,-30},{120,-10}})));
  Modelica.Blocks.Sources.Ramp h_ramp_subcooling_superheating(
    height=Medium.specificEnthalpy_pT(1e5, 273.15 + 120),
    duration=1,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 20),
    startTime=0) annotation(Placement(transformation(extent={{60,-32},{80,-12}})));
equation
  connect(h_const.y, loopBreaker4.h_out_prescribed) annotation(Line(points={{-19,-20},{-2,-20},{-2,-12}}, color={0,0,127}));
  connect(h_ramp_subcooling_superheating.y, loopBreaker9.h_out_prescribed) annotation(Line(points={{81,-22},{98,-22},{98,-12}}, color={0,0,127}));
  connect(loopBreaker1.outlet, loopBreaker1.inlet) annotation(Line(
      points={{-110,0},{-120,0},{-120,20},{-80,20},{-80,0},{-90,0}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_pulse.y, loopBreaker1.m_flow_in_prescribed) annotation(Line(points={{-81,-20},{-90,-20},{-90,-12}},    color={0,0,127}));
  connect(loopBreaker4.outlet, loopBreaker4.inlet) annotation(Line(
      points={{-10,0},{-20,0},{-20,20},{20,20},{20,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_pulse2.y, loopBreaker4.m_flow_in_prescribed) annotation(Line(points={{19,-20},{10,-20},{10,-12}},       color={0,0,127}));
  connect(loopBreaker9.outlet, loopBreaker9.inlet) annotation(Line(
      points={{90,0},{80,0},{80,20},{120,20},{120,0},{110,0}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_pulse4.y, loopBreaker9.m_flow_in_prescribed) annotation(Line(points={{119,-20},{110,-20},{110,-12}},
                                                                                                             color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-80},{160,100}}), graphics={
        Polygon(
          points={{-160,40},{-120,40},{-120,60},{-140,60},{-140,100},{-160,100},{-160,40}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-130,90},{-50,70}},
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
end NeglectInertance;
