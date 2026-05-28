within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Fixed3 "Example - adiabatic process"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Tests.Processes.Adiabatic.PartialFixed;

  .ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{0,30},{20,50}})));
  ThermofluidStream.Boundaries.Sink_m  sink(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{60,30},{80,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic adiabaticFilter(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    eta_fixed=eta_is) annotation (Placement(transformation(extent={{30,30},{50,50}})));

  EnergyFlow.Sources.PrescribedEnergyFlow
                                     energyFlowSource                annotation(Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.RealExpression power(y=P) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  ThermofluidStream.Boundaries.Source  source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  ThermofluidStream.Boundaries.Sink_m  sink1(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  ThermofluidStream.Idealized.Processes.Adiabatic adiabatic(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    eta_fixed=eta_is,
    enableFilter=false) annotation (Placement(transformation(extent={{30,-20},{50,0}})));
equation
  connect(source.outlet, adiabaticFilter.inlet) annotation (Line(
      points={{20,40},{30,40}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabaticFilter.outlet, sink.inlet) annotation (Line(
      points={{50,40},{60,40}},
      color={28,108,200},
      thickness=0.5));

  connect(power.y, energyFlowSource.E_flow) annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  connect(adiabaticFilter.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{40,32},{40,20},{-10,20},{-10,0},{-29,0}}, color={255,170,85}));
  connect(source1.outlet, adiabatic.inlet) annotation (Line(
      points={{20,-10},{30,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabatic.outlet, sink1.inlet) annotation (Line(
      points={{50,-10},{60,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabatic.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{40,-18},{40,-30},{-10,-30},{-10,0},{-29,0}}, color={255,170,85}));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> process defined by parameters (mass flow rate and power given, FullMedium model).
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
end Fixed3;
