within ThermofluidStream.Boundaries;
model AccelerationBoundary "Sets and broadcasts acceleration vector, default is
  fixed in negative z-direction with length of DropOfCommons.g"
  SI.Acceleration a[3];
  parameter Boolean setFromInputs = false annotation (choices(checkBox=true), Evaluate=true);
  SI.Acceleration ax = 0
  annotation(Dialog(group="Time varying output signal",enable=not setFromInputs));
  SI.Acceleration ay = 0
  annotation(Dialog(group="Time varying output signal",enable=not setFromInputs));
  SI.Acceleration az = -dropOfCommons.g
  annotation(Dialog(group="Time varying output signal",enable=not setFromInputs));
  Modelica.Blocks.Interfaces.RealInput ux if setFromInputs
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput uy if setFromInputs
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput uz if setFromInputs
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
protected
  outer ThermofluidStream.DropOfCommons dropOfCommons;
equation
  connect(ux,a[1]);
  connect(uy,a[2]);
  connect(uz,a[3]);
  if not setFromInputs then
    a={ax,ay,az};
  end if;
  annotation (defaultComponentName="acceleration",
    defaultComponentPrefixes="inner",
    missingInnerMessage="
Your model is using an outer \"acceleration\" component but
an inner \"acceleration\" component is not defined.
Use SAABdefinedMedia.AccelerationBoundary in your model
to specify system wide accelerartion.",Icon(coordinateSystem(preserveAspectRatio=false),
        graphics={
        Rectangle(
          extent={{-100,100},{100,-98}},
          lineColor={206,103,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{20,98},{100,18}},
          textColor={206,103,0},
          textString="a"),
        Line(
          points={{80,-12},{30,-80}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{40,20},{-10,-48}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{0,48},{-50,-20}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{-40,80},{-90,12}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{-90,28},{-90,12},{-74,14}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{-50,-4},{-50,-20},{-34,-18}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{-10,-32},{-10,-48},{6,-46}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{30,-64},{30,-80},{46,-78}},
          color={206,103,0},
          thickness=1)}),                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><br>This component sets&nbsp;and&nbsp;broadcasts an&nbsp;acceleration&nbsp;vector.&nbsp;The default&nbsp;is fixed&nbsp;in&nbsp;negative&nbsp;z-direction&nbsp;with&nbsp;length&nbsp;of&nbsp;DropOfCommons.g. The acceleration can be set either by inputs or real expressions.</p>
<p><span style=\"color: #ff5500;\">Beware: This is a new addition to the library. It may be subject to design reconsiderations in future versions.</span></p>
</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end AccelerationBoundary;
