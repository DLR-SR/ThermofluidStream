within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Fixed1 "Example - Isochoric process"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Tests.Processes.Isochoric.PartialFixed;

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-90,20},{-70,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT1c(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{10,20},{30,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{70,20},{90,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out1c(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation (Placement(transformation(extent={{40,20},{60,40}})));
  .ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  .ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation (Placement(transformation(extent={{40,-40},{60,-20}})));

equation
  connect(source.outlet, dT1c.inlet) annotation (Line(
      points={{-70,30},{-60,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1c.outlet, sink.inlet) annotation (Line(
      points={{-40,30},{-30,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, T_out1c.inlet) annotation (Line(
      points={{30,30},{40,30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1c.outlet, sink1.inlet) annotation (Line(
      points={{60,30},{70,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, dT1.inlet) annotation (Line(
      points={{-70,-30},{-60,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet,sink2. inlet) annotation (Line(
      points={{-40,-30},{-30,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, T_out1.inlet) annotation (Line(
      points={{30,-30},{40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet,sink3. inlet) annotation (Line(
      points={{60,-30},{70,-30}},
      color={28,108,200},
      thickness=0.5));

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
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isochoric\">Isochoric</a> process defined by parameters (outlet state and mass flow rate given)
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
end Fixed1;
