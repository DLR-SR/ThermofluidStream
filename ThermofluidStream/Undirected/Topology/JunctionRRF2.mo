within ThermofluidStream.Undirected.Topology;
model JunctionRRF2 "Junction of two rear and one fore ports"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package for the Junction.</p>
</html>"));
  parameter Boolean assumeConstantDensity = true "= true, if mixture states are determined by mass flow rates"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold for small mass flow rates"
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
  Text(visible=displayInstanceName,
          extent={{-150,25},{150,65}},
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
          extent={{-60,-120},{-20,-80}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{-120,-60},{-80,-20}},
          textColor={175,175,175},
          textString="B")}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Junction with two rears and a fore in a standing T shape.</p>
</html>"));
end JunctionRRF2;
