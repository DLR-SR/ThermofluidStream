within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model Setpoint
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"
    annotation (choicesAllMatching=true);

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-240,120},{-220,140}})));
  ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-180,120},{-160,140}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT(redeclare package Medium = Medium, dT_fixed=20) annotation (Placement(transformation(extent={{-210,120},{-190,140}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{240,160},{260,180}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-140,120},{-120,140}})));
  ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-80,120},{-60,140}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT1(redeclare package Medium = Medium, outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-110,120},{-90,140}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=20)  annotation (Placement(transformation(extent={{-120,90},{-100,110}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-40,120},{-20,140}})));
  ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{20,120},{40,140}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false) annotation (Placement(transformation(extent={{-10,120},{10,140}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{60,120},{80,140}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{120,120},{140,140}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT3(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    dT_fixed=20) annotation (Placement(transformation(extent={{90,120},{110,140}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{160,120},{180,140}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{220,120},{240,140}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT4(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=100000)) annotation (Placement(transformation(extent={{190,120},{210,140}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=20)  annotation (Placement(transformation(extent={{240,90},{220,110}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-240,40},{-220,60}})));
  ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-180,40},{-160,60}})));
  ThermofluidStream.Idealized.Processes.Isobaric T(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    dT_fixed=20,
    T_out_fixed=313.15) annotation (Placement(transformation(extent={{-210,40},{-190,60}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-140,40},{-120,60}})));
  ThermofluidStream.Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  ThermofluidStream.Idealized.Processes.Isobaric T1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=313.15)
                                                               annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{20,40},{40,60}})));
  ThermofluidStream.Idealized.Processes.Isobaric T2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{60,40},{80,60}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink8(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{120,40},{140,60}})));
  ThermofluidStream.Idealized.Processes.Isobaric T3(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    dT_fixed=20,
    T_out_fixed=313.15) annotation (Placement(transformation(extent={{90,40},{110,60}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{160,40},{180,60}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink9(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{220,40},{240,60}})));
  ThermofluidStream.Idealized.Processes.Isobaric T4(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=100000)) annotation (Placement(transformation(extent={{190,40},{210,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=313.15)
                                                                annotation (Placement(transformation(extent={{240,10},{220,30}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-240,-30},{-220,-10}})));
  ThermofluidStream.Boundaries.Sink_m sink10(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-180,-30},{-160,-10}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    dT_fixed=20,
    T_out_fixed=313.15,
    dh_fixed=20000) annotation (Placement(transformation(extent={{-210,-30},{-190,-10}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
  ThermofluidStream.Boundaries.Sink_m sink11(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=20e3)
                                                               annotation (Placement(transformation(extent={{-120,-60},{-100,-40}})));
  ThermofluidStream.Boundaries.Source source12(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  ThermofluidStream.Boundaries.Sink_m sink12(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  ThermofluidStream.Boundaries.Source source13(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink13(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{120,-30},{140,-10}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh3(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    dT_fixed=20,
    T_out_fixed=313.15,
    dh_fixed=20000) annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  ThermofluidStream.Boundaries.Source source14(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{160,-30},{180,-10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink14(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{220,-30},{240,-10}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh4(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=100000)) annotation (Placement(transformation(extent={{190,-30},{210,-10}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=20e3)
                                                                annotation (Placement(transformation(extent={{240,-60},{220,-40}})));
  ThermofluidStream.Boundaries.Source source15(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-240,-100},{-220,-80}})));
  ThermofluidStream.Boundaries.Sink_m sink15(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-180,-100},{-160,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric h(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    dT_fixed=20,
    T_out_fixed=313.15,
    dh_fixed=20000,
    h_out_fixed=228000) annotation (Placement(transformation(extent={{-210,-100},{-190,-80}})));
  ThermofluidStream.Boundaries.Source source16(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-140,-100},{-120,-80}})));
  ThermofluidStream.Boundaries.Sink_m sink16(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric h1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-110,-100},{-90,-80}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=228e3)
                                                               annotation (Placement(transformation(extent={{-120,-130},{-100,-110}})));
  ThermofluidStream.Boundaries.Source source17(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  ThermofluidStream.Boundaries.Sink_m sink17(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric h2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy) annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
  ThermofluidStream.Boundaries.Source source18(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink18(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{120,-100},{140,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric h3(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    dT_fixed=20,
    T_out_fixed=313.15,
    dh_fixed=20000,
    h_out_fixed=228000) annotation (Placement(transformation(extent={{90,-100},{110,-80}})));
  ThermofluidStream.Boundaries.Source source19(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{160,-100},{180,-80}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink19(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{220,-100},{240,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric h4(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=100000)) annotation (Placement(transformation(extent={{190,-100},{210,-80}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=228e3)
                                                                annotation (Placement(transformation(extent={{240,-130},{220,-110}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{-40,90},{-20,110}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource1(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{60,90},{80,110}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource2(E_flow(displayUnit="kW") = 1000) annotation (Placement(transformation(extent={{160,90},{180,110}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource3(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource4(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{60,10},{80,30}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource5(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{160,10},{180,30}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource6(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource7(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource8(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{160,-70},{180,-50}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource9(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{-40,-130},{-20,-110}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource10(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{60,-130},{80,-110}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource11(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{160,-130},{180,-110}})));
equation
  connect(source.outlet,dT. inlet) annotation (Line(
      points={{-220,130},{-210,130}},
      color={28,108,200},
      thickness=0.5));
  connect(dT.outlet, sink.inlet) annotation (Line(
      points={{-190,130},{-180,130}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet,dT1. inlet) annotation (Line(
      points={{-120,130},{-110,130}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet, sink1.inlet) annotation (Line(
      points={{-90,130},{-80,130}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression.y,dT1. outletSpec_prescribed) annotation (Line(points={{-99,100},{-90,100},{-90,118}}, color={0,0,127}));
  connect(source2.outlet,dT2. inlet) annotation (Line(
      points={{-20,130},{-10,130}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outlet, sink2.inlet) annotation (Line(
      points={{10,130},{20,130}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet,dT3. inlet) annotation (Line(
      points={{80,130},{90,130}},
      color={28,108,200},
      thickness=0.5));
  connect(dT3.outlet, sink3.inlet) annotation (Line(
      points={{110,130},{120,130}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet,dT4. inlet) annotation (Line(
      points={{180,130},{190,130}},
      color={28,108,200},
      thickness=0.5));
  connect(dT4.outlet, sink4.inlet) annotation (Line(
      points={{210,130},{220,130}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression1.y,dT4. outletSpec_prescribed) annotation (Line(points={{219,100},{210,100},{210,118}}, color={0,0,127}));
  connect(source5.outlet, T.inlet) annotation (Line(
      points={{-220,50},{-210,50}},
      color={28,108,200},
      thickness=0.5));
  connect(T.outlet, sink5.inlet) annotation (Line(
      points={{-190,50},{-180,50}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, T1.inlet) annotation (Line(
      points={{-120,50},{-110,50}},
      color={28,108,200},
      thickness=0.5));
  connect(T1.outlet, sink6.inlet) annotation (Line(
      points={{-90,50},{-80,50}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression2.y, T1.outletSpec_prescribed) annotation (Line(points={{-99,20},{-90,20},{-90,38}}, color={0,0,127}));
  connect(source7.outlet, T2.inlet) annotation (Line(
      points={{-20,50},{-10,50}},
      color={28,108,200},
      thickness=0.5));
  connect(T2.outlet, sink7.inlet) annotation (Line(
      points={{10,50},{20,50}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, T3.inlet) annotation (Line(
      points={{80,50},{90,50}},
      color={28,108,200},
      thickness=0.5));
  connect(T3.outlet, sink8.inlet) annotation (Line(
      points={{110,50},{120,50}},
      color={28,108,200},
      thickness=0.5));
  connect(source9.outlet, T4.inlet) annotation (Line(
      points={{180,50},{190,50}},
      color={28,108,200},
      thickness=0.5));
  connect(T4.outlet, sink9.inlet) annotation (Line(
      points={{210,50},{220,50}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression3.y, T4.outletSpec_prescribed) annotation (Line(points={{219,20},{210,20},{210,38}}, color={0,0,127}));
  connect(source10.outlet, dh.inlet) annotation (Line(
      points={{-220,-20},{-210,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(dh.outlet, sink10.inlet) annotation (Line(
      points={{-190,-20},{-180,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source11.outlet, dh1.inlet) annotation (Line(
      points={{-120,-20},{-110,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(dh1.outlet, sink11.inlet) annotation (Line(
      points={{-90,-20},{-80,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression4.y, dh1.outletSpec_prescribed) annotation (Line(points={{-99,-50},{-90,-50},{-90,-32}}, color={0,0,127}));
  connect(source12.outlet, dh2.inlet) annotation (Line(
      points={{-20,-20},{-10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(dh2.outlet, sink12.inlet) annotation (Line(
      points={{10,-20},{20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source13.outlet, dh3.inlet) annotation (Line(
      points={{80,-20},{90,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(dh3.outlet, sink13.inlet) annotation (Line(
      points={{110,-20},{120,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source14.outlet, dh4.inlet) annotation (Line(
      points={{180,-20},{190,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(dh4.outlet, sink14.inlet) annotation (Line(
      points={{210,-20},{220,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression5.y, dh4.outletSpec_prescribed) annotation (Line(points={{219,-50},{210,-50},{210,-32}}, color={0,0,127}));
  connect(source15.outlet, h.inlet) annotation (Line(
      points={{-220,-90},{-210,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(h.outlet, sink15.inlet) annotation (Line(
      points={{-190,-90},{-180,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source16.outlet, h1.inlet) annotation (Line(
      points={{-120,-90},{-110,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(h1.outlet, sink16.inlet) annotation (Line(
      points={{-90,-90},{-80,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression6.y, h1.outletSpec_prescribed) annotation (Line(points={{-99,-120},{-90,-120},{-90,-102}}, color={0,0,127}));
  connect(source17.outlet, h2.inlet) annotation (Line(
      points={{-20,-90},{-10,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(h2.outlet, sink17.inlet) annotation (Line(
      points={{10,-90},{20,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source18.outlet, h3.inlet) annotation (Line(
      points={{80,-90},{90,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(h3.outlet, sink18.inlet) annotation (Line(
      points={{110,-90},{120,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source19.outlet, h4.inlet) annotation (Line(
      points={{180,-90},{190,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(h4.outlet, sink19.inlet) annotation (Line(
      points={{210,-90},{220,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression7.y, h4.outletSpec_prescribed) annotation (Line(points={{219,-120},{210,-120},{210,-102}}, color={0,0,127}));
  connect(energyFlowSource.E_flow_out, dT2.Q_flow_in) annotation (Line(points={{-19,100},{0,100},{0,122}}, color={255,170,85}));
  connect(energyFlowSource1.E_flow_out, dT3.Q_flow_in) annotation (Line(points={{81,100},{100,100},{100,122}}, color={255,170,85}));
  connect(energyFlowSource2.E_flow_out, dT4.Q_flow_in) annotation (Line(points={{181,100},{200,100},{200,122}}, color={255,170,85}));
  connect(energyFlowSource5.E_flow_out, T4.Q_flow_in) annotation (Line(points={{181,20},{200,20},{200,42}}, color={255,170,85}));
  connect(energyFlowSource4.E_flow_out, T3.Q_flow_in) annotation (Line(points={{81,20},{100,20},{100,42}}, color={255,170,85}));
  connect(energyFlowSource3.E_flow_out, T2.Q_flow_in) annotation (Line(points={{-19,20},{0,20},{0,42}}, color={255,170,85}));
  connect(energyFlowSource6.E_flow_out, dh2.Q_flow_in) annotation (Line(points={{-19,-60},{0,-60},{0,-28}}, color={255,170,85}));
  connect(energyFlowSource7.E_flow_out, dh3.Q_flow_in) annotation (Line(points={{81,-60},{100,-60},{100,-28}}, color={255,170,85}));
  connect(energyFlowSource8.E_flow_out, dh4.Q_flow_in) annotation (Line(points={{181,-60},{200,-60},{200,-28}}, color={255,170,85}));
  connect(energyFlowSource9.E_flow_out, h2.Q_flow_in) annotation (Line(points={{-19,-120},{0,-120},{0,-98}}, color={255,170,85}));
  connect(energyFlowSource10.E_flow_out, h3.Q_flow_in) annotation (Line(points={{81,-120},{100,-120},{100,-98}}, color={255,170,85}));
  connect(energyFlowSource11.E_flow_out, h4.Q_flow_in) annotation (Line(points={{181,-120},{200,-120},{200,-98}}, color={255,170,85}));
  annotation (Diagram(coordinateSystem(extent={{-260,-180},{260,180}})),
                                             Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Setpoint;
