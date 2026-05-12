within ThermofluidStream.Idealized.EnergyFlow.Interfaces;
connector EnergyFlowOutput = output SI.EnergyFlowRate "'output SI.EnergyFlowRate' as connector"
annotation(
  defaultComponentName="E_flow_out",
  Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Polygon(
      lineColor={255,170,85},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})}),
  Diagram(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Polygon(
      lineColor={255,170,85},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      points={{-100.0,50.0},{0.0,0.0},{-100.0,-50.0}}),
    Text(
      textColor={255,170,85},
      extent={{30.0,60.0},{30.0,110.0}},
      textString="%name")}),
  Documentation(info="<html>
  <p>
    Model 'inspired' by <a href=\"modelica://Modelica.Blocks.Interfaces.RealOutput\">Modelica.RealOutput</a>.
  </p> 

  <p>
    Connector with one output signal of type <code>SI.EnergyFlowRate</code> (e.g., heat flow rate or power).
  </p>

  <p>
    The connector is fully compatible with <code>Modelica.RealInput/Output</code>. It is introduced to improve the distinction between physical energy flow and, for example, control signal flow. 
    The connector indicates the direction of information flow (in terms of solving a system of equation). It does <strong>not</strong> indicate the actual positive direction of energy flow.
  </p>
</html>"));
