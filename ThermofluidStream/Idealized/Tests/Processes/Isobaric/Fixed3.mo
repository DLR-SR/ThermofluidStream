within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model Fixed3 "Example - Isobaric process"
  extends ThermofluidStream.Idealized.Tests.Processes.Isobaric.PartialFixed;
  extends Modelica.Icons.Example;

  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow=Q_flow) annotation(Placement(transformation(extent={{-80,-80},{-60,-60}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricFlow(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricCycle(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,-40},{40,-20}})));

equation
  connect(source.outlet, isobaricFlow.inlet) annotation (Line(
      points={{-20,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricFlow.outlet, sink.inlet) annotation (Line(
      points={{10,30},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, isobaricFlow.Q_flow_in) annotation (Line(points={{-59,-70},{-50,-70},{-50,0},{0,0},{0,22}}, color={255,170,85}));
  connect(source1.outlet, isobaricCycle.inlet) annotation (Line(
      points={{-20,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricCycle.outlet, sink1.inlet) annotation (Line(
      points={{10,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));

  connect(isobaricCycle.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{0,-38},{0,-70},{-59,-70}}, color={255,170,85}));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>",
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isobaric\">Isobaric</a> process for heat transfer defined by parameters (mass flow rate and heat flow rate given).
  </p>
</html>"));
end Fixed3;
