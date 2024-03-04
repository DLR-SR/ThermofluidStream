within ThermofluidStream.Topology.Variants;
model JunctionX1v2 "2 to 2 X-Junction"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;                //Define the display of the component name for your component.

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true);
  parameter Boolean assumeConstantDensity = true "If true only mass-flow rate will determine the mixing";
  parameter SI.MassFlowRate m_flow_eps = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance on each Branch of Component"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Outlet outleta(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{20,-20},{-20,20}}, rotation=180, origin={100,0}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={100,0})));
  Interfaces.Outlet outletb(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,-100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,-100})));
  Interfaces.Inlet inletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,100})));
  Interfaces.Inlet inletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{20,-20},{-20,20}}, rotation=180, origin={-100,0}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-100,0})));
  JunctionNM junctionNM(N=2, M=2, redeclare package Medium = Medium, final L=L,
    final assumeConstantDensity = assumeConstantDensity, final m_flow_eps=m_flow_eps)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={0,0})));

equation
  connect(inletB, junctionNM.inlets[2]) annotation (Line(
      points={{-100,0},{-10,0},{-10,-0.5}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionNM.outlets[1], outleta) annotation (Line(
      points={{10,0.5},{104,0.5},{104,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(inletA, junctionNM.inlets[1]) annotation (Line(
      points={{0,100},{0,40},{-20,40},{-20,0.5},{-10,0.5}},
      color={28,108,200},
      thickness=0.5));
  connect(outletb, junctionNM.outlets[2]) annotation (Line(
      points={{0,-100},{0,-40},{20,-40},{20,-0.5},{10,-0.5}},
      color={28,108,200},
      thickness=0.5));
  connect(outleta, outleta) annotation (Line(
      points={{100,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor={0,0,255}),
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
          extent={{-120,-60},{-80,-20}},
          textColor={175,175,175},
          textString="B"),
        Text(
          extent={{120,-20},{80,-60}},
          textColor={175,175,175},
          textString="a"),
        Text(
          extent={{-20,-120},{-60,-80}},
          textColor={175,175,175},
          textString="b")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Medium package used in the component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
end JunctionX1v2;