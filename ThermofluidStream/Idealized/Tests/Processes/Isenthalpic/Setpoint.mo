within ThermofluidStream.Idealized.Tests.Processes.Isenthalpic;
model Setpoint
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"
    annotation (choicesAllMatching=true);

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic dpLoss(redeclare package Medium = Medium, dpLoss_fixed=20000) annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{70,106},{90,126}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{10,70},{30,90}})));
  ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{70,70},{90,90}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic dpLoss1(redeclare package Medium = Medium, outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0.2e5)
                                                               annotation (Placement(transformation(extent={{30,40},{50,60}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic prLoss(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.RelativePressureLoss,
    prLoss_fixed=0.2) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  ThermofluidStream.Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic prLoss1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.RelativePressureLoss,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=0.2)
                                                               annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  ThermofluidStream.Boundaries.Sink_m sink10(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    p_out_fixed=80000) annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
  ThermofluidStream.Boundaries.Sink_m sink11(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic p_out1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=0.8e5)
                                                               annotation (Placement(transformation(extent={{30,-120},{50,-100}})));
equation
  connect(source.outlet, dpLoss.inlet) annotation (Line(
      points={{-70,80},{-60,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dpLoss.outlet, sink.inlet) annotation (Line(
      points={{-40,80},{-30,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, dpLoss1.inlet) annotation (Line(
      points={{30,80},{40,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dpLoss1.outlet, sink1.inlet) annotation (Line(
      points={{60,80},{70,80}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression.y, dpLoss1.outletSpec_prescribed) annotation (Line(points={{51,50},{60,50},{60,68}}, color={0,0,127}));
  connect(source5.outlet, prLoss.inlet) annotation (Line(
      points={{-70,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(prLoss.outlet, sink5.inlet) annotation (Line(
      points={{-40,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, prLoss1.inlet) annotation (Line(
      points={{30,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(prLoss1.outlet, sink6.inlet) annotation (Line(
      points={{60,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression2.y, prLoss1.outletSpec_prescribed) annotation (Line(points={{51,-30},{60,-30},{60,-12}}, color={0,0,127}));
  connect(source10.outlet, p_out.inlet) annotation (Line(
      points={{-70,-80},{-60,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out.outlet, sink10.inlet) annotation (Line(
      points={{-40,-80},{-30,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source11.outlet, p_out1.inlet) annotation (Line(
      points={{30,-80},{40,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out1.outlet, sink11.inlet) annotation (Line(
      points={{60,-80},{70,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression4.y, p_out1.outletSpec_prescribed) annotation (Line(points={{51,-110},{60,-110},{60,-92}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-140},{100,140}})),
                                             Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Setpoint;
