within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model FixedAdvanced "Example - Isochoric process"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconInertanceNeglect;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  parameter SI.MassFlowRate m_flow=1   "Mass flow rate";
  parameter Medium.AbsolutePressure p=200000 "Pressure (inlet = outlet)";
  parameter Medium.Temperature T_in=293.15 "Inlet temperature";
  parameter SI.TemperatureDifference dT=0    "Temperature difference";
  parameter SI.AbsolutePressure p_inf=100000   "Ambient pressure";

  final parameter Medium.Temperature T_out = T_in + dT "Outlet temperature";

  final parameter Medium.ThermodynamicState state_in = Medium.setState_pTX(p, T_in, Medium.X_default) "Inlet state";
  final parameter Medium.ThermodynamicState state_out = Medium.setState_pTX(p, T_out, Medium.X_default) "Outlet state";

  final parameter Medium.Density rho_in = Medium.density(state_in) "Inlet density";
  final parameter Medium.Density rho_out = Medium.density(state_in) "Outlet density";

  final parameter SI.SpecificVolume v_in = 1/rho_in "Inlet density";
  final parameter SI.SpecificVolume v_out = 1/rho_out "Outlet density";

  final parameter Medium.SpecificEnthalpy h_in = Medium.specificEnthalpy(state_in) "Inlet specific enthalpy";
  final parameter Medium.SpecificEnthalpy h_out = Medium.specificEnthalpy(state_out) "Outlet specific enthalpy";
  final parameter Medium.SpecificEnthalpy dh = h_out - h_in "Specific enthalpy difference";

  final parameter Medium.SpecificEnergy q = dh "Specific heat flow rate";
  final parameter SI.HeatFlowRate Q_flow = m_flow*q "Heat flow rate";

  // Periodic closed cycle system process
  final parameter Medium.SpecificEnergy u_in = h_in - p/rho_in "Inlet specific internal energy";
  final parameter Medium.SpecificEnergy u_out = h_out - p/rho_out "Outlet specific internal energy";
  final parameter Medium.SpecificEnergy du = u_out - u_in "Specific internal energy difference";
  final parameter SI.SpecificEnergy w_exp = - p*(v_out - v_in)  "Specific expansion work";
  final parameter SI.SpecificEnergy w_amb = - p_inf*(v_out - v_in) "Specific ambient pressure work";
  final parameter SI.SpecificEnergy w_exp_net = w_exp - w_amb  "Net specific expansion work";
  final parameter SI.Power P = m_flow*w_exp_net "Net power (net expansion work flow rate)";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{300,80},{320,100}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-420,30},{-400,50}})));
  Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{-360,30},{-340,50}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-390,30},{-370,50}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-320,30},{-300,50}})));
  Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{-260,30},{-240,50}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-290,30},{-270,50}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-200,30},{-180,50}})));
  Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{-140,30},{-120,50}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-170,30},{-150,50}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-100,30},{-80,50}})));
  Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{-40,30},{-20,50}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-70,30},{-50,50}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-420,-10},{-400,10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium, considerInertance=false)
                                                                                         annotation(Placement(transformation(extent={{-360,-10},{-340,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT2(
    redeclare package Medium = Medium,
    considerInertance=false,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-390,-10},{-370,10}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow=Q_flow) annotation(Placement(transformation(extent={{-420,-40},{-400,-20}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-320,-10},{-300,10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink5(redeclare package Medium = Medium, considerInertance=false)
                                                                                         annotation(Placement(transformation(extent={{-260,-10},{-240,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out2(
    redeclare package Medium = Medium,
    considerInertance=false,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-290,-10},{-270,10}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-200,-10},{-180,10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink6(redeclare package Medium = Medium, considerInertance=false)
                                                                                         annotation(Placement(transformation(extent={{-140,-10},{-120,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh2(
    redeclare package Medium = Medium,
    considerInertance=false,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-170,-10},{-150,10}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-100,-10},{-80,10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink7(redeclare package Medium = Medium, considerInertance=false)
                                                                                         annotation(Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out2(
    redeclare package Medium = Medium,
    considerInertance=false,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-70,-10},{-50,10}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-260,-70},{-240,-50}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT3(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-230,-50},{-210,-70}})));
  Boundaries.Sink_m sink9(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{-200,-70},{-180,-50}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{20,30},{40,50}})));
  Boundaries.Sink_m sink8(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{80,30},{100,50}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT1c(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{50,30},{70,50}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{120,30},{140,50}})));
  Boundaries.Sink_m sink10(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{180,30},{200,50}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out1c(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{150,30},{170,50}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{240,30},{260,50}})));
  Boundaries.Sink_m sink11(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{300,30},{320,50}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh1c(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{270,30},{290,50}})));
  ThermofluidStream.Boundaries.Source source12(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{340,30},{360,50}})));
  Boundaries.Sink_m sink12(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{400,30},{420,50}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out1c(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{370,30},{390,50}})));
  ThermofluidStream.Boundaries.Source source13(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{20,-10},{40,10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink13(redeclare package Medium = Medium, considerInertance=false)
                                                                                          annotation(Placement(transformation(extent={{80,-10},{100,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT2c(
    redeclare package Medium = Medium,
    considerInertance=false,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{50,-10},{70,10}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource1(E_flow=Q_flow)
                                                                    annotation(Placement(transformation(extent={{20,-40},{40,-20}})));
  ThermofluidStream.Boundaries.Source source14(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{120,-10},{140,10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink14(redeclare package Medium = Medium, considerInertance=false)
                                                                                          annotation(Placement(transformation(extent={{180,-10},{200,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out2c(
    redeclare package Medium = Medium,
    considerInertance=false,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{150,-10},{170,10}})));
  ThermofluidStream.Boundaries.Source source15(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{240,-10},{260,10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink15(redeclare package Medium = Medium, considerInertance=false)
                                                                                          annotation(Placement(transformation(extent={{300,-10},{320,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh2c(
    redeclare package Medium = Medium,
    considerInertance=false,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{270,-10},{290,10}})));
  ThermofluidStream.Boundaries.Source source16(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{340,-10},{360,10}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink16(redeclare package Medium = Medium, considerInertance=false)
                                                                                          annotation(Placement(transformation(extent={{400,-10},{420,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out2c(
    redeclare package Medium = Medium,
    considerInertance=false,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{370,-10},{390,10}})));
  ThermofluidStream.Boundaries.Source source17(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{180,-70},{200,-50}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT3c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{210,-50},{230,-70}})));
  Boundaries.Sink_m sink17(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{240,-70},{260,-50}})));

equation
  connect(source.outlet, dT1.inlet) annotation(Line(
      points={{-400,40},{-390,40}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet, sink.inlet) annotation(Line(
      points={{-370,40},{-360,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, T_out1.inlet) annotation(Line(
      points={{-300,40},{-290,40}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet, sink1.inlet) annotation(Line(
      points={{-270,40},{-260,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, dh1.inlet) annotation(Line(
      points={{-180,40},{-170,40}},
      color={28,108,200},
      thickness=0.5));
  connect(dh1.outlet, sink2.inlet) annotation(Line(
      points={{-150,40},{-140,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, h_out1.inlet) annotation(Line(
      points={{-80,40},{-70,40}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out1.outlet, sink3.inlet) annotation(Line(
      points={{-50,40},{-40,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, dT2.inlet) annotation(Line(
      points={{-400,0},{-390,0}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outlet, sink4.inlet) annotation(Line(
      points={{-370,0},{-360,0}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, dT2.Q_flow_in) annotation(Line(points={{-399,-30},{-380,-30},{-380,-8}}, color={255,170,85}));
  connect(source5.outlet, T_out2.inlet) annotation(Line(
      points={{-300,0},{-290,0}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2.outlet, sink5.inlet) annotation(Line(
      points={{-270,0},{-260,0}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, T_out2.Q_flow_in) annotation(Line(points={{-399,-30},{-280,-30},{-280,-8}}, color={255,170,85}));
  connect(source6.outlet, dh2.inlet) annotation(Line(
      points={{-180,0},{-170,0}},
      color={28,108,200},
      thickness=0.5));
  connect(dh2.outlet, sink6.inlet) annotation(Line(
      points={{-150,0},{-140,0}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, dh2.Q_flow_in) annotation(Line(points={{-399,-30},{-160,-30},{-160,-8}}, color={255,170,85}));
  connect(source7.outlet, h_out2.inlet) annotation(Line(
      points={{-80,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out2.outlet, sink7.inlet) annotation(Line(
      points={{-50,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, h_out2.Q_flow_in) annotation(Line(points={{-399,-30},{-60,-30},{-60,-8}}, color={255,170,85}));
  connect(source8.outlet, dT3.inlet) annotation(Line(
      points={{-240,-60},{-230,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(dT3.outlet, sink9.inlet) annotation(Line(
      points={{-210,-60},{-200,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, dT3.Q_flow_in) annotation(Line(points={{-399,-30},{-220,-30},{-220,-52}}, color={255,170,85}));
  connect(source9.outlet, dT1c.inlet) annotation(Line(
      points={{40,40},{50,40}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1c.outlet, sink8.inlet) annotation(Line(
      points={{70,40},{80,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source10.outlet, T_out1c.inlet) annotation(Line(
      points={{140,40},{150,40}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1c.outlet, sink10.inlet) annotation(Line(
      points={{170,40},{180,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source11.outlet, dh1c.inlet) annotation(Line(
      points={{260,40},{270,40}},
      color={28,108,200},
      thickness=0.5));
  connect(dh1c.outlet, sink11.inlet) annotation(Line(
      points={{290,40},{300,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source12.outlet, h_out1c.inlet) annotation(Line(
      points={{360,40},{370,40}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out1c.outlet, sink12.inlet) annotation(Line(
      points={{390,40},{400,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source13.outlet, dT2c.inlet) annotation(Line(
      points={{40,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2c.outlet, sink13.inlet) annotation(Line(
      points={{70,0},{80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource1.E_flow_out, dT2c.Q_flow_in) annotation(Line(points={{41,-30},{60,-30},{60,-8}}, color={255,170,85}));
  connect(source14.outlet, T_out2c.inlet) annotation(Line(
      points={{140,0},{150,0}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2c.outlet, sink14.inlet) annotation(Line(
      points={{170,0},{180,0}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource1.E_flow_out, T_out2c.Q_flow_in) annotation(Line(points={{41,-30},{160,-30},{160,-8}}, color={255,170,85}));
  connect(source15.outlet, dh2c.inlet) annotation(Line(
      points={{260,0},{270,0}},
      color={28,108,200},
      thickness=0.5));
  connect(dh2c.outlet, sink15.inlet) annotation(Line(
      points={{290,0},{300,0}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource1.E_flow_out, dh2c.Q_flow_in) annotation(Line(points={{41,-30},{280,-30},{280,-8}}, color={255,170,85}));
  connect(source16.outlet, h_out2c.inlet) annotation(Line(
      points={{360,0},{370,0}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out2c.outlet, sink16.inlet) annotation(Line(
      points={{390,0},{400,0}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource1.E_flow_out, h_out2c.Q_flow_in) annotation(Line(points={{41,-30},{380,-30},{380,-8}}, color={255,170,85}));
  connect(source17.outlet, dT3c.inlet) annotation(Line(
      points={{200,-60},{210,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(dT3c.outlet, sink17.inlet) annotation(Line(
      points={{230,-60},{240,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource1.E_flow_out, dT3c.Q_flow_in) annotation(Line(points={{41,-30},{220,-30},{220,-52}}, color={255,170,85}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-440,-100},{440,100}}),
      graphics={
        Polygon(
          points={{-380,-100},{-340,-100},{-340,-80},{-360,-80},{-360,-40},{-380,-40},{-380,-100}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-350,-48},{-270,-68}},
          textColor={238,46,47},
          textString="requires considerInertance = false
see User's Guide",
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isobaric\">Isobaric</a> process for heat transfer defined by parameters in the case of <code>dT = 0</code>.
  </p>
    
  <p>
   Calculating the mass flow rate <code>m_flow := Q_flow/q</code> for <code>q = 0</code> is only supported for <code>considerInertance = false</code>.
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
end FixedAdvanced;
