within ThermofluidStream.Undirected.Topology;
model ConnectorInletOutletFore "Connects fore port to directed flow"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (Documentation(info="<html>
<p>This is the replaceable package that determines the medium of the Connector. Make sure it fits the medium in all models connected to inlet and port of the Connector.</p>
</html>"));
  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_ref = dropOfCommons.m_flow_reg "Reference mass flow rate"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Pressure p_ref = 1e5 "Reference pressure"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean assumeConstantDensity = true "= true, if mixture states are determined by mass flow rates"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold for small mass flow rates"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Fore fore(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}}), iconTransformation(extent={{-20,-120},{20,-80}})));
  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}), iconTransformation(extent={{-120,-20},{
            -80,20}})));
  ThermofluidStream.Interfaces.Outlet outlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}), iconTransformation(extent={{80,-20},{120,
            20}})));
  ThermofluidStream.FlowControl.CheckValve checkValve(
    redeclare package Medium = Medium,
    final L=L,
    final m_flow_ref=m_flow_ref,
    final p_ref=p_ref)
      annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  ThermofluidStream.FlowControl.CheckValve checkValve1(
    redeclare package Medium = Medium,
    final L=L,
    final m_flow_ref=m_flow_ref,
    final p_ref=p_ref)
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  ConnectRearOutlet connectRearOutlet(
    redeclare package Medium = Medium,
    final L=L,
    final useDefaultStateAsRear=false)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  ConnectInletFore connectInletFore(
    redeclare package Medium = Medium,
    final L=L)
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  JunctionRFF2 junctionRFF2_1(
    redeclare package Medium = Medium,
    final assumeConstantDensity=assumeConstantDensity,
    final m_flow_reg=m_flow_reg,
    final L=L)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  ThermofluidStream.Sensors.SensorState sensorState(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-10,8},{10,28}})));

equation
  connect(junctionRFF2_1.foreA, fore) annotation (Line(
      points={{0,-10},{0,-52},{0,-100},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionRFF2_1.foreB, connectRearOutlet.rear)
    annotation (Line(
      points={{10,0},{27,0}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionRFF2_1.rear, connectInletFore.fore) annotation (Line(
      points={{-10,0},{-27,0}},
      color={28,108,200},
      thickness=0.5));
  connect(connectInletFore.inlet, checkValve.outlet) annotation (Line(
      points={{-33,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(checkValve.inlet, inlet) annotation (Line(
      points={{-70,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearOutlet.outlet, checkValve1.inlet) annotation (Line(
      points={{33,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(checkValve1.outlet, outlet) annotation (Line(
      points={{70,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorState.inlet, checkValve.outlet)
    annotation (Line(
      points={{-10,18},{-40,18},{-40,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorState.state_out, connectRearOutlet.state_rear) annotation (Line(points={{8,18},{30,18},{30,-4}}, color={162,29,33}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Line(
          points={{-100,0},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,-100},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=true)));
end ConnectorInletOutletFore;
