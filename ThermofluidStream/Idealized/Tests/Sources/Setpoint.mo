within ThermofluidStream.Idealized.Tests.Sources;
model Setpoint
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{78,180},{98,200}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-180,78},{-160,98}})));
  ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-140,78},{-120,98}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
  ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-60,78},{-40,98}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0.7) annotation (Placement(transformation(extent={{-20,78},{-40,98}})));
  ThermofluidStream.Idealized.Sources.LoopBreaker T(
    redeclare package Medium = Medium,
    p_out_fixed=100000,
    T_out_fixed=293.15) annotation (Placement(transformation(extent={{-140,-10},{-120,10}})));
  ThermofluidStream.Idealized.Sources.LoopBreaker h(
    redeclare package Medium = Medium,
    p_out_fixed=100000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    h_out_fixed=0) annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  ThermofluidStream.Idealized.Sources.LoopBreaker T1(
    redeclare package Medium = Medium,
    pSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    XiSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
  ThermofluidStream.Idealized.Sources.LoopBreaker h1(
    redeclare package Medium = Medium,
    pSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    XiSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-48,-50},{-28,-30}})));
  Modelica.Blocks.Sources.RealExpression p(y=1e5) annotation (Placement(transformation(extent={{-160,-128},{-140,-108}})));
  Modelica.Blocks.Sources.RealExpression Xi[1](y={0.1}) annotation (Placement(transformation(extent={{-160,-100},{-140,-80}})));
  Modelica.Blocks.Sources.RealExpression thermal(y=293.15) annotation (Placement(transformation(extent={{-160,-114},{-140,-94}})));
  Modelica.Blocks.Sources.RealExpression p1(y=1e5) annotation (Placement(transformation(extent={{-68,-130},{-48,-110}})));
  Modelica.Blocks.Sources.RealExpression Xi1[1](y={0.1}) annotation (Placement(transformation(extent={{-68,-102},{-48,-82}})));
  Modelica.Blocks.Sources.RealExpression thermal1(y=0) annotation (Placement(transformation(extent={{-68,-116},{-48,-96}})));
  ThermofluidStream.Idealized.Sources.LoopBreaker_m T2(
    redeclare package Medium = Medium,
    m_flow_in_par=1,
    p_out_fixed=100000,
    T_out_fixed=293.15) annotation (Placement(transformation(extent={{44,-10},{64,10}})));
  ThermofluidStream.Idealized.Sources.LoopBreaker_m h2(
    redeclare package Medium = Medium,
    m_flow_in_par=1,
    p_out_fixed=100000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    h_out_fixed=0) annotation (Placement(transformation(extent={{104,-10},{124,10}})));
  ThermofluidStream.Idealized.Sources.LoopBreaker_m T3(
    redeclare package Medium = Medium,
    XiSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    pSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{44,-50},{64,-30}})));
  ThermofluidStream.Idealized.Sources.LoopBreaker_m h3(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    pSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    XiSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{104,-50},{124,-30}})));
  Modelica.Blocks.Sources.RealExpression p2(y=1e5) annotation (Placement(transformation(extent={{24,-128},{44,-108}})));
  Modelica.Blocks.Sources.RealExpression Xi2[1](y={0.1}) annotation (Placement(transformation(extent={{24,-100},{44,-80}})));
  Modelica.Blocks.Sources.RealExpression thermal2(y=293.15) annotation (Placement(transformation(extent={{24,-114},{44,-94}})));
  Modelica.Blocks.Sources.RealExpression p3(y=1e5) annotation (Placement(transformation(extent={{84,-128},{104,-108}})));
  Modelica.Blocks.Sources.RealExpression Xi3[1](y={0.1}) annotation (Placement(transformation(extent={{84,-100},{104,-80}})));
  Modelica.Blocks.Sources.RealExpression thermal3(y=0) annotation (Placement(transformation(extent={{84,-114},{104,-94}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-170,-10},{-150,10}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate1(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-170,-52},{-150,-32}})));
  Modelica.Blocks.Sources.RealExpression m_flow(y=1) annotation (Placement(transformation(extent={{-190,-80},{-170,-60}})));
  Modelica.Blocks.Sources.RealExpression m_flow1(y=1) annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.RealExpression m_flow2(y=1) annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Blocks.Sources.RealExpression m_flow3(y=1) annotation (Placement(transformation(extent={{80,-80},{100,-60}})));
