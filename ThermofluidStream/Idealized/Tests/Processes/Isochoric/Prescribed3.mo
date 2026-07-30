within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Prescribed3 "Example - Isochoric process"
  extends ThermofluidStream.Idealized.Tests.Processes.Isochoric.PartialPrescribed;
  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                 annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                                                                                                    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoricCycle(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed)
                       annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  .ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                 annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                                                                                                     annotation (Placement(transformation(extent={{110,-10},{130,10}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoricFlow(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed)
                       annotation (Placement(transformation(extent={{80,-10},{100,10}})));

equation
  connect(source.outlet, isochoricCycle.inlet) annotation (Line(
      points={{-30,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoricCycle.outlet, sink.inlet) annotation (Line(
      points={{0,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, isochoricFlow.inlet) annotation (Line(
      points={{70,0},{80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoricFlow.outlet, sink1.inlet) annotation (Line(
      points={{100,0},{110,0}},
      color={28,108,200},
      thickness=0.5));

  connect(inletPressure.y, source.p0_var) annotation (Line(points={{-79,80},{-50,80},{-50,6},{-42,6}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation (Line(points={{58,6},{52,6},{52,80},{-79,80}}, color={0,0,127}));
  connect(source.T0_var, inletTemperature.y) annotation (Line(points={{-42,0},{-56,0},{-56,40},{-79,40}}, color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation (Line(points={{58,0},{48,0},{48,40},{-79,40}}, color={0,0,127}));
  connect(energyFlowSource.E_flow_out, isochoricCycle.Q_flow_in) annotation (Line(points={{-79,-100},{-10,-100},{-10,-8}}, color={255,170,85}));
  connect(isochoricFlow.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{90,-8},{90,-100},{-79,-100}}, color={255,170,85}));
  connect(sink.m_flow_prescribed, firstOrder.y) annotation (Line(points={{22,0},{34,0},{34,-60},{-79,-60}}, color={0,0,127}));
  connect(sink1.m_flow_prescribed, firstOrder.y) annotation (Line(points={{122,0},{130,0},{130,-60},{-79,-60}}, color={0,0,127}));
  annotation(
    Documentation(
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isochoric\">Isochoric</a> process defined by parameters (mass flow rate and heat flow rate given)
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
