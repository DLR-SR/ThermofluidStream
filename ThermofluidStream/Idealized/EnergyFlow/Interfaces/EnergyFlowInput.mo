within ThermofluidStream.Idealized.EnergyFlow.Interfaces;
connector EnergyFlowInput = input SI.EnergyFlowRate "'input SI.EnergyFlowRate' as connector"
annotation(
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
    Connector with one input signal of type <code>SI.EnergyFlowRate</code> (e.g., heat flow rate or power), see <a href=\"modelica://ThermofluidStream.Idealized.UsersGuide.EnergyFlow\">UsersGuide.EnergyFlow</a>.
  </p>

  <p>
    The energy flow connector is compatible with standard Modelica Real input and output connectors. 
    It was introduced to emphasize its physical meaning and to clearly differentiate power and heat flow from, for example, control signals.
  </p>

  <p>
    The input and output connectors define the direction of information flow and must not be confused with the
    physical positive direction of energy flow, which can be indicated next to the connector on the icon layer
    during simulation.<br>
    <code>EnergyFlowInput</code> is defined as energy flowing <strong>into</strong> the system.<br>
    <code>EnergyFlowOutput</code> is defined as energy flowing <strong>out</strong> of the system.<br>
    This definition allows inputs and outputs to be connected directly.
  </p>
</html>"));
