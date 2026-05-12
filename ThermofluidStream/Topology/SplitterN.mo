within ThermofluidStream.Topology;
model SplitterN "Splitter with one inlet and N outlets"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Integer N(min=1) = 1 "Number of outputs";
  parameter Boolean neglectInertance = dropOfCommons.neglectInertance "=true, if mass flow rate dynamics are neglected - advanced mode!"
    annotation(Dialog(tab="Advanced"),Evaluate=true, HideResult=true);
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
    annotation(Dialog(tab="Advanced", enable = not neglectInertance), HideResult = neglectInertance);


  Interfaces.Inlet inlet(redeclare package Medium = Medium) "Inlet"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
      iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outlets[N](redeclare package Medium = Medium) "Vector of N outlets"
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
      iconTransformation(extent={{80,-20},{120,20}})));

protected
  SI.Pressure r_mix "Inertial pressure of mixture";

equation
  if not neglectInertance then
    der(inlet.m_flow) * L = inlet.r - r_mix;
  else
    0 = inlet.r - r_mix;
  end if;

  for i in 1:N loop
    if not neglectInertance then
      der(outlets[i].m_flow) * L = outlets[i].r - r_mix;
    else
      0 = outlets[i].r - r_mix;
    end if;
    outlets[i].state = inlet.state;
  end for;

  sum(outlets.m_flow) + inlet.m_flow = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
       Text(visible=displayInstanceName,
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Line(
          points={{0,0},{96,10}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{96,-10}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{120,-20},{80,-60}},
          textColor={175,175,175},
          textString="%N"),
        Ellipse(visible = neglectInertance,
          extent={{80,40},{100,20}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Generic splitter with one upstream connection and an array of <strong>N</strong> downstream connections. Use this model to parameterize the number of branches and avoid building large splitter trees manually. This is the recommended approach for scalable network templates.</p>
</html>"));
end SplitterN;
