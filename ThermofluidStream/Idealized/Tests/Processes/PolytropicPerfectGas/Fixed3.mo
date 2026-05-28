within ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas;
model Fixed3
  extends ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas.PartialFixed;
  extends Modelica.Icons.Example;

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{100,80},{120,100}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_eta_pol(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-50,50},{-30,70}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_n(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-50,10},{-30,30}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_eta_is(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-50,-30},{-30,-10}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_p_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-50,-70},{-30,-50}})));

  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow=P) annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{20,50},{40,70}})));
  ThermofluidStream.Boundaries.Sink_m sink4(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{80,50},{100,70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_eta_pol1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{50,50},{70,70}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{20,10},{40,30}})));
  ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{80,10},{100,30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_n1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{50,10},{70,30}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  ThermofluidStream.Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_eta_is1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{50,-30},{70,-10}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_p_out1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{50,-70},{70,-50}})));
equation
  connect(source.outlet, P_eta_pol.inlet) annotation (Line(
      points={{-60,60},{-50,60}},
      color={28,108,200},
      thickness=0.5));
  connect(P_eta_pol.outlet, sink.inlet) annotation (Line(
      points={{-30,60},{-20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, P_n.inlet) annotation (Line(
      points={{-60,20},{-50,20}},
      color={28,108,200},
      thickness=0.5));
  connect(P_n.outlet, sink1.inlet) annotation (Line(
      points={{-30,20},{-20,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, P_eta_is.inlet) annotation (Line(
      points={{-60,-20},{-50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(P_eta_is.outlet, sink2.inlet) annotation (Line(
      points={{-30,-20},{-20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, P_p_out.inlet) annotation (Line(
      points={{-60,-60},{-50,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(P_p_out.outlet, sink3.inlet) annotation (Line(
      points={{-30,-60},{-20,-60}},
      color={28,108,200},
      thickness=0.5));

  connect(source4.outlet, P_eta_pol1.inlet) annotation (Line(
      points={{40,60},{50,60}},
      color={28,108,200},
      thickness=0.5));
  connect(P_eta_pol1.outlet, sink4.inlet) annotation (Line(
      points={{70,60},{80,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, P_n1.inlet) annotation (Line(
      points={{40,20},{50,20}},
      color={28,108,200},
      thickness=0.5));
  connect(P_n1.outlet, sink5.inlet) annotation (Line(
      points={{70,20},{80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, P_eta_is1.inlet) annotation (Line(
      points={{40,-20},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(P_eta_is1.outlet, sink6.inlet) annotation (Line(
      points={{70,-20},{80,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, P_p_out1.inlet) annotation (Line(
      points={{40,-60},{50,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(P_p_out1.outlet, sink7.inlet) annotation (Line(
      points={{70,-60},{80,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, P_n.P_in) annotation (Line(points={{-89,0},{-40,0},{-40,12}}, color={255,170,85}));
  connect(P_n1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{60,12},{60,0},{-89,0}}, color={255,170,85}));
  connect(P_eta_is1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{60,-28},{60,-40},{-80,-40},{-80,0},{-89,0}}, color={255,170,85}));
  connect(P_eta_is.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{-40,-28},{-40,-40},{-80,-40},{-80,0},{-89,0}}, color={255,170,85}));
  connect(P_p_out1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{60,-68},{60,-80},{-80,-80},{-80,0},{-89,0}}, color={255,170,85}));
  connect(P_p_out.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{-40,-68},{-40,-80},{-80,-80},{-80,0},{-89,0}}, color={255,170,85}));
  connect(P_eta_pol1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{60,52},{60,40},{-80,40},{-80,0},{-89,0}}, color={255,170,85}));
  connect(P_eta_pol.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{-40,52},{-40,40},{-80,40},{-80,0},{-89,0}}, color={255,170,85}));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-120,-100},{120,100}}, grid={2,2})),
    Documentation(
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> process defined by parameters (mass flow rate and power given).
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
