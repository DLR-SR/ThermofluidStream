within ThermofluidStream.Topology;
model DynamicSplitterN "Dynamic pressure 1 to N splitter"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
                                                                "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make shure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));

  parameter Integer N(min=1) = 1 "Number of outputs";
  parameter SI.Area A_in "Cross section area of inlet";
  parameter SI.Area A_out[N] "Cross section area of outlets";
  parameter SI.Area A_splitter = 0.1 "Internal cross section area"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance on each Branch of Component"
    annotation (Dialog(tab="Advanced"));
  parameter Boolean assumeConstantDensity=true    "If true only inlet density is applied"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Inlet inlet(redeclare package Medium = Medium) "inlet"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
      iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outlets[N](redeclare package Medium = Medium) "vector of N outlets"
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
      iconTransformation(extent={{80,-20},{120,20}})));
  Processes.Nozzle nozzle_in(
    redeclare package Medium = Medium,
    A_in=A_in,
    A_out=A_splitter,
    final assumeConstantDensity=assumeConstantDensity,
    final L_value=L/3)
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  SplitterN splitterN(redeclare package Medium = Medium,
    final N = N,
    final L = L/3)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Processes.Nozzle nozzle_out[N](
    redeclare package Medium = Medium,
    A_out=A_out,
    each A_in=A_splitter/N,
    each final assumeConstantDensity=assumeConstantDensity,
    each final L_value=L/3)
      annotation (Placement(transformation(extent={{30,-10},{50,10}})));

protected
  outer DropOfCommons dropOfCommons;

equation
  connect(nozzle_out.outlet, outlets) annotation (Line(
      points={{50,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets, nozzle_out.inlet) annotation (Line(
      points={{10,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.inlet, nozzle_in.outlet) annotation (Line(
      points={{-10,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(nozzle_in.inlet, inlet) annotation (Line(
      points={{-50,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-70,0},{0,0}},
          color={0,127,0},
          thickness=0.5),
        Line(
          points={{0,0},{70,0}},
          color={0,127,0},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={0,127,0},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{90,80},{50,40}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%N"),
        Ellipse(
          extent={{-20,20},{20,-20}},
          lineThickness=0.5,
          lineColor={170,255,170})}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Splitter that takes into account dynamic pressure.</p>
<p>In general the component has two non-linear equation systems of size 1. This can be resolved by setting Advanced-&gt;assumeConstantDensity=true (default: false).</p>
</html>"));
end DynamicSplitterN;
