within ThermofluidStream.Topology;
model SplitterX "Splitter with one inlet and three outlets"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Inlet inlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20}, {20,20}}, rotation=90, origin={0,100})));
  Interfaces.Outlet outletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=270, origin={3.55271e-15,-100})));
  Interfaces.Outlet outletC(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20}, {20,20}},rotation=0,origin={100,0})));
  SplitterN splitterN(final N=3, final L=L, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));

equation
  connect(splitterN.inlet, inlet) annotation (Line(
      points={{-32,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[3], outletA) annotation (Line(
      points={{-12,0.666667},{0,0.666667},{0,100}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[2], outletC) annotation (Line(
      points={{-12,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[1], outletB) annotation (Line(
      points={{-12,-0.666667},{0,-0.666667},{0,-100},{3.55271e-15,-100}},
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
          textString="C")}),
    Diagram(coordinateSystem(preserveAspectRatio=true)));
end SplitterX;
