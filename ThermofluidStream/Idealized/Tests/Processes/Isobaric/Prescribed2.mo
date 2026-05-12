within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model Prescribed2 "Example - Isobaric cycle process"
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
    annotation (Placement(transformation(extent={{220,60},{240,80}})));

  Modelica.Blocks.Sources.SawTooth inletPressure(
    amplitude=1e5,
    period=1,
    offset=0.5e5,
    startTime=0.1) annotation (Placement(transformation(extent={{-240,40},{-220,60}})));
  Modelica.Blocks.Sources.SawTooth inletTemperature(
    amplitude=100,
    period=1,
    offset=293.15,
    startTime=0.2) annotation (Placement(transformation(extent={{-240,0},{-220,20}})));
  Modelica.Blocks.Sources.SawTooth temperatureDifference(
    amplitude=-40,
    period=1,
    offset=20,
    startTime=0.3) annotation (Placement(transformation(extent={{-240,-40},{-220,-20}})));
  Modelica.Blocks.Sources.RealExpression outletTemperature(y=T_out) annotation (Placement(transformation(extent={{-10,-30},{-30,-10}})));
  Modelica.Blocks.Sources.SawTooth massFlowRate(
    amplitude=4,
    period=1,
    offset=1,
    startTime=0.4) annotation (Placement(transformation(extent={{-240,-80},{-220,-60}})));
  Modelica.Blocks.Sources.RealExpression heatFlowRate(y=Q_flow) annotation (Placement(transformation(extent={{230,-50},{210,-30}})));
  EnergyFlow.Sources.PrescribedEnergyFlow
                                     energyFlowSource                annotation (Placement(transformation(extent={{190,-50},{170,-30}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(transformation(extent={{-190,0},{-170,20}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-128,0},{-108,20}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{-160,0},{-140,20}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{4,0},{24,20}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{64,0},{84,20}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{34,0},{54,20}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{104,0},{124,20}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink5(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{164,0},{184,20}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{134,0},{154,20}})));
  Modelica.Blocks.Sources.RealExpression specificEnthalpyDifference(y=dh) annotation (Placement(transformation(extent={{84,-30},{64,-10}})));
  Modelica.Blocks.Sources.RealExpression outletSpecificEnthalpy(y=h_out) annotation (Placement(transformation(extent={{194,-30},{174,-10}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(transformation(extent={{-190,-80},{-170,-60}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{-160,-60},{-140,-80}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-128,-80},{-108,-60}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{-60,-60},{-40,-80}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{4,-80},{24,-60}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{34,-60},{54,-80}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink6(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{64,-80},{84,-60}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{104,-80},{124,-60}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    p_inf=p_inf) annotation (Placement(transformation(extent={{134,-60},{154,-80}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink7(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{164,-80},{184,-60}})));
equation
  connect(source.outlet, dT1.inlet) annotation (Line(
      points={{-170,10},{-160,10}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet, sink.inlet) annotation (Line(
      points={{-140,10},{-128,10}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet,T_out1. inlet) annotation (Line(
      points={{-70,10},{-60,10}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet,sink1. inlet) annotation (Line(
      points={{-40,10},{-30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet,dh1. inlet) annotation (Line(
      points={{24,10},{34,10}},
      color={28,108,200},
      thickness=0.5));
  connect(dh1.outlet,sink4. inlet) annotation (Line(
      points={{54,10},{64,10}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet,h_out1. inlet) annotation (Line(
      points={{124,10},{134,10}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out1.outlet,sink5. inlet) annotation (Line(
      points={{154,10},{164,10}},
      color={28,108,200},
      thickness=0.5));
  connect(source.p0_var, inletPressure.y) annotation (Line(points={{-182,16},{-196,16},{-196,50},{-219,50}},
                                                                                                           color={0,0,127}));
  connect(source.T0_var, inletTemperature.y) annotation (Line(points={{-182,10},{-219,10}},
                                                                                          color={0,0,127}));
  connect(temperatureDifference.y,dT1. outletSpec_prescribed) annotation (Line(points={{-219,-30},{-140,-30},{-140,-2}},  color={0,0,127}));
  connect(outletTemperature.y,T_out1. outletSpec_prescribed) annotation (Line(points={{-31,-20},{-40,-20},{-40,-2}},     color={0,0,127}));
  connect(specificEnthalpyDifference.y,dh1. outletSpec_prescribed) annotation (Line(points={{63,-20},{54,-20},{54,-2}},     color={0,0,127}));
  connect(outletSpecificEnthalpy.y,h_out1. outletSpec_prescribed) annotation (Line(points={{173,-20},{154,-20},{154,-2}},  color={0,0,127}));
  connect(energyFlowSource.E_flow_out,h_out1. Q_flow_in) annotation (Line(points={{169,-40},{144,-40},{144,2}},   color={255,170,85}));
  connect(energyFlowSource.E_flow_out,dh1. Q_flow_in) annotation (Line(points={{169,-40},{44,-40},{44,2}},     color={255,170,85}));
  connect(T_out1.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{-50,2},{-50,-40},{169,-40}},     color={255,170,85}));
  connect(dT1.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{-150,2},{-150,-40},{169,-40}},   color={255,170,85}));
  connect(heatFlowRate.y, energyFlowSource.E_flow) annotation (Line(points={{209,-40},{192,-40}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation (Line(points={{-82,16},{-90,16},{-90,50},{-219,50}},  color={0,0,127}));
  connect(source4.p0_var, inletPressure.y) annotation (Line(points={{12,16},{4,16},{4,50},{-219,50}},    color={0,0,127}));
  connect(source5.p0_var, inletPressure.y) annotation (Line(points={{112,16},{104,16},{104,50},{-219,50}},
                                                                                                         color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation (Line(points={{-82,10},{-94,10},{-94,30},{-200,30},{-200,10},{-219,10}},color={0,0,127}));
  connect(source4.T0_var, inletTemperature.y) annotation (Line(points={{12,10},{0,10},{0,30},{-200,30},{-200,10},{-219,10}},  color={0,0,127}));
  connect(source5.T0_var, inletTemperature.y) annotation (Line(points={{112,10},{100,10},{100,30},{-200,30},{-200,10},{-219,10}},
                                                                                                                              color={0,0,127}));
  connect(h_out2.outletSpec_prescribed, outletSpecificEnthalpy.y) annotation (Line(points={{154,-58},{154,-20},{173,-20}}, color={0,0,127}));
  connect(h_out2.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{144,-62},{144,-40},{169,-40}}, color={255,170,85}));
  connect(dh2.outletSpec_prescribed, specificEnthalpyDifference.y) annotation (Line(points={{54,-58},{54,-20},{63,-20}}, color={0,0,127}));
  connect(dh2.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{44,-62},{44,-40},{169,-40}}, color={255,170,85}));
  connect(T_out2.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{-40,-58},{-40,-20},{-31,-20}}, color={0,0,127}));
  connect(T_out2.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{-50,-62},{-50,-40},{169,-40}}, color={255,170,85}));
  connect(dT2.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{-140,-58},{-140,-30},{-219,-30}}, color={0,0,127}));
  connect(dT2.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{-150,-62},{-150,-40},{169,-40}}, color={255,170,85}));
  connect(source2.outlet, dT2.inlet) annotation (Line(
      points={{-170,-70},{-160,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outlet, sink2.inlet) annotation (Line(
      points={{-140,-70},{-128,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, T_out2.inlet) annotation (Line(
      points={{-70,-70},{-60,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2.outlet, sink3.inlet) annotation (Line(
      points={{-40,-70},{-30,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, dh2.inlet) annotation (Line(
      points={{24,-70},{34,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(dh2.outlet, sink6.inlet) annotation (Line(
      points={{54,-70},{64,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, h_out2.inlet) annotation (Line(
      points={{124,-70},{134,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out2.outlet, sink7.inlet) annotation (Line(
      points={{154,-70},{164,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.p0_var, inletPressure.y) annotation (Line(points={{-182,-64},{-196,-64},{-196,50},{-219,50}}, color={0,0,127}));
  connect(source2.T0_var, inletTemperature.y) annotation (Line(points={{-182,-70},{-200,-70},{-200,10},{-219,10}}, color={0,0,127}));
  connect(source3.p0_var, inletPressure.y) annotation (Line(points={{-82,-64},{-90,-64},{-90,50},{-219,50}}, color={0,0,127}));
  connect(source3.T0_var, inletTemperature.y) annotation (Line(points={{-82,-70},{-94,-70},{-94,30},{-200,30},{-200,10},{-219,10}}, color={0,0,127}));
  connect(source6.p0_var, inletPressure.y) annotation (Line(points={{12,-64},{4,-64},{4,50},{-219,50}}, color={0,0,127}));
  connect(source6.T0_var, inletTemperature.y) annotation (Line(points={{12,-70},{0,-70},{0,30},{-200,30},{-200,10},{-219,10}}, color={0,0,127}));
  connect(source7.p0_var, inletPressure.y) annotation (Line(points={{112,-64},{104,-64},{104,50},{-219,50}}, color={0,0,127}));
  connect(source7.T0_var, inletTemperature.y) annotation (Line(points={{112,-70},{100,-70},{100,30},{-200,30},{-200,10},{-219,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-260,-100},{260,100}},
        grid={2,2}), graphics={Rectangle(extent={{-246,70},{-212,-88}}, lineColor={238,46,47}), Text(
          extent={{-252,90},{-200,76}},
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
    <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Processes.Isobaric\">Isobaric</a> process (<code>specifyOutlet = true</code> and <code>heatFlowSignal = Input</code>) defined by discontinuous inputs.
  </p>
  
  <p>
    Calculating the mass flow rate <code>m_flow = Q_flow/q</code>, may cause the simulation to fail at <code>q = 0</code>, which occurs for all models in this example.<br>
    This can in principle be avoided.
    See the <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Processes.Isobaric\">Isobaric</a> (text layer) for further information.
  </p>
</html>"));
end Prescribed2;
