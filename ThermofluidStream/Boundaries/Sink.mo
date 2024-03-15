within ThermofluidStream.Boundaries;
model Sink "Sink (p)"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Sink. Make sure it is the same as the one
the outlet the sink is connected to.
</p>
</html>"));
  parameter Boolean pressureFromInput = false "= true, if pressure input connector is enabled"
    annotation(Dialog(group="Pressure"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Pressure p0_par = Medium.p_default "Pressure set value"
    annotation(Dialog(group="Pressure", enable = not pressureFromInput));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance"
    annotation (Dialog(tab="Advanced"));

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displayPressure = true "= true, if pressure p0_par is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not pressureFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayInertance = false "= true, if inertance L is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean displayP = displayPressure and not pressureFromInput
    annotation(Evaluate=true, HideResult=true);
  final parameter String displayPos1=
    if displayP then
      "p = %p0_par"
    elseif displayInertance then
      "L = %L"
    else "";
  final parameter String displayPos2=
    if displayP and displayInertance then
      "L = %L"
    else "";
  //-----------------------------------------------------------------

  Interfaces.Inlet inlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput p0_var(unit="Pa") if pressureFromInput "Pressure input connector [Pa]"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={20,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={20,0})));

protected
  Modelica.Blocks.Interfaces.RealInput p0(unit="Pa") "Internal pressure connector";
  SI.Pressure r "Inertial pressure";
  SI.Pressure p = Medium.pressure(inlet.state) "Steady state pressure";

equation
  connect(p0_var, p0);
  if not pressureFromInput then
    p0 = p0_par;
  end if;

  der(inlet.m_flow)*L = inlet.r - r;
  r + p = p0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible=displayParameters,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString=displayPos1),
        Text(visible=displayParameters,
          extent={{-150,-130},{150,-160}},
          textColor={0,0,0},
          textString=displayPos2),
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
        Line(points={{-44,80},{-44,-80}}, color={255,255,255})}), Diagram(
        coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Sink for a thermofluid stream. The pressure can be set or given by a real signal via input connector.</p>
<p>The inertial pressure after the sinks inertance is by definition the difference between the input pressure and the set pressure. The sink therefore acts by definition as the origin of the energy to accelerate the stream. </p>
</html>"));
end Sink;
