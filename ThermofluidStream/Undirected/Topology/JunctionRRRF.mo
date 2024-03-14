within ThermofluidStream.Undirected.Topology;
model JunctionRRRF "Junction with tree rears and a fore"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package for the Junction.</p>
</html>"));
  parameter Boolean assumeConstantDensity = true "If true only mass-flow rate will determine the mixing"
    annotation (Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each branch"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Rear rearA(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={0,100})));
  Interfaces.Fore fore(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={100,0})));
  JunctionMN junctionMN(
    final M=1,
    final N=3,
    final assumeConstantDensity=assumeConstantDensity,
    final m_flow_reg=m_flow_reg,
    final L=L,
    redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Interfaces.Rear rearB(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-100,0})));
  Interfaces.Rear rearC(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={0,-100})));

protected
  outer DropOfCommons dropOfCommons;

equation
  connect(rearA, junctionMN.rears[2]) annotation (Line(
      points={{0,100},{0,0}},
      color={28,108,200},
      thickness=0.5));
  connect(rearB, junctionMN.rears[1]) annotation (Line(
      points={{-100,0},{0,0},{0,-0.666667}},
      color={28,108,200},
      thickness=0.5));
  connect(rearC, junctionMN.rears[3]) annotation (Line(
      points={{0,-100},{0,0.666667}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionMN.fores[1], fore) annotation (Line(
      points={{20,0},{60,0},{60,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-100,0},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{0,100}},
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
          extent={{-60,100},{-20,60}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{-50,-20},{-90,-60}},
          textColor={175,175,175},
          textString="B"),
        Text(
          extent={{60,-100},{20,-60}},
          textColor={175,175,175},
          textString="C")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Junction with three rears and a fore in a x shape.</p>
</html>"));
end JunctionRRRF;
