within ThermofluidStream.Idealized.Sources;
model Sink_free "Sink (free) - Underdetermined (1 equation)"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Sink. Make sure it is the same as the one
the outlet the sink is connected to.
</p>
</html>"));

  parameter Boolean considerInertance = dropOfCommons.considerInertance "=true, if transient momentum (inertance) term is considered; disable only for advanced use" annotation(
    Dialog(tab="Advanced"),Evaluate=true, HideResult=true);
  parameter ThermofluidStream.Utilities.Units.Inertance L=dropOfCommons.L "Inertance" annotation(
    Dialog(tab="Advanced", enable = considerInertance), Evaluate = not considerInertance, HideResult = not considerInertance);
  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{-120,-20},{-80,20}})));

  SI.Pressure r "Inertial pressure" annotation(
    HideResult=true);

equation
  r = inlet.r;
  annotation(defaultComponentName="sink", Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,150},{150,110}},
          textString="%name",
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
          points={{-60,80},{-60,-80}},
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
        Line(points={{-44,80},{-44,-80}}, color={255,255,255}),
        Ellipse(
          extent={{-108,58},{-72,22}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-106,42},{-74,38}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),      Diagram(
        coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
  <p>Model of a free sink.</p>
  <p>
    The model is locally underdetermined (one equation missing) and therefore must be connected to an overdetermined model 
    (e.g., <a href=\"modelica://ThermoFluidStream.Idealized.Sources.MassFlowRate\">MassFlowRate</a>) 
    to ensure that the overall system is balanced.
  </p>

  <p>
    Note that the inertance <code>L</code> and the parameter <code>neglectInertance</code> are provided for convenience, but they have no effect on the model.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Sink_free;
