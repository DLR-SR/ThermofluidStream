within ThermofluidStream.Topology;
model JunctionX2 "2 to 2 X-Junction"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
                                                                "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Boolean assumeConstantDensity = true "If true only mass-flow rate will determine the mixing";
  parameter SI.MassFlowRate m_flow_eps = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance on each Branch of Component"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Outlet outleta(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180, origin={-100,0}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=180,origin={-100,0})));
  Interfaces.Outlet outletb(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0, origin={100,0}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=0,origin={100,0})));
  Interfaces.Inlet  inletA( redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,100}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=270,origin={0,100})));
  Interfaces.Inlet  inletB( redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90, origin={0,-100}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,-100})));
  JunctionNM junctionNM(N=2, M=2, redeclare package Medium = Medium, final L=L,
    final assumeConstantDensity = assumeConstantDensity, final m_flow_eps=m_flow_eps)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,20})));

protected
  outer DropOfCommons dropOfCommons;

equation

  connect(junctionNM.outlets[1], outleta) annotation (Line(
      points={{-1,10},{-1,10},{-1,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionNM.outlets[2], outletb) annotation (Line(
      points={{1,10},{1,10},{1,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionNM.inlets[1], inletA) annotation (Line(
      points={{-1,30},{-1,66},{0,66},{0,100}},
      color={28,108,200},
      thickness=0.5));
  connect(inletB, junctionNM.inlets[2]) annotation (Line(
      points={{0,-100},{0,-40},{40,-40},{40,52},{1,52},{1,30}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-70,0},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{80,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{0,80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,-70},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-60,100},{-20,60}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{60,-100},{20,-60}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{-60,-20},{-100,-60}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="a"),
        Text(
          extent={{50,20},{90,60}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="b")}),
     Diagram(coordinateSystem(preserveAspectRatio=false)));
end JunctionX2;
