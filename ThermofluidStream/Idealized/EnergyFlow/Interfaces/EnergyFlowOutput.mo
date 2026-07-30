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
      Documentation(
        info="<html>
  <p>
    Model 'inspired' by <a href=\"modelica://Modelica.Blocks.Interfaces.RealOutput\">Modelica.RealOutput</a>.
  </p> 

  <p>
    Connector with one output signal of type <code>SI.EnergyFlowRate</code> (e.g., heat flow rate or power), see <a href=\"modelica://ThermofluidStream.Idealized.UsersGuide.EnergyFlow\">UsersGuide.EnergyFlow</a>.
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
</html>",
        revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
