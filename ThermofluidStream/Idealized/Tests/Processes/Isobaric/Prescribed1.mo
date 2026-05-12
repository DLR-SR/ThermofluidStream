within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model Prescribed1 "Example - Isobaric cycle process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);
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

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{260,78},{280,98}})));

  Modelica.Blocks.Sources.SawTooth inletPressure(
    amplitude=1e5,
    period=1,
    offset=0.5e5,
    startTime=0.1) annotation (Placement(transformation(extent={{-280,60},{-260,80}})));
  Modelica.Blocks.Sources.SawTooth inletTemperature(
    amplitude=100,
    period=1,
    offset=293.15,
    startTime=0.2) annotation (Placement(transformation(extent={{-280,20},{-260,40}})));
  Modelica.Blocks.Sources.SawTooth temperatureDifference(
    amplitude=-40,
    period=1,
    offset=20,
    startTime=0.3) annotation (Placement(transformation(extent={{-280,-60},{-260,-40}})));
  Modelica.Blocks.Sources.RealExpression outletTemperature(y=T_out) annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Blocks.Sources.SawTooth massFlowRate(
    amplitude=4,
    period=1,
    offset=1,
    startTime=0.4) annotation (Placement(transformation(extent={{-280,-20},{-260,0}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-230,-40},{-210,-20}})));
  Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-170,-40},{-150,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT1(
    redeclare package Medium = Medium,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{-200,-40},{-180,-20}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-130,-40},{-110,-20}})));
  Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{140,-40},{160,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{110,-40},{130,-20}})));
  Modelica.Blocks.Sources.RealExpression specificEnthalpyDifference(y=dh) annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  Modelica.Blocks.Sources.RealExpression outletSpecificEnthalpy(y=h_out) annotation (Placement(transformation(extent={{100,-72},{120,-52}})));
  Modelica.Blocks.Sources.RealExpression heatFlowRate(y=Q_flow) annotation (Placement(transformation(extent={{264,24},{244,44}})));
  EnergyFlow.Sources.PrescribedEnergyFlow
                                     energyFlowSource                annotation (Placement(transformation(extent={{234,24},{214,44}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(transformation(extent={{100,54},{120,74}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaric(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{130,54},{150,74}})));
  Boundaries.Sink_m sink4(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{160,54},{180,74}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-230,-100},{-210,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT2(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{-200,-80},{-180,-100}})));
  Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-170,-100},{-150,-80}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-130,-100},{-110,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out2(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{-100,-80},{-80,-100}})));
  Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-70,-100},{-50,-80}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh2(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{10,-80},{30,-100}})));
  Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out2(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{110,-80},{130,-100}})));
  Boundaries.Sink_m sink8(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{140,-100},{160,-80}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(transformation(extent={{100,0},{120,20}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricCycle(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{130,20},{150,0}})));
  Boundaries.Sink_m sink9(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{160,0},{180,20}})));
