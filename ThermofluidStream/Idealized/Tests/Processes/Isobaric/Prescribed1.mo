within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model Prescribed1 "Example - Isobaric process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  SI.MassFlowRate m_flow = massFlowRate.y "Mass flow rate";
  Medium.AbsolutePressure p = inletPressure.y "Pressure (inlet = outlet)";
  Medium.Temperature T_in = inletTemperature.y "Inlet temperature";
  SI.TemperatureDifference dT = temperatureDifference.y    "Temperature difference";

  Medium.Temperature T_out = T_in + dT "Outlet temperature";

  Medium.ThermodynamicState state_in = Medium.setState_pTX(p, T_in, Medium.X_default) "Inlet state";
  Medium.ThermodynamicState state_out = Medium.setState_pTX(p, T_out, Medium.X_default) "Outlet state";

  Medium.SpecificEnthalpy h_in = Medium.specificEnthalpy(state_in) "Inlet specific enthalpy";
  Medium.SpecificEnthalpy h_out = Medium.specificEnthalpy(state_out) "Outlet specific enthalpy";
  Medium.SpecificEnthalpy dh = h_out - h_in "Specific enthalpy difference";
  Medium.SpecificEnergy q = dh "Specific heat flow rate";
  SI.HeatFlowRate Q_flow = m_flow*q "Heat flow rate";

  // Periodic closed cycle system process
  parameter SI.AbsolutePressure p_inf = 100000 "Ambient pressure";
  Medium.Density rho_in = Medium.density(state_in) "Inlet density";
  Medium.Density rho_out = Medium.density(state_in) "Outlet density";
  SI.SpecificVolume v_in = 1/rho_in "Inlet density";
  SI.SpecificVolume v_out = 1/rho_out "Outlet density";
  Medium.SpecificEnergy u_in = h_in - p/rho_in "Inlet specific internal energy";
  Medium.SpecificEnergy u_out = h_out - p/rho_out "Outlet specific internal energy";
  Medium.SpecificEnergy du = u_out - u_in "Specific internal energy difference";
  SI.SpecificEnergy w_exp = - p*(v_out - v_in)  "Specific expansion work";
  SI.SpecificEnergy w_amb = - p_inf*(v_out - v_in) "Specific ambient pressure work";
  SI.SpecificEnergy w_exp_net = w_exp - w_amb  "Net specific expansion work";
  SI.Power P = m_flow*w_exp_net "Net power (net expansion work flow rate)";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{220,100},{240,120}})));

  Modelica.Blocks.Sources.SawTooth inletPressure(
    amplitude=1e5,
    period=1,
    offset=0.5e5,
    startTime=0.1) annotation(Placement(transformation(extent={{-220,60},{-200,80}})));
  Modelica.Blocks.Sources.SawTooth inletTemperature(
    amplitude=100,
    period=1,
    offset=293.15,
    startTime=0.2) annotation(Placement(transformation(extent={{-220,20},{-200,40}})));
  Modelica.Blocks.Sources.SawTooth temperatureDifference(
    amplitude=-40,
    period=1,
    offset=20,
    startTime=0.3) annotation(Placement(transformation(extent={{-220,-60},{-200,-40}})));
  Modelica.Blocks.Sources.RealExpression outletTemperature(y=T_out) annotation(Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Sources.SawTooth massFlowRate(
    amplitude=-2,
    period=1,
    offset=1,
    startTime=0.4) annotation(Placement(transformation(extent={{-220,-20},{-200,0}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-170,-40},{-150,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT1(
    redeclare package Medium = Medium,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation(Placement(transformation(extent={{-140,-40},{-120,-20}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-70,-40},{-50,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation(Placement(transformation(extent={{-40,-40},{-20,-20}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{40,-40},{60,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation(Placement(transformation(extent={{70,-40},{90,-20}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{140,-40},{160,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{200,-40},{220,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation(Placement(transformation(extent={{170,-40},{190,-20}})));
  Modelica.Blocks.Sources.RealExpression specificEnthalpyDifference(y=dh) annotation(Placement(transformation(extent={{60,-70},{80,-50}})));
  Modelica.Blocks.Sources.RealExpression outletSpecificEnthalpy(y=h_out) annotation(Placement(transformation(extent={{160,-72},{180,-52}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-170,-100},{-150,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT2(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation(Placement(transformation(extent={{-140,-80},{-120,-100}})));
  .ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-110,-100},{-90,-80}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-70,-100},{-50,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out2(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation(Placement(transformation(extent={{-40,-80},{-20,-100}})));
  .ThermofluidStream.Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{40,-100},{60,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh2(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation(Placement(transformation(extent={{70,-80},{90,-100}})));
  .ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{140,-100},{160,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out2(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation(Placement(transformation(extent={{170,-80},{190,-100}})));
  .ThermofluidStream.Boundaries.Sink_m sink8(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{200,-100},{220,-80}})));

equation
  connect(source.outlet,dT1. inlet) annotation(Line(
      points={{-150,-30},{-140,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet,sink. inlet) annotation(Line(
      points={{-120,-30},{-110,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet,T_out1. inlet) annotation(Line(
      points={{-50,-30},{-40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet,sink1. inlet) annotation(Line(
      points={{-20,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet,dh1. inlet) annotation(Line(
      points={{60,-30},{70,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(dh1.outlet,sink2. inlet) annotation(Line(
      points={{90,-30},{100,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet,h_out1. inlet) annotation(Line(
      points={{160,-30},{170,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out1.outlet,sink3. inlet) annotation(Line(
      points={{190,-30},{200,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(inletPressure.y, source.p0_var) annotation(Line(points={{-199,70},{-176,70},{-176,-24},{-162,-24}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation(Line(points={{-62,-24},{-76,-24},{-76,70},{-199,70}},    color={0,0,127}));
  connect(source2.p0_var, inletPressure.y) annotation(Line(points={{48,-24},{34,-24},{34,70},{-199,70}},    color={0,0,127}));
  connect(source3.p0_var, inletPressure.y) annotation(Line(points={{148,-24},{134,-24},{134,70},{-199,70}}, color={0,0,127}));
  connect(source.T0_var, inletTemperature.y) annotation(Line(points={{-162,-30},{-180,-30},{-180,30},{-199,30}},color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation(Line(points={{-62,-30},{-80,-30},{-80,30},{-199,30}},   color={0,0,127}));
  connect(source2.T0_var, inletTemperature.y) annotation(Line(points={{48,-30},{30,-30},{30,30},{-199,30}},   color={0,0,127}));
  connect(source3.T0_var, inletTemperature.y) annotation(Line(points={{148,-30},{130,-30},{130,30},{-199,30}},
                                                                                                             color={0,0,127}));
  connect(massFlowRate.y, sink.m_flow_prescribed) annotation(Line(points={{-199,-10},{-90,-10},{-90,-30},{-98,-30}},color={0,0,127}));
  connect(sink1.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{2,-30},{10,-30},{10,-10},{-199,-10}},    color={0,0,127}));
  connect(sink2.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{112,-30},{120,-30},{120,-10},{-199,-10}},
                                                                                                                  color={0,0,127}));
  connect(sink3.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{212,-30},{220,-30},{220,-10},{-199,-10}},
                                                                                                                  color={0,0,127}));
  connect(temperatureDifference.y, dT1.outletSpec_prescribed) annotation(Line(points={{-199,-50},{-120,-50},{-120,-42}},                    color={0,0,127}));
  connect(outletTemperature.y, T_out1.outletSpec_prescribed) annotation(Line(points={{-39,-60},{-20,-60},{-20,-42}},                       color={0,0,127}));
  connect(specificEnthalpyDifference.y, dh1.outletSpec_prescribed) annotation(Line(points={{81,-60},{90,-60},{90,-42}},                     color={0,0,127}));
  connect(h_out1.outletSpec_prescribed, outletSpecificEnthalpy.y) annotation(Line(points={{190,-42},{190,-62},{181,-62}},                  color={0,0,127}));
  connect(source5.outlet, dT2.inlet) annotation(Line(
      points={{-150,-90},{-140,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outlet, sink5.inlet) annotation(Line(
      points={{-120,-90},{-110,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, T_out2.inlet) annotation(Line(
      points={{-50,-90},{-40,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2.outlet, sink6.inlet) annotation(Line(
      points={{-20,-90},{-10,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, dh2.inlet) annotation(Line(
      points={{60,-90},{70,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(dh2.outlet, sink7.inlet) annotation(Line(
      points={{90,-90},{100,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, h_out2.inlet) annotation(Line(
      points={{160,-90},{170,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out2.outlet, sink8.inlet) annotation(Line(
      points={{190,-90},{200,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outletSpec_prescribed, temperatureDifference.y) annotation(Line(points={{-120,-78},{-120,-50},{-199,-50}}, color={0,0,127}));
  connect(T_out2.outletSpec_prescribed, outletTemperature.y) annotation(Line(points={{-20,-78},{-20,-60},{-39,-60}}, color={0,0,127}));
  connect(dh2.outletSpec_prescribed, specificEnthalpyDifference.y) annotation(Line(points={{90,-78},{90,-60},{81,-60}}, color={0,0,127}));
  connect(h_out2.outletSpec_prescribed, outletSpecificEnthalpy.y) annotation(Line(points={{190,-78},{190,-62},{181,-62}}, color={0,0,127}));
  connect(sink8.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{212,-90},{220,-90},{220,-10},{-199,-10}}, color={0,0,127}));
  connect(sink7.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{112,-90},{120,-90},{120,-10},{-199,-10}},
                                                                                                                   color={0,0,127}));
  connect(sink6.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{2,-90},{10,-90},{10,-10},{-199,-10}},     color={0,0,127}));
  connect(sink5.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-98,-90},{-90,-90},{-90,-10},{-199,-10}},    color={0,0,127}));
  connect(source8.p0_var, inletPressure.y) annotation(Line(points={{148,-84},{134,-84},{134,70},{-199,70}},
                                                                                                         color={0,0,127}));
  connect(source8.T0_var, inletTemperature.y) annotation(Line(points={{148,-90},{130,-90},{130,30},{-199,30}},
                                                                                                            color={0,0,127}));
  connect(source7.p0_var, inletPressure.y) annotation(Line(points={{48,-84},{34,-84},{34,70},{-199,70}},    color={0,0,127}));
  connect(source7.T0_var, inletTemperature.y) annotation(Line(points={{48,-90},{30,-90},{30,30},{-199,30}},    color={0,0,127}));
  connect(source6.p0_var, inletPressure.y) annotation(Line(points={{-62,-84},{-76,-84},{-76,70},{-199,70}},    color={0,0,127}));
  connect(source6.T0_var, inletTemperature.y) annotation(Line(points={{-62,-90},{-80,-90},{-80,30},{-199,30}},    color={0,0,127}));
  connect(source5.p0_var, inletPressure.y) annotation(Line(points={{-162,-84},{-176,-84},{-176,70},{-199,70}}, color={0,0,127}));
  connect(source5.T0_var, inletTemperature.y) annotation(Line(points={{-162,-90},{-180,-90},{-180,30},{-199,30}}, color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-240,-120},{240,120}}),
      graphics={
        Rectangle(
          extent={{-226,88},{-192,-70}},
          lineColor={238,46,47}),
        Text(
          extent={{-232,104},{-180,90}},
          textColor={238,46,47},
          textString="Independent inputs")}),
    Documentation(
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isobaric\">Isobaric</a> process for heat transfer defined by time varying inputs (outlet state and mass flow rate given).
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
end Prescribed1;