equation
  connect(source.outlet, sink.inlet) annotation (Line(
      points={{-160,88},{-140,88}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, sink1.inlet) annotation (Line(
      points={{-80,88},{-60,88}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.m_flow_prescribed, realExpression.y) annotation (Line(points={{-48,88},{-41,88}}, color={0,0,127}));
  connect(Xi.y, T1.Xi_out_prescribed) annotation (Line(points={{-139,-90},{-132,-90},{-132,-52}}, color={0,0,127}));
  connect(p.y, T1.p_out_prescribed) annotation (Line(points={{-139,-118},{-120,-118},{-120,-52}}, color={0,0,127}));
  connect(Xi1.y, h1.Xi_out_prescribed) annotation (Line(points={{-47,-92},{-40,-92},{-40,-52}}, color={0,0,127}));
  connect(thermal1.y, h1.h_out_prescribed) annotation (Line(points={{-47,-106},{-36,-106},{-36,-52}}, color={0,0,127}));
  connect(p1.y, h1.p_out_prescribed) annotation (Line(points={{-47,-120},{-28,-120},{-28,-52}}, color={0,0,127}));
  connect(T2.outlet, T2.inlet) annotation (Line(
      points={{64,0},{76,0},{76,19},{32,19},{32,0},{44,0}},
      color={28,108,200},
      thickness=0.5));
  connect(h2.outlet, h2.inlet) annotation (Line(
      points={{124,0},{136,0},{136,19},{92,19},{92,0},{104,0}},
      color={28,108,200},
      thickness=0.5));
  connect(T3.outlet, T3.inlet) annotation (Line(
      points={{64,-40},{76,-40},{76,-21},{32,-21},{32,-40},{44,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(h3.outlet, h3.inlet) annotation (Line(
      points={{124,-40},{136,-40},{136,-21},{92,-21},{92,-40},{104,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(Xi2.y, T3.Xi_out_prescribed) annotation (Line(points={{45,-90},{52,-90},{52,-52}}, color={0,0,127}));
  connect(p2.y, T3.p_out_prescribed) annotation (Line(points={{45,-118},{64,-118},{64,-52}}, color={0,0,127}));
  connect(Xi3.y, h3.Xi_out_prescribed) annotation (Line(points={{105,-90},{112,-90},{112,-52}}, color={0,0,127}));
  connect(thermal3.y, h3.h_out_prescribed) annotation (Line(points={{105,-104},{116,-104},{116,-52}}, color={0,0,127}));
  connect(p3.y, h3.p_out_prescribed) annotation (Line(points={{105,-118},{124,-118},{124,-52}}, color={0,0,127}));
  connect(massFlowRate.outlet, T.inlet) annotation (Line(
      points={{-150,0},{-140,0}},
      color={28,108,200},
      thickness=0.5));
  connect(T.outlet, massFlowRate.inlet) annotation (Line(
      points={{-120,0},{-110,0},{-110,20},{-180,20},{-180,0},{-170,0}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate1.outlet, h.inlet) annotation (Line(
      points={{-60,0},{-48,0}},
      color={28,108,200},
      thickness=0.5));
  connect(h.outlet, massFlowRate1.inlet) annotation (Line(
      points={{-28,0},{-20,0},{-20,20},{-90,20},{-90,0},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate2.outlet, T1.inlet) annotation (Line(
      points={{-150,-42},{-146,-42},{-146,-40},{-140,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(T1.outlet, massFlowRate2.inlet) annotation (Line(
      points={{-120,-40},{-108,-40},{-108,-20},{-180,-20},{-180,-42},{-170,-42}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow.y, massFlowRate2.m_flow_prescribed) annotation (Line(points={{-169,-70},{-160,-70},{-160,-50}}, color={0,0,127}));
  connect(massFlowRate3.outlet, h1.inlet) annotation (Line(
      points={{-60,-40},{-48,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(h1.outlet, massFlowRate3.inlet) annotation (Line(
      points={{-28,-40},{-18,-40},{-18,-20},{-90,-20},{-90,-40},{-80,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(m_flow1.y, massFlowRate3.m_flow_prescribed) annotation (Line(points={{-79,-70},{-70,-70},{-70,-48}}, color={0,0,127}));
  connect(m_flow2.y, T3.m_flow_in_prescribed) annotation (Line(points={{41,-70},{44,-70},{44,-52}}, color={0,0,127}));
  connect(m_flow3.y, h3.m_flow_in_prescribed) annotation (Line(points={{101,-70},{104,-70},{104,-52}}, color={0,0,127}));
  connect(T3.T_out_prescribed, thermal2.y) annotation (Line(points={{60,-52},{60,-104},{45,-104}}, color={0,0,127}));
  connect(T1.T_out_prescribed, thermal.y) annotation (Line(points={{-124,-52},{-124,-104},{-139,-104}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-200,-200},{200,200}})),
                                             Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Setpoint;
