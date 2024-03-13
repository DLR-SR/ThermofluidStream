within ThermofluidStream.Interfaces.Tests;
model Test_p_out_clipping "Test for the lower limit of p_out in SISOFlow components"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium "Medium package"
    annotation (Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  Boundaries.Source source(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Boundaries.Sink sink(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Topology.SplitterN splitterN(redeclare package Medium = Medium, N=6)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Topology.JunctionN junctionN(redeclare package Medium = Medium, N=6)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Processes.FlowResistance flowResistance(redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=100,
    r=1,
    l=1,
    L_value=100,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100, k2=50))
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Processes.Fan fan(redeclare package Medium = Medium,
    L=1000,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=100,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_0=1,
    initPhi=true,
    redeclare function dp_tau_fan =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  FlowControl.BasicControlValve basicControlValve(redeclare package Medium = Medium,
    L=1000,
    m_flowStateSelect=StateSelect.prefer,
    Kvs(displayUnit="m3/s") = 3600,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=10)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  FlowControl.SpecificValveType specificValveType(redeclare package Medium = Medium,
    L=1000,
    m_flowStateSelect=StateSelect.prefer,
    invertInput=true,
    Kvs(displayUnit="m3/s") = 3600,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=100)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  FlowControl.TanValve tanValve(redeclare package Medium = Medium,
    L=100000,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=1,
    m_flow_ref=1)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));

  Modelica.Blocks.Sources.RealExpression realExpression annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  inner DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Processes.Nozzle nozzle(
    redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=100,
    A_out=0.1,
    L_value=100,
    assumeConstantDensity=true)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
equation
  connect(source.outlet, splitterN.inlet) annotation (Line(
      points={{-80,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, junctionN.outlet) annotation (Line(
      points={{80,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[6], flowResistance.inlet)
    annotation (Line(
      points={{-50,0.833333},{-40,0.833333},{-40,50},{-10,50}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[5], fan.inlet)
    annotation (Line(
      points={{-50,0.5},{-38,0.5},{-38,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[3], basicControlValve.inlet)
    annotation (Line(
      points={{-50,-0.166667},{-36,-0.166667},{-36,-10},{-10,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[2], specificValveType.inlet)
    annotation (Line(
      points={{-50,-0.5},{-38,-0.5},{-38,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[1], tanValve.inlet)
    annotation (Line(
      points={{-50,-0.833333},{-40,-0.833333},{-40,-50},{-10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, junctionN.inlets[6])
    annotation (Line(
      points={{10,50},{40,50},{40,0.833333},{50,0.833333}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.inlets[5], fan.outlet) annotation (Line(
      points={{50,0.5},{38,0.5},{38,30},{10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.inlets[3], basicControlValve.outlet)
    annotation (Line(
      points={{50,-0.166667},{36,-0.166667},{36,-10},{10,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(specificValveType.outlet, junctionN.inlets[2])
    annotation (Line(
      points={{10,-30},{38,-30},{38,-0.5},{50,-0.5}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve.outlet, junctionN.inlets[1])
    annotation (Line(
      points={{10,-50},{40,-50},{40,-0.833333},{50,-0.833333}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression.y, tanValve.u) annotation (Line(points={{-59,-20},{-30,-20},{-30,-38},{0,-38},{0,-42}}, color={0,0,127}));
  connect(specificValveType.u_in, tanValve.u) annotation (Line(points={{0,-22},{0,-18},{-30,-18},{-30,-38},{0,-38},{0,-42}}, color={0,0,127}));
  connect(basicControlValve.u_in, tanValve.u) annotation (Line(points={{0,-2},{0,2},{-30,2},{-30,-38},{0,-38},{0,-42}}, color={0,0,127}));
  connect(nozzle.inlet, splitterN.outlets[4])
    annotation (Line(
      points={{-10,10},{-30,10},{-30,0.166667},{-50,0.166667}},
      color={28,108,200},
      thickness=0.5));
  connect(nozzle.outlet, junctionN.inlets[4])
    annotation (Line(
      points={{10,10},{30,10},{30,0.166667},{50,0.166667}},
      color={28,108,200},
      thickness=0.5));
  annotation (experiment(StopTime=1, Tolerance=1e-6, Interval=0.001), Documentation(info="<html>
<p>Test for the lower limit of p_out in SISOFlow components</p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Test_p_out_clipping;
