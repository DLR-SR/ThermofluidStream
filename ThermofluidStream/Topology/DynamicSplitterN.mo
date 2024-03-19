within ThermofluidStream.Topology;
model DynamicSplitterN "Splitter with 1 inlet and N outlets, taking dynamic pressure into account"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Boolean assumeConstantDensity=true "= true, if incompressibility is assumed (use '= false' for Ma > 0.3)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Integer N(min=1) = 1 "Number of outlets";
  parameter SI.Area A_in "Inlet cross section area";
  parameter SI.Area A_out[N] "Cross section area of outlets";
  parameter SI.Area A_splitter = 0.1 "Internal cross section area"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
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
          extent={{120,-20},{80,-60}},
          textColor={175,175,175},
          textString="%N"),
        Ellipse(
          extent={{-20,20},{20,-20}},
          lineThickness=0.5,
          lineColor={170,255,170})}),
      Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Splitter that takes dynamic pressure into account.</p>
<p>In general the component has two non-linear equation systems of size 1. This can be resolved by setting Advanced-&gt;assumeConstantDensity=true (default: false).</p>
</html>"));
end DynamicSplitterN;
