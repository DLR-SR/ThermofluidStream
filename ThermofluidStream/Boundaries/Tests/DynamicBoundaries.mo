within ThermofluidStream.Boundaries.Tests;
model DynamicBoundaries "Test for DynamicInflow and Outflow"
  extends Modelica.Icons.Example;

  package Medium = Media.myMedia.Water.StandardWater;

  Source source(redeclare package Medium=Medium, p0_par=101000)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  DynamicPressureInflow dynamicPressureInflow(redeclare package Medium=Medium,
    areaFromInput=true,
    velocityFromInput=true)
    annotation (Placement(transformation(extent={{-50,10},{-30,-10}})));
  DynamicPressureOutflow dynamicPressureOutflow(redeclare package Medium=Medium,
    areaFromInput=false,
    velocityFromInput=false,
    assumeConstantDensity=true)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Sink sink(redeclare package Medium=Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Processes.FlowResistance flowResistance(redeclare package Medium=Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.005,
    l=10,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Source source1(redeclare package Medium=Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  DynamicPressureInflow dynamicPressureInflow1(redeclare package Medium=Medium,
    A_par=0.005,
    v_in_par=-10,
    assumeConstantDensity=true)
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  DynamicPressureOutflow dynamicPressureOutflow1(redeclare package Medium=Medium,
    A_par=0.005,
    v_out_par=0)
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  Sink sink1(redeclare package Medium=Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Processes.FlowResistance flowResistance1(redeclare package Medium=Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=-1,
    r(displayUnit="mm") = 0.005,
    l=10,
    L_value=1000,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));

  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=0.5,
    startTime=0.4) annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  inner DropOfCommons dropOfCommons(m_flow_reg=0.01)
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-0.98e-3,
    duration=0.4,
    offset=1e-3,
    startTime=0) annotation (Placement(transformation(extent={{0,22},{-20,42}})));
  Source source2(redeclare package Medium = Medium, p0_par=101000)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  DynamicPressureInflow dynamicPressureInflow2(
    redeclare package Medium = Medium,
    areaFromInput=false,
    velocityFromInput=false,
    assumeConstantDensity=true)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  DynamicPressureOutflow dynamicPressureOutflow2(
    redeclare package Medium = Medium,
    areaFromInput=true,
    velocityFromInput=true,
    assumeConstantDensity=true)
    annotation (Placement(transformation(extent={{30,70},{50,50}})));
  Sink sink2(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.005,
    l=10,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=1,
    duration=0.5,
    startTime=0.4) annotation (Placement(transformation(extent={{88,80},{68,100}})));
  Modelica.Blocks.Sources.Ramp ramp3(
    height=-0.95e-3,
    duration=0.4,
    offset=1e-3,
    startTime=0) annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Source source3(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  DynamicPressureInflow dynamicPressureInflow3(
    redeclare package Medium = Medium,
    A_par=0.01,
    v_in_par=0,
    assumeConstantDensity=true)
    annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  DynamicPressureOutflow dynamicPressureOutflow3(
    redeclare package Medium = Medium,
    A_par=0.005,
    v_out_par=10)
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  Sink sink3(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=-1,
    r(displayUnit="mm") = 0.005,
    l=10,
    L_value=1000,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Source source4(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  DynamicPressureInflow dynamicPressureInflow4(
    redeclare package Medium = Medium,
    A_par=0.01,
    v_in_par=0,
    assumeConstantDensity=true)
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  DynamicPressureOutflow dynamicPressureOutflow4(
    redeclare package Medium = Medium,
    A_par=0.005,
    v_out_par=-10)
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  Sink sink4(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=1,
    r(displayUnit="mm") = 0.005,
    l=10,
    L_value=1000,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Source source5(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  DynamicPressureInflow dynamicPressureInflow5(
    redeclare package Medium = Medium,
    A_par=0.005,
    v_in_par=10,
    assumeConstantDensity=true)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  DynamicPressureOutflow dynamicPressureOutflow5(
    redeclare package Medium = Medium,
    A_par=0.005,
    v_out_par=0)
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  Sink sink5(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Processes.FlowResistance flowResistance5(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=-1,
    r(displayUnit="mm") = 0.005,
    l=10,
    L_value=1000,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
equation
  connect(source.outlet, dynamicPressureInflow.inlet) annotation (Line(
      points={{-60,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, dynamicPressureOutflow.outlet) annotation (Line(
      points={{60,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow.outlet, flowResistance.inlet)
    annotation (Line(
      points={{-30,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow.inlet, flowResistance.outlet)
    annotation (Line(
      points={{30,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, dynamicPressureInflow1.inlet)
    annotation (Line(
      points={{-60,-40},{-50,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, dynamicPressureOutflow1.outlet) annotation (Line(
      points={{60,-40},{50,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow1.outlet, flowResistance1.inlet)
    annotation (Line(
      points={{-30,-40},{-10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow1.inlet, flowResistance1.outlet)
    annotation (Line(
      points={{30,-40},{10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow.v_in_var, ramp.y) annotation (Line(points={{-52,6},{-58,6},{-58,20},{-79,20}},
                                                                                                        color={0,0,127}));
  connect(dynamicPressureInflow.A_var, ramp1.y) annotation (Line(points={{-28,6},{-24,6},{-24,32},{-21,32}},
                                                                                                      color={0,0,127}));
  connect(source2.outlet,dynamicPressureInflow2. inlet)
    annotation (Line(
      points={{-60,60},{-50,60}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet,dynamicPressureOutflow2. outlet) annotation (Line(
      points={{60,60},{50,60}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow2.outlet,flowResistance2. inlet)
    annotation (Line(
      points={{-30,60},{-10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow2.inlet,flowResistance2. outlet)
    annotation (Line(
      points={{30,60},{10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp2.y,dynamicPressureOutflow2. v_out_var) annotation (Line(points={{67,90},{58,90},{58,66},{52,66}},
                                                                                                         color={0,0,127}));
  connect(ramp3.y,dynamicPressureOutflow2. A_var) annotation (Line(points={{1,90},{20,90},{20,66},{28,66}},
                                                                                                     color={0,0,127}));
  connect(source3.outlet,dynamicPressureInflow3. inlet)
    annotation (Line(
      points={{-60,-60},{-50,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(sink3.inlet,dynamicPressureOutflow3. outlet) annotation (Line(
      points={{60,-60},{50,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow3.outlet,flowResistance3. inlet)
    annotation (Line(
      points={{-30,-60},{-10,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow3.inlet,flowResistance3. outlet)
    annotation (Line(
      points={{30,-60},{10,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet,dynamicPressureInflow4. inlet)
    annotation (Line(
      points={{-60,-80},{-50,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(sink4.inlet,dynamicPressureOutflow4. outlet) annotation (Line(
      points={{60,-80},{50,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow4.outlet,flowResistance4. inlet)
    annotation (Line(
      points={{-30,-80},{-10,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow4.inlet,flowResistance4. outlet)
    annotation (Line(
      points={{30,-80},{10,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet,dynamicPressureInflow5. inlet)
    annotation (Line(
      points={{-60,-20},{-50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sink5.inlet,dynamicPressureOutflow5. outlet) annotation (Line(
      points={{60,-20},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow5.outlet,flowResistance5. inlet)
    annotation (Line(
      points={{-30,-20},{-10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow5.inlet,flowResistance5. outlet)
    annotation (Line(
      points={{30,-20},{10,-20}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
    Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end DynamicBoundaries;
