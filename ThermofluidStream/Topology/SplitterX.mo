within ThermofluidStream.Topology;
model SplitterX "Splits a flow into three subflows"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance on each Branch of Component"
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

protected
  outer DropOfCommons dropOfCommons;

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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-80,0},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{0,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{0,80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{80,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-20,100},{-60,60}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{20,-60},{60,-100}},
          textColor={175,175,175},
          textString="B"),
        Text(
          extent={{50, 60},{90, 20}},
          textColor={175,175,175},
          textString="C")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end SplitterX;
