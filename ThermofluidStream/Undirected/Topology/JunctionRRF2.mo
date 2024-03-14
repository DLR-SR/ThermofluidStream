within ThermofluidStream.Undirected.Topology;
model JunctionRRF2 "Junction with two rears and a fore"

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

  JunctionMN junctionMN(
    final M=1,
    final N=2,
    final assumeConstantDensity=assumeConstantDensity,
    final m_flow_reg=m_flow_reg,
    final L=L,
    redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Interfaces.Rear rearA(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={0,-100})));
  Interfaces.Rear rearB(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-100,0})));
  Interfaces.Fore fore(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={100,0})));

protected
  outer DropOfCommons dropOfCommons;

equation

  connect(junctionMN.rears[1], rearA) annotation (Line(
      points={{30,-0.5},{0,-0.5},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(fore, junctionMN.fores[1]) annotation (Line(
      points={{100,0},{76,0},{76,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(rearB, junctionMN.rears[2]) annotation (Line(
      points={{-100,0},{-36,0},{-36,0.5},{30,0.5}},
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
          points={{0,0},{0,-100}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{20,-100},{60,-60}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{60,20},{100,60}},
          textColor={175,175,175},
          textString="B")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Junction with two rears and a fore in a standing T shape.</p>
</html>"));
end JunctionRRF2;
