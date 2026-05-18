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
    T0_par=293.15) annotation(Placement(transformation(extent={{-230,70},{-210,90}})));
  ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-170,70},{-150,90}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp(redeclare package Medium = Medium, dp_fixed=100000) annotation(Placement(transformation(extent={{-200,70},{-180,90}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{240,120},{260,140}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-130,70},{-110,90}})));
  ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-70,70},{-50,90}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp1(redeclare package Medium = Medium, outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-100,70},{-80,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1e5) annotation(Placement(transformation(extent={{-110,40},{-90,60}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-30,70},{-10,90}})));
  ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{30,70},{50,90}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    dp_fixed=100000,
    enableFilter=true,
    TC=0.3,
    P_nom(displayUnit="kW") = 1000,
    dp_nom=2000) annotation(Placement(transformation(extent={{0,70},{20,90}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{70,70},{90,90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink3(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{130,70},{150,90}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    dp_fixed=100000,
    p_out(start=100000)) annotation(Placement(transformation(extent={{100,70},{120,90}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{170,70},{190,90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{230,70},{250,90}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp4(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=100000)) annotation(Placement(transformation(extent={{200,70},{220,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=1e5) annotation(Placement(transformation(extent={{250,40},{230,60}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-230,-10},{-210,10}})));
  ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-170,-10},{-150,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pr(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000,
    pr_fixed=2) annotation(Placement(transformation(extent={{-200,-10},{-180,10}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-130,-10},{-110,10}})));
  ThermofluidStream.Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-70,-10},{-50,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pr1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=2) annotation(Placement(transformation(extent={{-110,-40},{-90,-20}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
  ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{30,-10},{50,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pr2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000,
    enableFilter=true,
    TC=0.3,
    P_nom(displayUnit="kW") = 1000,
    dp_nom=2000) annotation(Placement(transformation(extent={{0,-10},{20,10}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{70,-10},{90,10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink8(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{130,-10},{150,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pr3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000,
    p_out(start=100000),
    pr_fixed=2) annotation(Placement(transformation(extent={{100,-10},{120,10}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{170,-10},{190,10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink9(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{230,-10},{250,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pr4(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=100000)) annotation(Placement(transformation(extent={{200,-10},{220,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=2)  annotation(Placement(transformation(extent={{250,-40},{230,-20}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-230,-90},{-210,-70}})));
  ThermofluidStream.Boundaries.Sink_m sink10(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-170,-90},{-150,-70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    dp_fixed=100000,
    pr_fixed=2,
    p_out_fixed=200000) annotation(Placement(transformation(extent={{-200,-90},{-180,-70}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-130,-90},{-110,-70}})));
  ThermofluidStream.Boundaries.Sink_m sink11(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-70,-90},{-50,-70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic p_out1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-100,-90},{-80,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=2e5)
                                                              annotation(Placement(transformation(extent={{-110,-120},{-90,-100}})));
  ThermofluidStream.Boundaries.Source source12(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-30,-90},{-10,-70}})));
  ThermofluidStream.Boundaries.Sink_m sink12(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{30,-90},{50,-70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic p_out2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    dp_fixed=100000,
    enableFilter=true,
    TC=0.3,
    P_nom(displayUnit="kW") = 1000,
    dp_nom=2000) annotation(Placement(transformation(extent={{0,-90},{20,-70}})));
  ThermofluidStream.Boundaries.Source source13(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{70,-90},{90,-70}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink13(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{130,-90},{150,-70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic p_out3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    dp_fixed=100000,
    p_out_fixed=200000,
    p_out(start=100000),
    pr_fixed=2) annotation(Placement(transformation(extent={{100,-90},{120,-70}})));
  ThermofluidStream.Boundaries.Source source14(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{170,-90},{190,-70}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink14(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{230,-90},{250,-70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic p_out4(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=100000)) annotation(Placement(transformation(extent={{200,-90},{220,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=2e5) annotation(Placement(transformation(extent={{250,-120},{230,-100}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{-30,40},{-10,60}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource1(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{70,40},{90,60}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource2(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{170,40},{190,60}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource3(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{-30,-40},{-10,-20}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource4(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{70,-40},{90,-20}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource5(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{170,-40},{190,-20}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource6(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{-30,-120},{-10,-100}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource7(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{70,-120},{90,-100}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource8(E_flow(displayUnit="kW") = 1000) annotation(Placement(transformation(extent={{170,-120},{190,-100}})));
equation
  connect(source.outlet, dp.inlet) annotation(Line(
      points={{-210,80},{-200,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dp.outlet, sink.inlet) annotation(Line(
      points={{-180,80},{-170,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, dp1.inlet) annotation(Line(
      points={{-110,80},{-100,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dp1.outlet, sink1.inlet) annotation(Line(
      points={{-80,80},{-70,80}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression.y, dp1.outletSpec_prescribed) annotation(Line(points={{-89,50},{-80,50},{-80,68}},    color={0,0,127}));
  connect(source2.outlet, dp2.inlet) annotation(Line(
      points={{-10,80},{0,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dp2.outlet, sink2.inlet) annotation(Line(
      points={{20,80},{30,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, dp3.inlet) annotation(Line(
      points={{90,80},{100,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dp3.outlet, sink3.inlet) annotation(Line(
      points={{120,80},{130,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, dp4.inlet) annotation(Line(
      points={{190,80},{200,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dp4.outlet, sink4.inlet) annotation(Line(
      points={{220,80},{230,80}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression1.y, dp4.outletSpec_prescribed) annotation(Line(points={{229,50},{220,50},{220,68}},    color={0,0,127}));
  connect(source5.outlet, pr.inlet) annotation(Line(
      points={{-210,0},{-200,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pr.outlet, sink5.inlet) annotation(Line(
      points={{-180,0},{-170,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet,pr1. inlet) annotation(Line(
      points={{-110,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pr1.outlet,sink6. inlet) annotation(Line(
      points={{-80,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression2.y, pr1.outletSpec_prescribed) annotation(Line(points={{-89,-30},{-80,-30},{-80,-12}}, color={0,0,127}));
  connect(source7.outlet,pr2. inlet) annotation(Line(
      points={{-10,0},{0,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pr2.outlet,sink7. inlet) annotation(Line(
      points={{20,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet,pr3. inlet) annotation(Line(
      points={{90,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pr3.outlet,sink8. inlet) annotation(Line(
      points={{120,0},{130,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source9.outlet,pr4. inlet) annotation(Line(
      points={{190,0},{200,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pr4.outlet,sink9. inlet) annotation(Line(
      points={{220,0},{230,0}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression3.y,pr4. outletSpec_prescribed) annotation(Line(points={{229,-30},{220,-30},{220,-12}}, color={0,0,127}));
  connect(source10.outlet, p_out.inlet) annotation(Line(
      points={{-210,-80},{-200,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out.outlet, sink10.inlet) annotation(Line(
      points={{-180,-80},{-170,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source11.outlet, p_out1.inlet) annotation(Line(
      points={{-110,-80},{-100,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out1.outlet, sink11.inlet) annotation(Line(
      points={{-80,-80},{-70,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression4.y, p_out1.outletSpec_prescribed) annotation(Line(points={{-89,-110},{-80,-110},{-80,-92}}, color={0,0,127}));
  connect(source12.outlet, p_out2.inlet) annotation(Line(
      points={{-10,-80},{0,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out2.outlet, sink12.inlet) annotation(Line(
      points={{20,-80},{30,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source13.outlet, p_out3.inlet) annotation(Line(
      points={{90,-80},{100,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out3.outlet, sink13.inlet) annotation(Line(
      points={{120,-80},{130,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source14.outlet, p_out4.inlet) annotation(Line(
      points={{190,-80},{200,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out4.outlet, sink14.inlet) annotation(Line(
      points={{220,-80},{230,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression5.y, p_out4.outletSpec_prescribed) annotation(Line(points={{229,-110},{220,-110},{220,-92}}, color={0,0,127}));
  connect(energyFlowSource.E_flow_out, dp2.P_in) annotation(Line(points={{-9,50},{10,50},{10,72}}, color={255,170,85}));
  connect(energyFlowSource1.E_flow_out, dp3.P_in) annotation(Line(points={{91,50},{110,50},{110,72}}, color={255,170,85}));
  connect(energyFlowSource2.E_flow_out, dp4.P_in) annotation(Line(points={{191,50},{210,50},{210,72}}, color={255,170,85}));
  connect(energyFlowSource3.E_flow_out, pr2.P_in) annotation(Line(points={{-9,-30},{10,-30},{10,-8}}, color={255,170,85}));
  connect(energyFlowSource4.E_flow_out, pr3.P_in) annotation(Line(points={{91,-30},{110,-30},{110,-8}}, color={255,170,85}));
  connect(energyFlowSource5.E_flow_out, pr4.P_in) annotation(Line(points={{191,-30},{210,-30},{210,-8}}, color={255,170,85}));
  connect(energyFlowSource6.E_flow_out, p_out2.P_in) annotation(Line(points={{-9,-110},{10,-110},{10,-88}}, color={255,170,85}));
  connect(energyFlowSource7.E_flow_out, p_out3.P_in) annotation(Line(points={{91,-110},{110,-110},{110,-88}}, color={255,170,85}));
  connect(energyFlowSource8.E_flow_out, p_out4.P_in) annotation(Line(points={{191,-110},{210,-110},{210,-88}}, color={255,170,85}));
  annotation(Diagram(coordinateSystem(extent={{-260,-140},{260,140}})),
                                             Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Tests hiding the parameters (<code>dp_fixed</code>, <code>pr_fixed</code>, <code>p_out_fixed</code>) in the variable browser.
  </p>
</html>"));
end Setpoint;
