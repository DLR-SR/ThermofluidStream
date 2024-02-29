within ThermofluidStream.Undirected.Interfaces.Tests;
model Test_p_out_clipping "Test for the lower limit of p_out in SISOFlow components"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium "Medium package"
    annotation (Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  Boundaries.BoundaryRear boundary_rear(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Boundaries.BoundaryFore boundary_fore(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=-100,
    r=1,
    l=1,
    L_value=100,
    computeL=false,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100, k2=50))
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  FlowControl.BasicControlValve basicControlValve(
    redeclare package Medium = Medium,
    L=1000,
    m_flowStateSelect=StateSelect.prefer,
    Kvs(displayUnit="m3/s") = 3600,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=10) annotation (Placement(transformation(extent={{-10,0},{10,20}})));
   FlowControl.SpecificValveType specificValveType(
    redeclare package Medium = Medium,
    L=1000,
    m_flowStateSelect=StateSelect.prefer,
    invertInput=true,
    Kvs(displayUnit="m3/s") = 3600,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=-100) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  FlowControl.TanValve tanValve(
    redeclare package Medium = Medium,
    L=100000,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=1,
    m_flow_ref=1) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));

  Modelica.Blocks.Sources.RealExpression realExpression annotation (Placement(transformation(extent={{-72,-60},{-52,-40}})));
  inner DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=100,
    r=1,
    l=1,
    L_value=100,
    computeL=false,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=50))
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Boundaries.BoundaryRear boundary_rear1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Boundaries.BoundaryRear boundary_rear2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Boundaries.BoundaryRear boundary_rear3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Boundaries.BoundaryRear boundary_rear4(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Boundaries.BoundaryFore boundary_fore1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Boundaries.BoundaryFore boundary_fore2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Boundaries.BoundaryFore boundary_fore3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Boundaries.BoundaryFore boundary_fore4(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
equation
  connect(realExpression.y, tanValve.u) annotation (Line(points={{-51,-50},{-30,-50},{-30,-18},{0,-18},{0,-22}}, color={0,0,127}));
  connect(specificValveType.u_in, tanValve.u) annotation (Line(points={{0,-2},{0,2},{-30,2},{-30,-18},{0,-18},{0,-22}}, color={0,0,127}));
  connect(basicControlValve.u_in, tanValve.u) annotation (Line(points={{0,18},{0,22},{-30,22},{-30,-18},{0,-18},{0,-22}},
                                                                                                                        color={0,0,127}));
  connect(boundary_rear.fore, flowResistance1.rear) annotation (Line(
      points={{-40,50},{-10,50}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear4.fore, tanValve.rear)
    annotation (Line(
      points={{-40,-30},{-26,-30},{-26,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(specificValveType.rear, boundary_rear3.fore)
    annotation (Line(
      points={{-10,-10},{-40,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear2.fore, basicControlValve.rear)
    annotation (Line(
      points={{-40,10},{-10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear1.fore, flowResistance.rear) annotation (Line(
      points={{-40,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore4.rear, tanValve.fore) annotation (Line(
      points={{40,-30},{10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(specificValveType.fore, boundary_fore3.rear)
    annotation (Line(
      points={{10,-10},{40,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore2.rear, basicControlValve.fore) annotation (Line(
      points={{40,10},{10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore1.rear, flowResistance.fore) annotation (Line(
      points={{40,30},{10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.fore, boundary_fore.rear) annotation (Line(
      points={{10,50},{40,50}},
      color={28,108,200},
      thickness=0.5));
  annotation (experiment(StopTime=1, Tolerance=1e-6, Interval=0.001), Documentation(info="<html>
<p>Test for the lower limit of p_out in SISOFlow components</p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Test_p_out_clipping;
