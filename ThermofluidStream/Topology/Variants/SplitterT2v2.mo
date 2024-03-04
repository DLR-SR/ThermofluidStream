within ThermofluidStream.Topology.Variants;
model SplitterT2v2 "Splits a flow into two subflows"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;                //Define the display of the component name for your component.

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance on each Branch of Component"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Inlet inlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-42,-110},{-2,-70}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Interfaces.Outlet outletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,100})));
  Interfaces.Outlet outletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=0,origin={100,0})));
  SplitterN splitterN(final N=2, final L=L, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

equation

  connect(splitterN.inlet, inlet) annotation (Line(
      points={{-40,0},{-32,0},{-32,-90},{-22,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[1], outletB) annotation (Line(
      points={{-20,-0.5},{-20,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(outletA, splitterN.outlets[2]) annotation (Line(
      points={{0,100},{0,0.5},{-20,0.5}},
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
          points={{0,-100},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{100,0}},
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
          extent={{80,-20},{120,-60}},
          textColor={175,175,175},
          textString="B")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end SplitterT2v2;
