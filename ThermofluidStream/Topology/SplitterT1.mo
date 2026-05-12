within ThermofluidStream.Topology;
model SplitterT1 "Splitter with one inlet and two outlets"

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
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,100})));
  Interfaces.Outlet outletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,-100})));
  SplitterN splitterN(
    displayInstanceName=true,
    final N=2,
    final L=L,
    final neglectInertance = neglectInertance,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

equation
  connect(splitterN.inlet, inlet) annotation (Line(
      points={{-40,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[2], outletA) annotation (Line(
      points={{-20,0.5},{0,0.5},{0,100}},
      color={28,108,200},
      thickness=0.5));
  connect(outletB, splitterN.outlets[1]) annotation (Line(
      points={{0,-100},{0,-0.5},{-20,-0.5}},
      color={28,108,200},
      thickness=0.5));
  annotation (defaultComponentName = "splitter",Icon(coordinateSystem(preserveAspectRatio=true), graphics={
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
          textString="B"),
        Ellipse(visible = neglectInertance,
          extent={{20,100},{40,80}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Ellipse(visible = neglectInertance,
          extent={{22,-80},{42,-100}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Three-port splitter for branching a single flow path into two downstream branches. </p>
<p>Use this model to create a clear, directed network structure when dividing mass flow into two parallel paths. </p>
<p>The component is intended for steady (non-dynamic) topology definition within ThermoFluidStream networks.</p>
</html>"));
end SplitterT1;
