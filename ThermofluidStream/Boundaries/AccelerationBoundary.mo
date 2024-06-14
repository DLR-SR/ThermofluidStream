within ThermofluidStream.Boundaries;
model AccelerationBoundary "Sets and broadcasts acceleration vector, default is
  fixed in negative z-direction with length of DropOfCommons.g"
  Modelica.Units.SI.Acceleration a[3];
  parameter Boolean setFromInputs = false annotation (choices(checkBox=true), Evaluate=true);
  Modelica.Units.SI.Acceleration ax = 0
  annotation(Dialog(group="Time varying output signal",enable=not setFromInputs));
  Modelica.Units.SI.Acceleration ay = 0
  annotation(Dialog(group="Time varying output signal",enable=not setFromInputs));
  Modelica.Units.SI.Acceleration az = -dropOfCommons.g
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
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{18,46},{-26,-12}},
          color={28,108,200},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Line(
          points={{34,36},{-10,-22}},
          color={28,108,200},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Line(
          points={{50,26},{6,-32}},
          color={28,108,200},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Line(
          points={{-30,80},{-74,22}},
          color={28,108,200},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Line(
          points={{-14,68},{-58,10}},
          color={28,108,200},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Line(
          points={{2,58},{-42,0}},
          color={28,108,200},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Line(
          points={{68,14},{24,-44}},
          color={28,108,200},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Line(
          points={{84,2},{40,-56}},
          color={28,108,200},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Line(
          points={{100,-8},{56,-66}},
          color={28,108,200},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Text(
          extent={{-4,116},{102,30}},
          textColor={28,108,200},
          textString="a")}),                                                              Diagram(
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
