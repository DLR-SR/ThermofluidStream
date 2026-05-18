within ThermofluidStream.Idealized.Tests.Sources.LoopBreaker;
model Specification "Example - Loop breaker"
  extends Modelica.Icons.Example;
  .ThermofluidStream.Idealized.Sources.LoopBreaker loopBreaker(
    redeclare package Medium = Medium,

    p_out_fixed=100000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=293.15) annotation(Placement(transformation(extent={{-160,140},{-180,160}})));

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{240,180},{260,200}})));

  .ThermofluidStream.Idealized.Sources.LoopBreaker loopBreaker2(
    redeclare package Medium = Medium,

    p_out_fixed=100000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=293.15) annotation(Placement(transformation(extent={{-160,60},{-180,80}})));
  Modelica.Blocks.Sources.Ramp m_flow_ramp(
    height=1,
    duration=1,
    offset=1,
    startTime=0) annotation(Placement(transformation(extent={{-240,30},{-220,50}})));
  .ThermofluidStream.Idealized.Sources.LoopBreaker loopBreaker3(
    redeclare package Medium = Medium,

    p_out_fixed=100000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=293.15) annotation(Placement(transformation(extent={{-74,60},{-94,80}})));
  Modelica.Blocks.Sources.Sine m_flow_sine(
    amplitude=1,
    f=2,
    offset=0) annotation(Placement(transformation(extent={{-150,30},{-130,50}})));
  .ThermofluidStream.Idealized.Sources.LoopBreaker loopBreaker5(
    redeclare package Medium = Medium,
    pSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    T_out_fixed=293.15) annotation(Placement(transformation(extent={{30,140},{10,160}})));
  .ThermofluidStream.Idealized.Sources.LoopBreaker loopBreaker6(
    redeclare package Medium = Medium,
    pSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    T_out_fixed=293.15) annotation(Placement(transformation(extent={{132,140},{112,160}})));
  Modelica.Blocks.Sources.Ramp m_flow_ramp1(
    height=1,
    duration=1,
    offset=1,
    startTime=0) annotation(Placement(transformation(extent={{48,120},{68,140}})));
  .ThermofluidStream.Idealized.Sources.LoopBreaker loopBreaker7(
    redeclare package Medium = Medium,
    pSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    T_out_fixed=293.15) annotation(Placement(transformation(extent={{240,140},{220,160}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse1(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-80,110},{-60,130}})));
  Modelica.Blocks.Sources.Sine m_flow_sine1(
    amplitude=1,
    f=2,
    offset=0) annotation(Placement(transformation(extent={{160,110},{180,130}})));
  Modelica.Blocks.Sources.Pulse p_pulse(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation(Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Blocks.Sources.Ramp p_ramp(
    height=1e5,
    duration=1,
    offset=1e5,
    startTime=0) annotation(Placement(transformation(extent={{82,68},{102,88}})));
  Modelica.Blocks.Sources.Sine p_sine(
    amplitude=0.1e5,
    f=2,
    offset=1e5) annotation(Placement(transformation(extent={{200,70},{220,90}})));
  .ThermofluidStream.Idealized.Sources.LoopBreaker loopBreaker8(
    redeclare package Medium = Medium,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,

    p_out_fixed=100000) annotation(Placement(transformation(extent={{-20,-30},{-40,-10}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse3(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{-130,-60},{-110,-40}})));
  Modelica.Blocks.Sources.Ramp h_ramp_evaporization(
    height=Medium.dewEnthalpy(Medium.setSat_p(1e5)) - Medium.bubbleEnthalpy(Medium.setSat_p(1e5)),
    duration=1,
    offset=Medium.bubbleEnthalpy(Medium.setSat_p(1e5)),
    startTime=0) annotation(Placement(transformation(extent={{-60,-90},{-40,-70}})));
  .ThermofluidStream.Idealized.Sources.LoopBreaker loopBreaker10(
    redeclare package Medium = Medium,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    pSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{220,-30},{200,-10}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse5(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation(Placement(transformation(extent={{112,-60},{132,-40}})));
  Modelica.Blocks.Sources.Ramp p_ramp1(
    height=299e5,
    duration=1,
    offset=1e5,
    startTime=0) annotation(Placement(transformation(extent={{180,-90},{200,-70}})));
  Modelica.Blocks.Sources.RealExpression h_const1(y=Medium.bubbleEnthalpy(Medium.setSat_p(1e5)) + 0.9*(
        Medium.dewEnthalpy(Medium.setSat_p(1e5)) - Medium.bubbleEnthalpy(Medium.setSat_p(1e5)))) annotation(
    Placement(transformation(extent={{180,-120},{200,-100}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateSource(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-200,140},{-220,160}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateSource2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-200,60},{-220,80}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateSource3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-108,60},{-128,80}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateSource5(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-10,140},{-30,160}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateSource6(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{90,140},{70,160}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateSource7(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{200,140},{180,160}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateSource8(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-60,-30},{-80,-10}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateSource10(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{180,-30},{160,-10}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation(Placement(transformation(extent={{-50,110},{-30,130}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation(Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation(Placement(transformation(extent={{140,-60},{160,-40}})));
equation
  connect(p_pulse.y, loopBreaker5.p_out_prescribed) annotation(Line(points={{-19,80},{10,80},{10,138}},color={0,0,127}));
  connect(p_ramp.y, loopBreaker6.p_out_prescribed) annotation(Line(points={{103,78},{112,78},{112,138}},
                                                                                                color={0,0,127}));
  connect(p_sine.y, loopBreaker7.p_out_prescribed) annotation(Line(points={{221,80},{220,80},{220,138}}, color={0,0,127}));
  connect(p_ramp1.y, loopBreaker10.p_out_prescribed) annotation(Line(points={{201,-80},{200,-80},{200,-32}},
                                                                                                    color={0,0,127}));
  connect(loopBreaker.outlet, massFlowRateSource.inlet) annotation(
    Line(
      points={{-180,150},{-200,150}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource.outlet, loopBreaker.inlet) annotation(Line(
      points={{-220,150},{-226,150},{-226,166},{-154,166},{-154,150},{-160,150}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_ramp.y, massFlowRateSource2.m_flow_prescribed) annotation(
    Line(points={{-219,40},{-210,40},{-210,62}}, color={0,0,127}));
  connect(loopBreaker2.outlet, massFlowRateSource2.inlet) annotation(
    Line(
      points={{-180,70},{-200,70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource2.outlet, loopBreaker2.inlet) annotation(Line(
      points={{-220,70},{-228,70},{-228,88},{-154,88},{-154,70},{-160,70}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker3.outlet, massFlowRateSource3.inlet) annotation(
    Line(
      points={{-94,70},{-108,70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource3.outlet, loopBreaker3.inlet) annotation(Line(
      points={{-128,70},{-136,70},{-136,86},{-68,86},{-68,70},{-74,70}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_sine.y, massFlowRateSource3.m_flow_prescribed) annotation(
    Line(points={{-129,40},{-118,40},{-118,62}},          color={0,0,127}));
  connect(massFlowRateSource10.inlet, loopBreaker10.outlet) annotation(
    Line(
      points={{180,-20},{200,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource10.outlet, loopBreaker10.inlet) annotation(Line(
      points={{160,-20},{154,-20},{154,-4},{226,-4},{226,-20},{220,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource8.inlet, loopBreaker8.outlet) annotation(
    Line(
      points={{-60,-20},{-40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource8.outlet, loopBreaker8.inlet) annotation(Line(
      points={{-80,-20},{-86,-20},{-86,-4},{-14,-4},{-14,-20},{-20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_sine1.y, massFlowRateSource7.m_flow_prescribed) annotation(
    Line(points={{181,120},{190,120},{190,142}}, color={0,0,127}));
  connect(massFlowRateSource7.inlet, loopBreaker7.outlet) annotation(
    Line(
      points={{200,150},{220,150}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource7.outlet, loopBreaker7.inlet) annotation(Line(
      points={{180,150},{174,150},{174,166},{246,166},{246,150},{240,150}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow_ramp1.y, massFlowRateSource6.m_flow_prescribed) annotation(
    Line(points={{69,130},{80,130},{80,142}},    color={0,0,127}));
  connect(massFlowRateSource6.inlet, loopBreaker6.outlet) annotation(
    Line(
      points={{90,150},{112,150}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource6.outlet, loopBreaker6.inlet) annotation(Line(
      points={{70,150},{64,150},{64,166},{132,166},{132,150}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource5.inlet, loopBreaker5.outlet) annotation(
    Line(
      points={{-10,150},{10,150}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource5.outlet, loopBreaker5.inlet) annotation(Line(
      points={{-30,150},{-36,150},{-36,166},{36,166},{36,150},{30,150}},
      color={28,108,200},
      thickness=0.5));
  connect(h_ramp_evaporization.y, loopBreaker8.h_out_prescribed) annotation(Line(points={{-39,-80},{-32,-80},{-32,-32}}, color={0,0,127}));
  connect(h_const1.y, loopBreaker10.h_out_prescribed) annotation(Line(points={{201,-110},{208,-110},{208,-32}}, color={0,0,127}));
  connect(m_flow_pulse1.y, firstOrder.u) annotation(Line(points={{-59,120},{-52,120}}, color={0,0,127}));
  connect(firstOrder.y, massFlowRateSource5.m_flow_prescribed) annotation(Line(points={{-29,120},{-20,120},{-20,142}}, color={0,0,127}));
  connect(m_flow_pulse3.y, firstOrder1.u) annotation(Line(points={{-109,-50},{-102,-50}}, color={0,0,127}));
  connect(firstOrder1.y, massFlowRateSource8.m_flow_prescribed) annotation(Line(points={{-79,-50},{-70,-50},{-70,-28}}, color={0,0,127}));
  connect(m_flow_pulse5.y, firstOrder2.u) annotation(Line(points={{133,-50},{138,-50}}, color={0,0,127}));
  connect(firstOrder2.y, massFlowRateSource10.m_flow_prescribed) annotation(Line(points={{161,-50},{170,-50},{170,-28}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-260,-200},{260,200}})),
    Documentation(info="<html>
  <p>
    Tests different inputs of mass flow rate, pressure, and specific enthalpy/temperature.
  </p>
  <p>
    The three inputs are varied independently using pulse, sine, and ramp blocks.
  </p>
  <p>
    The mass flow rate is treated independently of the thermodynamic state.
  </p> 
  <p>
    Note that the inlet and outlet of the loop breaker are independent of each other. 
    To obtain a physically meaningful system, the user must ensure that the mass flow rate and thermodynamic state at inlet and outlet are consistent. 
    For numerical robustness, “equal” should be interpreted as “within a specified tolerance.”
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Specification;
