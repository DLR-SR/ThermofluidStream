within ThermofluidStream.Idealized.Tests.Sources.LoopBreaker_m;
model Specification "Example - mass flow loop breaker"
  extends Modelica.Icons.Example;
  .ThermofluidStream.Idealized.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=1,

    p_out_fixed=100000,
    T_out_fixed=293.15) annotation (Placement(transformation(extent={{-210,150},{-230,170}})));

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{160,60},{180,80}})));

  .ThermofluidStream.Idealized.LoopBreaker_m loopBreaker2(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,

    p_out_fixed=100000,
    thermalSpec=ThermofluidStream.Idealized.Utilities.Types.ThermalSpecification.Temperature,
    T_out_fixed=293.15) annotation (Placement(transformation(extent={{-210,70},{-230,90}})));
  Modelica.Blocks.Sources.Ramp m_flow_ramp(
    height=1,
    duration=1,
    offset=1,
    startTime=0) annotation (Placement(transformation(extent={{-180,50},{-200,70}})));
  .ThermofluidStream.Idealized.LoopBreaker_m loopBreaker3(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,

    p_out_fixed=100000,
    thermalSpec=ThermofluidStream.Idealized.Utilities.Types.ThermalSpecification.Temperature,
    T_out_fixed=293.15) annotation (Placement(transformation(extent={{-130,70},{-150,90}})));
  Modelica.Blocks.Sources.Sine m_flow_sine(
    amplitude=1,
    f=2,
    offset=0) annotation (Placement(transformation(extent={{-100,50},{-120,70}})));
  .ThermofluidStream.Idealized.LoopBreaker_m loopBreaker5(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    pSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    T_out_fixed=293.15) annotation (Placement(transformation(extent={{-50,150},{-70,170}})));
  .ThermofluidStream.Idealized.LoopBreaker_m loopBreaker6(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    pSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    T_out_fixed=293.15) annotation (Placement(transformation(extent={{90,150},{70,170}})));
  Modelica.Blocks.Sources.Ramp m_flow_ramp1(
    height=1,
    duration=1,
    offset=1,
    startTime=0) annotation (Placement(transformation(extent={{120,130},{100,150}})));
  .ThermofluidStream.Idealized.LoopBreaker_m loopBreaker7(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    pSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    T_out_fixed=293.15) annotation (Placement(transformation(extent={{190,150},{170,170}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse1(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation (Placement(transformation(extent={{20,130},{0,150}})));
  Modelica.Blocks.Sources.Sine m_flow_sine1(
    amplitude=1,
    f=2,
    offset=0) annotation (Placement(transformation(extent={{220,130},{200,150}})));
  Modelica.Blocks.Sources.Pulse p_pulse(
    amplitude=1e5,
    period=0.4,
    offset=1e5,
    startTime=0.2) annotation (Placement(transformation(extent={{-100,130},{-80,150}})));
  Modelica.Blocks.Sources.Ramp p_ramp(
    height=1e5,
    duration=1,
    offset=1e5,
    startTime=0) annotation (Placement(transformation(extent={{40,130},{60,150}})));
  Modelica.Blocks.Sources.Sine p_sine(
    amplitude=0.1e5,
    f=2,
    offset=1e5) annotation (Placement(transformation(extent={{140,130},{160,150}})));
  .ThermofluidStream.Idealized.LoopBreaker_m loopBreaker8(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    thermalSpec=ThermofluidStream.Idealized.Utilities.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,

    p_out_fixed=100000) annotation (Placement(transformation(extent={{-110,-30},{-130,-10}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse3(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation (Placement(transformation(extent={{-40,-50},{-60,-30}})));
  Modelica.Blocks.Sources.Ramp h_ramp_evaporization(
    height=Medium.dewEnthalpy(Medium.setSat_p(1e5)) - Medium.bubbleEnthalpy(Medium.setSat_p(1e5)),
    duration=1,
    offset=Medium.bubbleEnthalpy(Medium.setSat_p(1e5)),
    startTime=0) annotation (Placement(transformation(extent={{-160,-50},{-140,-30}})));
  .ThermofluidStream.Idealized.LoopBreaker_m loopBreaker10(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    thermalSpec=ThermofluidStream.Idealized.Utilities.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    pSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{130,-30},{110,-10}})));
  Modelica.Blocks.Sources.Pulse m_flow_pulse5(
    amplitude=1,
    period=0.3,
    offset=1,
    startTime=0.1) annotation (Placement(transformation(extent={{200,-50},{180,-30}})));
  Modelica.Blocks.Sources.Ramp p_ramp1(
    height=299e5,
    duration=1,
    offset=1e5,
    startTime=0) annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
  Modelica.Blocks.Sources.RealExpression h_const1(y=Medium.bubbleEnthalpy(Medium.setSat_p(1e5)) + 0.9*(
        Medium.dewEnthalpy(Medium.setSat_p(1e5)) - Medium.bubbleEnthalpy(Medium.setSat_p(1e5))))
    annotation (Placement(transformation(extent={{80,-74},{100,-54}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation (Placement(transformation(extent={{-20,130},{-40,150}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation (Placement(transformation(extent={{-80,-50},{-100,-30}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=0.01, initType=Modelica.Blocks.Types.Init.InitialOutput) annotation (Placement(transformation(extent={{160,-50},{140,-30}})));
equation
  connect(p_pulse.y, loopBreaker5.p_out_prescribed) annotation (Line(points={{-79,140},{-70,140},{-70,148}},
                                                                                                 color={0,0,127}));
  connect(p_ramp.y, loopBreaker6.p_out_prescribed) annotation (Line(points={{61,140},{70,140},{70,148}},
                                                                                                color={0,0,127}));
  connect(p_sine.y, loopBreaker7.p_out_prescribed) annotation (Line(points={{161,140},{170,140},{170,148}},
                                                                                                   color={0,0,127}));
  connect(p_ramp1.y, loopBreaker10.p_out_prescribed) annotation (Line(points={{101,-40},{110,-40},{110,-32}},
                                                                                                    color={0,0,127}));
  connect(h_ramp_evaporization.y, loopBreaker8.h_out_prescribed) annotation (Line(points={{-139,-40},{-122,-40},{-122,-32}}, color={0,0,127}));
  connect(h_const1.y, loopBreaker10.h_out_prescribed) annotation (Line(points={{101,-64},{118,-64},{118,-32}}, color={0,0,127}));
  connect(loopBreaker.outlet, loopBreaker.inlet) annotation (Line(
      points={{-230,160},{-240,160},{-240,180},{-200,180},{-200,160},{-210,160}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker5.outlet, loopBreaker5.inlet) annotation (Line(
      points={{-70,160},{-80,160},{-80,180},{-40,180},{-40,160},{-50,160}},
      color={28,108,200},
      thickness=0.5));
  connect(firstOrder.u, m_flow_pulse1.y) annotation (Line(points={{-18,140},{-1,140}}, color={0,0,127}));
  connect(firstOrder.y, loopBreaker5.m_flow_in_prescribed) annotation (Line(points={{-41,140},{-50,140},{-50,148}}, color={0,0,127}));
  connect(loopBreaker6.outlet, loopBreaker6.inlet) annotation (Line(
      points={{70,160},{60,160},{60,180},{100,180},{100,160},{90,160}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker6.m_flow_in_prescribed, m_flow_ramp1.y) annotation (Line(points={{90,148},{90,140},{99,140}}, color={0,0,127}));
  connect(loopBreaker7.outlet, loopBreaker7.inlet) annotation (Line(
      points={{170,160},{160,160},{160,180},{200,180},{200,160},{190,160}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker7.m_flow_in_prescribed, m_flow_sine1.y) annotation (Line(points={{190,148},{190,140},{199,140}}, color={0,0,127}));
  connect(m_flow_ramp.y, loopBreaker2.m_flow_in_prescribed) annotation (Line(points={{-201,60},{-210,60},{-210,68}}, color={0,0,127}));
  connect(loopBreaker2.outlet, loopBreaker2.inlet) annotation (Line(
      points={{-230,80},{-240,80},{-240,100},{-200,100},{-200,80},{-210,80}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker3.outlet, loopBreaker3.inlet) annotation (Line(
      points={{-150,80},{-160,80},{-160,100},{-120,100},{-120,80},{-130,80}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker3.m_flow_in_prescribed, m_flow_sine.y) annotation (Line(points={{-130,68},{-130,60},{-121,60}}, color={0,0,127}));
  connect(loopBreaker8.outlet, loopBreaker8.inlet) annotation (Line(
      points={{-130,-20},{-140,-20},{-140,0},{-100,0},{-100,-20},{-110,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(firstOrder1.u, m_flow_pulse3.y) annotation (Line(points={{-78,-40},{-61,-40}}, color={0,0,127}));
  connect(firstOrder1.y, loopBreaker8.m_flow_in_prescribed) annotation (Line(points={{-101,-40},{-110,-40},{-110,-32}}, color={0,0,127}));
  connect(loopBreaker10.outlet, loopBreaker10.inlet) annotation (Line(
      points={{110,-20},{100,-20},{100,0},{142,0},{142,-20},{130,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker10.m_flow_in_prescribed, firstOrder2.y) annotation (Line(points={{130,-32},{130,-40},{139,-40}}, color={0,0,127}));
  connect(firstOrder2.u, m_flow_pulse5.y) annotation (Line(points={{162,-40},{179,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-260,-200},{260,200}})),
    Documentation(info="<html>
  <p>
    This example investigates the behavior of <code>LoopBreaker_m</code> for different inputs of mass flow rate, pressure, and specific enthalpy/temperature.
  </p>
  <p>
    The three inputs are varied independently using pulse, sine, and ramp blocks.
  </p>
  <p>
    The mass flow rate is treated as independent of the thermodynamic state.
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
