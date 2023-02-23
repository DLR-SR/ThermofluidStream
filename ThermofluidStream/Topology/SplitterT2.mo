within ThermofluidStream.Topology;
model SplitterT2 "Splits a flow into two subflows"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance on each Branch of Component"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Inlet inlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
      iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,100}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,100})));
  Interfaces.Outlet outletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=0,origin={100,0}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=0,origin={100,0})));
  SplitterN splitterN(final N=2, final L=L, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

protected
  outer DropOfCommons dropOfCommons;

equation

  connect(splitterN.inlet, inlet) annotation (Line(
      points={{-40,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[1], outletB) annotation (Line(
      points={{-20,-0.5},{36,-0.5},{36,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(outletA, splitterN.outlets[2]) annotation (Line(
      points={{0,100},{0,0.5},{-20,0.5}},
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
          extent={{60,-20},{100,-60}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="B")}),    Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end SplitterT2;
