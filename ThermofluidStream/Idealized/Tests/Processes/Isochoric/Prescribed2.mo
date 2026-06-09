within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Prescribed2 "Example - Isochoric process"
  extends ThermofluidStream.Idealized.Tests.Processes.Isochoric.PartialPrescribed;
  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                 annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT2c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-40,-40},{-20,-20}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out2c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  .ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                 annotation (Placement(transformation(extent={{60,20},{80,40}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{120,20},{140,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{90,20},{110,40}})));
  .ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                 annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{120,-40},{140,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{90,-40},{110,-20}})));

equation
  connect(source.outlet, dT2c.inlet) annotation (Line(
      points={{-20,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2c.outlet, sink.inlet) annotation (Line(
      points={{10,30},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, T_out2c.inlet) annotation (Line(
      points={{-20,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2c.outlet,sink2. inlet) annotation (Line(
      points={{10,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, dT2.inlet) annotation (Line(
      points={{80,30},{90,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outlet,sink1. inlet) annotation (Line(
      points={{110,30},{120,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, T_out2.inlet) annotation (Line(
      points={{80,-30},{90,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2.outlet,sink3. inlet) annotation (Line(
      points={{110,-30},{120,-30}},
      color={28,108,200},
      thickness=0.5));

  connect(inletPressure.y, source.p0_var) annotation (Line(points={{-79,80},{-40,80},{-40,36},{-32,36}}, color={0,0,127}));
  connect(source2.p0_var, inletPressure.y) annotation (Line(points={{-32,-24},{-40,-24},{-40,80},{-79,80}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation (Line(points={{68,36},{60,36},{60,50},{-40,50},{-40,80},{-79,80}}, color={0,0,127}));
  connect(source3.p0_var, inletPressure.y) annotation (Line(points={{68,-24},{60,-24},{60,50},{-40,50},{-40,80},{-79,80}}, color={0,0,127}));
  connect(source.T0_var, inletTemperature.y) annotation (Line(points={{-32,30},{-44,30},{-44,40},{-79,40}}, color={0,0,127}));
  connect(source2.T0_var, inletTemperature.y) annotation (Line(points={{-32,-30},{-44,-30},{-44,40},{-79,40}}, color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation (Line(points={{68,30},{56,30},{56,46},{-44,46},{-44,40},{-79,40}}, color={0,0,127}));
  connect(source3.T0_var, inletTemperature.y) annotation (Line(points={{68,-30},{56,-30},{56,46},{-44,46},{-44,40},{-79,40}}, color={0,0,127}));
  connect(dT2c.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{-10,18},{-10,0},{-79,0}}, color={0,0,127}));
  connect(dT2.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{90,18},{90,0},{-79,0}}, color={0,0,127}));
  connect(T_out2c.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{-10,-42},{-10,-48},{-52,-48},{-52,-30},{-79,-30}}, color={0,0,127}));
  connect(T_out2.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{90,-42},{90,-48},{-52,-48},{-52,-30},{-79,-30}}, color={0,0,127}));
  connect(energyFlowSource.E_flow_out, T_out2c.Q_flow_in) annotation (Line(points={{-79,-100},{0,-100},{0,-38}}, color={255,170,85}));
  connect(energyFlowSource.E_flow_out, T_out2.Q_flow_in) annotation (Line(points={{-79,-100},{100,-100},{100,-38}}, color={255,170,85}));
  connect(dT2c.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{0,22},{0,-4},{-48,-4},{-48,-100},{-79,-100}}, color={255,170,85}));
  connect(dT2.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{100,22},{100,-4},{-48,-4},{-48,-100},{-79,-100}}, color={255,170,85}));
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
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isochoric\">Isochoric</a> process defined by time-varying inputs (outlet state and heat flow rate given)
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
end Prescribed2;
