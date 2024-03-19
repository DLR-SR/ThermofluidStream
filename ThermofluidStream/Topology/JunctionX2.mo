within ThermofluidStream.Topology;
model JunctionX2 "Splitter/Junction with two inlets and two outlets"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Boolean assumeConstantDensity = true "= true, if mixture states are determined by mass flow rates"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.MassFlowRate m_flow_eps = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Outlet outleta(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180, origin={-100,0})));
  Interfaces.Outlet outletb(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0, origin={100,0})));
  Interfaces.Inlet inletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,100})));
  Interfaces.Inlet inletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90, origin={0,-100})));
  JunctionNM junctionNM(N=2, M=2, redeclare package Medium = Medium, final L=L,
    final assumeConstantDensity = assumeConstantDensity, final m_flow_eps=m_flow_eps)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,20})));

equation

  connect(junctionNM.outlets[1], outleta) annotation (Line(
      points={{-0.5,10},{-1,10},{-1,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionNM.outlets[2], outletb) annotation (Line(
      points={{0.5,10},{1,10},{1,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionNM.inlets[1], inletA) annotation (Line(
      points={{-0.5,30},{-0.5,66},{0,66},{0,100}},
      color={28,108,200},
      thickness=0.5));
  connect(inletB, junctionNM.inlets[2]) annotation (Line(
      points={{0,-100},{0,-40},{40,-40},{40,52},{0.5,52},{0.5,30}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Line(visible= not displayInstanceName,
          points={{0,0},{0,100}},
          color={28,108,200},
          thickness=0.5),
        Line(visible= displayInstanceName,
          points={{0,0},{0,20}},
          color={28,108,200},
          thickness=0.5),
        Line(visible= displayInstanceName,
          points={{0,70},{0,100}},
          color={28,108,200},
          thickness=0.5),
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
          lineThickness=0.5),
        Text(
          extent={{-60,120},{-20,80}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{-20,-120},{-60,-80}},
          textColor={175,175,175},
          textString="B"),
        Text(
          extent={{-80,-20},{-120,-60}},
          textColor={175,175,175},
          textString="a"),
        Text(
          extent={{80,-60},{120,-20}},
          textColor={175,175,175},
          textString="b")}),
    Diagram(coordinateSystem(preserveAspectRatio=true)));
end JunctionX2;
