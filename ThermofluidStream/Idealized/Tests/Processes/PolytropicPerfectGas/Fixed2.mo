within ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas;
model Fixed2
  extends ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas.PartialFixed;
  extends Modelica.Icons.Example;

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{540,160},{560,180}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-510,130},{-490,150}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-450,130},{-430,150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_eta_pol(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-480,130},{-460,150}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-510,90},{-490,110}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-450,90},{-430,110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_eta_pol(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-480,90},{-460,110}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-510,50},{-490,70}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-450,50},{-430,70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_eta_pol(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-480,50},{-460,70}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-510,10},{-490,30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-450,10},{-430,30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_eta_pol(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-480,10},{-460,30}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-510,-30},{-490,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink4(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-450,-30},{-430,-10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_eta_pol(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-480,-30},{-460,-10}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-510,-70},{-490,-50}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink5(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-450,-70},{-430,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_eta_pol(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-480,-70},{-460,-50}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-510,-110},{-490,-90}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink6(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-450,-110},{-430,-90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_eta_pol(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-480,-110},{-460,-90}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-410,130},{-390,150}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink7(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-350,130},{-330,150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_n(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-380,130},{-360,150}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-410,90},{-390,110}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink8(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-350,90},{-330,110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_n(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-380,90},{-360,110}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-410,50},{-390,70}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink9(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-350,50},{-330,70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_n(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-380,50},{-360,70}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-410,10},{-390,30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink10(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-350,10},{-330,30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_n(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-380,10},{-360,30}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-410,-30},{-390,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink11(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-350,-30},{-330,-10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_n(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-380,-30},{-360,-10}})));
  ThermofluidStream.Boundaries.Source source12(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-410,-70},{-390,-50}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink12(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-350,-70},{-330,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_n(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-380,-70},{-360,-50}})));
  ThermofluidStream.Boundaries.Source source13(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-410,-110},{-390,-90}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink13(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-350,-110},{-330,-90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_n(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-380,-110},{-360,-90}})));
  ThermofluidStream.Boundaries.Source source14(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-310,130},{-290,150}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink14(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-250,130},{-230,150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_eta_is(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-280,130},{-260,150}})));
  ThermofluidStream.Boundaries.Source source15(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-310,90},{-290,110}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink15(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-250,90},{-230,110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_eta_is(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-280,90},{-260,110}})));
  ThermofluidStream.Boundaries.Source source16(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-310,50},{-290,70}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink16(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-250,50},{-230,70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_eta_is(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-280,50},{-260,70}})));
  ThermofluidStream.Boundaries.Source source17(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-310,10},{-290,30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink17(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-250,10},{-230,30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_eta_is(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-280,10},{-260,30}})));
  ThermofluidStream.Boundaries.Source source18(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-310,-30},{-290,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink18(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-250,-30},{-230,-10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_eta_is(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-280,-30},{-260,-10}})));
  ThermofluidStream.Boundaries.Source source19(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-310,-70},{-290,-50}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink19(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-250,-70},{-230,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_eta_is(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-280,-70},{-260,-50}})));
  ThermofluidStream.Boundaries.Source source20(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-310,-110},{-290,-90}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink20(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-250,-110},{-230,-90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_eta_is(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-280,-110},{-260,-90}})));
  ThermofluidStream.Boundaries.Source source21(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-210,130},{-190,150}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink21(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-150,130},{-130,150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_T_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-180,130},{-160,150}})));
  ThermofluidStream.Boundaries.Source source22(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-210,90},{-190,110}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink22(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-150,90},{-130,110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_T_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-180,90},{-160,110}})));
  ThermofluidStream.Boundaries.Source source23(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-210,50},{-190,70}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink23(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-150,50},{-130,70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_T_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-180,50},{-160,70}})));
  ThermofluidStream.Boundaries.Source source25(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-210,-30},{-190,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink25(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-150,-30},{-130,-10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_T_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-180,-30},{-160,-10}})));
  ThermofluidStream.Boundaries.Source source26(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-210,-70},{-190,-50}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink26(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-150,-70},{-130,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_T_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-180,-70},{-160,-50}})));
  ThermofluidStream.Boundaries.Source source27(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-210,-110},{-190,-90}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink27(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-150,-110},{-130,-90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_T_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-180,-110},{-160,-90}})));
  ThermofluidStream.Boundaries.Source source28(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-110,-30},{-90,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink28(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_p_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-80,-30},{-60,-10}})));
  ThermofluidStream.Boundaries.Source source29(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-110,-70},{-90,-50}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink29(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_p_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-80,-70},{-60,-50}})));
  ThermofluidStream.Boundaries.Source source30(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-110,-110},{-90,-90}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink30(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_p_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-80,-110},{-60,-90}})));
  ThermofluidStream.Boundaries.Source source24(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-110,10},{-90,30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink24(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_p_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-80,10},{-60,30}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow=P) annotation(Placement(transformation(extent={{-570,-10},{-550,10}})));

  ThermofluidStream.Boundaries.Source source31(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{70,130},{90,150}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink31(redeclare package Medium = Medium)
                                                                                           annotation (Placement(transformation(extent={{130,130},{150,150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_eta_pol1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{100,130},{120,150}})));
  ThermofluidStream.Boundaries.Source source32(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{70,90},{90,110}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink32(redeclare package Medium = Medium)
                                                                                            annotation (Placement(transformation(extent={{130,90},{150,110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_eta_pol1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{100,90},{120,110}})));
  ThermofluidStream.Boundaries.Source source33(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{70,50},{90,70}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink33(redeclare package Medium = Medium)
                                                                                            annotation (Placement(transformation(extent={{130,50},{150,70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_eta_pol1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{100,50},{120,70}})));
  ThermofluidStream.Boundaries.Source source34(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{70,10},{90,30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink34(redeclare package Medium = Medium)
                                                                                            annotation (Placement(transformation(extent={{130,10},{150,30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_eta_pol1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{100,10},{120,30}})));
  ThermofluidStream.Boundaries.Source source35(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{70,-30},{90,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink35(redeclare package Medium = Medium)
                                                                                            annotation (Placement(transformation(extent={{130,-30},{150,-10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_eta_pol1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{100,-30},{120,-10}})));
  ThermofluidStream.Boundaries.Source source36(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{70,-70},{90,-50}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink36(redeclare package Medium = Medium)
                                                                                            annotation (Placement(transformation(extent={{130,-70},{150,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_eta_pol1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{100,-70},{120,-50}})));
  ThermofluidStream.Boundaries.Source source37(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{70,-110},{90,-90}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink37(redeclare package Medium = Medium)
                                                                                            annotation (Placement(transformation(extent={{130,-110},{150,-90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_eta_pol1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{100,-110},{120,-90}})));
  ThermofluidStream.Boundaries.Source source38(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{170,130},{190,150}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink38(redeclare package Medium = Medium)
                                                                                            annotation (Placement(transformation(extent={{230,130},{250,150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_n1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{200,130},{220,150}})));
  ThermofluidStream.Boundaries.Source source39(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{170,90},{190,110}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink39(redeclare package Medium = Medium)
                                                                                            annotation (Placement(transformation(extent={{230,90},{250,110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_n1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{200,90},{220,110}})));
  ThermofluidStream.Boundaries.Source source40(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{170,50},{190,70}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink40(redeclare package Medium = Medium)
                                                                                            annotation (Placement(transformation(extent={{230,50},{250,70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_n1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{200,50},{220,70}})));
  ThermofluidStream.Boundaries.Source source41(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{170,10},{190,30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink41(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{230,10},{250,30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_n1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{200,10},{220,30}})));
  ThermofluidStream.Boundaries.Source source42(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{170,-30},{190,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink42(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{230,-30},{250,-10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_n1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{200,-30},{220,-10}})));
  ThermofluidStream.Boundaries.Source source43(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{170,-70},{190,-50}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink43(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{230,-70},{250,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_n1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{200,-70},{220,-50}})));
  ThermofluidStream.Boundaries.Source source44(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{170,-110},{190,-90}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink44(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{230,-110},{250,-90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_n1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{200,-110},{220,-90}})));
  ThermofluidStream.Boundaries.Source source45(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{270,130},{290,150}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink45(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{330,130},{350,150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_eta_is1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{300,130},{320,150}})));
  ThermofluidStream.Boundaries.Source source46(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{270,90},{290,110}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink46(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{330,90},{350,110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_eta_is1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{300,90},{320,110}})));
  ThermofluidStream.Boundaries.Source source47(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{270,50},{290,70}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink47(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{330,50},{350,70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_eta_is1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{300,50},{320,70}})));
  ThermofluidStream.Boundaries.Source source48(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{270,10},{290,30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink48(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{330,10},{350,30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_eta_is1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{300,10},{320,30}})));
  ThermofluidStream.Boundaries.Source source49(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{270,-30},{290,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink49(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{330,-30},{350,-10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_eta_is1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{300,-30},{320,-10}})));
  ThermofluidStream.Boundaries.Source source50(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{270,-70},{290,-50}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink50(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{330,-70},{350,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_eta_is1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{300,-70},{320,-50}})));
  ThermofluidStream.Boundaries.Source source51(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{270,-110},{290,-90}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink51(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{330,-110},{350,-90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_eta_is1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{300,-110},{320,-90}})));
  ThermofluidStream.Boundaries.Source source52(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{370,130},{390,150}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink52(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{430,130},{450,150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_T_out1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{400,130},{420,150}})));
  ThermofluidStream.Boundaries.Source source53(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{370,90},{390,110}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink53(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{430,90},{450,110}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_T_out1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{400,90},{420,110}})));
  ThermofluidStream.Boundaries.Source source54(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{370,50},{390,70}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink54(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{430,50},{450,70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_T_out1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{400,50},{420,70}})));
  ThermofluidStream.Boundaries.Source source55(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{370,-30},{390,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink55(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{430,-30},{450,-10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_T_out1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{400,-30},{420,-10}})));
  ThermofluidStream.Boundaries.Source source56(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{370,-70},{390,-50}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink56(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{430,-70},{450,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_T_out1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{400,-70},{420,-50}})));
  ThermofluidStream.Boundaries.Source source57(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{370,-110},{390,-90}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink57(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{430,-110},{450,-90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_T_out1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{400,-110},{420,-90}})));
  ThermofluidStream.Boundaries.Source source58(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{470,-30},{490,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink58(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{530,-30},{550,-10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_p_out1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{500,-30},{520,-10}})));
  ThermofluidStream.Boundaries.Source source59(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{470,-70},{490,-50}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink59(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{530,-70},{550,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_p_out1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{500,-70},{520,-50}})));
  ThermofluidStream.Boundaries.Source source60(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{470,-110},{490,-90}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink60(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{530,-110},{550,-90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_p_out1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{500,-110},{520,-90}})));
  ThermofluidStream.Boundaries.Source source61(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{470,10},{490,30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink61(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{530,10},{550,30}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_p_out1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{500,10},{520,30}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource1(E_flow=P)
                                                                annotation(Placement(transformation(extent={{10,-10},{30,10}})));
equation
  connect(source.outlet, dp_eta_pol.inlet) annotation(Line(
      points={{-490,140},{-480,140}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_pol.outlet, sink.inlet) annotation(Line(
      points={{-460,140},{-450,140}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, pRatio_eta_pol.inlet) annotation(Line(
      points={{-490,100},{-480,100}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_eta_pol.outlet, sink1.inlet) annotation(Line(
      points={{-460,100},{-450,100}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, p_out_eta_pol.inlet) annotation(Line(
      points={{-490,60},{-480,60}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_eta_pol.outlet, sink2.inlet) annotation(Line(
      points={{-460,60},{-450,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, T_out_eta_pol.inlet) annotation(Line(
      points={{-490,20},{-480,20}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_eta_pol.outlet, sink3.inlet) annotation(Line(
      points={{-460,20},{-450,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, rhoRatio_eta_pol.inlet) annotation(Line(
      points={{-490,-20},{-480,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_eta_pol.outlet, sink4.inlet) annotation(Line(
      points={{-460,-20},{-450,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, rho_out_eta_pol.inlet) annotation(Line(
      points={{-490,-60},{-480,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_eta_pol.outlet, sink5.inlet) annotation(Line(
      points={{-460,-60},{-450,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, v_out_eta_pol.inlet) annotation(Line(
      points={{-490,-100},{-480,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_eta_pol.outlet, sink6.inlet) annotation(Line(
      points={{-460,-100},{-450,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, dp_n.inlet) annotation(Line(
      points={{-390,140},{-380,140}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_n.outlet, sink7.inlet) annotation(Line(
      points={{-360,140},{-350,140}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, pRatio_n.inlet) annotation(Line(
      points={{-390,100},{-380,100}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_n.outlet, sink8.inlet) annotation(Line(
      points={{-360,100},{-350,100}},
      color={28,108,200},
      thickness=0.5));
  connect(source9.outlet, p_out_n.inlet) annotation(Line(
      points={{-390,60},{-380,60}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_n.outlet, sink9.inlet) annotation(Line(
      points={{-360,60},{-350,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source10.outlet, T_out_n.inlet) annotation(Line(
      points={{-390,20},{-380,20}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_n.outlet, sink10.inlet) annotation(Line(
      points={{-360,20},{-350,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source11.outlet, rhoRatio_n.inlet) annotation(Line(
      points={{-390,-20},{-380,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_n.outlet, sink11.inlet) annotation(Line(
      points={{-360,-20},{-350,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source12.outlet, rho_out_n.inlet) annotation(Line(
      points={{-390,-60},{-380,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_n.outlet, sink12.inlet) annotation(Line(
      points={{-360,-60},{-350,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source13.outlet, v_out_n.inlet) annotation(Line(
      points={{-390,-100},{-380,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_n.outlet, sink13.inlet) annotation(Line(
      points={{-360,-100},{-350,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source14.outlet, dp_eta_is.inlet) annotation(Line(
      points={{-290,140},{-280,140}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_is.outlet, sink14.inlet) annotation(Line(
      points={{-260,140},{-250,140}},
      color={28,108,200},
      thickness=0.5));
  connect(source15.outlet, pRatio_eta_is.inlet) annotation(Line(
      points={{-290,100},{-280,100}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_eta_is.outlet, sink15.inlet) annotation(Line(
      points={{-260,100},{-250,100}},
      color={28,108,200},
      thickness=0.5));
  connect(source16.outlet, p_out_eta_is.inlet) annotation(Line(
      points={{-290,60},{-280,60}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_eta_is.outlet, sink16.inlet) annotation(Line(
      points={{-260,60},{-250,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source17.outlet, T_out_eta_is.inlet) annotation(Line(
      points={{-290,20},{-280,20}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_eta_is.outlet, sink17.inlet) annotation(Line(
      points={{-260,20},{-250,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source18.outlet, rhoRatio_eta_is.inlet) annotation(Line(
      points={{-290,-20},{-280,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_eta_is.outlet, sink18.inlet) annotation(Line(
      points={{-260,-20},{-250,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source19.outlet, rho_out_eta_is.inlet) annotation(Line(
      points={{-290,-60},{-280,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_eta_is.outlet, sink19.inlet) annotation(Line(
      points={{-260,-60},{-250,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source20.outlet, v_out_eta_is.inlet) annotation(Line(
      points={{-290,-100},{-280,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_eta_is.outlet, sink20.inlet) annotation(Line(
      points={{-260,-100},{-250,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source21.outlet, dp_T_out.inlet) annotation(Line(
      points={{-190,140},{-180,140}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_T_out.outlet, sink21.inlet) annotation(Line(
      points={{-160,140},{-150,140}},
      color={28,108,200},
      thickness=0.5));
  connect(source22.outlet, pRatio_T_out.inlet) annotation(Line(
      points={{-190,100},{-180,100}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_T_out.outlet, sink22.inlet) annotation(Line(
      points={{-160,100},{-150,100}},
      color={28,108,200},
      thickness=0.5));
  connect(source23.outlet, p_out_T_out.inlet) annotation(Line(
      points={{-190,60},{-180,60}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_T_out.outlet, sink23.inlet) annotation(Line(
      points={{-160,60},{-150,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source25.outlet, rhoRatio_T_out.inlet) annotation(Line(
      points={{-190,-20},{-180,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_T_out.outlet, sink25.inlet) annotation(Line(
      points={{-160,-20},{-150,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source26.outlet, rho_out_T_out.inlet) annotation(Line(
      points={{-190,-60},{-180,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_T_out.outlet, sink26.inlet) annotation(Line(
      points={{-160,-60},{-150,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source27.outlet, v_out_T_out.inlet) annotation(Line(
      points={{-190,-100},{-180,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_T_out.outlet, sink27.inlet) annotation(Line(
      points={{-160,-100},{-150,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source28.outlet, rhoRatio_p_out.inlet) annotation(Line(
      points={{-90,-20},{-80,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_p_out.outlet, sink28.inlet) annotation(Line(
      points={{-60,-20},{-50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source29.outlet, rho_out_p_out.inlet) annotation(Line(
      points={{-90,-60},{-80,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_p_out.outlet, sink29.inlet) annotation(Line(
      points={{-60,-60},{-50,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source30.outlet, v_out_p_out.inlet) annotation(Line(
      points={{-90,-100},{-80,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_p_out.outlet, sink30.inlet) annotation(Line(
      points={{-60,-100},{-50,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source24.outlet, T_out_p_out.inlet) annotation(Line(
      points={{-90,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_p_out.outlet, sink24.inlet) annotation(Line(
      points={{-60,20},{-50,20}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_pol.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-470,132},{-470,120},{-530,120},{-530,0},{-549,0}}, color={255,170,85}));
  connect(pRatio_eta_pol.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-470,92},{-470,80},{-530,80},{-530,0},{-549,0}},  color={255,170,85}));
  connect(p_out_eta_pol.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-470,52},{-470,40},{-530,40},{-530,0},{-549,0}}, color={255,170,85}));
  connect(T_out_eta_pol.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-470,12},{-470,0},{-549,0}},                     color={255,170,85}));
  connect(v_out_eta_pol.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-470,-108},{-470,-120},{-530,-120},{-530,0},{-549,0}},color={255,170,85}));
  connect(rho_out_eta_pol.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-470,-68},{-470,-80},{-530,-80},{-530,0},{-549,0}}, color={255,170,85}));
  connect(rhoRatio_eta_pol.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-470,-28},{-470,-38},{-530,-38},{-530,0},{-549,0}}, color={255,170,85}));
  connect(dp_T_out.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-170,132},{-170,120},{-530,120},{-530,0},{-549,0}},
                                                                                                                                 color={255,170,85}));
  connect(dp_eta_is.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-270,132},{-270,120},{-530,120},{-530,0},{-549,0}},
                                                                                                                              color={255,170,85}));
  connect(dp_n.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-370,132},{-370,120},{-530,120},{-530,0},{-549,0}}, color={255,170,85}));
  connect(pRatio_T_out.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-170,92},{-170,80},{-530,80},{-530,0},{-549,0}},color={255,170,85}));
  connect(pRatio_n.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-370,92},{-370,80},{-530,80},{-530,0},{-549,0}},  color={255,170,85}));
  connect(pRatio_eta_is.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-270,92},{-270,80},{-530,80},{-530,0},{-549,0}},
                                                                                                                                color={255,170,85}));
  connect(p_out_T_out.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-170,52},{-170,40},{-530,40},{-530,0},{-549,0}},
                                                                                                                                 color={255,170,85}));
  connect(p_out_n.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-370,52},{-370,40},{-530,40},{-530,0},{-549,0}}, color={255,170,85}));
  connect(p_out_eta_is.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-270,52},{-270,40},{-530,40},{-530,0},{-549,0}},
                                                                                                                              color={255,170,85}));
  connect(T_out_p_out.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-70,12},{-70,0},{-549,0}},                     color={255,170,85}));
  connect(T_out_n.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-370,12},{-370,0},{-549,0}},                     color={255,170,85}));
  connect(T_out_eta_is.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-270,12},{-270,0},{-549,0}},               color={255,170,85}));
  connect(rhoRatio_p_out.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-70,-28},{-70,-38},{-530,-38},{-530,0},{-549,0}}, color={255,170,85}));
  connect(rhoRatio_n.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-370,-28},{-370,-38},{-530,-38},{-530,0},{-549,0}}, color={255,170,85}));
  connect(rhoRatio_eta_is.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-270,-28},{-270,-38},{-530,-38},{-530,0},{-549,0}},
                                                                                                                                    color={255,170,85}));
  connect(rhoRatio_T_out.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-170,-28},{-170,-38},{-530,-38},{-530,0},{-549,0}},
                                                                                                                                       color={255,170,85}));
  connect(rho_out_p_out.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-70,-68},{-70,-80},{-530,-80},{-530,0},{-549,0}}, color={255,170,85}));
  connect(rho_out_n.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-370,-68},{-370,-80},{-530,-80},{-530,0},{-549,0}}, color={255,170,85}));
  connect(rho_out_eta_is.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-270,-68},{-270,-80},{-530,-80},{-530,0},{-549,0}},
                                                                                                                                   color={255,170,85}));
  connect(rho_out_T_out.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-170,-68},{-170,-80},{-530,-80},{-530,0},{-549,0}},
                                                                                                                                      color={255,170,85}));
  connect(v_out_p_out.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-70,-108},{-70,-120},{-530,-120},{-530,0},{-549,0}},color={255,170,85}));
  connect(v_out_n.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-370,-108},{-370,-120},{-530,-120},{-530,0},{-549,0}},color={255,170,85}));
  connect(v_out_eta_is.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-270,-108},{-270,-120},{-530,-120},{-530,0},{-549,0}},
                                                                                                                                   color={255,170,85}));
  connect(v_out_T_out.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-170,-108},{-170,-120},{-530,-120},{-530,0},{-549,0}},
                                                                                                                                      color={255,170,85}));

  connect(source31.outlet, dp_eta_pol1.inlet) annotation (Line(
      points={{90,140},{100,140}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_pol1.outlet, sink31.inlet) annotation (Line(
      points={{120,140},{130,140}},
      color={28,108,200},
      thickness=0.5));
  connect(source32.outlet, pRatio_eta_pol1.inlet) annotation (Line(
      points={{90,100},{100,100}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_eta_pol1.outlet, sink32.inlet) annotation (Line(
      points={{120,100},{130,100}},
      color={28,108,200},
      thickness=0.5));
  connect(source33.outlet, p_out_eta_pol1.inlet) annotation (Line(
      points={{90,60},{100,60}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_eta_pol1.outlet, sink33.inlet) annotation (Line(
      points={{120,60},{130,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source34.outlet, T_out_eta_pol1.inlet) annotation (Line(
      points={{90,20},{100,20}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_eta_pol1.outlet, sink34.inlet) annotation (Line(
      points={{120,20},{130,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source35.outlet, rhoRatio_eta_pol1.inlet) annotation (Line(
      points={{90,-20},{100,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_eta_pol1.outlet, sink35.inlet) annotation (Line(
      points={{120,-20},{130,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source36.outlet, rho_out_eta_pol1.inlet) annotation (Line(
      points={{90,-60},{100,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_eta_pol1.outlet, sink36.inlet) annotation (Line(
      points={{120,-60},{130,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source37.outlet, v_out_eta_pol1.inlet) annotation (Line(
      points={{90,-100},{100,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_eta_pol1.outlet, sink37.inlet) annotation (Line(
      points={{120,-100},{130,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source38.outlet, dp_n1.inlet) annotation (Line(
      points={{190,140},{200,140}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_n1.outlet, sink38.inlet) annotation (Line(
      points={{220,140},{230,140}},
      color={28,108,200},
      thickness=0.5));
  connect(source39.outlet, pRatio_n1.inlet) annotation (Line(
      points={{190,100},{200,100}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_n1.outlet, sink39.inlet) annotation (Line(
      points={{220,100},{230,100}},
      color={28,108,200},
      thickness=0.5));
  connect(source40.outlet, p_out_n1.inlet) annotation (Line(
      points={{190,60},{200,60}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_n1.outlet, sink40.inlet) annotation (Line(
      points={{220,60},{230,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source41.outlet, T_out_n1.inlet) annotation (Line(
      points={{190,20},{200,20}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_n1.outlet, sink41.inlet) annotation (Line(
      points={{220,20},{230,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source42.outlet, rhoRatio_n1.inlet) annotation (Line(
      points={{190,-20},{200,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_n1.outlet, sink42.inlet) annotation (Line(
      points={{220,-20},{230,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source43.outlet, rho_out_n1.inlet) annotation (Line(
      points={{190,-60},{200,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_n1.outlet, sink43.inlet) annotation (Line(
      points={{220,-60},{230,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source44.outlet, v_out_n1.inlet) annotation (Line(
      points={{190,-100},{200,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_n1.outlet, sink44.inlet) annotation (Line(
      points={{220,-100},{230,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source45.outlet, dp_eta_is1.inlet) annotation (Line(
      points={{290,140},{300,140}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_is1.outlet, sink45.inlet) annotation (Line(
      points={{320,140},{330,140}},
      color={28,108,200},
      thickness=0.5));
  connect(source46.outlet, pRatio_eta_is1.inlet) annotation (Line(
      points={{290,100},{300,100}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_eta_is1.outlet, sink46.inlet) annotation (Line(
      points={{320,100},{330,100}},
      color={28,108,200},
      thickness=0.5));
  connect(source47.outlet, p_out_eta_is1.inlet) annotation (Line(
      points={{290,60},{300,60}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_eta_is1.outlet, sink47.inlet) annotation (Line(
      points={{320,60},{330,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source48.outlet, T_out_eta_is1.inlet) annotation (Line(
      points={{290,20},{300,20}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_eta_is1.outlet, sink48.inlet) annotation (Line(
      points={{320,20},{330,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source49.outlet, rhoRatio_eta_is1.inlet) annotation (Line(
      points={{290,-20},{300,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_eta_is1.outlet, sink49.inlet) annotation (Line(
      points={{320,-20},{330,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source50.outlet, rho_out_eta_is1.inlet) annotation (Line(
      points={{290,-60},{300,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_eta_is1.outlet, sink50.inlet) annotation (Line(
      points={{320,-60},{330,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source51.outlet, v_out_eta_is1.inlet) annotation (Line(
      points={{290,-100},{300,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_eta_is1.outlet, sink51.inlet) annotation (Line(
      points={{320,-100},{330,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source52.outlet, dp_T_out1.inlet) annotation (Line(
      points={{390,140},{400,140}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_T_out1.outlet, sink52.inlet) annotation (Line(
      points={{420,140},{430,140}},
      color={28,108,200},
      thickness=0.5));
  connect(source53.outlet, pRatio_T_out1.inlet) annotation (Line(
      points={{390,100},{400,100}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_T_out1.outlet, sink53.inlet) annotation (Line(
      points={{420,100},{430,100}},
      color={28,108,200},
      thickness=0.5));
  connect(source54.outlet, p_out_T_out1.inlet) annotation (Line(
      points={{390,60},{400,60}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_T_out1.outlet, sink54.inlet) annotation (Line(
      points={{420,60},{430,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source55.outlet, rhoRatio_T_out1.inlet) annotation (Line(
      points={{390,-20},{400,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_T_out1.outlet, sink55.inlet) annotation (Line(
      points={{420,-20},{430,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source56.outlet, rho_out_T_out1.inlet) annotation (Line(
      points={{390,-60},{400,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_T_out1.outlet, sink56.inlet) annotation (Line(
      points={{420,-60},{430,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source57.outlet, v_out_T_out1.inlet) annotation (Line(
      points={{390,-100},{400,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_T_out1.outlet, sink57.inlet) annotation (Line(
      points={{420,-100},{430,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source58.outlet, rhoRatio_p_out1.inlet) annotation (Line(
      points={{490,-20},{500,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_p_out1.outlet, sink58.inlet) annotation (Line(
      points={{520,-20},{530,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source59.outlet, rho_out_p_out1.inlet) annotation (Line(
      points={{490,-60},{500,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_p_out1.outlet, sink59.inlet) annotation (Line(
      points={{520,-60},{530,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source60.outlet, v_out_p_out1.inlet) annotation (Line(
      points={{490,-100},{500,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_p_out1.outlet, sink60.inlet) annotation (Line(
      points={{520,-100},{530,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source61.outlet, T_out_p_out1.inlet) annotation (Line(
      points={{490,20},{500,20}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_p_out1.outlet, sink61.inlet) annotation (Line(
      points={{520,20},{530,20}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_pol1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{110,132},{110,120},{50,120},{50,0},{31,0}}, color={255,170,85}));
  connect(pRatio_eta_pol1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{110,92},{110,80},{50,80},{50,0},{31,0}}, color={255,170,85}));
  connect(p_out_eta_pol1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{110,52},{110,40},{50,40},{50,0},{31,0}}, color={255,170,85}));
  connect(T_out_eta_pol1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{110,12},{110,0},{31,0}}, color={255,170,85}));
  connect(v_out_eta_pol1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{110,-108},{110,-120},{50,-120},{50,0},{31,0}}, color={255,170,85}));
  connect(rho_out_eta_pol1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{110,-68},{110,-80},{50,-80},{50,0},{31,0}}, color={255,170,85}));
  connect(rhoRatio_eta_pol1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{110,-28},{110,-38},{50,-38},{50,0},{31,0}}, color={255,170,85}));
  connect(dp_T_out1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{410,132},{410,120},{50,120},{50,0},{31,0}}, color={255,170,85}));
  connect(dp_eta_is1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{310,132},{310,120},{50,120},{50,0},{31,0}}, color={255,170,85}));
  connect(dp_n1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{210,132},{210,120},{50,120},{50,0},{31,0}}, color={255,170,85}));
  connect(pRatio_T_out1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{410,92},{410,80},{50,80},{50,0},{31,0}}, color={255,170,85}));
  connect(pRatio_n1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{210,92},{210,80},{50,80},{50,0},{31,0}}, color={255,170,85}));
  connect(pRatio_eta_is1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{310,92},{310,80},{50,80},{50,0},{31,0}}, color={255,170,85}));
  connect(p_out_T_out1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{410,52},{410,40},{50,40},{50,0},{31,0}}, color={255,170,85}));
  connect(p_out_n1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{210,52},{210,40},{50,40},{50,0},{31,0}}, color={255,170,85}));
  connect(p_out_eta_is1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{310,52},{310,40},{50,40},{50,0},{31,0}}, color={255,170,85}));
  connect(T_out_p_out1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{510,12},{510,0},{31,0}}, color={255,170,85}));
  connect(T_out_n1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{210,12},{210,0},{31,0}}, color={255,170,85}));
  connect(T_out_eta_is1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{310,12},{310,0},{31,0}}, color={255,170,85}));
  connect(rhoRatio_p_out1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{510,-28},{510,-38},{50,-38},{50,0},{31,0}}, color={255,170,85}));
  connect(rhoRatio_n1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{210,-28},{210,-38},{50,-38},{50,0},{31,0}}, color={255,170,85}));
  connect(rhoRatio_eta_is1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{310,-28},{310,-38},{50,-38},{50,0},{31,0}}, color={255,170,85}));
  connect(rhoRatio_T_out1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{410,-28},{410,-38},{50,-38},{50,0},{31,0}}, color={255,170,85}));
  connect(rho_out_p_out1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{510,-68},{510,-80},{50,-80},{50,0},{31,0}}, color={255,170,85}));
  connect(rho_out_n1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{210,-68},{210,-80},{50,-80},{50,0},{31,0}}, color={255,170,85}));
  connect(rho_out_eta_is1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{310,-68},{310,-80},{50,-80},{50,0},{31,0}}, color={255,170,85}));
  connect(rho_out_T_out1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{410,-68},{410,-80},{50,-80},{50,0},{31,0}}, color={255,170,85}));
  connect(v_out_p_out1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{510,-108},{510,-120},{50,-120},{50,0},{31,0}}, color={255,170,85}));
  connect(v_out_n1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{210,-108},{210,-120},{50,-120},{50,0},{31,0}}, color={255,170,85}));
  connect(v_out_eta_is1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{310,-108},{310,-120},{50,-120},{50,0},{31,0}}, color={255,170,85}));
  connect(v_out_T_out1.P_in, energyFlowSource1.E_flow_out) annotation (Line(points={{410,-108},{410,-120},{50,-120},{50,0},{31,0}}, color={255,170,85}));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-580,-180},{560,180}})),
    Documentation(
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> process defined by parameters (outlet state and power given).
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
