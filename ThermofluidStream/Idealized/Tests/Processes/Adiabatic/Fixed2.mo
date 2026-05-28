within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Fixed2 "Example - adiabatic process"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Tests.Processes.Adiabatic.PartialFixed;

  .ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{0,30},{20,50}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free
                                       sink(redeclare package Medium = Medium)                      annotation (Placement(transformation(extent={{60,30},{80,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    eta_fixed=eta_is)  annotation (Placement(transformation(extent={{30,30},{50,50}})));

  ThermofluidStream.Boundaries.Source  source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free
                                       sink1(redeclare package Medium = Medium)                     annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pRatio1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    eta_fixed=eta_is) annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  ThermofluidStream.Boundaries.Source  source2(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free
                                       sink2(redeclare package Medium = Medium)                     annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pOut1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    eta_fixed=eta_is) annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  EnergyFlow.Sources.PrescribedEnergyFlow
                                     energyFlowSource                annotation(Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.RealExpression power(y=P) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(source.outlet,dp1. inlet) annotation (Line(
      points={{20,40},{30,40}},
      color={28,108,200},
      thickness=0.5));
  connect(dp1.outlet, sink.inlet) annotation (Line(
      points={{50,40},{60,40}},
      color={28,108,200},
      thickness=0.5));

  connect(source1.outlet, pRatio1.inlet) annotation (Line(
      points={{20,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio1.outlet, sink1.inlet) annotation (Line(
      points={{50,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, pOut1.inlet) annotation (Line(
      points={{20,-40},{30,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(pOut1.outlet, sink2.inlet) annotation (Line(
      points={{50,-40},{60,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(power.y, energyFlowSource.E_flow) annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  connect(dp1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{40,32},{40,20},{-10,20},{-10,0},{-29,0}}, color={255,170,85}));
  connect(pRatio1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{40,-8},{40,-20},{-10,-20},{-10,0},{-29,0}}, color={255,170,85}));
  connect(pOut1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{40,-48},{40,-60},{-10,-60},{-10,0},{-29,0}}, color={255,170,85}));
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
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> process defined by parameters (outlet state and power given, FullMedium model).
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
end Fixed2;
