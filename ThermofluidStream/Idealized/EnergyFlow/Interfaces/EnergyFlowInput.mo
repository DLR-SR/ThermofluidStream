within ThermofluidStream.Idealized.EnergyFlow.Interfaces;
connector EnergyFlowInput = input SI.EnergyFlowRate "'input SI.EnergyFlowRate' as connector"
annotation (
  defaultComponentName="E_flow_in",
  Icon(graphics={
    Polygon(
      lineColor={255,170,85},
      fillColor={255,170,85},
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
      lineColor={255,170,85},
      fillColor={255,170,85},
      fillPattern=FillPattern.Solid,
      points={{0.0,50.0},{100.0,0.0},{0.0,-50.0},{0.0,50.0}}),
    Text(
      textColor={255,170,85},
      extent={{-10.0,60.0},{-10.0,85.0}},
      textString="%name")}),
  Documentation(info="<html>
  <p>
    Model 'inspired' by <a href=\"modelica://Modelica.Blocks.Interfaces.RealInput\">Modelica.RealInput</a>.
  </p> 

  <p>
    Connector with pne input signal of type <code>SI.EnergyFlowRate</code> (e.g., heat flow rate or power).
  </p>

  <p>
    The connector is fully compatible with <code>Modelica.RealInput/Output</code>. It is introduced to improve the distinction between physical energy flow and, for example, control signal flow. 
    The connector indicates the direction of information flow (in terms of solving a system of equation). It does <strong>not</strong> indicate the actual positive direction of energy flow.
  </p>
</html>"));
