within ThermofluidStream.Processes.Tests;
model Flow_Resistance "Test for flow resistance"
  extends Modelica.Icons.Example;

  import tf = ThermofluidStream;
  replaceable package Medium = tf.Media.myMedia.Air.SimpleAir "Medium model"
    annotation (Documentation(info="<html>
<p>
Medium model for the test. Can be anything.
</p>
</html>"));

  tf.Boundaries.Source source(
    redeclare package Medium = Medium,
    T0_par(displayUnit="K") = 300,
    p0_par=300000)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  tf.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  inner tf.DropOfCommons dropOfCommons(L=1, assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));

  tf.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.steadyState,
    computeL=true,
    r=0.1,
    l=100,
    redeclare function pLoss = tf.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1000,
      k2=100))
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  tf.Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.derivative,
    m_acceleration_0=1,
    computeL=false,
    L_value=1000,
    r=0.02,
    l=100,
    redeclare function pLoss =
        tf.Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  tf.Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    computeL=false,
    L_value=30000,
    r=0.075,
    l=10,
    redeclare function pLoss = tf.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));

  tf.Boundaries.Source source1(
    redeclare package Medium = Medium,
    T0_par(displayUnit="K") = 300,
    p0_par=300000)
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  tf.Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    computeL=false,
    L_value=30000,
    r=0.075,
    l=10,
    redeclare function pLoss =
        tf.Processes.Internal.FlowResistance.laminarTurbulentPressureLossHaaland (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));

  tf.Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  tf.Boundaries.Source source2(
    redeclare package Medium = Medium,
    T0_par(displayUnit="K") = 300,
    p0_par=300000)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  tf.Boundaries.Sink sink2(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  tf.Boundaries.Source source3(
    redeclare package Medium = Medium,
    T0_par(displayUnit="K") = 300,
    p0_par=300000)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  tf.Boundaries.Sink sink3(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
equation
  connect(source1.outlet, flowResistance3.inlet) annotation (Line(
      points={{-20,-60},{-10,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, sink1.inlet) annotation (Line(
      points={{10,-60},{20,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, flowResistance2.inlet) annotation (Line(
      points={{-20,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, sink3.inlet) annotation (Line(
      points={{10,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance1.inlet) annotation (Line(
      points={{-20,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance1.outlet) annotation (Line(
      points={{20,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, flowResistance.inlet) annotation (Line(
      points={{-20,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, sink2.inlet) annotation (Line(
      points={{10,30},{20,30}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(StopTime=10, Tolerance=1e-6, Interval=0.01),
        Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Flow_Resistance;
