within ThermofluidStream.Topology;
model JunctionX3 "Junction with three inlets and one outlet"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Boolean assumeConstantDensity = true "= true, if mixture states are determined by mass flow rates"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.MassFlowRate m_flow_eps = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Outlet outlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{20,-20},{-20,20}}, rotation=180, origin={100,0}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={100,0})));
  Interfaces.Inlet inletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,100})));
  Interfaces.Inlet inletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{20,-20},{-20,20}}, rotation=180, origin={-100,0}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-100,0})));
  Interfaces.Inlet inletC(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90, origin={0,-100})));
  JunctionN junctionN(final N=3, redeclare package Medium = Medium, final L=L,
    final m_flow_eps=m_flow_eps, final assumeConstantDensity = assumeConstantDensity)
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={40,0})));

equation

  connect(junctionN.inlets[2], inletB) annotation (Line(
      points={{20,3.10862e-15},{-40,3.10862e-15},{-40,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(inletC, junctionN.inlets[3]) annotation (Line(
      points={{0,-100},{0,-1.33333},{20,-1.33333}},
      color={28,108,200},
      thickness=0.5));
  connect(inletA, junctionN.inlets[1]) annotation (Line(
      points={{0,100},{0,1.33333},{20,1.33333}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.outlet, outlet) annotation (Line(
      points={{60,-1.33227e-15},{81,-1.33227e-15},{81,0},{100,0}},
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
          extent={{20,120},{60,80}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{-120,-60},{-80,-20}},
          textColor={175,175,175},
          textString="B"),
        Text(
          extent={{60,-120},{20,-80}},
          textColor={175,175,175},
          textString="C")}),
    Diagram(coordinateSystem(preserveAspectRatio=true)));
end JunctionX3;