equation
  connect(source.outlet,dT1. inlet) annotation (Line(
      points={{-210,-30},{-200,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet,sink. inlet) annotation (Line(
      points={{-180,-30},{-170,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet,T_out1. inlet) annotation (Line(
      points={{-110,-30},{-100,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet,sink1. inlet) annotation (Line(
      points={{-80,-30},{-70,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet,dh1. inlet) annotation (Line(
      points={{0,-30},{10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(dh1.outlet,sink2. inlet) annotation (Line(
      points={{30,-30},{40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet,h_out1. inlet) annotation (Line(
      points={{100,-30},{110,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out1.outlet,sink3. inlet) annotation (Line(
      points={{130,-30},{140,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(inletPressure.y, source.p0_var) annotation (Line(points={{-259,70},{-236,70},{-236,-24},{-222,-24}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation (Line(points={{-122,-24},{-136,-24},{-136,70},{-259,70}}, color={0,0,127}));
  connect(source2.p0_var, inletPressure.y) annotation (Line(points={{-12,-24},{-26,-24},{-26,70},{-259,70}}, color={0,0,127}));
  connect(source3.p0_var, inletPressure.y) annotation (Line(points={{88,-24},{74,-24},{74,70},{-259,70}},    color={0,0,127}));
  connect(source.T0_var, inletTemperature.y) annotation (Line(points={{-222,-30},{-240,-30},{-240,30},{-259,30}},
                                                                                                                color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation (Line(points={{-122,-30},{-140,-30},{-140,30},{-259,30}},
                                                                                                                 color={0,0,127}));
  connect(source2.T0_var, inletTemperature.y) annotation (Line(points={{-12,-30},{-30,-30},{-30,30},{-259,30}},
                                                                                                              color={0,0,127}));
  connect(source3.T0_var, inletTemperature.y) annotation (Line(points={{88,-30},{70,-30},{70,30},{-259,30}},  color={0,0,127}));
  connect(massFlowRate.y, sink.m_flow_prescribed) annotation (Line(points={{-259,-10},{-150,-10},{-150,-30},{-158,-30}},
                                                                                                                    color={0,0,127}));
  connect(sink1.m_flow_prescribed, massFlowRate.y) annotation (Line(points={{-58,-30},{-50,-30},{-50,-10},{-259,-10}},
                                                                                                                     color={0,0,127}));
  connect(sink2.m_flow_prescribed, massFlowRate.y) annotation (Line(points={{52,-30},{60,-30},{60,-10},{-259,-10}},
                                                                                                                  color={0,0,127}));
  connect(sink3.m_flow_prescribed, massFlowRate.y) annotation (Line(points={{152,-30},{160,-30},{160,-10},{-259,-10}},
                                                                                                                  color={0,0,127}));
  connect(temperatureDifference.y, dT1.outletSpec_prescribed) annotation (Line(points={{-259,-50},{-180,-50},{-180,-42}},                    color={0,0,127}));
  connect(outletTemperature.y, T_out1.outletSpec_prescribed) annotation (Line(points={{-99,-60},{-80,-60},{-80,-42}},                       color={0,0,127}));
  connect(specificEnthalpyDifference.y, dh1.outletSpec_prescribed) annotation (Line(points={{21,-60},{30,-60},{30,-42}},                     color={0,0,127}));
  connect(h_out1.outletSpec_prescribed, outletSpecificEnthalpy.y) annotation (Line(points={{130,-42},{130,-62},{121,-62}},                  color={0,0,127}));
  connect(source4.outlet, isobaric.inlet) annotation (Line(
      points={{120,64},{130,64}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric.outlet, sink4.inlet) annotation (Line(
      points={{150,64},{160,64}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{140,56},{140,34},{213,34}}, color={255,170,85}));
  connect(heatFlowRate.y,energyFlowSource. E_flow) annotation (Line(points={{243,34},{236,34}},   color={0,0,127}));
  connect(sink4.m_flow_prescribed, massFlowRate.y) annotation (Line(points={{172,64},{202,64},{202,-10},{-259,-10}}, color={0,0,127}));
  connect(source4.p0_var, inletPressure.y) annotation (Line(points={{108,70},{-259,70}},                   color={0,0,127}));
  connect(source4.T0_var, inletTemperature.y) annotation (Line(points={{108,64},{84,64},{84,30},{-259,30}},   color={0,0,127}));
  connect(source5.outlet, dT2.inlet) annotation (Line(
      points={{-210,-90},{-200,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outlet, sink5.inlet) annotation (Line(
      points={{-180,-90},{-170,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, T_out2.inlet) annotation (Line(
      points={{-110,-90},{-100,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2.outlet, sink6.inlet) annotation (Line(
      points={{-80,-90},{-70,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, dh2.inlet) annotation (Line(
      points={{0,-90},{10,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(dh2.outlet, sink7.inlet) annotation (Line(
      points={{30,-90},{40,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, h_out2.inlet) annotation (Line(
      points={{100,-90},{110,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out2.outlet, sink8.inlet) annotation (Line(
      points={{130,-90},{140,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{-180,-78},{-180,-50},{-259,-50}}, color={0,0,127}));
  connect(T_out2.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{-80,-78},{-80,-60},{-99,-60}}, color={0,0,127}));
  connect(dh2.outletSpec_prescribed, specificEnthalpyDifference.y) annotation (Line(points={{30,-78},{30,-60},{21,-60}}, color={0,0,127}));
  connect(h_out2.outletSpec_prescribed, outletSpecificEnthalpy.y) annotation (Line(points={{130,-78},{130,-62},{121,-62}}, color={0,0,127}));
  connect(sink8.m_flow_prescribed, massFlowRate.y) annotation (Line(points={{152,-90},{160,-90},{160,-10},{-259,-10}}, color={0,0,127}));
  connect(sink7.m_flow_prescribed, massFlowRate.y) annotation (Line(points={{52,-90},{60,-90},{60,-10},{-259,-10}}, color={0,0,127}));
  connect(sink6.m_flow_prescribed, massFlowRate.y) annotation (Line(points={{-58,-90},{-50,-90},{-50,-10},{-259,-10}}, color={0,0,127}));
  connect(sink5.m_flow_prescribed, massFlowRate.y) annotation (Line(points={{-158,-90},{-150,-90},{-150,-10},{-259,-10}}, color={0,0,127}));
  connect(source8.p0_var, inletPressure.y) annotation (Line(points={{88,-84},{74,-84},{74,70},{-259,70}}, color={0,0,127}));
  connect(source8.T0_var, inletTemperature.y) annotation (Line(points={{88,-90},{70,-90},{70,30},{-259,30}}, color={0,0,127}));
  connect(source7.p0_var, inletPressure.y) annotation (Line(points={{-12,-84},{-26,-84},{-26,70},{-259,70}}, color={0,0,127}));
  connect(source7.T0_var, inletTemperature.y) annotation (Line(points={{-12,-90},{-30,-90},{-30,30},{-259,30}}, color={0,0,127}));
  connect(source6.p0_var, inletPressure.y) annotation (Line(points={{-122,-84},{-136,-84},{-136,70},{-259,70}}, color={0,0,127}));
  connect(source6.T0_var, inletTemperature.y) annotation (Line(points={{-122,-90},{-140,-90},{-140,30},{-259,30}}, color={0,0,127}));
  connect(source5.p0_var, inletPressure.y) annotation (Line(points={{-222,-84},{-236,-84},{-236,70},{-259,70}}, color={0,0,127}));
  connect(source5.T0_var, inletTemperature.y) annotation (Line(points={{-222,-90},{-240,-90},{-240,30},{-259,30}}, color={0,0,127}));
  connect(source9.outlet, isobaricCycle.inlet) annotation (Line(
      points={{120,10},{130,10}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricCycle.outlet, sink9.inlet) annotation (Line(
      points={{150,10},{160,10}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricCycle.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{140,18},{140,34},{213,34}}, color={255,170,85}));
  connect(sink9.m_flow_prescribed, massFlowRate.y) annotation (Line(points={{172,10},{202,10},{202,-10},{-259,-10}}, color={0,0,127}));
  connect(source9.p0_var, inletPressure.y) annotation (Line(points={{108,16},{74,16},{74,70},{-259,70}}, color={0,0,127}));
  connect(source9.T0_var, inletTemperature.y) annotation (Line(points={{108,10},{70,10},{70,30},{-259,30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-300,-120},{300,120}},
        grid={2,2}), graphics={Rectangle(extent={{-286,88},{-252,-70}}, lineColor={238,46,47}), Text(
          extent={{-292,104},{-240,90}},
          textColor={238,46,47},
          textString="Independent inputs")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Processes.IsobaricCycle\">IsobaricCycle</a> process (<code>specifyOutlet = true</code> and <code>heatFlowSignal not= Input</code>) defined by discontinuous inputs.
  </p>
  
</html>"));
end Prescribed1;
