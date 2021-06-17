within ThermofluidStream.Topology;
model JunctionX3 "3 to 1 X-Junction"

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
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180, origin={-100,0}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=180,origin={-100,0})));
  Interfaces.Inlet  inletA( redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,100}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=270,origin={0,100})));
  Interfaces.Inlet  inletB( redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180, origin={100,0}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=180,origin={100,0})));
  Interfaces.Inlet  inletC( redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90, origin={0,-100}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,-100})));
  JunctionN junctionN(final N=3, redeclare package Medium = Medium, final L=L,
    final m_flow_eps=m_flow_eps, final assumeConstantDensity = assumeConstantDensity)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-40,0})));

protected
  outer DropOfCommons dropOfCommons;

equation

  connect(junctionN.inlets[2], inletB) annotation (Line(
      points={{-30,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(inletC, junctionN.inlets[3]) annotation (Line(
      points={{0,-100},{0,-1.33333},{-30,-1.33333}},
      color={28,108,200},
      thickness=0.5));
  connect(inletA, junctionN.inlets[1]) annotation (Line(
      points={{0,100},{0,1.33333},{-30,1.33333}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.outlet, outlet) annotation (Line(
      points={{-50,0},{-100,0}},
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
        Line(
          points={{0,0},{0,-80}},
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
          extent={{50,20},{90,60}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{60,-100},{20,-60}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="C")}),    Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end JunctionX3;
