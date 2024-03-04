within ThermofluidStream.Topology.Variants;
model JunctionT1v1 "2 to 1 T-Junction"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;                //Define the display of the component name for your component.

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Boolean assumeConstantDensity = true "If true only mass-flow rate will determine the mixing";
  parameter SI.MassFlowRate m_flow_eps = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance on each Branch of Component"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Outlet outlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=270, origin={0,-100}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={0,-100})));
  Interfaces.Inlet inletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0,   origin={-100,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,0})));
  Interfaces.Inlet inletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180,origin={100,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,0})));
  JunctionN junctionN(final N=2, redeclare package Medium = Medium, final L=L,
    final assumeConstantDensity = assumeConstantDensity, final m_flow_eps=m_flow_eps)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-36})));

equation

  connect(junctionN.outlet, outlet) annotation (Line(
      points={{-1.77636e-15,-46},{-1.77636e-15,-73},{0,-73},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(inletA, junctionN.inlets[1]) annotation (Line(
      points={{-100,0},{-0.5,0},{-0.5,-26}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.inlets[2], inletB) annotation (Line(
      points={{0.5,-26},{0.5,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{0,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{0,-100}},
          color={28,108,200},
          thickness=0.5),
        Text(
          extent={{-120,-20},{-80,-60}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{80,-20},{120,-60}},
          textColor={175,175,175},
          textString="B"),
        Line(
          points={{-100,0},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end JunctionT1v1;
