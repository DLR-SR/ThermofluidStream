within ThermofluidStream.Topology;
model SplitterT1 "Splitter with one inlet and two outlets"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,-65},{150,-25}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor,
          rotation=90),
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
          extent={{-60,120},{-20,80}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{-60,-80},{-20,-120}},
          textColor={175,175,175},
          textString="B")}),
    Diagram(coordinateSystem(preserveAspectRatio=true)));
end SplitterT1;
