within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Setpoint
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"
    annotation (choicesAllMatching=true);

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-240,50},{-220,70}})));
  ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-180,50},{-160,70}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.TemperatureDifference,
    dT_fixed=20) annotation (Placement(transformation(extent={{-210,50},{-190,70}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{240,100},{260,120}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-140,50},{-120,70}})));
  ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=20)  annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{20,50},{40,70}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.TemperatureDifference) annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{60,50},{80,70}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{120,50},{140,70}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT3(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.TemperatureDifference,
    dT_fixed=20) annotation (Placement(transformation(extent={{90,50},{110,70}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{160,50},{180,70}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{220,50},{240,70}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT4(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=100000)) annotation (Placement(transformation(extent={{190,50},{210,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=20)  annotation (Placement(transformation(extent={{240,20},{220,40}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-240,-30},{-220,-10}})));
  ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-180,-30},{-160,-10}})));
  ThermofluidStream.Idealized.Processes.Isochoric T(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.OutletTemperature,
    dT_fixed=20,
    T_out_fixed=313.15) annotation (Placement(transformation(extent={{-210,-30},{-190,-10}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
  ThermofluidStream.Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  ThermofluidStream.Idealized.Processes.Isochoric T1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=313.15)
                                                               annotation (Placement(transformation(extent={{-120,-60},{-100,-40}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  ThermofluidStream.Idealized.Processes.Isochoric T2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.OutletTemperature) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink8(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{120,-30},{140,-10}})));
  ThermofluidStream.Idealized.Processes.Isochoric T3(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.OutletTemperature,
    dT_fixed=20,
    T_out_fixed=313.15) annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{160,-30},{180,-10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink9(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{220,-30},{240,-10}})));
  ThermofluidStream.Idealized.Processes.Isochoric T4(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=100000)) annotation (Placement(transformation(extent={{190,-30},{210,-10}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=313.15)
                                                                annotation (Placement(transformation(extent={{240,-60},{220,-40}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource1(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{60,20},{80,40}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource2(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{160,20},{180,40}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource3(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource4(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource5(E_flow(displayUnit="kW") = 20000) annotation (Placement(transformation(extent={{160,-60},{180,-40}})));
equation
  connect(source.outlet,dT. inlet) annotation (Line(
      points={{-220,60},{-210,60}},
      color={28,108,200},
      thickness=0.5));
  connect(dT.outlet, sink.inlet) annotation (Line(
      points={{-190,60},{-180,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet,dT1. inlet) annotation (Line(
      points={{-120,60},{-110,60}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet, sink1.inlet) annotation (Line(
      points={{-90,60},{-80,60}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression.y,dT1. outletSpec_prescribed) annotation (Line(points={{-99,30},{-90,30},{-90,48}},    color={0,0,127}));
  connect(source2.outlet,dT2. inlet) annotation (Line(
      points={{-20,60},{-10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outlet, sink2.inlet) annotation (Line(
      points={{10,60},{20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet,dT3. inlet) annotation (Line(
      points={{80,60},{90,60}},
      color={28,108,200},
      thickness=0.5));
  connect(dT3.outlet, sink3.inlet) annotation (Line(
      points={{110,60},{120,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet,dT4. inlet) annotation (Line(
      points={{180,60},{190,60}},
      color={28,108,200},
      thickness=0.5));
  connect(dT4.outlet, sink4.inlet) annotation (Line(
      points={{210,60},{220,60}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression1.y,dT4. outletSpec_prescribed) annotation (Line(points={{219,30},{210,30},{210,48}},    color={0,0,127}));
  connect(source5.outlet, T.inlet) annotation (Line(
      points={{-220,-20},{-210,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(T.outlet, sink5.inlet) annotation (Line(
      points={{-190,-20},{-180,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, T1.inlet) annotation (Line(
      points={{-120,-20},{-110,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(T1.outlet, sink6.inlet) annotation (Line(
      points={{-90,-20},{-80,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression2.y, T1.outletSpec_prescribed) annotation (Line(points={{-99,-50},{-90,-50},{-90,-32}}, color={0,0,127}));
  connect(source7.outlet, T2.inlet) annotation (Line(
      points={{-20,-20},{-10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(T2.outlet, sink7.inlet) annotation (Line(
      points={{10,-20},{20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, T3.inlet) annotation (Line(
      points={{80,-20},{90,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(T3.outlet, sink8.inlet) annotation (Line(
      points={{110,-20},{120,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source9.outlet, T4.inlet) annotation (Line(
      points={{180,-20},{190,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(T4.outlet, sink9.inlet) annotation (Line(
      points={{210,-20},{220,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression3.y, T4.outletSpec_prescribed) annotation (Line(points={{219,-50},{210,-50},{210,-32}}, color={0,0,127}));
  connect(energyFlowSource.E_flow_out, dT2.Q_flow_in) annotation (Line(points={{-19,30},{0,30},{0,52}}, color={255,170,85}));
  connect(energyFlowSource1.E_flow_out, dT3.Q_flow_in) annotation (Line(points={{81,30},{100,30},{100,52}}, color={255,170,85}));
  connect(energyFlowSource2.E_flow_out, dT4.Q_flow_in) annotation (Line(points={{181,30},{200,30},{200,52}}, color={255,170,85}));
  connect(energyFlowSource3.E_flow_out, T2.Q_flow_in) annotation (Line(points={{-19,-50},{0,-50},{0,-28}}, color={255,170,85}));
  connect(energyFlowSource4.E_flow_out, T3.Q_flow_in) annotation (Line(points={{81,-50},{100,-50},{100,-28}}, color={255,170,85}));
  connect(energyFlowSource5.E_flow_out, T4.Q_flow_in) annotation (Line(points={{181,-50},{200,-50},{200,-28}}, color={255,170,85}));
  annotation (Diagram(coordinateSystem(extent={{-260,-100},{260,100}})),
                                             Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Setpoint;
