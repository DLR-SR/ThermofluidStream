within ThermofluidStream.Sensors;
model SensorState "Sensor for thermodynamic state"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus(displayInstanceName = false);

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true,
      Documentation(info="<html>
        <p>Medium Model for the sensor. Make sure it is the same as for all lines the sensors input is connected.</p>
        </html>"));
  Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Interfaces.StateOutput state_out(redeclare package Medium = Medium) "State output connector"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation
  inlet.m_flow = 0;

  state_out.state = inlet.state;

  annotation (defaultComponentName ="stateSensor",Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Rectangle(
          extent={{-74,24},{86,-36}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-80,30},{60,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,26},{60,-26}},
          textColor={0,0,0},
          textString=" state "),
        Line(
          points={{60,0},{100,0}},
          color={162,29,33})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Sensor for measuring the full state.</p>
<p>This sensor can be connected to a fluid stream without a junction.</p>
</html>"));
end SensorState;
