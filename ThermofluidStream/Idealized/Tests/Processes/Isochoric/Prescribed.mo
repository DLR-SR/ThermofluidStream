within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Prescribed "Example - Isochoric process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  SI.MassFlowRate m_flow = firstOrder.y "Mass flow rate";
  Medium.AbsolutePressure p_in = inletPressure.y "Inlet pressure";
  Medium.Temperature T_in = inletTemperature.y "Inlet temperature";
  SI.TemperatureDifference dT = temperatureDifference.y "Temperature difference";
  Medium.Temperature T_out = T_in + dT "Outlet temperature";
  Medium.Density rho = Medium.density(state_in) "Density";
  Medium.ThermodynamicState state_in = Medium.setState_pTX(p_in, T_in, Medium.X_default) "Inlet state";
  Medium.ThermodynamicState state_out = Medium.setState_dTX(rho, T_out, Medium.X_default) "Outlet state";
  SI.SpecificEnthalpy h_in = Medium.specificEnthalpy(state_in) "Inlet specific enthalpy";
  SI.SpecificEnthalpy h_out = Medium.specificEnthalpy(state_out) "Outlet specific enthalpy";
  SI.Pressure p_out = Medium.pressure(state_out) "Outlet pressure";
  SI.SpecificEnergy u_in = h_in - p_in/rho "Inlet specific internal energy";
  SI.SpecificEnergy u_out = h_out - p_out/rho "Outlet specific internal energy";
  SI.SpecificEnergy du = u_out - u_in "Specific internal energy difference";
  SI.HeatFlowRate Q_flow = m_flow*du "Heat flow rate";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{160,160},{180,180}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-92,120},{-72,140}})));
  Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-32,120},{-12,140}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT1c(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-62,120},{-42,140}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-92,-30},{-72,-10}})));
  Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-32,-30},{-12,-10}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out1c(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-62,-30},{-42,-10}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-92,70},{-72,90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink2(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-32,70},{-12,90}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT2c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-62,70},{-42,90}})));
  EnergyFlow.Sources.PrescribedEnergyFlow
                                     energyFlowSource               annotation(Placement(transformation(extent={{-142,-120},{-122,-100}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-92,-80},{-72,-60}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink3(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-32,-80},{-12,-60}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out2c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-62,-80},{-42,-60}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-92,20},{-72,40}})));
  Boundaries.Sink_m sink4(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-32,20},{-12,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT3c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-62,20},{-42,40}})));
  Modelica.Blocks.Sources.SawTooth inletPressure(
    amplitude=1e5,
    period=1,
    offset=1e5,
    startTime=0.1) annotation(Placement(transformation(extent={{-150,126},{-130,146}})));
  Modelica.Blocks.Sources.SawTooth inletTemperature(
    amplitude=100,
    period=1,
    offset=293.15,
    startTime=0.2) annotation(Placement(transformation(extent={{-150,70},{-130,90}})));
  Modelica.Blocks.Sources.SawTooth massFlowRate(
    amplitude=-2,
    period=1,
    offset=1,
    startTime=0.4) annotation(Placement(transformation(extent={{-172,-150},{-152,-130}})));
  Modelica.Blocks.Sources.SawTooth temperatureDifference(
    amplitude=-40,
    period=1,
    offset=20,
    startTime=0.3) annotation(Placement(transformation(extent={{-150,16},{-130,36}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation(Placement(transformation(extent={{-132,-150},{-112,-130}})));
  Modelica.Blocks.Sources.RealExpression heatFlowRate(y=Q_flow) annotation(Placement(transformation(extent={{-172,-120},{-152,-100}})));
  Modelica.Blocks.Sources.RealExpression outletTemperature(y=T_out) annotation(Placement(transformation(extent={{-150,-50},{-130,-30}})));
  Boundaries.Source                   source5(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{38,120},{58,140}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{68,120},{88,140}})));
  Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                                                                                                                              annotation(Placement(transformation(extent={{98,120},{118,140}})));
  Boundaries.Source                   source6(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{38,70},{58,90}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{68,70},{88,90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink6(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{98,70},{118,90}})));
  Boundaries.Source                   source7(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{38,20},{58,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT3(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{68,20},{88,40}})));
  Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{98,20},{118,40}})));
  Boundaries.Source                   source8(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{38,-30},{58,-10}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{68,-30},{88,-10}})));
  Boundaries.Sink_m sink8(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{98,-30},{118,-10}})));
  Boundaries.Source                   source9(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{38,-80},{58,-60}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{68,-80},{88,-60}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink9(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{98,-80},{118,-60}})));

