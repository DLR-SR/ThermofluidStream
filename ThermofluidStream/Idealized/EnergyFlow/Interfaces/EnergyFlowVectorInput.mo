within ThermofluidStream.Idealized.EnergyFlow.Interfaces;
connector EnergyFlowVectorInput = input SI.EnergyFlowRate "SI.EnergyFlow input connector used for vector of connectors"
  annotation(
  defaultComponentName="u",
  Icon(graphics={Ellipse(
        extent={{-100,100},{100,-100}},
        lineColor={255,170,85},
        fillColor={255,170,85},
        fillPattern=FillPattern.Solid)}, coordinateSystem(
      extent={{-100,-100},{100,100}},
      preserveAspectRatio=true,
      initialScale=0.2)),
  Diagram(coordinateSystem(
      preserveAspectRatio=false,
      initialScale=0.2,
      extent={{-100,-100},{100,100}}), graphics={Text(
        extent={{-10,85},{-10,60}},
        textColor={255,170,85},
        textString="%name"), Ellipse(
        extent={{-50,50},{50,-50}},
        lineColor={255,170,85},
        fillColor={255,170,85},
        fillPattern=FillPattern.Solid)}),
  Documentation(info="<html>
  <p>
    Model 'inspired' by <a href=\"modelica://Modelica.Blocks.Interfaces.RealVectorInput\">RealVectorInput</a>.
  </p> 

  <p>
    SI.EnergyFlowRate input connector that is used for a vector of connectors,
    for example <a href=\\\"modelica://ThermofluidStream.Idealized.EnergyFlow.Components.Sum\">Sum</a>,
    and has therefore a different icon as EnergyFlowInput connector.
  </p>
</html>
", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
