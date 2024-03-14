within ThermofluidStream.Undirected.Sensors;
model SensorState "Sensor for whole state"
  extends Internal.PartialSensor;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected.</p>
        </html>"));

  ThermofluidStream.Interfaces.StateOutput state_out(redeclare package Medium = Medium) "Measured value [variable]"
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

equation

  state_out.state = state;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-54,24},{66,-36}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{0,0},{0,-80}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-60,30},{60,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,30},{60,-30}},
          textColor={28,108,200},
          textString="state"),
        Ellipse(
          extent={{-5,-75},{5,-85}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Sensor for measuring the full state.</p>
<p>This sensor can be connected to a fluid stream without a junction.</p>
</html>"));
end SensorState;
