within ThermofluidStream.Topology;
model JunctionT1 "2 to 1 T-Junction"

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

  Interfaces.Outlet outlet( redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180, origin={-100,0}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=180,origin={-100,0})));
  Interfaces.Inlet  inletA( redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,100}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=270,origin={0,100})));
  Interfaces.Inlet  inletB( redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90, origin={0,-100}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,-100})));
  JunctionN junctionN(final N=2, redeclare package Medium = Medium, final L=L,
    final assumeConstantDensity = assumeConstantDensity, final m_flow_eps=m_flow_eps)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-34,0})));

protected
  outer DropOfCommons dropOfCommons;

equation

  connect(junctionN.outlet, outlet) annotation (Line(
      points={{-44,1.33227e-15},{-72,1.33227e-15},{-72,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(inletA, junctionN.inlets[1]) annotation (Line(
      points={{0,100},{0,1},{-24,1}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.inlets[2], inletB) annotation (Line(
      points={{-24,-1},{0,-1},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-70,0},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{0,-70}},
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
          extent={{20,100},{60,60}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{20,-60},{60,-100}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="B")}),    Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end JunctionT1;
