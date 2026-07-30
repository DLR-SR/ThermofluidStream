within ThermofluidStream.Idealized.Boundaries;
model Sink_free "Sink (free) - Underdetermined (1 equation)"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  parameter Boolean considerInertance = dropOfCommons.considerInertance "=true, if transient momentum (inertance) term is considered; disable only for advanced use" annotation(
    Dialog(tab="Advanced"), Evaluate=true, HideResult=true);
  parameter ThermofluidStream.Utilities.Units.Inertance L = dropOfCommons.L "Inertance" annotation(
    Dialog(tab="Advanced", enable = considerInertance), Evaluate = not considerInertance, HideResult = not considerInertance);

  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{-120,-20},{-80,20}})));

  SI.Pressure r "Inertial pressure" annotation(
    HideResult=true);

equation
  if considerInertance then
    der(inlet.m_flow)*L = inlet.r - r;
  else
    0 = inlet.r - r;
  end if;

  annotation(
    defaultComponentName="sink",
    Icon(
      coordinateSystem(
        preserveAspectRatio=true),
      graphics={
        Text(
          extent={{-150,150},{150,110}},
          textString = if displayInstanceName then "%name" else "",
          textColor=dropOfCommons.instanceNameColor),
        Text(
          extent={{-150,-100},{150,-130}},
          textColor={0,0,0},
          textString="free"),
        Rectangle(
          extent={{-56,76},{4,-84}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-60,80},{0,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{-60,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-12,80},{-12,-80}},
          color={255,255,255},
          thickness=1),
        Line(
          points={{-28,80},{-28,-80}},
          color={255,255,255},
          thickness=0.5),
        Line(
          points={{-44,80},{-44,-80}},
          color={255,255,255}),
        Ellipse(
          extent={{-108,78},{-72,42}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-106,62},{-74,58}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-100,40},{-80,20}},
          fillColor={238,46,47},
          pattern=LinePattern.None,
          fillPattern= if considerInertance then FillPattern.None else FillPattern.Solid),
        Line(
          points={{-60,80},{-60,-80}},
          color={28,108,200},
          thickness=0.5)}),
    Documentation(
      info="<html>
  <p>
    Model of a free sink.
  </p>

  <p>
    The model is locally underdetermined (one equation missing) and therefore must be connected to an overdetermined model 
    (e.g., <a href=\"modelica://ThermofluidStream.Idealized.Boundaries.MassFlowRate\">MassFlowRate</a>) 
    to ensure that the overall system is balanced.
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Sink_free;
