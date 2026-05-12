within ThermofluidStream.Idealized.EnergyFlow.Sources;
model PrescribedEnergyFlow "Prescribed energy flow rate boundary condition"

  Modelica.Blocks.Interfaces.RealInput E_flow(unit="W")
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  Interfaces.EnergyFlowOutput E_flow_out annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation
  E_flow_out = E_flow;
  annotation (defaultComponentName = "energyFlowSource",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{-80,-20},{62,-20}},
          color={255,170,85},
          thickness=0.5),
        Line(
          points={{-80,20},{60,20}},
          color={255,170,85},
          thickness=0.5),
        Polygon(
          points={{50,0},{50,40},{80,20},{50,0}},
          lineColor={255,170,85},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{50,-40},{50,0},{80,-20},{50,-40}},
          lineColor={255,170,85},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,40},{100,-40}},
          lineColor={255,170,85},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,0},{-80,20}},
          color={255,170,85},
          thickness=0.5),
        Line(
          points={{-100,0},{-80,-20}},
          color={255,170,85},
          thickness=0.5),
        Polygon(origin={128,-26},
          rotation = if E_flow >= 0 then 0 else 180,
          points={{-18,3},{4,3},{4,10},{18,0},{4,-10},{4,-3},{-18,-3},{-18,3}},
          fillColor = {255,170,85},
          fillPattern = if abs(E_flow_out) >= 1e-8 then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None),
        Text(
          origin={100,-44},
          extent={{0,0},{36,36}},
          textColor={255,170,85},
          textStyle={TextStyle.Bold},
          textString= if abs(E_flow_out) < 1e-8 then "0" else "")}),
    Documentation(info="<html>
   <p>
    Model 'inspired' by <a href=\"modelica://Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow\">PrescribedHeatFlow</a>.
  </p>  

  <p>
    This model allows a specified amount of energy flow rate to be \"injected\"
    into a thermodynamic system at a given port.  The amount of energy flow
    is given by the input signal E_flow into the model. The energy flows out of this component and into the
    component to which the component PrescribedEnergyFlow is connected,
    if the input signal is positive.
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
end PrescribedEnergyFlow;
