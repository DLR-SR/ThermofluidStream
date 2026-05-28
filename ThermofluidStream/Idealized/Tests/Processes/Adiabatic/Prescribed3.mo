within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Prescribed3 "Example - adiabatic process"
  extends ThermofluidStream.Idealized.Tests.Processes.Adiabatic.PartialPrescribed;
  extends Modelica.Icons.Example;

  .ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                 annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  ThermofluidStream.Boundaries.Sink_m  sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                                                                                                    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic adiabaticFilter(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    TC=0.01,
    P_nom=80000)      annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  ThermofluidStream.Boundaries.Source  source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                 annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  ThermofluidStream.Boundaries.Sink_m  sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                                                                                                    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  ThermofluidStream.Idealized.Processes.Adiabatic adiabatic(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    enableFilter=false) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
equation
  connect(source.outlet, adiabaticFilter.inlet) annotation (Line(
      points={{-20,40},{-10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabaticFilter.outlet, sink.inlet) annotation (Line(
      points={{10,40},{20,40}},
      color={28,108,200},
      thickness=0.5));

  connect(source1.outlet, adiabatic.inlet) annotation (Line(
      points={{-20,-10},{-10,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabatic.outlet, sink1.inlet) annotation (Line(
      points={{10,-10},{20,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source.p0_var, inletPressure.y) annotation (Line(points={{-32,46},{-40,46},{-40,110},{-79,110}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation (Line(points={{-32,-4},{-40,-4},{-40,110},{-79,110}}, color={0,0,127}));
  connect(source.T0_var, inletTemperature.y) annotation (Line(points={{-32,40},{-44,40},{-44,70},{-79,70}}, color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation (Line(points={{-32,-10},{-44,-10},{-44,70},{-79,70}}, color={0,0,127}));
  connect(adiabaticFilter.eta_prescribed, isentropicEfficiency.y) annotation (Line(points={{6,28},{6,20},{-48,20},{-48,-50},{-79,-50}}, color={0,0,127}));
  connect(adiabatic.eta_prescribed, isentropicEfficiency.y) annotation (Line(points={{6,-22},{6,-50},{-79,-50}}, color={0,0,127}));
  connect(adiabaticFilter.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{0,32},{0,24},{-52,24},{-52,-130},{-79,-130}}, color={255,170,85}));
  connect(adiabatic.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{0,-18},{0,-54},{-52,-54},{-52,-130},{-79,-130}}, color={255,170,85}));
  connect(sink.m_flow_prescribed, firstOrder.y) annotation (Line(points={{32,40},{40,40},{40,-90},{-79,-90}}, color={0,0,127}));
  connect(sink1.m_flow_prescribed, firstOrder.y) annotation (Line(points={{32,-10},{40,-10},{40,-90},{-79,-90}}, color={0,0,127}));
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
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> process defined by time varying inputs (mass flow rate and power given, FullMedium model).
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
