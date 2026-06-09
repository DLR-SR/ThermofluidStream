within ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas;
model Fixed1
  extends ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas.PartialFixed;
  extends Modelica.Icons.Example;

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{500,140},{520,160}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-500,110},{-480,130}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-440,110},{-420,130}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_eta_pol(
    redeclare package Medium = Medium,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-470,110},{-450,130}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-500,70},{-480,90}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-440,70},{-420,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_eta_pol(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-470,70},{-450,90}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-500,30},{-480,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-440,30},{-420,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_eta_pol(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-470,30},{-450,50}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-500,-10},{-480,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-440,-10},{-420,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_eta_pol(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-470,-10},{-450,10}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-500,-50},{-480,-30}})));
  .ThermofluidStream.Boundaries.Sink_m sink4(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-440,-50},{-420,-30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_eta_pol(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-470,-50},{-450,-30}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-500,-90},{-480,-70}})));
  .ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-440,-90},{-420,-70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_eta_pol(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-470,-90},{-450,-70}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-500,-130},{-480,-110}})));
  .ThermofluidStream.Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-440,-130},{-420,-110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_eta_pol(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-470,-130},{-450,-110}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-400,110},{-380,130}})));
  .ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-340,110},{-320,130}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_n(
    redeclare package Medium = Medium,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-370,110},{-350,130}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-400,70},{-380,90}})));
  .ThermofluidStream.Boundaries.Sink_m sink8(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-340,70},{-320,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_n(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-370,70},{-350,90}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-400,30},{-380,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink9(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-340,30},{-320,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_n(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-370,30},{-350,50}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-400,-10},{-380,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink10(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-340,-10},{-320,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_n(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-370,-10},{-350,10}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-400,-50},{-380,-30}})));
  .ThermofluidStream.Boundaries.Sink_m sink11(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-340,-50},{-320,-30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_n(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-370,-50},{-350,-30}})));
  ThermofluidStream.Boundaries.Source source12(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-400,-90},{-380,-70}})));
  .ThermofluidStream.Boundaries.Sink_m sink12(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-340,-90},{-320,-70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_n(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-370,-90},{-350,-70}})));
  ThermofluidStream.Boundaries.Source source13(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-400,-130},{-380,-110}})));
  .ThermofluidStream.Boundaries.Sink_m sink13(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-340,-130},{-320,-110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_n(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-370,-130},{-350,-110}})));
  ThermofluidStream.Boundaries.Source source14(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-300,110},{-280,130}})));
  .ThermofluidStream.Boundaries.Sink_m sink14(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-240,110},{-220,130}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_eta_is(
    redeclare package Medium = Medium,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-270,110},{-250,130}})));
  ThermofluidStream.Boundaries.Source source15(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-300,70},{-280,90}})));
  .ThermofluidStream.Boundaries.Sink_m sink15(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-240,70},{-220,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_eta_is(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-270,70},{-250,90}})));
  ThermofluidStream.Boundaries.Source source16(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-300,30},{-280,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink16(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-240,30},{-220,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_eta_is(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-270,30},{-250,50}})));
  ThermofluidStream.Boundaries.Source source17(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-300,-10},{-280,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink17(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-240,-10},{-220,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_eta_is(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-270,-10},{-250,10}})));
  ThermofluidStream.Boundaries.Source source18(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-300,-50},{-280,-30}})));
  .ThermofluidStream.Boundaries.Sink_m sink18(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-240,-50},{-220,-30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_eta_is(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-270,-50},{-250,-30}})));
  ThermofluidStream.Boundaries.Source source19(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-300,-90},{-280,-70}})));
  .ThermofluidStream.Boundaries.Sink_m sink19(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-240,-90},{-220,-70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_eta_is(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-270,-90},{-250,-70}})));
  ThermofluidStream.Boundaries.Source source20(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-300,-130},{-280,-110}})));
  .ThermofluidStream.Boundaries.Sink_m sink20(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-240,-130},{-220,-110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_eta_is(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-270,-130},{-250,-110}})));
  ThermofluidStream.Boundaries.Source source21(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-200,110},{-180,130}})));
  .ThermofluidStream.Boundaries.Sink_m sink21(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-140,110},{-120,130}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_T_out(
    redeclare package Medium = Medium,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-170,110},{-150,130}})));
  ThermofluidStream.Boundaries.Source source22(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-200,70},{-180,90}})));
  .ThermofluidStream.Boundaries.Sink_m sink22(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-140,70},{-120,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_T_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-170,70},{-150,90}})));
  ThermofluidStream.Boundaries.Source source23(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-200,30},{-180,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink23(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_T_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-170,30},{-150,50}})));
  ThermofluidStream.Boundaries.Source source25(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-200,-50},{-180,-30}})));
  .ThermofluidStream.Boundaries.Sink_m sink25(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_T_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-170,-50},{-150,-30}})));
  ThermofluidStream.Boundaries.Source source26(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-200,-90},{-180,-70}})));
  .ThermofluidStream.Boundaries.Sink_m sink26(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-140,-90},{-120,-70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_T_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-170,-90},{-150,-70}})));
  ThermofluidStream.Boundaries.Source source27(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-200,-130},{-180,-110}})));
  .ThermofluidStream.Boundaries.Sink_m sink27(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-140,-130},{-120,-110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_T_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-170,-130},{-150,-110}})));
  ThermofluidStream.Boundaries.Source source28(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-100,-50},{-80,-30}})));
  .ThermofluidStream.Boundaries.Sink_m sink28(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-70,-50},{-50,-30}})));
  ThermofluidStream.Boundaries.Source source29(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-100,-90},{-80,-70}})));
  .ThermofluidStream.Boundaries.Sink_m sink29(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-70,-90},{-50,-70}})));
  ThermofluidStream.Boundaries.Source source30(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-100,-130},{-80,-110}})));
  .ThermofluidStream.Boundaries.Sink_m sink30(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-40,-130},{-20,-110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-70,-130},{-50,-110}})));
  ThermofluidStream.Boundaries.Source source24(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-100,-10},{-80,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink24(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-70,-10},{-50,10}})));

  ThermofluidStream.Boundaries.Source source31(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{20,110},{40,130}})));
  ThermofluidStream.Boundaries.Sink_m  sink31(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                    annotation (Placement(transformation(extent={{80,110},{100,130}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_eta_pol1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{50,110},{70,130}})));
  ThermofluidStream.Boundaries.Source source32(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{20,70},{40,90}})));
  ThermofluidStream.Boundaries.Sink_m  sink32(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                     annotation (Placement(transformation(extent={{80,70},{100,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_eta_pol1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{50,70},{70,90}})));
  ThermofluidStream.Boundaries.Source source33(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{20,30},{40,50}})));
  ThermofluidStream.Boundaries.Sink_m  sink33(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                     annotation (Placement(transformation(extent={{80,30},{100,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_eta_pol1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{50,30},{70,50}})));
  ThermofluidStream.Boundaries.Source source34(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{20,-10},{40,10}})));
  ThermofluidStream.Boundaries.Sink_m  sink34(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                     annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_eta_pol1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{50,-10},{70,10}})));
  ThermofluidStream.Boundaries.Source source35(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{20,-50},{40,-30}})));
  ThermofluidStream.Boundaries.Sink_m  sink35(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                     annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_eta_pol1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{50,-50},{70,-30}})));
  ThermofluidStream.Boundaries.Source source36(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{20,-90},{40,-70}})));
  ThermofluidStream.Boundaries.Sink_m  sink36(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                     annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_eta_pol1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{50,-90},{70,-70}})));
  ThermofluidStream.Boundaries.Source source37(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{20,-130},{40,-110}})));
  ThermofluidStream.Boundaries.Sink_m  sink37(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                     annotation (Placement(transformation(extent={{80,-130},{100,-110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_eta_pol1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{50,-130},{70,-110}})));
  ThermofluidStream.Boundaries.Source source38(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{120,110},{140,130}})));
  ThermofluidStream.Boundaries.Sink_m  sink38(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                     annotation (Placement(transformation(extent={{180,110},{200,130}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_n1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{150,110},{170,130}})));
  ThermofluidStream.Boundaries.Source source39(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{120,70},{140,90}})));
  ThermofluidStream.Boundaries.Sink_m  sink39(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                     annotation (Placement(transformation(extent={{180,70},{200,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_n1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{150,70},{170,90}})));
  ThermofluidStream.Boundaries.Source source40(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{120,30},{140,50}})));
  ThermofluidStream.Boundaries.Sink_m  sink40(redeclare package Medium = Medium, m_flow_fixed=m_flow)
                                                                                                     annotation (Placement(transformation(extent={{180,30},{200,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_n1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{150,30},{170,50}})));
  ThermofluidStream.Boundaries.Source source41(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{120,-10},{140,10}})));
  ThermofluidStream.Boundaries.Sink_m  sink41(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{180,-10},{200,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_n1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{150,-10},{170,10}})));
  ThermofluidStream.Boundaries.Source source42(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{120,-50},{140,-30}})));
  ThermofluidStream.Boundaries.Sink_m  sink42(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{180,-50},{200,-30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_n1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{150,-50},{170,-30}})));
  ThermofluidStream.Boundaries.Source source43(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{120,-90},{140,-70}})));
  ThermofluidStream.Boundaries.Sink_m  sink43(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{180,-90},{200,-70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_n1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{150,-90},{170,-70}})));
  ThermofluidStream.Boundaries.Source source44(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{120,-130},{140,-110}})));
  ThermofluidStream.Boundaries.Sink_m  sink44(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{180,-130},{200,-110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_n1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{150,-130},{170,-110}})));
  ThermofluidStream.Boundaries.Source source45(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{220,110},{240,130}})));
  ThermofluidStream.Boundaries.Sink_m  sink45(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{280,110},{300,130}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_eta_is1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{250,110},{270,130}})));
  ThermofluidStream.Boundaries.Source source46(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{220,70},{240,90}})));
  ThermofluidStream.Boundaries.Sink_m  sink46(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{280,70},{300,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_eta_is1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{250,70},{270,90}})));
  ThermofluidStream.Boundaries.Source source47(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{220,30},{240,50}})));
  ThermofluidStream.Boundaries.Sink_m  sink47(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{280,30},{300,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_eta_is1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{250,30},{270,50}})));
  ThermofluidStream.Boundaries.Source source48(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{220,-10},{240,10}})));
  ThermofluidStream.Boundaries.Sink_m  sink48(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{280,-10},{300,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_eta_is1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{250,-10},{270,10}})));
  ThermofluidStream.Boundaries.Source source49(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{220,-50},{240,-30}})));
  ThermofluidStream.Boundaries.Sink_m  sink49(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{280,-50},{300,-30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_eta_is1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{250,-50},{270,-30}})));
  ThermofluidStream.Boundaries.Source source50(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{220,-90},{240,-70}})));
  ThermofluidStream.Boundaries.Sink_m  sink50(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{280,-90},{300,-70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_eta_is1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{250,-90},{270,-70}})));
  ThermofluidStream.Boundaries.Source source51(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{220,-130},{240,-110}})));
  ThermofluidStream.Boundaries.Sink_m  sink51(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{280,-130},{300,-110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_eta_is1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{250,-130},{270,-110}})));
  ThermofluidStream.Boundaries.Source source52(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{320,110},{340,130}})));
  ThermofluidStream.Boundaries.Sink_m  sink52(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{380,110},{400,130}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_T_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{350,110},{370,130}})));
  ThermofluidStream.Boundaries.Source source53(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{320,70},{340,90}})));
  ThermofluidStream.Boundaries.Sink_m  sink53(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{380,70},{400,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_T_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{350,70},{370,90}})));
  ThermofluidStream.Boundaries.Source source54(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{320,30},{340,50}})));
  ThermofluidStream.Boundaries.Sink_m  sink54(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{380,30},{400,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_T_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{350,30},{370,50}})));
  ThermofluidStream.Boundaries.Source source55(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{320,-50},{340,-30}})));
  ThermofluidStream.Boundaries.Sink_m  sink55(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{380,-50},{400,-30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_T_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{350,-50},{370,-30}})));
  ThermofluidStream.Boundaries.Source source56(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{320,-90},{340,-70}})));
  ThermofluidStream.Boundaries.Sink_m  sink56(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{380,-90},{400,-70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_T_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{350,-90},{370,-70}})));
  ThermofluidStream.Boundaries.Source source57(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{320,-130},{340,-110}})));
  ThermofluidStream.Boundaries.Sink_m  sink57(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{380,-130},{400,-110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_T_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{350,-130},{370,-110}})));
  ThermofluidStream.Boundaries.Source source58(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{420,-50},{440,-30}})));
  ThermofluidStream.Boundaries.Sink_m  sink58(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{480,-50},{500,-30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_p_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{450,-50},{470,-30}})));
  ThermofluidStream.Boundaries.Source source59(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{420,-90},{440,-70}})));
  ThermofluidStream.Boundaries.Sink_m  sink59(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{480,-90},{500,-70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_p_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{450,-90},{470,-70}})));
  ThermofluidStream.Boundaries.Source source60(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{420,-130},{440,-110}})));
  ThermofluidStream.Boundaries.Sink_m  sink60(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{480,-130},{500,-110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_p_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{450,-130},{470,-110}})));
  ThermofluidStream.Boundaries.Source source61(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{420,-10},{440,10}})));
  ThermofluidStream.Boundaries.Sink_m  sink61(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{480,-10},{500,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_p_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{450,-10},{470,10}})));
