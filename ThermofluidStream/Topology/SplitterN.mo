within ThermofluidStream.Topology;
model SplitterN "Splitter with one inlet and N outlets"
  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));

  parameter Integer N(min=1) = 1 "Number of outputs";
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance on each Branch of Component"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Inlet inlet(redeclare package Medium = Medium) "inlet"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
      iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outlets[N](redeclare package Medium = Medium) "vector of N outlets"
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
      iconTransformation(extent={{80,-20},{120,20}})));

protected
  outer DropOfCommons dropOfCommons;

  SI.Pressure r_mix;

equation
  der(inlet.m_flow) * L = inlet.r - r_mix;

  for i in 1:N loop
    der(outlets[i].m_flow) * L = outlets[i].r - r_mix;
    outlets[i].state = inlet.state;
  end for;

  sum(outlets.m_flow) + inlet.m_flow = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{0,0},{80,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{100,10}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{100,-10}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-80,0},{0,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{90,80},{50,40}},
          textColor={175,175,175},
          textString="%N")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end SplitterN;
