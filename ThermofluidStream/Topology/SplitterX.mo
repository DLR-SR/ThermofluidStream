within ThermofluidStream.Topology;
model SplitterX "Splitter with one inlet and three outlets"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Boolean neglectInertance = dropOfCommons.neglectInertance "=true, if mass flow rate dynamics are neglected - advanced mode!"
    annotation(Dialog(tab="Advanced"),Evaluate=true, HideResult=true);
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
    annotation(Dialog(tab="Advanced", enable = not neglectInertance), HideResult = neglectInertance);

  Interfaces.Inlet inlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20}, {20,20}}, rotation=90, origin={0,100})));
  Interfaces.Outlet outletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=270, origin={0,-100})));
  Interfaces.Outlet outletC(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  SplitterN splitterN(
    displayInstanceName=true,
    final N=3,
    final L=L,
    final neglectInertance = neglectInertance,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

equation
  connect(splitterN.inlet, inlet) annotation (Line(
      points={{-40,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[3], outletA) annotation (Line(
      points={{-20,0.666667},{0,0.666667},{0,100}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[2], outletC) annotation (Line(
      points={{-20,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[1], outletB) annotation (Line(
      points={{-20,-0.666667},{0,-0.666667},{0,-100}},
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
          points={{-100,0},{100,0}},
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
          extent={{-20,120},{-60,80}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{-60,-80},{-20,-120}},
          textColor={175,175,175},
          textString="B"),
        Text(
          extent={{80,-20},{120,-60}},
          textColor={175,175,175},
          textString="C"),
        Ellipse(visible = neglectInertance,
          extent={{20,100},{40,80}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Ellipse(visible = neglectInertance,
          extent={{80,40},{100,20}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Ellipse(visible = neglectInertance,
          extent={{20,-80},{40,-100}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Multi-branch splitter for distributing one upstream stream into multiple downstream branches in an X-type topology. Use this component when you need a compact representation of a higher-order split without cascading several T-splitters.</p>
</html>"));
end SplitterX;
