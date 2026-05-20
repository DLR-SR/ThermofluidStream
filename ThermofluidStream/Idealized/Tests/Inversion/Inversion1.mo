within ThermofluidStream.Idealized.Tests.Inversion;
model Inversion1 "Example - Inversion with non-linear equations solver and h as iteration variable"
  extends ThermofluidStream.Idealized.Tests.Inversion.BaseClasses.PartialInverse(
    massFlowRateB(m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed),
    dropOfCommons(considerInertance=false));
  extends ThermofluidStream.Idealized.Utilities.IconInertanceNeglect;

  Modelica.Blocks.Sources.RealExpression temperatureSetpoint(y(
      unit="K",
      displayUnit="degC") = 298.15) annotation(
    Placement(transformation(extent={{74,-40},{54,-20}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints annotation(
    Placement(transformation(extent={{20,-42},{-20,-18}})));

equation
  connect(temperatureSetpoint.y, inverseBlockConstraints.u1) annotation(Line(points={{53,-30},{22,-30}},   color={0,0,127}));
  connect(inverseBlockConstraints.y2, massFlowRateB.m_flow_prescribed) annotation(Line(points={{-17,-30},{-12,-30},{-12,-8},{-30,
          -8},{-30,2}},                                                                                                             color={0,0,127}));
  connect(singleSensorSelect.value_out, inverseBlockConstraints.u2) annotation(Line(points={{30,1.8},{30,-10},{4,-10},{
          4,-30},{16,-30}},                                                                                                                  color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-120,-100},{100,140}}),
      graphics={
        Text(
          extent={{-84,-52},{76,-72}},
          textColor={28,108,200},
          textString="Find massFlowRateB such that T_mix = 25 °C"),
        Polygon(
          points={{-120,80},{-80,80},{-80,100},{-100,100},{-100,140},{-120,140},{-120,80}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-90,130},{-10,110}},
          textColor={238,46,47},
          textString="requires considerInertance = false
see User's Guide",
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(
      info="<html>
  <p>
    Mixing of two fluid streams, A and B. Assuming constant specific heat capacities <code>c_p</code>, the mixing equation is:
  </p>

  <blockquote><pre>
m_flow_A * T_A + m_flow_B * T_B = (m_flow_A + m_flow_B) * T_mix;
  </pre></blockquote>

  <p>
    This equation can be easily solved for a single unknown.
  </p>

  <p>
    In this test, the goal is to determine the mass flow rate <code>m_flow_B</code> such that the mixture temperature is 
    <code>T_mix = 25&nbsp;°C</code>. The solution is:
  </p>

  <blockquote><pre>
m_flow_B = - m_flow_A * (T_B - T_mix) / (T_A - T_mix)
         = - 1 kg/s * (30 - 25) / (20 - 25)
         = 1 kg/s
  </pre></blockquote>

  <p>
    Dymola uses the mass flow rate
    <code>junction.m_flowA</code> and the specific enthalpy of the mixture <code>junction.h_mix</code> as the iteration variable. Their default start values might not be appropriate, which can cause the simulation to fail.
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
end Inversion1;
