within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Setpoint
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium" annotation(
      choicesAllMatching=true);

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-290,70},{-270,90}})));
  ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-230,70},{-210,90}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp(redeclare package Medium = Medium, dp_fixed=100000) annotation(Placement(transformation(extent={{-260,70},{-240,90}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{300,120},{320,140}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-190,70},{-170,90}})));
  ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-130,70},{-110,90}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp1(redeclare package Medium = Medium, outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-160,70},{-140,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1e5) annotation(Placement(transformation(extent={{-170,40},{-150,60}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-90,70},{-70,90}})));
  ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-30,70},{-10,90}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    dp_fixed=100000,
    enableFilter=true,
    TC=0.3,
    P_nom(displayUnit="kW") = 1000,
    dp_nom=2000) annotation(Placement(transformation(extent={{-60,70},{-40,90}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{10,70},{30,90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink3(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{70,70},{90,90}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    dp_fixed=100000,
    p_out(start=100000)) annotation(Placement(transformation(extent={{40,70},{60,90}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{110,70},{130,90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{170,70},{190,90}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp4(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=100000)) annotation(Placement(transformation(extent={{140,70},{160,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=1e5) annotation(Placement(transformation(extent={{190,40},{170,60}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-290,-10},{-270,10}})));
  ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-230,-10},{-210,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pRatio(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000,
    pRatio_fixed=2) annotation(Placement(transformation(extent={{-260,-10},{-240,10}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-190,-10},{-170,10}})));
  ThermofluidStream.Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-130,-10},{-110,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pRatio1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-160,-10},{-140,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=2) annotation(Placement(transformation(extent={{-170,-40},{-150,-20}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-90,-10},{-70,10}})));
  ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pRatio2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000,
    enableFilter=true,
    TC=0.3,
    P_nom(displayUnit="kW") = 1000,
    dp_nom=2000) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{10,-10},{30,10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink8(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{70,-10},{90,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pRatio3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000,
    pRatio_fixed=2) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{110,-10},{130,10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink9(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{170,-10},{190,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pRatio4(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                         annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=2)  annotation(Placement(transformation(extent={{190,-40},{170,-20}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-290,-90},{-270,-70}})));
  ThermofluidStream.Boundaries.Sink_m sink10(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-230,-90},{-210,-70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    dp_fixed=100000,
    pRatio_fixed=2,
    p_out_fixed=200000) annotation(Placement(transformation(extent={{-260,-90},{-240,-70}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-190,-90},{-170,-70}})));
  ThermofluidStream.Boundaries.Sink_m sink11(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-130,-90},{-110,-70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic p_out1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-160,-90},{-140,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=2e5)
                                                              annotation(Placement(transformation(extent={{-170,-120},{-150,-100}})));
  ThermofluidStream.Boundaries.Source source12(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-90,-90},{-70,-70}})));
  ThermofluidStream.Boundaries.Sink_m sink12(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-30,-90},{-10,-70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic p_out2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    dp_fixed=100000,
    enableFilter=true,
    TC=0.3,
    P_nom(displayUnit="kW") = 1000,
    dp_nom=2000) annotation(Placement(transformation(extent={{-60,-90},{-40,-70}})));
  ThermofluidStream.Boundaries.Source source13(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{10,-90},{30,-70}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink13(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{70,-90},{90,-70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic p_out3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    dp_fixed=100000,
    p_out_fixed=200000,
    p_out(start=100000),
    pRatio_fixed=2) annotation(Placement(transformation(extent={{40,-90},{60,-70}})));
  ThermofluidStream.Boundaries.Source source14(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{110,-90},{130,-70}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink14(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{170,-90},{190,-70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic p_out4(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=100000)) annotation(Placement(transformation(extent={{140,-90},{160,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=2e5) annotation(Placement(transformation(extent={{190,-120},{170,-100}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{-90,40},{-70,60}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource1(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{10,40},{30,60}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource2(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{110,40},{130,60}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource3(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{-90,-40},{-70,-20}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource4(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{10,-40},{30,-20}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource5(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{110,-40},{130,-20}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource6(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{-90,-120},{-70,-100}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource7(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{10,-120},{30,-100}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource8(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{110,-120},{130,-100}})));
  Boundaries.Source                   source15(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{220,70},{240,90}})));
  Boundaries.Sink_m                   sink15(redeclare package Medium = Medium, m_flow_fixed=1)
                                                                                               annotation(Placement(transformation(extent={{280,70},{300,90}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp5(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    dp_fixed=100000,
    enableFilter=false,
    TC=0.3,
    P_nom(displayUnit="kW") = 1000,
    dp_nom=2000) annotation(Placement(transformation(extent={{250,70},{270,90}})));
  Boundaries.Source                   source16(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{220,-10},{240,10}})));
  Boundaries.Sink_m                   sink16(redeclare package Medium = Medium, m_flow_fixed=1)
                                                                                               annotation(Placement(transformation(extent={{280,-10},{300,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pRatio5(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000,
    enableFilter=false,
    TC=0.3,
    P_nom(displayUnit="kW") = 1000,
    dp_nom=2000) annotation (Placement(transformation(extent={{250,-10},{270,10}})));
  Boundaries.Source                   source17(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{220,-90},{240,-70}})));
  Boundaries.Sink_m                   sink17(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{280,-90},{300,-70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic p_out5(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    dp_fixed=100000,
    enableFilter=true,
    TC=0.3,
    P_nom(displayUnit="kW") = 1000,
    dp_nom=2000) annotation(Placement(transformation(extent={{250,-90},{270,-70}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource9(E_flow(displayUnit="kW") = 1000)
                                                                                       annotation(Placement(transformation(extent={{220,40},{240,60}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource10(E_flow(displayUnit="kW") = 1000)
                                                                                        annotation(Placement(transformation(extent={{220,-40},{240,-20}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource11(E_flow(displayUnit="kW") = 1000)
                                                                                        annotation(Placement(transformation(extent={{220,-120},{240,-100}})));

equation
  connect(source.outlet, dp.inlet) annotation(Line(
      points={{-270,80},{-260,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dp.outlet, sink.inlet) annotation(Line(
      points={{-240,80},{-230,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, dp1.inlet) annotation(Line(
      points={{-170,80},{-160,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dp1.outlet, sink1.inlet) annotation(Line(
      points={{-140,80},{-130,80}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression.y, dp1.outletSpec_prescribed) annotation(Line(points={{-149,50},{-140,50},{-140,68}}, color={0,0,127}));
  connect(source2.outlet, dp2.inlet) annotation(Line(
      points={{-70,80},{-60,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dp2.outlet, sink2.inlet) annotation(Line(
      points={{-40,80},{-30,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, dp3.inlet) annotation(Line(
      points={{30,80},{40,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dp3.outlet, sink3.inlet) annotation(Line(
      points={{60,80},{70,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, dp4.inlet) annotation(Line(
      points={{130,80},{140,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dp4.outlet, sink4.inlet) annotation(Line(
      points={{160,80},{170,80}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression1.y, dp4.outletSpec_prescribed) annotation(Line(points={{169,50},{160,50},{160,68}},    color={0,0,127}));
  connect(source5.outlet, pRatio.inlet) annotation(Line(
      points={{-270,0},{-260,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio.outlet, sink5.inlet) annotation(Line(
      points={{-240,0},{-230,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, pRatio1.inlet) annotation (Line(
      points={{-170,0},{-160,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio1.outlet, sink6.inlet) annotation (Line(
      points={{-140,0},{-130,0}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression2.y, pRatio1.outletSpec_prescribed) annotation (Line(points={{-149,-30},{-140,-30},{-140,-12}},
                                                                                                                     color={0,0,127}));
  connect(source7.outlet, pRatio2.inlet) annotation (Line(
      points={{-70,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio2.outlet, sink7.inlet) annotation (Line(
      points={{-40,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, pRatio3.inlet) annotation (Line(
      points={{30,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio3.outlet, sink8.inlet) annotation (Line(
      points={{60,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source9.outlet, pRatio4.inlet) annotation (Line(
      points={{130,0},{140,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio4.outlet, sink9.inlet) annotation (Line(
      points={{160,0},{170,0}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression3.y, pRatio4.outletSpec_prescribed) annotation (Line(points={{169,-30},{160,-30},{160,-12}}, color={0,0,127}));
  connect(source10.outlet, p_out.inlet) annotation(Line(
      points={{-270,-80},{-260,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out.outlet, sink10.inlet) annotation(Line(
      points={{-240,-80},{-230,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source11.outlet, p_out1.inlet) annotation(Line(
      points={{-170,-80},{-160,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out1.outlet, sink11.inlet) annotation(Line(
      points={{-140,-80},{-130,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression4.y, p_out1.outletSpec_prescribed) annotation(Line(points={{-149,-110},{-140,-110},{-140,-92}},
                                                                                                                     color={0,0,127}));
  connect(source12.outlet, p_out2.inlet) annotation(Line(
      points={{-70,-80},{-60,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out2.outlet, sink12.inlet) annotation(Line(
      points={{-40,-80},{-30,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source13.outlet, p_out3.inlet) annotation(Line(
      points={{30,-80},{40,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out3.outlet, sink13.inlet) annotation(Line(
      points={{60,-80},{70,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source14.outlet, p_out4.inlet) annotation(Line(
      points={{130,-80},{140,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out4.outlet, sink14.inlet) annotation(Line(
      points={{160,-80},{170,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression5.y, p_out4.outletSpec_prescribed) annotation(Line(points={{169,-110},{160,-110},{160,-92}}, color={0,0,127}));
  connect(energyFlowSource.E_flow_out, dp2.P_in) annotation(Line(points={{-69,50},{-50,50},{-50,72}},
                                                                                                   color={255,170,85}));
  connect(energyFlowSource1.E_flow_out, dp3.P_in) annotation(Line(points={{31,50},{50,50},{50,72}},   color={255,170,85}));
  connect(energyFlowSource2.E_flow_out, dp4.P_in) annotation(Line(points={{131,50},{150,50},{150,72}}, color={255,170,85}));
  connect(energyFlowSource3.E_flow_out, pRatio2.P_in) annotation (Line(points={{-69,-30},{-50,-30},{-50,-8}},
                                                                                                           color={255,170,85}));
  connect(energyFlowSource4.E_flow_out, pRatio3.P_in) annotation (Line(points={{31,-30},{50,-30},{50,-8}},   color={255,170,85}));
  connect(energyFlowSource5.E_flow_out, pRatio4.P_in) annotation (Line(points={{131,-30},{150,-30},{150,-8}}, color={255,170,85}));
  connect(energyFlowSource6.E_flow_out, p_out2.P_in) annotation(Line(points={{-69,-110},{-50,-110},{-50,-88}},
                                                                                                            color={255,170,85}));
  connect(energyFlowSource7.E_flow_out, p_out3.P_in) annotation(Line(points={{31,-110},{50,-110},{50,-88}},   color={255,170,85}));
  connect(energyFlowSource8.E_flow_out, p_out4.P_in) annotation(Line(points={{131,-110},{150,-110},{150,-88}}, color={255,170,85}));
  connect(source15.outlet, dp5.inlet) annotation (Line(
      points={{240,80},{250,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dp5.outlet, sink15.inlet) annotation (Line(
      points={{270,80},{280,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source16.outlet, pRatio5.inlet) annotation (Line(
      points={{240,0},{250,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio5.outlet, sink16.inlet) annotation (Line(
      points={{270,0},{280,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source17.outlet,p_out5. inlet) annotation(Line(
      points={{240,-80},{250,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out5.outlet,sink17. inlet) annotation(Line(
      points={{270,-80},{280,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource9.E_flow_out, dp5.P_in) annotation (Line(points={{241,50},{260,50},{260,72}}, color={255,170,85}));
  connect(energyFlowSource10.E_flow_out, pRatio5.P_in) annotation (Line(points={{241,-30},{260,-30},{260,-8}}, color={255,170,85}));
  connect(energyFlowSource11.E_flow_out, p_out5.P_in) annotation (Line(points={{241,-110},{260,-110},{260,-88}}, color={255,170,85}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-320,-140},{320,140}})),
    Documentation(
      info="<html>
  <p>
    Tests hiding the parameters (<code>dp_fixed</code>, <code>pRatio_fixed</code>, <code>p_out_fixed</code>) in the variable browser.
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
end Setpoint;
