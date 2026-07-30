within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model Prescribed3 "Example - Isobaric process"
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
    Placement(transformation(extent={{80,80},{100,100}})));

  Modelica.Blocks.Sources.SawTooth inletPressure(
    amplitude=1e5,
    period=1,
    offset=0.5e5,
    startTime=0.1) annotation(Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Sources.SawTooth inletTemperature(
    amplitude=100,
    period=1,
    offset=293.15,
    startTime=0.2) annotation(Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.SawTooth temperatureDifference(
    amplitude=-40,
    period=1,
    offset=20,
    startTime=0.3) annotation(Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Blocks.Sources.SawTooth massFlowRate(
    amplitude=-2,
    period=1,
    offset=1,
    startTime=0.4) annotation(Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Sources.RealExpression heatFlowRate(y=Q_flow) annotation(Placement(transformation(extent={{60,-10},{40,10}})));
  EnergyFlow.Sources.PrescribedEnergyFlow
                                     energyFlowSource               annotation(Placement(transformation(extent={{30,-10},{10,10}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaric(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    p_inf=p_inf) annotation(Placement(transformation(extent={{-10,20},{10,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation(Placement(transformation(extent={{-40,-40},{-20,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricCycle(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    p_inf=p_inf) annotation(Placement(transformation(extent={{-10,-20},{10,-40}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{20,-40},{40,-20}})));

equation
  connect(source.outlet, isobaric.inlet) annotation (Line(
      points={{-20,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric.outlet, sink.inlet) annotation (Line(
      points={{10,30},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric.Q_flow_in, energyFlowSource.E_flow_out) annotation(Line(points={{0,22},{0,0},{9,0}},         color={255,170,85}));
  connect(heatFlowRate.y,energyFlowSource. E_flow) annotation(Line(points={{39,0},{32,0}},       color={0,0,127}));
  connect(source1.outlet, isobaricCycle.inlet) annotation(Line(
      points={{-20,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricCycle.outlet,sink1. inlet) annotation(Line(
      points={{10,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricCycle.Q_flow_in, energyFlowSource.E_flow_out) annotation(Line(points={{0,-22},{0,0},{9,0}},        color={255,170,85}));

  connect(inletPressure.y, source.p0_var) annotation (Line(points={{-59,60},{-40,60},{-40,36},{-32,36}}, color={0,0,127}));
  connect(source.T0_var, inletTemperature.y) annotation (Line(points={{-32,30},{-44,30},{-44,20},{-59,20}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation (Line(points={{-32,-24},{-40,-24},{-40,60},{-59,60}}, color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation (Line(points={{-32,-30},{-44,-30},{-44,20},{-59,20}}, color={0,0,127}));
  connect(sink.m_flow_prescribed, temperatureDifference.y) annotation (Line(points={{32,30},{70,30},{70,-60},{-59,-60}}, color={0,0,127}));
  connect(sink1.m_flow_prescribed, temperatureDifference.y) annotation (Line(points={{32,-30},{70,-30},{70,-60},{-59,-60}}, color={0,0,127}));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      graphics={
        Rectangle(
          extent={{-86,78},{-52,-80}},
          lineColor={238,46,47}),
        Text(
          extent={{-92,94},{-40,80}},
          textColor={238,46,47},
          textString="Independent inputs")}),
    Documentation(
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.IsobaricCycle\">IsobaricCycle</a> process (<code>specifyOutlet = true</code> and <code>heatFlowSignal not= Input</code>) defined by discontinuous inputs.
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
end Prescribed3;
