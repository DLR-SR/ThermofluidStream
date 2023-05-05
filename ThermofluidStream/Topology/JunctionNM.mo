within ThermofluidStream.Topology;
model JunctionNM "Junction with N inlets and M outlets"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Integer N(min=1) = 1 "Number of inputs";
  parameter Integer M(min=1) = 1 "Number of outputs";
  parameter Boolean assumeConstantDensity = true "If true only mass-flow rate will determine the mixing"
    annotation(Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_eps = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance on each Branch of Component"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Inlet inlets[N](redeclare package Medium = Medium) "vector of N inlets"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0, origin={-100,0}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=0,origin={-100,0})));
  Interfaces.Outlet outlets[M](redeclare package Medium = Medium) "vector of N outlets"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0, origin={100,0}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=0,origin={100,0})));
  SplitterN splitterN(
    final N=M,
    redeclare package Medium = Medium, final L=L)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={18,0})));
  JunctionN junctionN(
    final N=N,
    redeclare package Medium = Medium,
    final L=L,
    final m_flow_eps=m_flow_eps,
    final assumeConstantDensity = assumeConstantDensity)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-14,0})));

protected
  outer DropOfCommons dropOfCommons;

equation

  connect(junctionN.inlets, inlets) annotation (Line(
      points={{-24,0},{-62,0},{-62,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.outlet, splitterN.inlet) annotation (Line(
      points={{-4,0},{8,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets, outlets) annotation (Line(
      points={{28,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{-100,10}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{-100,-10}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{100,10}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{100,-10}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-90,80},{-50,40}},
          textColor={175,175,175},
          textString="%N"),
        Text(
          extent={{90,80},{50,40}},
          textColor={175,175,175},
          textString="%M")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end JunctionNM;
