within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model Fixed2 "Example - Isobaric process"
  extends ThermofluidStream.Idealized.Tests.Processes.Isobaric.PartialFixed;
  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{-190,40},{-170,60}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-130,40},{-110,60}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-160,40},{-140,60}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow=Q_flow) annotation(Placement(transformation(extent={{-190,10},{-170,30}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-90,40},{-70,60}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-60,40},{-40,60}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{10,40},{30,60}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{70,40},{90,60}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{40,40},{60,60}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{110,40},{130,60}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{170,40},{190,60}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{140,40},{160,60}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{-190,-30},{-170,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink4(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-130,-30},{-110,-10}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT1c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-160,-30},{-140,-10}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource1(E_flow=Q_flow)
                                                                    annotation(Placement(transformation(extent={{-190,-60},{-170,-40}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink5(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out1c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-60,-30},{-40,-10}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink6(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh1c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{110,-30},{130,-10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink7(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{170,-30},{190,-10}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out1c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{140,-30},{160,-10}})));

equation
  connect(source.outlet, dT1.inlet) annotation (Line(
      points={{-170,50},{-160,50}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet, sink.inlet) annotation (Line(
      points={{-140,50},{-130,50}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out,dT1. Q_flow_in) annotation(Line(points={{-169,20},{-150,20},{-150,42}},   color={255,170,85}));
  connect(source1.outlet,T_out1. inlet) annotation(Line(
      points={{-70,50},{-60,50}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet,sink1. inlet) annotation(Line(
      points={{-40,50},{-30,50}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out,T_out1. Q_flow_in) annotation(Line(points={{-169,20},{-50,20},{-50,42}},     color={255,170,85}));
  connect(source2.outlet,dh1. inlet) annotation(Line(
      points={{30,50},{40,50}},
      color={28,108,200},
      thickness=0.5));
  connect(dh1.outlet,sink2. inlet) annotation(Line(
      points={{60,50},{70,50}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out,dh1. Q_flow_in) annotation(Line(points={{-169,20},{50,20},{50,42}},       color={255,170,85}));
  connect(source3.outlet,h_out1. inlet) annotation(Line(
      points={{130,50},{140,50}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out1.outlet,sink3. inlet) annotation(Line(
      points={{160,50},{170,50}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out,h_out1. Q_flow_in) annotation(Line(points={{-169,20},{150,20},{150,42}},   color={255,170,85}));
  connect(source4.outlet, dT1c.inlet) annotation (Line(
      points={{-170,-20},{-160,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1c.outlet, sink4.inlet) annotation (Line(
      points={{-140,-20},{-130,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource1.E_flow_out,dT1c. Q_flow_in) annotation(Line(points={{-169,-50},{-150,-50},{-150,-28}},
                                                                                                            color={255,170,85}));
  connect(source5.outlet, T_out1c.inlet) annotation (Line(
      points={{-70,-20},{-60,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1c.outlet, sink5.inlet) annotation (Line(
      points={{-40,-20},{-30,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource1.E_flow_out,T_out1c. Q_flow_in) annotation(Line(points={{-169,-50},{-50,-50},{-50,-28}},
                                                                                                                 color={255,170,85}));
  connect(source6.outlet, dh1c.inlet) annotation (Line(
      points={{30,-20},{40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(dh1c.outlet, sink6.inlet) annotation (Line(
      points={{60,-20},{70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource1.E_flow_out,dh1c. Q_flow_in) annotation(Line(points={{-169,-50},{50,-50},{50,-28}},color={255,170,85}));
  connect(source7.outlet, h_out1c.inlet) annotation (Line(
      points={{130,-20},{140,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out1c.outlet, sink7.inlet) annotation (Line(
      points={{160,-20},{170,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource1.E_flow_out,h_out1c. Q_flow_in) annotation(Line(points={{-169,-50},{150,-50},{150,-28}},
                                                                                                                 color={255,170,85}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-200,-100},{220,100}})),
    Documentation(
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>",
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isobaric\">Isobaric</a> process for heat transfer defined by parameters (outlet state and heat flow rate given).
  </p>   
</html>"));
end Fixed2;
