within ThermofluidStream.Idealized.Tests.Inversion;
model Inversion2 "Example - Inversion with temperature as iteration variable"
  extends ThermofluidStream.Idealized.Tests.Inversion.BaseClasses.PartialInverse(sourceB(T0_var(start=Medium.T_default), temperatureFromInput=true), junction(h_mix(start=Medium.specificEnthalpy_pT(1e5, 273.15 + 20))));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraintsannotation(
    Placement(transformation(extent={{-40,-44},{0,-20}})));
  Modelica.Blocks.Sources.RealExpression temperatureSetpoint(y(
      unit="K",
      displayUnit="degC") = 298.15) annotation(Placement(transformation(extent={{-80,-42},{-60,-22}})));
equation
  connect(temperatureSetpoint.y, inverseBlockConstraints.u1)annotation(
    Line(points={{-59,-32},{-42,-32}}, color={0,0,127}));
  connect(singleSensorSelect.value_out, inverseBlockConstraints.u2)annotation(
    Line(points={{30,1.8},{30,-12},{-26,-12},{-26,-32},{-36,-32}}, color={0,0,127}));
  connect(inverseBlockConstraints.y2, sourceB.T0_var)annotation(
    Line(points={{-3,-32},{-6,-32},{-6,-8},{-84,-8},{-84,10},{-72,10}}, color={0,0,127}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-100,100},{-60,80}},
          textColor={28,108,200},
          textString="fails in OM"), Text(
          extent={{-80,-60},{80,-80}},
          textColor={28,108,200},
          textString="Find sourceB.T such that T_mix = 25 °C")}),
    Documentation(info="<html>
  <p>
    Mixing of two fluid flows A and B. Assuming constant specific heat capacities <code>c_p</code>, the mixing equation is:
  </p>

  <blockquote>
    <pre>
      m_flow_A * T_A + m_flow_B * T_B = (m_flow_A + m_flow_B) * T_mix;
    </pre>
  </blockquote>

  <p>
    This equation can be easily solved for a single unknown.
  </p>

  <p>
    In this test, we solve for the temperature <code>T_B</code> such that the mixing temperature is <code>T_mix = 25&nbsp;°C</code>. The solution is:
  </p>

  <blockquote>
    <pre>
      T_B = ((m_flow_A + m_flow_B) * T_mix - m_flow_A * T_A) / m_flow_B
    = (2*25 - 1*20) / 1 °C
    = 30 °C
    </pre>
  </blockquote>

  <p>
    Dymola uses the temperature <code>sourceB.T0</code> as the iteration variable and defaults the start value to <code>T0 = 0</code>, which causes the simulation to fail. 
    By specifying <code>sourceB(T0(start=Medium.T_default))</code>, Dymola can solve the 'nonlinear' equation.
  </p>

  <p>
    Since <code>T0</code> is <code>protected</code>, giving it a start value generates a warning, and removing the <code>protected</code> modifier would cause an error due to the current implementation of the source. 
    However, using <code>sourceB(T0_var(start=Medium.T_default))</code> (which is not protected) allows Dymola to solve the nonlinear equation correctly.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Inversion2;
