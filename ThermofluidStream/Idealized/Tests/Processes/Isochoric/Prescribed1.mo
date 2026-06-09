within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Prescribed1 "Example - Isochoric process"
  extends ThermofluidStream.Idealized.Tests.Processes.Isochoric.PartialPrescribed;
  extends Modelica.Icons.Example;


  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-50,20},{-30,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,20},{30,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT1c(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{50,20},{70,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{110,20},{130,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out1c(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{80,20},{100,40}})));
  .ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  .ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{110,-40},{130,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{80,-40},{100,-20}})));



equation
  connect(source.outlet, dT1c.inlet) annotation (Line(
      points={{-30,30},{-20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1c.outlet, sink.inlet) annotation (Line(
      points={{0,30},{10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, T_out1c.inlet) annotation (Line(
      points={{70,30},{80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1c.outlet, sink1.inlet) annotation (Line(
      points={{100,30},{110,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, dT1.inlet) annotation (Line(
      points={{-30,-30},{-20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet,sink2. inlet) annotation (Line(
      points={{0,-30},{10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, T_out1.inlet) annotation (Line(
      points={{70,-30},{80,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet,sink3. inlet) annotation (Line(
      points={{100,-30},{110,-30}},
      color={28,108,200},
      thickness=0.5));

  connect(inletPressure.y, source.p0_var) annotation (Line(points={{-79,80},{-50,80},{-50,36},{-42,36}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation (Line(points={{58,36},{50,36},{50,80},{-79,80}}, color={0,0,127}));
  connect(source2.p0_var, inletPressure.y) annotation (Line(points={{-42,-24},{-50,-24},{-50,80},{-79,80}}, color={0,0,127}));
  connect(source3.p0_var, inletPressure.y) annotation (Line(points={{58,-24},{50,-24},{50,80},{-79,80}}, color={0,0,127}));
  connect(inletTemperature.y, source.T0_var) annotation (Line(points={{-79,40},{-54,40},{-54,30},{-42,30}}, color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation (Line(points={{58,30},{46,30},{46,76},{-54,76},{-54,40},{-79,40}}, color={0,0,127}));
  connect(source3.T0_var, inletTemperature.y) annotation (Line(points={{58,-30},{46,-30},{46,76},{-54,76},{-54,40},{-79,40}}, color={0,0,127}));
  connect(source2.T0_var, inletTemperature.y) annotation (Line(points={{-42,-30},{-54,-30},{-54,40},{-79,40}}, color={0,0,127}));
  connect(temperatureDifference.y, dT1c.outletSpec_prescribed) annotation (Line(points={{-79,0},{-20,0},{-20,18}}, color={0,0,127}));
  connect(dT1.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{-20,-42},{-20,-48},{-58,-48},{-58,0},{-79,0}}, color={0,0,127}));
  connect(T_out1c.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{80,18},{80,-4},{-62,-4},{-62,-30},{-79,-30}}, color={0,0,127}));
  connect(T_out1.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{80,-42},{80,-52},{-62,-52},{-62,-30},{-79,-30}}, color={0,0,127}));
  connect(massFlowRate.y, firstOrder.u) annotation (Line(points={{-119,-60},{-110,-60},{-110,-60},{-102,-60}},
                                                                                         color={0,0,127}));
  connect(firstOrder.y, sink.m_flow_prescribed) annotation (Line(points={{-79,-60},{32,-60},{32,30},{22,30}}, color={0,0,127}));
  connect(sink2.m_flow_prescribed, firstOrder.y) annotation (Line(points={{22,-30},{32,-30},{32,-60},{-79,-60}}, color={0,0,127}));
  connect(sink1.m_flow_prescribed, firstOrder.y) annotation (Line(points={{122,30},{132,30},{132,-60},{-79,-60}}, color={0,0,127}));
  connect(sink3.m_flow_prescribed, firstOrder.y) annotation (Line(points={{122,-30},{132,-30},{132,-60},{-79,-60}}, color={0,0,127}));

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
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isochoric\">Isochoric</a> process defined by time-varying inputs (outlet state and mass flow rate given)
  </p>

  <p>
    <code>m_flow = 0</code> and/or <code>dT = 0</code> are supported.
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
