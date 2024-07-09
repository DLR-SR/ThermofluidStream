within ThermofluidStream.Undirected.Sensors;
model SensorState "State sensor"

  extends Internal.PartialSensor;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected.</p>
        </html>"));

  ThermofluidStream.Interfaces.StateOutput state_out(redeclare package Medium = Medium) "State output connector"
    annotation (Placement(transformation(extent={{70,50},{90,70}}), iconTransformation(extent={{70,50},{90,70}})));

equation

  state_out.state = state;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,-25},{150,-65}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Rectangle(
          extent={{-54,84},{66,24}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{0,34},{0,0}},    color={0,0,0}),
        Rectangle(
          extent={{-60,90},{60,30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,90},{60,30}},
          textColor={28,108,200},
          textString="state"),
        Ellipse(
          extent={{-5,5},{5,-5}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{60,60},{78,60}},
          color={162,29,33})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Sensor for measuring the full state.</p>
<p>This sensor can be connected to a fluid stream without a junction.</p>
</html>"));
end SensorState;