equation
  connect(source.outlet, dT1c.inlet) annotation (Line(
      points={{-72,130},{-62,130}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1c.outlet, sink.inlet) annotation (Line(
      points={{-42,130},{-32,130}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, T_out1c.inlet) annotation (Line(
      points={{-72,-20},{-62,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1c.outlet, sink1.inlet) annotation (Line(
      points={{-42,-20},{-32,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, dT2c.inlet) annotation (Line(
      points={{-72,80},{-62,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2c.outlet, sink2.inlet) annotation (Line(
      points={{-42,80},{-32,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, T_out2c.inlet) annotation (Line(
      points={{-72,-70},{-62,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2c.outlet, sink3.inlet) annotation (Line(
      points={{-42,-70},{-32,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, dT3c.inlet) annotation (Line(
      points={{-72,30},{-62,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT3c.outlet, sink4.inlet) annotation (Line(
      points={{-42,30},{-32,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source.p0_var, inletPressure.y) annotation(Line(points={{-84,136},{-129,136}}, color={0,0,127}));
  connect(source2.p0_var, inletPressure.y) annotation(Line(points={{-84,86},{-116,86},{-116,136},{-129,136}}, color={0,0,127}));
  connect(source4.p0_var, inletPressure.y) annotation(Line(points={{-84,36},{-116,36},{-116,136},{-129,136}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation(Line(points={{-84,-14},{-116,-14},{-116,136},{-129,136}}, color={0,0,127}));
  connect(source3.p0_var, inletPressure.y) annotation(Line(points={{-84,-64},{-116,-64},{-116,136},{-129,136}}, color={0,0,127}));
  connect(inletTemperature.y, source2.T0_var) annotation(Line(points={{-129,80},{-84,80}}, color={0,0,127}));
  connect(source.T0_var, inletTemperature.y) annotation(Line(points={{-84,130},{-120,130},{-120,80},{-129,80}}, color={0,0,127}));
  connect(source4.T0_var, inletTemperature.y) annotation(Line(points={{-84,30},{-120,30},{-120,80},{-129,80}}, color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation(Line(points={{-84,-20},{-120,-20},{-120,80},{-129,80}}, color={0,0,127}));
  connect(source3.T0_var, inletTemperature.y) annotation(Line(points={{-84,-70},{-120,-70},{-120,80},{-129,80}}, color={0,0,127}));
  connect(dT2c.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{-52,72},{-52,54},{-108,54},{-108,-110},{-121,-110}}, color={255,170,85}));
  connect(dT3c.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{-52,22},{-52,12},{-108,12},{-108,-110},{-121,-110}}, color={255,170,85}));
  connect(T_out2c.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{-52,-78},{-52,-110},{-121,-110}}, color={255,170,85}));
  connect(dT1c.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{-62,118},{-62,108},{-112,108},{-112,26},{-129,26}}, color={0,0,127}));
  connect(dT2c.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{-62,68},{-62,58},{-112,58},{-112,26},{-129,26}}, color={0,0,127}));
  connect(massFlowRate.y, firstOrder.u) annotation(Line(points={{-151,-140},{-134,-140}},
                                                                                    color={0,0,127}));
  connect(sink.m_flow_prescribed, firstOrder.y) annotation(Line(points={{-20,130},{-6,130},{-6,-140},{-111,-140}},
                                                                                                            color={0,0,127}));
  connect(sink4.m_flow_prescribed, firstOrder.y) annotation(Line(points={{-20,30},{-6,30},{-6,-140},{-111,-140}},
                                                                                           color={0,0,127}));
  connect(sink1.m_flow_prescribed, firstOrder.y) annotation(Line(points={{-20,-20},{-6,-20},{-6,-140},{-111,-140}},
                                                                                                             color={0,0,127}));
  connect(energyFlowSource.E_flow, heatFlowRate.y) annotation(Line(points={{-144,-110},{-151,-110}},
                                                                                                 color={0,0,127}));
  connect(T_out1c.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{-62,-32},{-62,-40},{-129,-40}}, color={0,0,127}));
  connect(T_out2c.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{-62,-82},{-62,-88},{-124,-88},{-124,-40},{-129,-40}}, color={0,0,127}));
  connect(sink5.m_flow_prescribed, firstOrder.y) annotation (Line(points={{110,130},{120,130},{120,-140},{-111,-140}}, color={0,0,127}));
  connect(sink7.m_flow_prescribed, firstOrder.y) annotation (Line(points={{110,30},{120,30},{120,-140},{-111,-140}}, color={0,0,127}));
  connect(sink8.m_flow_prescribed, firstOrder.y) annotation (Line(points={{110,-20},{120,-20},{120,-140},{-111,-140}}, color={0,0,127}));
  connect(source5.outlet, dT1.inlet) annotation (Line(
      points={{58,130},{68,130}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet, sink5.inlet) annotation (Line(
      points={{88,130},{98,130}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, dT2.inlet) annotation (Line(
      points={{58,80},{68,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outlet, sink6.inlet) annotation (Line(
      points={{88,80},{98,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, dT3.inlet) annotation (Line(
      points={{58,30},{68,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT3.outlet, sink7.inlet) annotation (Line(
      points={{88,30},{98,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, T_out1.inlet) annotation (Line(
      points={{58,-20},{68,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet, sink8.inlet) annotation (Line(
      points={{88,-20},{98,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source9.outlet, T_out2.inlet) annotation (Line(
      points={{58,-70},{68,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2.outlet, sink9.inlet) annotation (Line(
      points={{88,-70},{98,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.p0_var, inletPressure.y) annotation (Line(points={{46,136},{28,136},{28,150},{-116,150},{-116,136},{-129,136}}, color={0,0,127}));
  connect(source6.p0_var, inletPressure.y) annotation (Line(points={{46,86},{28,86},{28,150},{-116,150},{-116,136},{-129,136}}, color={0,0,127}));
  connect(source7.p0_var, inletPressure.y) annotation (Line(points={{46,36},{28,36},{28,150},{-116,150},{-116,136},{-129,136}}, color={0,0,127}));
  connect(source8.p0_var, inletPressure.y) annotation (Line(points={{46,-14},{28,-14},{28,150},{-116,150},{-116,136},{-129,136}}, color={0,0,127}));
  connect(source9.p0_var, inletPressure.y) annotation (Line(points={{46,-64},{28,-64},{28,150},{-116,150},{-116,136},{-129,136}}, color={0,0,127}));
  connect(source5.T0_var, inletTemperature.y) annotation (Line(points={{46,130},{24,130},{24,146},{-120,146},{-120,80},{-129,80}}, color={0,0,127}));
  connect(source6.T0_var, inletTemperature.y) annotation (Line(points={{46,80},{24,80},{24,146},{-120,146},{-120,80},{-129,80}}, color={0,0,127}));
  connect(source7.T0_var, inletTemperature.y) annotation (Line(points={{46,30},{24,30},{24,146},{-120,146},{-120,80},{-129,80}}, color={0,0,127}));
  connect(source8.T0_var, inletTemperature.y) annotation (Line(points={{46,-20},{24,-20},{24,146},{-120,146},{-120,80},{-129,80}}, color={0,0,127}));
  connect(source9.T0_var, inletTemperature.y) annotation (Line(points={{46,-70},{24,-70},{24,146},{-120,146},{-120,80},{-129,80}}, color={0,0,127}));
  connect(dT1.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{68,118},{68,108},{-112,108},{-112,26},{-129,26}}, color={0,0,127}));
  connect(dT2.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{68,68},{68,58},{-112,58},{-112,26},{-129,26}}, color={0,0,127}));
  connect(T_out1.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{68,-32},{68,-40},{-129,-40}}, color={0,0,127}));
  connect(T_out2.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{68,-82},{68,-88},{-124,-88},{-124,-40},{-129,-40}}, color={0,0,127}));
  connect(T_out2.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{78,-78},{78,-110},{-121,-110}}, color={255,170,85}));
  connect(dT3.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{78,22},{78,12},{-108,12},{-108,-110},{-121,-110}}, color={255,170,85}));
  connect(dT2.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{78,72},{78,54},{-108,54},{-108,-110},{-121,-110}}, color={255,170,85}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-180,-180},{180,180}}),
      graphics={
        Text(
          extent={{-140,180},{-40,160}},
          textColor={28,108,200},
          textString="Closed cycle (periodic)"),
        Text(
          extent={{40,180},{140,160}},
          textColor={28,108,200},
          textString="Open (steady-flow)")}),
    Documentation(
      info="<html>
  <p>
    This example illustrates several variants of using the
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isochoric\">Isochoric</a>
    process with prescribed inputs.
  </p>

  <p>
    If the heat flow rate is prescribed as an input, the solver may fail if conditions such as <code>dT = 0</code>, <code>m_flow = 0</code> and/or
    <code>P = 0</code> appear for extended periods of time.
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
end Prescribed;
