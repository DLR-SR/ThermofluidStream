within ThermofluidStreamTest.Boundaries;
model ConditionalConnectors
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  inner ThermofluidStream.DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    outlet(m_flow(start=0.5, fixed=true)))
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=true,
    enthalpyFromInput=true,
    xiFromInput=true,
    outlet(m_flow(start=0.5, fixed=true)))
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=true,
    xiFromInput=true) annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  ThermofluidStream.Boundaries.Sink sink(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  ThermofluidStream.Boundaries.Sink sink1(
    redeclare package Medium = Medium,
    pressureFromInput=true)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  ThermofluidStream.Boundaries.CreateState createState(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  ThermofluidStream.Boundaries.CreateState createState1(
    redeclare package Medium = Medium,
    setEnthalpy=false,
    PFromInput=true,
    TFromInput=true,
    XiFromInput=true) annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  ThermofluidStream.Boundaries.CreateState createState2(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    PFromInput=true,
    TFromInput=false,
    hFromInput=true,
    XiFromInput=true) annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  ThermofluidStream.Boundaries.DynamicPressureInflow dynamicPressureInflow(
    redeclare package Medium = Medium,
    v_in_par=0.1)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  ThermofluidStream.Boundaries.DynamicPressureInflow dynamicPressureInflow1(
    redeclare package Medium = Medium,
    areaFromInput=true,
    velocityFromInput=true) annotation (Placement(transformation(extent={{20,-10},{40,-30}})));
  ThermofluidStream.Boundaries.DynamicPressureOutflow dynamicPressureOutflow(
    redeclare package Medium = Medium,
    v_out_par=0.1)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  ThermofluidStream.Boundaries.DynamicPressureOutflow dynamicPressureOutflow1(
    redeclare package Medium = Medium,
    areaFromInput=true,
    velocityFromInput=true) annotation (Placement(transformation(extent={{50,-10},{70,-30}})));
  ThermofluidStream.Topology.SplitterT2 splitterT2_1(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-30,100},{-10,80}})));
  Modelica.Blocks.Sources.Sine sine_p(
    amplitude=0.1,
    f=1,
    offset=1e5) annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=0.1,
    duration=5,
    offset=0.1) annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  Modelica.Blocks.Sources.Sine sine_h(
    amplitude=1,
    f=1,
    offset=4e4) annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=0.1,
    duration=5,
    offset=0.1) annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
  Modelica.Blocks.Sources.Sine sine_T(
    amplitude=1,
    f=1,
    offset=293) annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Sources.Sine sine_xi(
    amplitude=0.001,
    f=0.5,
    offset=0.01) annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.Constant const(k=9e4)
    annotation (Placement(transformation(extent={{40,0},{20,20}})));
equation
  connect(sine_p.y, source1.p0_var) annotation (Line(points={{-79,20},{-62,20},{-62,16},{-42,16}}, color={0,0,127}));
  connect(sine_p.y, source2.p0_var) annotation (Line(points={{-79,20},{-62,20},{-62,-14},{-42,-14}}, color={0,0,127}));
  connect(dynamicPressureInflow.outlet,dynamicPressureOutflow. inlet) annotation (Line(
      points={{10,60},{20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet,splitterT2_1. inlet) annotation (Line(
      points={{-40,90},{-30,90}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletB,sink. inlet) annotation (Line(
      points={{-10,90},{0,90}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletA,dynamicPressureInflow. inlet) annotation (Line(
      points={{-20,80},{-20,60},{-10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, sink1.inlet) annotation (Line(
      points={{-30,10},{-10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sine_p.y, createState1.p_inp) annotation (Line(points={{-79,20},{-62,20},{-62,-40},{-40,-40}}, color={0,0,127}));
  connect(sine_p.y, createState2.p_inp) annotation (Line(points={{-79,20},{-62,20},{-62,-70},{-40,-70}}, color={0,0,127}));
  connect(dynamicPressureInflow1.outlet, dynamicPressureOutflow1.inlet) annotation (Line(
      points={{40,-20},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, dynamicPressureInflow1.inlet) annotation (Line(
      points={{-30,-20},{20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp.y, dynamicPressureInflow1.v_in_var) annotation (Line(points={{21,-60},{30,-60},{30,-30}}, color={0,0,127}));
  connect(ramp.y, dynamicPressureOutflow1.v_out_var) annotation (Line(points={{21,-60},{54,-60},{54,-30}}, color={0,0,127}));
  connect(ramp1.y, dynamicPressureInflow1.A_var) annotation (Line(points={{79,-50},{36,-50},{36,-30}}, color={0,0,127}));
  connect(ramp1.y, dynamicPressureOutflow1.A_var) annotation (Line(points={{79,-50},{60,-50},{60,-30}}, color={0,0,127}));
  connect(sine_T.y, source1.T0_var) annotation (Line(points={{-79,-20},{-68,-20},{-68,10},{-42,10}}, color={0,0,127}));
  connect(sine_xi.y, source1.xi_var[1]) annotation (Line(points={{-79,-50},{-74,-50},{-74,4},{-42,4}}, color={0,0,127}));
  connect(sine_xi.y, source2.xi_var[1]) annotation (Line(points={{-79,-50},{-74,-50},{-74,-26},{-42,-26}}, color={0,0,127}));
  connect(const.y, sink1.p0_var) annotation (Line(points={{19,10},{2,10}}, color={0,0,127}));
  connect(sine_T.y, createState1.T_inp) annotation (Line(points={{-79,-20},{-68,-20},{-68,-50},{-40,-50}}, color={0,0,127}));
  connect(sine_xi.y, createState1.Xi_inp[1]) annotation (Line(points={{-79,-50},{-74,-50},{-74,-60},{-40,-60}}, color={0,0,127}));
  connect(sine_xi.y, createState2.Xi_inp[1]) annotation (Line(points={{-79,-50},{-74,-50},{-74,-90},{-40,-90}}, color={0,0,127}));
  connect(sine_h.y, createState2.h0_var) annotation (Line(points={{-79,-80},{-32,-80}}, color={0,0,127}));
  connect(sine_h.y, source2.h0_var) annotation (Line(points={{-79,-80},{-56,-80},{-56,-20},{-42,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end ConditionalConnectors;
