within ThermofluidStream.Interfaces;
connector StateInput "Thermodynamic state as connector"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Model of the medium for this thermodynamic state connector.</p>
</html>"));

  input Medium.ThermodynamicState state "Thermodynamic state";

  annotation (
    defaultComponentName="u",
    Icon(graphics={
      Polygon(
        lineColor={162,29,33},
        fillColor={162,29,33},
        fillPattern=FillPattern.Solid,
        points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})},
      coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(
      coordinateSystem(preserveAspectRatio=true,
        initialScale=0.2,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Polygon(
        lineColor={162,29,33},
        fillColor={162,29,33},
        fillPattern=FillPattern.Solid,
        points={{0.0,50.0},{100.0,0.0},{0.0,-50.0},{0.0,50.0}}),
      Text(
        textColor={162,29,33},
        extent={{-10.0,60.0},{-10.0,85.0}},
        textString="%name")}),
    Documentation(info="<html>
<p>Connector with one input signal of type Medium.Thermodynamic state. </p>
</html>"));

end StateInput;
