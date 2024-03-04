within ThermofluidStream.Topology.Variants;
model SplitterT1v1 "Version 1 of SplitterT1"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;                //Define the display of the component name for your component.

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance on each Branch of Component"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Inlet inlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90,origin={0,-100})));
  Interfaces.Outlet outletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180,origin={-100,0})));
  Interfaces.Outlet outletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0,   origin={100,0})));
  SplitterN splitterN(final N=2, final L=L, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-46})));

equation

  connect(splitterN.inlet, inlet) annotation (Line(
      points={{-5.55112e-16,-56},{-5.55112e-16,-76},{0,-76},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[2], outletA) annotation (Line(
      points={{-0.5,-36},{-0.5,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(outletB, splitterN.outlets[1]) annotation (Line(
      points={{100,0},{0.5,0},{0.5,-36}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor={0,0,255}),
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
          extent={{-120,-20},{-80,-60}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{80,-20},{120,-60}},
          textColor={175,175,175},
          textString="B")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end SplitterT1v1;
