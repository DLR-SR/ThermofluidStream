within ThermofluidStream.Topology.Variants;
model JunctionT1v3 "Combined Version (3) of JunctionT1"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;                //Define the display of the component name for your component.
  extends ThermofluidStream.Topology.Variants.Trash.RotateInstanceName;
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
    annotation (Placement(transformation(extent={{20,-20},{-20,20}}, rotation=180, origin={100,0}),  iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={100,0})));
  Interfaces.Inlet inletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,100})));
  Interfaces.Inlet inletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90, origin={0,-100})));
  JunctionN junctionN(final N=2, redeclare package Medium = Medium, final L=L,
    final assumeConstantDensity = assumeConstantDensity, final m_flow_eps=m_flow_eps)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={30,0})));

equation

  connect(junctionN.outlet, outlet) annotation (Line(
      points={{40,-6.66134e-16},{70,-6.66134e-16},{70,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(inletA, junctionN.inlets[1]) annotation (Line(
      points={{0,100},{0,0.5},{20,0.5}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.inlets[2], inletB) annotation (Line(
      points={{20,-0.5},{0,-0.5},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,25},{150,65}},
          textString="%name",
          textColor={0,0,255},
          rotation=90),
        Line(
          points={{0,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{0,-100}},
          color={28,108,200},
          thickness=0.5),
        Text(
          extent={{20,120},{60,80}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{20,-80},{60,-120}},
          textColor={175,175,175},
          textString="B"),
        Line(
          points={{0,100},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end JunctionT1v3;
