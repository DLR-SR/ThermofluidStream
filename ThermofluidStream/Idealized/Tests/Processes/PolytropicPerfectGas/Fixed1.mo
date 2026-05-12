within ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas;
model Fixed1
  extends ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas.PartialFixed;

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{286,194},{306,214}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-240,140},{-220,160}})));
  Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-180,140},{-160,160}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-210,140},{-190,160}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-240,100},{-220,120}})));
  Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-180,100},{-160,120}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-210,100},{-190,120}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-240,60},{-220,80}})));
  Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-210,60},{-190,80}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-240,20},{-220,40}})));
  Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-180,20},{-160,40}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-210,20},{-190,40}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-240,-20},{-220,0}})));
  Sink_m sink4(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-180,-20},{-160,0}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-210,-20},{-190,0}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-240,-60},{-220,-40}})));
  Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-180,-60},{-160,-40}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-210,-60},{-190,-40}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-240,-100},{-220,-80}})));
  Sink_m sink6(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-180,-100},{-160,-80}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-210,-100},{-190,-80}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-140,140},{-120,160}})));
  Sink_m sink7(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-80,140},{-60,160}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-110,140},{-90,160}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-140,100},{-120,120}})));
  Sink_m sink8(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-80,100},{-60,120}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-110,100},{-90,120}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
  Sink_m sink9(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-110,60},{-90,80}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-140,20},{-120,40}})));
  Sink_m sink10(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-110,20},{-90,40}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));
  Sink_m sink11(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-110,-20},{-90,0}})));
  ThermofluidStream.Boundaries.Source source12(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-140,-60},{-120,-40}})));
  Sink_m sink12(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-110,-60},{-90,-40}})));
  ThermofluidStream.Boundaries.Source source13(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-140,-100},{-120,-80}})));
  Sink_m sink13(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-110,-100},{-90,-80}})));
  ThermofluidStream.Boundaries.Source source14(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-40,140},{-20,160}})));
  Sink_m sink14(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,140},{40,160}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-10,140},{10,160}})));
  ThermofluidStream.Boundaries.Source source15(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-40,100},{-20,120}})));
  Sink_m sink15(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,100},{40,120}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-10,100},{10,120}})));
  ThermofluidStream.Boundaries.Source source16(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Sink_m sink16(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,60},{40,80}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  ThermofluidStream.Boundaries.Source source17(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Sink_m sink17(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,20},{40,40}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  ThermofluidStream.Boundaries.Source source18(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Sink_m sink18(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,-20},{40,0}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  ThermofluidStream.Boundaries.Source source19(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Sink_m sink19(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  ThermofluidStream.Boundaries.Source source20(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Sink_m sink20(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
  ThermofluidStream.Boundaries.Source source21(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{60,140},{80,160}})));
  Sink_m sink21(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{120,140},{140,160}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{90,140},{110,160}})));
  ThermofluidStream.Boundaries.Source source22(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{60,100},{80,120}})));
  Sink_m sink22(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{120,100},{140,120}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{90,100},{110,120}})));
  ThermofluidStream.Boundaries.Source source23(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Sink_m sink23(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{120,60},{140,80}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{90,60},{110,80}})));
  ThermofluidStream.Boundaries.Source source25(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Sink_m sink25(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{120,-20},{140,0}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{90,-20},{110,0}})));
  ThermofluidStream.Boundaries.Source source26(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Sink_m sink26(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{120,-60},{140,-40}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{90,-60},{110,-40}})));
  ThermofluidStream.Boundaries.Source source27(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  Sink_m sink27(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{120,-100},{140,-80}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{90,-100},{110,-80}})));
  ThermofluidStream.Boundaries.Source source28(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{160,-20},{180,0}})));
  Sink_m sink28(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{220,-20},{240,0}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{190,-20},{210,0}})));
  ThermofluidStream.Boundaries.Source source29(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{160,-60},{180,-40}})));
  Sink_m sink29(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{220,-60},{240,-40}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{190,-60},{210,-40}})));
  ThermofluidStream.Boundaries.Source source30(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{160,-100},{180,-80}})));
  Sink_m sink30(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{220,-100},{240,-80}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{190,-100},{210,-80}})));
  ThermofluidStream.Boundaries.Source source24(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{160,20},{180,40}})));
  Sink_m sink24(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{220,20},{240,40}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{190,20},{210,40}})));
  ThermofluidStream.Boundaries.Source source31(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-240,-140},{-220,-120}})));
  Sink_m sink31(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-180,-140},{-160,-120}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-210,-140},{-190,-120}})));
  ThermofluidStream.Boundaries.Source source32(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-140,-140},{-120,-120}})));
  Sink_m sink32(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-80,-140},{-60,-120}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-110,-140},{-90,-120}})));
  ThermofluidStream.Boundaries.Source source33(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{-40,-140},{-20,-120}})));
  Sink_m sink33(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,-140},{40,-120}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{-10,-140},{10,-120}})));
  ThermofluidStream.Boundaries.Source source35(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation (Placement(transformation(extent={{160,-140},{180,-120}})));
  Sink_m sink35(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{220,-140},{240,-120}})));
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
    eta_is_fixed=eta_is) annotation (Placement(transformation(extent={{190,-140},{210,-120}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow=P) annotation (Placement(transformation(extent={{-260,-170},{-240,-150}})));
equation
  connect(source.outlet, dp_eta_pol.inlet) annotation (Line(
      points={{-220,150},{-210,150}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_pol.outlet, sink.inlet) annotation (Line(
      points={{-190,150},{-180,150}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, pRatio_eta_pol.inlet) annotation (Line(
      points={{-220,110},{-210,110}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_eta_pol.outlet, sink1.inlet) annotation (Line(
      points={{-190,110},{-180,110}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, p_out_eta_pol.inlet) annotation (Line(
      points={{-220,70},{-210,70}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_eta_pol.outlet, sink2.inlet) annotation (Line(
      points={{-190,70},{-180,70}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, T_out_eta_pol.inlet) annotation (Line(
      points={{-220,30},{-210,30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_eta_pol.outlet, sink3.inlet) annotation (Line(
      points={{-190,30},{-180,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, rhoRatio_eta_pol.inlet) annotation (Line(
      points={{-220,-10},{-210,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_eta_pol.outlet, sink4.inlet) annotation (Line(
      points={{-190,-10},{-180,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, rho_out_eta_pol.inlet) annotation (Line(
      points={{-220,-50},{-210,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_eta_pol.outlet, sink5.inlet) annotation (Line(
      points={{-190,-50},{-180,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, v_out_eta_pol.inlet) annotation (Line(
      points={{-220,-90},{-210,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_eta_pol.outlet, sink6.inlet) annotation (Line(
      points={{-190,-90},{-180,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, dp_n.inlet) annotation (Line(
      points={{-120,150},{-110,150}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_n.outlet, sink7.inlet) annotation (Line(
      points={{-90,150},{-80,150}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, pRatio_n.inlet) annotation (Line(
      points={{-120,110},{-110,110}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_n.outlet, sink8.inlet) annotation (Line(
      points={{-90,110},{-80,110}},
      color={28,108,200},
      thickness=0.5));
  connect(source9.outlet, p_out_n.inlet) annotation (Line(
      points={{-120,70},{-110,70}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_n.outlet, sink9.inlet) annotation (Line(
      points={{-90,70},{-80,70}},
      color={28,108,200},
      thickness=0.5));
  connect(source10.outlet, T_out_n.inlet) annotation (Line(
      points={{-120,30},{-110,30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_n.outlet, sink10.inlet) annotation (Line(
      points={{-90,30},{-80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source11.outlet, rhoRatio_n.inlet) annotation (Line(
      points={{-120,-10},{-110,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_n.outlet, sink11.inlet) annotation (Line(
      points={{-90,-10},{-80,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source12.outlet, rho_out_n.inlet) annotation (Line(
      points={{-120,-50},{-110,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_n.outlet, sink12.inlet) annotation (Line(
      points={{-90,-50},{-80,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(source13.outlet, v_out_n.inlet) annotation (Line(
      points={{-120,-90},{-110,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_n.outlet, sink13.inlet) annotation (Line(
      points={{-90,-90},{-80,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source14.outlet, dp_eta_is.inlet) annotation (Line(
      points={{-20,150},{-10,150}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_is.outlet, sink14.inlet) annotation (Line(
      points={{10,150},{20,150}},
      color={28,108,200},
      thickness=0.5));
  connect(source15.outlet, pRatio_eta_is.inlet) annotation (Line(
      points={{-20,110},{-10,110}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_eta_is.outlet, sink15.inlet) annotation (Line(
      points={{10,110},{20,110}},
      color={28,108,200},
      thickness=0.5));
  connect(source16.outlet, p_out_eta_is.inlet) annotation (Line(
      points={{-20,70},{-10,70}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_eta_is.outlet, sink16.inlet) annotation (Line(
      points={{10,70},{20,70}},
      color={28,108,200},
      thickness=0.5));
  connect(source17.outlet, T_out_eta_is.inlet) annotation (Line(
      points={{-20,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_eta_is.outlet, sink17.inlet) annotation (Line(
      points={{10,30},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source18.outlet, rhoRatio_eta_is.inlet) annotation (Line(
      points={{-20,-10},{-10,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_eta_is.outlet, sink18.inlet) annotation (Line(
      points={{10,-10},{20,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source19.outlet, rho_out_eta_is.inlet) annotation (Line(
      points={{-20,-50},{-10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_eta_is.outlet, sink19.inlet) annotation (Line(
      points={{10,-50},{20,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(source20.outlet, v_out_eta_is.inlet) annotation (Line(
      points={{-20,-90},{-10,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_eta_is.outlet, sink20.inlet) annotation (Line(
      points={{10,-90},{20,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source21.outlet, dp_T_out.inlet) annotation (Line(
      points={{80,150},{90,150}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_T_out.outlet, sink21.inlet) annotation (Line(
      points={{110,150},{120,150}},
      color={28,108,200},
      thickness=0.5));
  connect(source22.outlet, pRatio_T_out.inlet) annotation (Line(
      points={{80,110},{90,110}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_T_out.outlet, sink22.inlet) annotation (Line(
      points={{110,110},{120,110}},
      color={28,108,200},
      thickness=0.5));
  connect(source23.outlet, p_out_T_out.inlet) annotation (Line(
      points={{80,70},{90,70}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_T_out.outlet, sink23.inlet) annotation (Line(
      points={{110,70},{120,70}},
      color={28,108,200},
      thickness=0.5));
  connect(source25.outlet, rhoRatio_T_out.inlet) annotation (Line(
      points={{80,-10},{90,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_T_out.outlet, sink25.inlet) annotation (Line(
      points={{110,-10},{120,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source26.outlet, rho_out_T_out.inlet) annotation (Line(
      points={{80,-50},{90,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_T_out.outlet, sink26.inlet) annotation (Line(
      points={{110,-50},{120,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(source27.outlet, v_out_T_out.inlet) annotation (Line(
      points={{80,-90},{90,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_T_out.outlet, sink27.inlet) annotation (Line(
      points={{110,-90},{120,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source28.outlet, rhoRatio_p_out.inlet) annotation (Line(
      points={{180,-10},{190,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_p_out.outlet, sink28.inlet) annotation (Line(
      points={{210,-10},{220,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source29.outlet, rho_out_p_out.inlet) annotation (Line(
      points={{180,-50},{190,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_p_out.outlet, sink29.inlet) annotation (Line(
      points={{210,-50},{220,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(source30.outlet, v_out_p_out.inlet) annotation (Line(
      points={{180,-90},{190,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_p_out.outlet, sink30.inlet) annotation (Line(
      points={{210,-90},{220,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source24.outlet, T_out_p_out.inlet) annotation (Line(
      points={{180,30},{190,30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_p_out.outlet, sink24.inlet) annotation (Line(
      points={{210,30},{220,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source31.outlet, P_eta_pol.inlet) annotation (Line(
      points={{-220,-130},{-210,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(P_eta_pol.outlet, sink31.inlet) annotation (Line(
      points={{-190,-130},{-180,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(source32.outlet, P_n.inlet) annotation (Line(
      points={{-120,-130},{-110,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(P_n.outlet, sink32.inlet) annotation (Line(
      points={{-90,-130},{-80,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(source33.outlet, P_eta_is.inlet) annotation (Line(
      points={{-20,-130},{-10,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(P_eta_is.outlet, sink33.inlet) annotation (Line(
      points={{10,-130},{20,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(source35.outlet, P_p_out.inlet) annotation (Line(
      points={{180,-130},{190,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(P_p_out.outlet, sink35.inlet) annotation (Line(
      points={{210,-130},{220,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, P_eta_pol.P_in) annotation (Line(points={{-239,-160},{-200,-160},{-200,-138}}, color={255,170,85}));
  connect(P_n.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{-100,-138},{-100,-160},{-239,-160}}, color={255,170,85}));
  connect(P_eta_is.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{0,-138},{0,-160},{-239,-160}}, color={255,170,85}));
  connect(P_p_out.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{200,-138},{200,-160},{-239,-160}}, color={255,170,85}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-300,-180},{300,180}},
        grid={2,2})),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> test for fixed parameters/boundary conditions (given mass flow rate).
  </p>
</html>"));
end Fixed1;
