within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Fixed1 "Example - adiabatic process"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Tests.Processes.Adiabatic.PartialFixed;

  .ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp1(
    redeclare package Medium = Medium,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    eta_fixed=eta_is)  annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  ThermofluidStream.Boundaries.Source  source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Boundaries.Sink_m  sink1(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pRatio1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    eta_fixed=eta_is) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Boundaries.Source  source2(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  ThermofluidStream.Boundaries.Sink_m  sink2(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pOut1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    eta_fixed=eta_is) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
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
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> process defined by parameters (outlet state and mass flow rate given, FullMedium model)
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
