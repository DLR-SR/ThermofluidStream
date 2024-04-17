within ThermofluidStream.Topology;
model DynamicJunctionNM "Splitter/Junction with N inlets and M outlets, taking dynamic pressure into account"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Boolean assumeConstantDensity=true "= true, if incompressibility is assumed (use '= false' for Ma > 0.3)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Integer N(min=1) = 1 "Number of inputs";
  parameter Integer M(min=1) = 1 "Number of outputs";
  parameter SI.Area A_in[N] "Cross section area of inlets";
  parameter SI.Area A_out[M] "Cross section area of outlets";
  parameter SI.Area A_splitter = 0.1 "Internal cross section of Junction"
    annotation(Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
    annotation (Dialog(tab="Advanced"));
  Interfaces.Inlet inlets[N](redeclare package Medium = Medium) "vector of N inlets"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0, origin={-100,0}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=0,origin={-100,0})));
  Interfaces.Outlet outlets[M](redeclare package Medium = Medium) "vector of N outlets"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0, origin={100,0}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=0,origin={100,0})));
  DynamicJunctionN dynamicJunctionN(redeclare package Medium = Medium,
    final N=N,
    final L=L,
    final assumeConstantDensity=assumeConstantDensity,
    final A=A_in,
    final A_out=A_splitter)
      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,0})));
  DynamicSplitterN dynamicSplitterN(redeclare package Medium = Medium,
    final N=M,
    final L=L,
    final assumeConstantDensity=assumeConstantDensity,
    final A_splitter=A_splitter,
    final A_in=A_splitter,
    final A_out=A_out)
      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={20,0})));

equation
  connect(dynamicJunctionN.inlets, inlets) annotation (Line(
      points={{-30,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicJunctionN.outlet, dynamicSplitterN.inlet) annotation (Line(
      points={{-10,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicSplitterN.outlets, outlets) annotation (Line(
      points={{30,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Line(
          points={{-100,0},{100,0}},
          color={0,127,0},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={0,127,0},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-120,-20},{-80,-60}},
          textColor={175,175,175},
          textString="%N"),
        Text(
          extent={{120,-20},{80,-60}},
          textColor={175,175,175},
          textString="%M"),
        Ellipse(
          extent={{-20,20},{20,-20}},
          lineThickness=0.5,
          lineColor={170,255,170})}),
      Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Junction/Splitter that takes into account dynamic pressure.</p>
<p>In general the component has four non-linear equation systems of size 1. This can be resolved by setting Advanced-&gt;assumeConstantDensity=true (default: false).</p>
</html>"));
end DynamicJunctionNM;
