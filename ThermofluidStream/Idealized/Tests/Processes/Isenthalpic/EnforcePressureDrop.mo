within ThermofluidStream.Idealized.Tests.Processes.Isenthalpic;
model EnforcePressureDrop
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-100,60},{-80,80}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{100,100},{120,120}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic dpLoss(redeclare package Medium = Medium, outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    enforcePressureDrop=true)                                                                                                                                        annotation(Placement(transformation(extent={{-70,60},{-50,80}})));
  Modelica.Blocks.Sources.Step massFlowRateStep(
    height=-2,
    offset=1,
    startTime=0.5) annotation(Placement(transformation(extent={{140,-10},{120,10}})));
  Modelica.Blocks.Sources.Pulse dpLossPulse(
    amplitude=-0.2e5,
    period=1,
    offset=0.1e5,
    startTime=0.25) annotation(Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation(Placement(transformation(extent={{110,-10},{90,10}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-100,-10},{-80,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic prLoss(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.RelativePressureLoss,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    enforcePressureDrop=true)                                              annotation(Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Sources.Pulse prLossPulse(
    amplitude=-0.2,
    period=1,
    offset=0.1,
    startTime=0.25) annotation(Placement(transformation(extent={{-80,-40},{-60,-20}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-98,-80},{-78,-60}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-38,-80},{-18,-60}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic pout(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    enforcePressureDrop=true)                                              annotation(Placement(transformation(extent={{-68,-80},{-48,-60}})));
  Modelica.Blocks.Sources.Pulse p_outPulse(
    amplitude=0.2e5,
    period=1,
    offset=0.9e5,
    startTime=0.25) annotation(Placement(transformation(extent={{-78,-110},{-58,-90}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{0,60},{20,80}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{60,60},{80,80}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic dpLoss1(
    redeclare package Medium = Medium,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{30,60},{50,80}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{0,-10},{20,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink4(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic prLoss1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.RelativePressureLoss,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{30,-10},{50,10}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{0,-80},{20,-60}})));
  .ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic pout1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{30,-80},{50,-60}})));

equation
  connect(source.outlet, dpLoss.inlet) annotation(Line(
      points={{-80,70},{-70,70}},
      color={28,108,200},
      thickness=0.5));
  connect(dpLoss.outlet, sink.inlet) annotation(Line(
      points={{-50,70},{-40,70}},
      color={28,108,200},
      thickness=0.5));
  connect(dpLossPulse.y, dpLoss.outletSpec_prescribed) annotation(Line(points={{-59,40},{-50,40},{-50,58}}, color={0,0,127}));
  connect(firstOrder.u, massFlowRateStep.y) annotation(Line(points={{112,0},{119,0}}, color={0,0,127}));
  connect(source1.outlet, prLoss.inlet) annotation(Line(
      points={{-80,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(prLoss.outlet, sink1.inlet) annotation(Line(
      points={{-50,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(prLossPulse.y, prLoss.outletSpec_prescribed) annotation(Line(points={{-59,-30},{-50,-30},{-50,-12}}, color={0,0,127}));
  connect(source2.outlet, pout.inlet) annotation(Line(
      points={{-78,-70},{-68,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(pout.outlet, sink2.inlet) annotation(Line(
      points={{-48,-70},{-38,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(p_outPulse.y, pout.outletSpec_prescribed) annotation(Line(points={{-57,-100},{-48,-100},{-48,-82}}, color={0,0,127}));
  connect(source3.outlet, dpLoss1.inlet) annotation(Line(
      points={{20,70},{30,70}},
      color={28,108,200},
      thickness=0.5));
  connect(dpLoss1.outlet, sink3.inlet) annotation(Line(
      points={{50,70},{60,70}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, prLoss1.inlet) annotation(Line(
      points={{20,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(prLoss1.outlet, sink4.inlet) annotation(Line(
      points={{50,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, pout1.inlet) annotation(Line(
      points={{20,-70},{30,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(pout1.outlet, sink5.inlet) annotation(Line(
      points={{50,-70},{60,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(p_outPulse.y, pout1.outletSpec_prescribed) annotation(Line(points={{-57,-100},{50,-100},{50,-82}}, color={0,0,127}));
  connect(prLossPulse.y, prLoss1.outletSpec_prescribed) annotation(Line(points={{-59,-30},{50,-30},{50,-12}}, color={0,0,127}));
  connect(dpLossPulse.y, dpLoss1.outletSpec_prescribed) annotation(Line(points={{-59,40},{50,40},{50,58}}, color={0,0,127}));
  connect(sink.m_flow_prescribed, firstOrder.y) annotation(Line(points={{-28,70},{-20,70},{-20,90},{80,90},{80,0},{89,0}}, color={0,0,127}));
  connect(firstOrder.y, sink3.m_flow_prescribed) annotation(Line(points={{89,0},{80,0},{80,70},{72,70}}, color={0,0,127}));
  connect(firstOrder.y, sink4.m_flow_prescribed) annotation(Line(points={{89,0},{72,0}}, color={0,0,127}));
  connect(firstOrder.y, sink1.m_flow_prescribed) annotation(Line(points={{89,0},{80,0},{80,20},{-20,20},{-20,0},{-28,0}}, color={0,0,127}));
  connect(firstOrder.y, sink2.m_flow_prescribed) annotation(Line(points={{89,0},{80,0},{80,-52},{-20,-52},{-20,-70},{-26,-70}}, color={0,0,127}));
  connect(firstOrder.y, sink5.m_flow_prescribed) annotation(Line(points={{89,0},{80,0},{80,-70},{72,-70}}, color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-140,-120},{140,120}}),
      graphics={
        Text(
          extent={{-94,110},{-34,92}},
          textColor={28,108,200},
          textString="enforcePressureDrop"),
        Text(
          extent={{2,110},{80,92}},
          textColor={28,108,200},
          textString="not enforcePressureDrop")}),
    Documentation(
      info="<html>
  <p>
    Checks <code>enforcePressureDrop</code>:
  </p>

  <ul>
    <li>
      If <code>enforcePressureDrop = true</code>, the product of mass flow rate and pressure drop 
      <code>m_flow*dp &gt;= 0</code> is enforced, independent of the setpoint.
      If pressure clipping becomes active, this is indicated by a red circle in the icon layer.
    </li>

    <li>
      If <code>enforcePressureDrop = false</code>, the pressure drop may violate the second law of thermodynamics.
      In this case, a warning is issued and the condition is indicated in the icon layer.
    </li>
  </ul>

  <p>
    For inverse calculations, it may be advantageous to set 
    <code>enforcePressureDrop = false</code>, as this simplifies the equation system.
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
end EnforcePressureDrop;
