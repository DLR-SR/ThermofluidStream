within ThermofluidStream.Undirected.Topology;
model JunctionRFF "Junction with rear and two fores"

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

  Interfaces.Rear rear(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-100,0})));
  Interfaces.Fore foreA(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={0,100})));
  Interfaces.Fore foreB(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={0,-100})));
  JunctionMN junctionMN(
    final M=2,
    final N=1,
    final assumeConstantDensity=assumeConstantDensity,
    final m_flow_reg=m_flow_reg,
    final L=L,
    redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));

protected
  outer DropOfCommons dropOfCommons;

equation

  connect(junctionMN.rears[1], rear) annotation (Line(
      points={{-50,0},{-76,0},{-76,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionMN.fores[1], foreB) annotation (Line(
      points={{-30,-0.5},{0,-0.5},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(foreA, junctionMN.fores[2]) annotation (Line(
      points={{0,100},{0,0.5},{-30,0.5}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-100,0},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{0,-100}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{0,100}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{20,100},{60,60}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{20,-60},{60,-100}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="B")}), Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(info="<html>
<p>
Junction with a rear and two fores in a lying T shape.
</p>
</html>"));
end JunctionRFF;
