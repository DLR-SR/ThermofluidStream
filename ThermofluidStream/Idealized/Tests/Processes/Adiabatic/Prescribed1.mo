within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Prescribed1 "Example - adiabatic process"
  extends ThermofluidStream.Idealized.Tests.Processes.Adiabatic.PartialPrescribed;
  extends Modelica.Icons.Example;

  .ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                 annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                                                                                                    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp1(
    redeclare package Medium = Medium,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  ThermofluidStream.Boundaries.Source  source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                 annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Boundaries.Sink_m  sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                                                                                                    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pRatio1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Boundaries.Source  source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                 annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  ThermofluidStream.Boundaries.Sink_m  sink2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                                                                                                    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pOut1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
equation
  connect(source.outlet,dp1. inlet) annotation (Line(
      points={{-20,40},{-10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(dp1.outlet, sink.inlet) annotation (Line(
      points={{10,40},{20,40}},
      color={28,108,200},
      thickness=0.5));

  connect(source1.outlet, pRatio1.inlet) annotation (Line(
      points={{-20,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio1.outlet, sink1.inlet) annotation (Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, pOut1.inlet) annotation (Line(
      points={{-20,-40},{-10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(pOut1.outlet, sink2.inlet) annotation (Line(
      points={{10,-40},{20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source.p0_var, inletPressure.y) annotation (Line(points={{-32,46},{-40,46},{-40,110},{-79,110}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation (Line(points={{-32,6},{-40,6},{-40,110},{-79,110}}, color={0,0,127}));
  connect(source2.p0_var, inletPressure.y) annotation (Line(points={{-32,-34},{-40,-34},{-40,110},{-79,110}}, color={0,0,127}));
  connect(source.T0_var, inletTemperature.y) annotation (Line(points={{-32,40},{-44,40},{-44,70},{-79,70}}, color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation (Line(points={{-32,0},{-44,0},{-44,70},{-79,70}}, color={0,0,127}));
  connect(source2.T0_var, inletTemperature.y) annotation (Line(points={{-32,-40},{-44,-40},{-44,70},{-79,70}}, color={0,0,127}));
  connect(firstOrder.y, sink2.m_flow_prescribed) annotation (Line(points={{-79,-90},{40,-90},{40,-40},{32,-40}}, color={0,0,127}));
  connect(sink1.m_flow_prescribed, firstOrder.y) annotation (Line(points={{32,0},{40,0},{40,-90},{-79,-90}}, color={0,0,127}));
  connect(sink.m_flow_prescribed, firstOrder.y) annotation (Line(points={{32,40},{40,40},{40,-90},{-79,-90}}, color={0,0,127}));
  connect(dp1.eta_prescribed, isentropicEfficiency.y) annotation (Line(points={{6,28},{6,24},{-60,24},{-60,-50},{-79,-50}}, color={0,0,127}));
  connect(pRatio1.eta_prescribed, isentropicEfficiency.y) annotation (Line(points={{6,-12},{6,-16},{-60,-16},{-60,-50},{-79,-50}}, color={0,0,127}));
  connect(pOut1.eta_prescribed, isentropicEfficiency.y) annotation (Line(points={{6,-52},{6,-56},{-60,-56},{-60,-50},{-79,-50}}, color={0,0,127}));
  connect(pRatio1.outletSpec_prescribed, pressureRatio.y) annotation (Line(points={{10,-12},{10,-20},{-56,-20},{-56,30},{-79,30}}, color={0,0,127}));
  connect(pOut1.outletSpec_prescribed, outletPressure.y) annotation (Line(points={{10,-52},{10,-60},{-52,-60},{-52,0},{-79,0}}, color={0,0,127}));
  connect(dp1.outletSpec_prescribed, pressureDifference.y) annotation (Line(points={{10,28},{10,20},{-64,20},{-64,-20},{-79,-20}}, color={0,0,127}));
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
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> process defined by time varying inputs (outlet state and mass flow rate given, FullMedium model)
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
