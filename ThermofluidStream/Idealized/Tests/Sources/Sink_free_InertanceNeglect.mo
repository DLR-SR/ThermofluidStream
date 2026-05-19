within ThermofluidStream.Idealized.Tests.Sources;
model Sink_free_InertanceNeglect "Example - free sink"
  import ThermofluidStream;
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{40,60},{60,80}})));

  Modelica.Blocks.Sources.Pulse m_flow_pulse1(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-200,-56},{-180,-36}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-200,-16},{-180,4}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink10(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{-140,-16},{-120,4}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    considerInertance=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-40,-16},{-20,4}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink11(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{20,-16},{40,4}})));
  Modelica.Blocks.Sources.Ramp p_ramp2(
    height=1e5,
    duration=1,
    offset=1e5,
    startTime=0) annotation(Placement(transformation(extent={{-80,-10},{-60,10}})));
  ThermofluidStream.Boundaries.Source source12(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    considerInertance=false,
    xiFromInput=false,
    setEnthalpy=true,
    enthalpyFromInput=true) annotation(Placement(transformation(extent={{120,-16},{140,4}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink12(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{180,-16},{200,4}})));
  Modelica.Blocks.Sources.Ramp p_ramp3(
    height=1e5,
    duration=1,
    offset=1e5,
    startTime=0) annotation(Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Sources.Sine h_sine1(
    amplitude=(Medium.specificEnthalpy_pT(1e5, 273.15 + 200) - Medium.specificEnthalpy_pT(1e5, 273.15 + 120)),
    f=1,
    offset=Medium.specificEnthalpy_pT(1e5, 273.15 + 120)) annotation(
    Placement(transformation(extent={{80,-40},{100,-20}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate10(
    redeclare package Medium = Medium,
    considerInertance=false,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-170,-16},{-150,4}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate11(
    redeclare package Medium = Medium,
    considerInertance=false,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-10,-16},{10,4}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate12(
    redeclare package Medium = Medium,
    considerInertance=false,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{150,-16},{170,4}})));
equation
  connect(p_ramp2.y, source11.p0_var) annotation(Line(points={{-59,0},{-32,0}},   color={0,0,127}));
  connect(p_ramp3.y, source12.p0_var) annotation(Line(points={{101,0},{128,0}},   color={0,0,127}));
  connect(h_sine1.y, source12.h0_var) annotation(Line(points={{101,-30},{114,-30},{114,-6},{128,-6}},color={0,0,127}));
  connect(source10.outlet, massFlowRate10.inlet) annotation(Line(
      points={{-180,-6},{-170,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate10.outlet, sink10.inlet) annotation(Line(
      points={{-150,-6},{-140,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_pulse1.y, massFlowRate10.m_flow_prescribed) annotation(Line(points={{-179,-46},{-160,-46},{-160,-14}},
                                                                                                             color={0,0,127}));
  connect(source11.outlet, massFlowRate11.inlet) annotation(Line(
      points={{-20,-6},{-10,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate11.outlet, sink11.inlet) annotation(Line(
      points={{10,-6},{20,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_pulse1.y, massFlowRate11.m_flow_prescribed) annotation(Line(points={{-179,-46},{0,-46},{0,-14}},
                                                                                                       color={0,0,127}));
  connect(massFlowRate12.outlet, sink12.inlet) annotation(Line(
      points={{170,-6},{180,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(source12.outlet, massFlowRate12.inlet) annotation(Line(
      points={{140,-6},{150,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate12.m_flow_prescribed, m_flow_pulse1.y) annotation(Line(points={{160,-14},{160,-46},{-179,-46}},
                                                                                                           color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-100,-100},{-20,-100},{-20,-60},{-60,-60},{-60,20},{-100,20},{-100,-100}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None)}),                           Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-220,-80},{220,80}}),   graphics={
        Polygon(
          points={{-160,20},{-120,20},{-120,40},{-140,40},{-140,80},{-160,80},{-160,20}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-140,80},{-60,60}},
          textColor={238,46,47},
          textString="requires considerInertance = false
see User's Guide",
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(info="<html>
  <p>
    Test model for the <a href=\"modelica://ThermofluidStream.Idealized.Sources.Sink_free\">Sink_free</a> model.
  </p>

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
end Sink_free_InertanceNeglect;
