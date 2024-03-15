within ThermofluidStream.Undirected.Sensors;
model UnidirectionalSensorAdapter "Adapter to connect a unidirectional sensor"

  extends Internal.PartialSensor;

  ThermofluidStream.Interfaces.Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,100}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,100})));

equation
  outlet.r = rear.r;
  outlet.state = state;

  annotation (Icon(
    graphics={
      Text(visible=displayInstanceName,
          extent={{-150,-65},{150,-25}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
      Line(
        points={{0,0},{0,98}},
        color={28,108,200},
        thickness=0.5),
      Ellipse(
        extent={{-5,-5},{5,5}},
        lineColor={28,108,200},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        lineThickness=0.5)},
    coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}})),
                                                  Diagram(
     coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>A adapter to outputs the relevant state of the undirected flow, with r=0 at the outlet. It can be used to connect a unidirectional sensor to a undirected network.</p>
</html>"));
end UnidirectionalSensorAdapter;
