within ThermofluidStream.Topology.Variants.Trash;
model SplitterT1v3 "Combined Version (3) of SplitterT1"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;                //Define the display of the component name for your component.
  extends ThermofluidStream.Topology.Variants.Trash.RotateInstanceName;
  /*
  parameter Boolean rotateInstanceName = false "= true, if you wish to rotate the instane name by 90°" annotation(Dialog(tab="Layout",group="Display instance name",enable=displayInstanceName),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean d1name = displayInstanceName and not rotateInstanceName "displayInstanceName version 1" annotation(Evaluate=true, HideResult=true);
  final parameter Boolean d2name = displayInstanceName and rotateInstanceName "displayInstanceName version 1" annotation(Evaluate=true, HideResult=true);
  */
  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance on each Branch of Component"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Inlet inlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0, origin={-100,0})));
  Interfaces.Outlet outletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90, origin={0,100})));
  Interfaces.Outlet outletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,-100})));
  SplitterN splitterN(final N=2, final L=L, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));

equation

  connect(splitterN.inlet, inlet) annotation (Line(
      points={{-28,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[2], outletA) annotation (Line(
      points={{-8,0.5},{0,0.5},{0,100}},
      color={28,108,200},
      thickness=0.5));
  connect(outletB, splitterN.outlets[1]) annotation (Line(
      points={{0,-100},{0,-0.5},{-8,-0.5}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(visible=d1name,
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor={0,0,255}),
        Line(visible= not d1name,
          points={{0,0},{0,100}},
          color={28,108,200},
          thickness=0.5),
        Line(visible= d1name,
          points={{0,0},{0,20}},
          color={28,108,200},
          thickness=0.5),
        Line(visible= d1name,
          points={{0,70},{0,100}},
          color={28,108,200},
          thickness=0.5),
        Text(visible=d2name,
          extent={{-150,20},{150,-20}},
          textString="%name",
          textColor={0,0,255},
          origin={60,0},
          rotation=90),
        Line(
          points={{-100,0},{0,0}},
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
          extent={{-60,120},{-20,80}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{-60,-80},{-20,-120}},
          textColor={175,175,175},
          textString="B")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end SplitterT1v3;
