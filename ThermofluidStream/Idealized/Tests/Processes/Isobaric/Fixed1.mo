within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model Fixed1 "Example - Isobaric process"

  extends ThermofluidStream.Idealized.Tests.Processes.Isobaric.PartialFixed;
  extends Modelica.Icons.Example;

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{100,80},{120,100}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-200,20},{-180,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-140,20},{-120,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-170,20},{-150,40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-100,20},{-80,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-70,20},{-50,40}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{20,20},{40,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{80,20},{100,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{50,20},{70,40}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{120,20},{140,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{180,20},{200,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{150,20},{170,40}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-200,-40},{-180,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink8(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT1c(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-170,-40},{-150,-20}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-100,-40},{-80,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink10(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out1c(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{-70,-40},{-50,-20}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{20,-40},{40,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink11(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh1c(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{50,-40},{70,-20}})));
  ThermofluidStream.Boundaries.Source source12(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{120,-40},{140,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink12(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{180,-40},{200,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out1c(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out,
    dh_fixed=dh,
    p_inf=p_inf,
    h_out_fixed=h_out) annotation(Placement(transformation(extent={{150,-40},{170,-20}})));

equation
  connect(source.outlet, dT1.inlet) annotation(Line(
      points={{-180,30},{-170,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet, sink.inlet) annotation(Line(
      points={{-150,30},{-140,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, T_out1.inlet) annotation(Line(
      points={{-80,30},{-70,30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet, sink1.inlet) annotation(Line(
      points={{-50,30},{-40,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, dh1.inlet) annotation(Line(
      points={{40,30},{50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dh1.outlet, sink2.inlet) annotation(Line(
      points={{70,30},{80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, h_out1.inlet) annotation(Line(
      points={{140,30},{150,30}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out1.outlet, sink3.inlet) annotation(Line(
      points={{170,30},{180,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source9.outlet, dT1c.inlet) annotation(Line(
      points={{-180,-30},{-170,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1c.outlet, sink8.inlet) annotation(Line(
      points={{-150,-30},{-140,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source10.outlet, T_out1c.inlet) annotation(Line(
      points={{-80,-30},{-70,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1c.outlet, sink10.inlet) annotation(Line(
      points={{-50,-30},{-40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source11.outlet, dh1c.inlet) annotation(Line(
      points={{40,-30},{50,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(dh1c.outlet, sink11.inlet) annotation(Line(
      points={{70,-30},{80,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source12.outlet, h_out1c.inlet) annotation(Line(
      points={{140,-30},{150,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out1c.outlet, sink12.inlet) annotation(Line(
      points={{170,-30},{180,-30}},
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
        extent={{-220,-100},{220,100}})),
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
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isobaric\">Isobaric</a> process for heat transfer defined by parameters (outlet state and mass flow rate given).
  </p>
</html>"));
end Fixed1;