equation
  connect(source.outlet, dp_eta_pol.inlet) annotation(Line(
      points={{-480,120},{-470,120}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_pol.outlet, sink.inlet) annotation(Line(
      points={{-450,120},{-440,120}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, pRatio_eta_pol.inlet) annotation(Line(
      points={{-480,80},{-470,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_eta_pol.outlet, sink1.inlet) annotation(Line(
      points={{-450,80},{-440,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, p_out_eta_pol.inlet) annotation(Line(
      points={{-480,40},{-470,40}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_eta_pol.outlet, sink2.inlet) annotation(Line(
      points={{-450,40},{-440,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, T_out_eta_pol.inlet) annotation(Line(
      points={{-480,0},{-470,0}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_eta_pol.outlet, sink3.inlet) annotation(Line(
      points={{-450,0},{-440,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, rhoRatio_eta_pol.inlet) annotation(Line(
      points={{-480,-40},{-470,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_eta_pol.outlet, sink4.inlet) annotation(Line(
      points={{-450,-40},{-440,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, rho_out_eta_pol.inlet) annotation(Line(
      points={{-480,-80},{-470,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_eta_pol.outlet, sink5.inlet) annotation(Line(
      points={{-450,-80},{-440,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, v_out_eta_pol.inlet) annotation(Line(
      points={{-480,-120},{-470,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_eta_pol.outlet, sink6.inlet) annotation(Line(
      points={{-450,-120},{-440,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, dp_n.inlet) annotation(Line(
      points={{-380,120},{-370,120}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_n.outlet, sink7.inlet) annotation(Line(
      points={{-350,120},{-340,120}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, pRatio_n.inlet) annotation(Line(
      points={{-380,80},{-370,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_n.outlet, sink8.inlet) annotation(Line(
      points={{-350,80},{-340,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source9.outlet, p_out_n.inlet) annotation(Line(
      points={{-380,40},{-370,40}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_n.outlet, sink9.inlet) annotation(Line(
      points={{-350,40},{-340,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source10.outlet, T_out_n.inlet) annotation(Line(
      points={{-380,0},{-370,0}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_n.outlet, sink10.inlet) annotation(Line(
      points={{-350,0},{-340,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source11.outlet, rhoRatio_n.inlet) annotation(Line(
      points={{-380,-40},{-370,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_n.outlet, sink11.inlet) annotation(Line(
      points={{-350,-40},{-340,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source12.outlet, rho_out_n.inlet) annotation(Line(
      points={{-380,-80},{-370,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_n.outlet, sink12.inlet) annotation(Line(
      points={{-350,-80},{-340,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source13.outlet, v_out_n.inlet) annotation(Line(
      points={{-380,-120},{-370,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_n.outlet, sink13.inlet) annotation(Line(
      points={{-350,-120},{-340,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(source14.outlet, dp_eta_is.inlet) annotation(Line(
      points={{-280,120},{-270,120}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_is.outlet, sink14.inlet) annotation(Line(
      points={{-250,120},{-240,120}},
      color={28,108,200},
      thickness=0.5));
  connect(source15.outlet, pRatio_eta_is.inlet) annotation(Line(
      points={{-280,80},{-270,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_eta_is.outlet, sink15.inlet) annotation(Line(
      points={{-250,80},{-240,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source16.outlet, p_out_eta_is.inlet) annotation(Line(
      points={{-280,40},{-270,40}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_eta_is.outlet, sink16.inlet) annotation(Line(
      points={{-250,40},{-240,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source17.outlet, T_out_eta_is.inlet) annotation(Line(
      points={{-280,0},{-270,0}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_eta_is.outlet, sink17.inlet) annotation(Line(
      points={{-250,0},{-240,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source18.outlet, rhoRatio_eta_is.inlet) annotation(Line(
      points={{-280,-40},{-270,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_eta_is.outlet, sink18.inlet) annotation(Line(
      points={{-250,-40},{-240,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source19.outlet, rho_out_eta_is.inlet) annotation(Line(
      points={{-280,-80},{-270,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_eta_is.outlet, sink19.inlet) annotation(Line(
      points={{-250,-80},{-240,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source20.outlet, v_out_eta_is.inlet) annotation(Line(
      points={{-280,-120},{-270,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_eta_is.outlet, sink20.inlet) annotation(Line(
      points={{-250,-120},{-240,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(source21.outlet, dp_T_out.inlet) annotation(Line(
      points={{-180,120},{-170,120}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_T_out.outlet, sink21.inlet) annotation(Line(
      points={{-150,120},{-140,120}},
      color={28,108,200},
      thickness=0.5));
  connect(source22.outlet, pRatio_T_out.inlet) annotation(Line(
      points={{-180,80},{-170,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_T_out.outlet, sink22.inlet) annotation(Line(
      points={{-150,80},{-140,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source23.outlet, p_out_T_out.inlet) annotation(Line(
      points={{-180,40},{-170,40}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_T_out.outlet, sink23.inlet) annotation(Line(
      points={{-150,40},{-140,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source25.outlet, rhoRatio_T_out.inlet) annotation(Line(
      points={{-180,-40},{-170,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_T_out.outlet, sink25.inlet) annotation(Line(
      points={{-150,-40},{-140,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source26.outlet, rho_out_T_out.inlet) annotation(Line(
      points={{-180,-80},{-170,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_T_out.outlet, sink26.inlet) annotation(Line(
      points={{-150,-80},{-140,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source27.outlet, v_out_T_out.inlet) annotation(Line(
      points={{-180,-120},{-170,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_T_out.outlet, sink27.inlet) annotation(Line(
      points={{-150,-120},{-140,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(source28.outlet, rhoRatio_p_out.inlet) annotation(Line(
      points={{-80,-40},{-70,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_p_out.outlet, sink28.inlet) annotation(Line(
      points={{-50,-40},{-40,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source29.outlet, rho_out_p_out.inlet) annotation(Line(
      points={{-80,-80},{-70,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_p_out.outlet, sink29.inlet) annotation(Line(
      points={{-50,-80},{-40,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source30.outlet, v_out_p_out.inlet) annotation(Line(
      points={{-80,-120},{-70,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_p_out.outlet, sink30.inlet) annotation(Line(
      points={{-50,-120},{-40,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(source24.outlet, T_out_p_out.inlet) annotation(Line(
      points={{-80,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_p_out.outlet, sink24.inlet) annotation(Line(
      points={{-50,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));

  connect(source31.outlet, dp_eta_pol1.inlet) annotation (Line(
      points={{40,120},{50,120}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_pol1.outlet, sink31.inlet) annotation (Line(
      points={{70,120},{80,120}},
      color={28,108,200},
      thickness=0.5));
  connect(source32.outlet, pRatio_eta_pol1.inlet) annotation (Line(
      points={{40,80},{50,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_eta_pol1.outlet, sink32.inlet) annotation (Line(
      points={{70,80},{80,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source33.outlet, p_out_eta_pol1.inlet) annotation (Line(
      points={{40,40},{50,40}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_eta_pol1.outlet, sink33.inlet) annotation (Line(
      points={{70,40},{80,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source34.outlet, T_out_eta_pol1.inlet) annotation (Line(
      points={{40,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_eta_pol1.outlet, sink34.inlet) annotation (Line(
      points={{70,0},{80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source35.outlet, rhoRatio_eta_pol1.inlet) annotation (Line(
      points={{40,-40},{50,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_eta_pol1.outlet, sink35.inlet) annotation (Line(
      points={{70,-40},{80,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source36.outlet, rho_out_eta_pol1.inlet) annotation (Line(
      points={{40,-80},{50,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_eta_pol1.outlet, sink36.inlet) annotation (Line(
      points={{70,-80},{80,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source37.outlet, v_out_eta_pol1.inlet) annotation (Line(
      points={{40,-120},{50,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_eta_pol1.outlet, sink37.inlet) annotation (Line(
      points={{70,-120},{80,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(source38.outlet, dp_n1.inlet) annotation (Line(
      points={{140,120},{150,120}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_n1.outlet, sink38.inlet) annotation (Line(
      points={{170,120},{180,120}},
      color={28,108,200},
      thickness=0.5));
  connect(source39.outlet, pRatio_n1.inlet) annotation (Line(
      points={{140,80},{150,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_n1.outlet, sink39.inlet) annotation (Line(
      points={{170,80},{180,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source40.outlet, p_out_n1.inlet) annotation (Line(
      points={{140,40},{150,40}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_n1.outlet, sink40.inlet) annotation (Line(
      points={{170,40},{180,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source41.outlet, T_out_n1.inlet) annotation (Line(
      points={{140,0},{150,0}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_n1.outlet, sink41.inlet) annotation (Line(
      points={{170,0},{180,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source42.outlet, rhoRatio_n1.inlet) annotation (Line(
      points={{140,-40},{150,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_n1.outlet, sink42.inlet) annotation (Line(
      points={{170,-40},{180,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source43.outlet, rho_out_n1.inlet) annotation (Line(
      points={{140,-80},{150,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_n1.outlet, sink43.inlet) annotation (Line(
      points={{170,-80},{180,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source44.outlet, v_out_n1.inlet) annotation (Line(
      points={{140,-120},{150,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_n1.outlet, sink44.inlet) annotation (Line(
      points={{170,-120},{180,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(source45.outlet, dp_eta_is1.inlet) annotation (Line(
      points={{240,120},{250,120}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_is1.outlet, sink45.inlet) annotation (Line(
      points={{270,120},{280,120}},
      color={28,108,200},
      thickness=0.5));
  connect(source46.outlet, pRatio_eta_is1.inlet) annotation (Line(
      points={{240,80},{250,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_eta_is1.outlet, sink46.inlet) annotation (Line(
      points={{270,80},{280,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source47.outlet, p_out_eta_is1.inlet) annotation (Line(
      points={{240,40},{250,40}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_eta_is1.outlet, sink47.inlet) annotation (Line(
      points={{270,40},{280,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source48.outlet, T_out_eta_is1.inlet) annotation (Line(
      points={{240,0},{250,0}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_eta_is1.outlet, sink48.inlet) annotation (Line(
      points={{270,0},{280,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source49.outlet, rhoRatio_eta_is1.inlet) annotation (Line(
      points={{240,-40},{250,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_eta_is1.outlet, sink49.inlet) annotation (Line(
      points={{270,-40},{280,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source50.outlet, rho_out_eta_is1.inlet) annotation (Line(
      points={{240,-80},{250,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_eta_is1.outlet, sink50.inlet) annotation (Line(
      points={{270,-80},{280,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source51.outlet, v_out_eta_is1.inlet) annotation (Line(
      points={{240,-120},{250,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_eta_is1.outlet, sink51.inlet) annotation (Line(
      points={{270,-120},{280,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(source52.outlet, dp_T_out1.inlet) annotation (Line(
      points={{340,120},{350,120}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_T_out1.outlet, sink52.inlet) annotation (Line(
      points={{370,120},{380,120}},
      color={28,108,200},
      thickness=0.5));
  connect(source53.outlet, pRatio_T_out1.inlet) annotation (Line(
      points={{340,80},{350,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_T_out1.outlet, sink53.inlet) annotation (Line(
      points={{370,80},{380,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source54.outlet, p_out_T_out1.inlet) annotation (Line(
      points={{340,40},{350,40}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_T_out1.outlet, sink54.inlet) annotation (Line(
      points={{370,40},{380,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source55.outlet, rhoRatio_T_out1.inlet) annotation (Line(
      points={{340,-40},{350,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_T_out1.outlet, sink55.inlet) annotation (Line(
      points={{370,-40},{380,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source56.outlet, rho_out_T_out1.inlet) annotation (Line(
      points={{340,-80},{350,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_T_out1.outlet, sink56.inlet) annotation (Line(
      points={{370,-80},{380,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source57.outlet, v_out_T_out1.inlet) annotation (Line(
      points={{340,-120},{350,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_T_out1.outlet, sink57.inlet) annotation (Line(
      points={{370,-120},{380,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(source58.outlet, rhoRatio_p_out1.inlet) annotation (Line(
      points={{440,-40},{450,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_p_out1.outlet, sink58.inlet) annotation (Line(
      points={{470,-40},{480,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source59.outlet, rho_out_p_out1.inlet) annotation (Line(
      points={{440,-80},{450,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_p_out1.outlet, sink59.inlet) annotation (Line(
      points={{470,-80},{480,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source60.outlet, v_out_p_out1.inlet) annotation (Line(
      points={{440,-120},{450,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_p_out1.outlet, sink60.inlet) annotation (Line(
      points={{470,-120},{480,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(source61.outlet, T_out_p_out1.inlet) annotation (Line(
      points={{440,0},{450,0}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_p_out1.outlet, sink61.inlet) annotation (Line(
      points={{470,0},{480,0}},
      color={28,108,200},
      thickness=0.5));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-520,-160},{520,160}})),
    Documentation(
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> process defined by parameters (outlet state and mass flow rate given)
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
