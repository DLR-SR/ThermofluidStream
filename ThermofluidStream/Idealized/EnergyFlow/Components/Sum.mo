within ThermofluidStream.Idealized.EnergyFlow.Components;
block Sum "Sum of energy flow rates"

  parameter Integer n_in(min=0) = 0 "Number of input connections"
    annotation(Dialog(connectorSizing=true), HideResult=true);

  Interfaces.EnergyFlowVectorInput E_flow_in[n_in]
    annotation(Placement(transformation(extent={{-120,60},{-80,-60}}), iconTransformation(extent={{-120,60},{-80,-60}})));
  Interfaces.EnergyFlowOutput E_flow_out
    annotation(Placement(transformation(extent={{100,-17},{134,17}})));

equation
  if size(E_flow_in, 1) > 0 then
    E_flow_out =fill(1, n_in)*E_flow_in;
  else
    E_flow_out = 0;
  end if;

annotation(Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-88,6},{-22,-6}},
          lineColor={255,170,85},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255}),
        Ellipse(lineColor={255,170,85}, extent={{-30,-30},{30,30}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere,
          lineThickness=0.5),
        Line(points={{30,0},{100,0}}, color={255,170,85}),
        Text(extent={{-20,20},{20,-20}},
          textColor={0,0,0},
          textString="+"),
        Polygon(origin={108,-32},
          rotation = if E_flow_out >= 0 then 0 else 180,
          points={{-18,3},{4,3},{4,10},{18,0},{4,-10},{4,-3},{-18,-3},{-18,3}},
          fillColor = {255,170,85},
          fillPattern = if abs(E_flow_out) >= 1e-8 then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None),
        Text(
          origin={98,-48},
          extent={{0,0},{36,36}},
          textColor={255,170,85},
          textStyle={TextStyle.Bold},
          textString = if abs(E_flow_out) < 1e-8 then "0" else "")}), Documentation(info="<html>
  <p>
    Model 'inspired' by <a href=\"modelica://Modelica.Blocks.Math.MultiSum\">Modelica.Blocks.Math.MultiSum</a>. See its documentation for further information.
  </p> 
</html>"));
end Sum;
