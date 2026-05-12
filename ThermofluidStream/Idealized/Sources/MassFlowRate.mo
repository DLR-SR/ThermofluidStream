within ThermofluidStream.Idealized.Sources;
model MassFlowRate "Generic mass flow rate source - Overdetermined (1 equation)"

  extends ThermofluidStream.Interfaces.SISOFlow(clip_p_out = true);

  import ValueSpecification = ThermofluidStream.Types.ValueSpecification;

  parameter ValueSpecification m_flowSpec=ThermofluidStream.Types.ValueSpecification.Fixed "Method for specifying the value of the mass flow rate" annotation (Dialog(group="Specification"), Evaluate=true);
  parameter SI.MassFlowRate m_flow_fixed = 0 "Fixed mass flow rate" annotation(
    Dialog(group="Specification",
      enable = m_flowSpec ==ValueSpecification.Fixed),
      HideResult = not m_flowSpec == ValueSpecification.Fixed);
  parameter Boolean showMassFlowRate = true "= true to show the fixed mass flow rate value m_flow_fixed" annotation(
    Dialog(tab="Layout", group="Display parameters", enable = displayParameters and m_flowSpec ==ValueSpecification.Fixed),  Evaluate=true, HideResult=true, choices(checkBox=true));

  Modelica.Blocks.Interfaces.RealInput m_flow_prescribed(unit="kg/s") if m_flowSpec ==ValueSpecification.Prescribed  "Prescribed mass flow rate [kg/s]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,-80})));

protected
  Modelica.Blocks.Interfaces.RealInput m_flow_actual(unit = "kg/s") "Actual mass flow rate [kg/s], required due to the conditional connector m_flow_prescribed";

equation
  connect(m_flow_actual, m_flow_prescribed);
  if m_flowSpec ==ValueSpecification.Fixed  then
    m_flow_actual = m_flow_fixed;
  end if;
  m_flow = m_flow_actual;

  dp = 0;

  h_out = h_in;
  Xi_out = Xi_in;

  annotation (Icon(graphics={
        Text(visible=displayInstanceName,
          extent={{-150,80},{150,120}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible=displayParameters and showMassFlowRate and m_flowSpec == ThermoFluidStream.Types.ValueSpecification.Fixed,
          extent={{-150,-70},{150,-100}},
          textColor={0,0,0},
          textString="ṁ = %m_flow_fixed"),
        Ellipse(
          extent={{-56,54},{64,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-30,0},{30,0}},
          color={28,108,200},
          thickness=1),
        Polygon(
          points={{12,10},{32,0},{12,-10},{12,10}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-98,58},{-62,22}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-78,24},{-82,56}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-96,42},{-64,38}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
        Documentation(info="<html>
  <p>Model for specifying the mass flow rate.</p>
  <p>
    The model is locally overdetermined (one extra equation) and therefore must be connected to an underdetermined model 
    (e.g., <a href=\"modelica://ThermoFluidStream.Idealized.Sources.Sink_free\">Sink_free</a>) 
    to ensure that the overall system balanced.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end MassFlowRate;
