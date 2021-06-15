within ThermofluidStream.Processes.Tests;
model Flow_Resistance "Test for flow resistance"
  extends Modelica.Icons.Example;

  import tf = ThermofluidStream;
  replaceable package medium = tf.Media.myMedia.Air.SimpleAir
                                                        "Medium model"
    annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">Medium model for the test. Can be anything. </span></p>
</html>"));

  tf.Boundaries.Source source(
    redeclare package Medium = medium,
    T0_par(displayUnit="K") = 300,
    p0_par=300000)
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));
  tf.Boundaries.Sink sink(redeclare package Medium = medium, p0_par=100000)
    annotation (Placement(transformation(extent={{74,-10},{94,10}})));

  inner tf.DropOfCommons dropOfCommons(L=1, stopOnFailedAssert=false)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));

  tf.Processes.FlowResistance flowResistance(
    redeclare package Medium = medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    computeL=true,
    r=0.1,
    l=100,
    redeclare function pLoss =
        tf.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1000,
          k2=100))
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  tf.Processes.FlowResistance flowResistance1(
    redeclare package Medium = medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    computeL=false,
    L_value=1000,
    r=0.02,
    l=100,
    redeclare function pLoss =
        tf.Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  tf.Processes.FlowResistance flowResistance2(
    redeclare package Medium = medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.steadyState,
    computeL=false,
    L_value=30000,
    r=0.075,
    l=10,
    redeclare function pLoss =
        tf.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  tf.Topology.SplitterX splitterX(redeclare package Medium = medium)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  tf.Topology.JunctionX3 junctionX3_2(redeclare package Medium = medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,0})));

equation

  connect(splitterX.outletA, flowResistance.inlet) annotation (Line(
      points={{-40,10},{-40,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet, splitterX.outletC) annotation (Line(
      points={{-10,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.inlet, splitterX.outletB) annotation (Line(
      points={{-10,-30},{-40,-30},{-40,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterX.inlet, source.outlet) annotation (Line(
      points={{-50,0},{-74,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, junctionX3_2.outlet) annotation (Line(
      points={{74,0},{62,0},{62,-1.33227e-15},{50,-1.33227e-15}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, junctionX3_2.inletB) annotation (Line(
      points={{10,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionX3_2.inletC, flowResistance.outlet) annotation (Line(
      points={{40,10},{40,30},{10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionX3_2.inletA, flowResistance2.outlet) annotation (Line(
      points={{40,-10},{40,-30},{10,-30}},
      color={28,108,200},
      thickness=0.5));

  annotation (
    experiment(StopTime=10),
        Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Flow_Resistance;
