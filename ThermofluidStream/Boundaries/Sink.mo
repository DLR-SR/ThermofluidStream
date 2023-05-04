within ThermofluidStream.Boundaries;
model Sink "Boundary model of sink"
    replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Sink. Make sure it is the same as the one
the outlet the sink is connected to.
</p>
</html>"));

  parameter Boolean pressureFromInput = false "If true pressure comes from real input";
  parameter SI.Pressure p0_par = Medium.p_default "Pressure setpoint of Sink"
    annotation(Dialog(enable = not pressureFromInput));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of pressure"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Inlet inlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));

  Modelica.Blocks.Interfaces.RealInput p0_var(unit="Pa")=p0 if pressureFromInput "Pressure setpoint [Pa]"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={20,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={20,0})));

protected
  outer DropOfCommons dropOfCommons;

  SI.Pressure p0;
  SI.Pressure r;

  SI.Pressure p = Medium.pressure(inlet.state);

equation
  if not pressureFromInput then
    p0 = p0_par;
  end if;

  der(inlet.m_flow)*L = inlet.r - r;
  r + p = p0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
          points={{-80,0},{-60,0}},
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
        Line(points={{-44,80},{-44,-80}}, color={255,255,255})}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Sink for a thermofluid stream. The pressure can be set or given by a real signal via input connector.</p>
<p>The inertial pressure after the sinks inertance is by definition the difference between the input pressure and the set pressure. The sink therefore acts by definition as the origin of the energy to accelerate the stream. </p>
</html>"));
end Sink;
