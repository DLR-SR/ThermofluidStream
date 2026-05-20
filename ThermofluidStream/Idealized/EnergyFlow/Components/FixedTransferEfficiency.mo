within ThermofluidStream.Idealized.EnergyFlow.Components;
model FixedTransferEfficiency "Model with fixed transfer efficiency"

  parameter SI.Efficiency eta(final max = 1) = 1 "Transfer efficiency";
  parameter Boolean outputDissipation = false "= true, if dissipation output connector is enabled" annotation(
    Evaluate=true, HideResult=true, choices(checkBox=true));
  Real direction = sign(E_flow_in) "= 1.0 if physical direction of power flow is from input to output, = -1.0 if opposite";
  SI.EnergyFlowRate E_flow_dissipation "Dissipative energy flow rate (into the system) <0";

  Interfaces.EnergyFlowInput E_flow_in annotation(
    Placement(transformation(extent={{-140,-20},{-100,20}})));
  Interfaces.EnergyFlowOutput E_flow_out annotation(
    Placement(transformation(extent={{100,-10},{120,10}})));
  Interfaces.EnergyFlowOutput E_flow_dissipation_out = -E_flow_dissipation if outputDissipation "Dissipative energy flow rate" annotation(
    Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={0,-50})));


equation
    if noEvent(E_flow_in >= 0) then
      E_flow_out = eta*E_flow_in;
      E_flow_dissipation = -(1 - eta)*E_flow_in;
    else
      if noEvent(eta > 0) then
        E_flow_out = 1/eta*E_flow_in;
        E_flow_dissipation = (1 - eta)*E_flow_out;
      else
        E_flow_out = 0;
        E_flow_dissipation = 0;
        assert(false, "Problem not well defined for eta = 0 and E_flow_in < 0.", AssertionLevel.error);
      end if;
    end if;
    // DynamicSelect(FillPattern.None, if abs(E_flow_dissipation) > Modelica.Constants.eps then FillPattern.Solid else FillPattern.None),
  annotation(defaultComponentName="transfer",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-70},{150,-100}},
          textColor={0,0,0},
          textString = if outputDissipation then "eta = %eta" else ""),
        Text(
          extent={{-150,-20},{150,-50}},
          textColor={0,0,0},
          textString = if not outputDissipation then "eta = %eta" else ""),
        Line(
          points={{-100,0},{100,0}},
          color={255,170,85},
          thickness=0.5),
        Line(
          points = if outputDissipation then {{0,0},{0,-40}} else {{0,0}},
          color={255,170,85},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={255,170,85},
          fillColor={255, 165, 70},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(origin={102,-30},
          rotation = if E_flow_out >= 0 then 0 else 180,
          points={{-18,3},{4,3},{4,10},{18,0},{4,-10},{4,-3},{-18,-3},{-18,3}},
          fillColor = {255,170,85},
          fillPattern = if abs(E_flow_out) >= 1e-8 then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None),
        Text(
          origin={86,-48},
          extent={{0,0},{36,36}},
          textColor={255,170,85},
          textStyle={TextStyle.Bold},
          textString= if abs(E_flow_out) < 1e-8 then "0" else ""),
        Polygon(origin={-122,-30},
          rotation = if E_flow_in >= 0 then 0 else 180,
          points={{-18,3},{4,3},{4,10},{18,0},{4,-10},{4,-3},{-18,-3},{-18,3}},
          fillColor = {255,170,85},
          fillPattern = if abs(E_flow_in) >= 1e-8 then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None),
        Text(
          origin={-136,-48},
          extent={{0,0},{36,36}},
          textColor={255,170,85},
          textStyle={TextStyle.Bold},
          textString= if abs(E_flow_in) < 1e-8 then "0" else ""),
        Polygon(visible = outputDissipation,
          origin={-25,-45},
          rotation = -90,
          points={{-18,3},{4,3},{4,10},{18,0},{4,-10},{4,-3},{-18,-3},{-18,3}},
          fillColor = {255,170,85},
          fillPattern = if abs(E_flow_dissipation) >= 1e-8 then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None),
        Text(visible = outputDissipation,
          origin={-44,-66},
          extent={{0,0},{36,36}},
          textColor={255,170,85},
          textStyle={TextStyle.Bold},
          textString= if abs(E_flow_dissipation) < 1e-8 then "0" else "")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    This model assumes a fixed transfer efficiency <code>eta</code> in the direction of the actual (positive) energy flow.
  </p>
  
  <p>
    The actual (positive) direction of energy flow is indicated by arrows on icon layer.
  </p>
  
  <p>
    Note that the case <code>eta = 0</code>, <code>E_flow_in &le; 0</code> 
    (which implies <code>E_flow_out = E_flow_dissipation</code>) is not well-defined.
  </p>
</html>"));
end FixedTransferEfficiency;
