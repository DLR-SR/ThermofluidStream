within ThermofluidStream.Idealized.Tests.Inversion;
model PseudoInversion1 "Example - Pseudo-inversion using a feedback control loop"
  extends ThermofluidStream.Idealized.Tests.Inversion.BaseClasses.PartialInverse(massFlowRateB(m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=2) annotation(Placement(transformation(extent={{0,-30},{-20,-10}})));
  Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent={{40,-10},{20,-30}})));
  Modelica.Blocks.Sources.RealExpression temperatureSetpoint1(y(
      unit="K",
      displayUnit="degC") = 298.15) annotation(Placement(transformation(extent={{80,-30},{60,-10}})));
equation
  connect(feedback.y, integrator.u) annotation(Line(points={{21,-20},{2,-20}}, color={0,0,127}));
  connect(integrator.y, massFlowRateB.m_flow_prescribed)
    annotation(Line(points={{-21,-20},{-30,-20},{-30,2}}, color={0,0,127}));
  connect(singleSensorSelect.value_out, feedback.u2) annotation(Line(points={{30,1.8},{30,-12}}, color={0,0,127}));
  connect(feedback.u1, temperatureSetpoint1.y) annotation(Line(points={{38,-20},{59,-20}}, color={0,0,127}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false, grid={2,2}),                     graphics={Text(
          extent={{-80,-60},{80,-80}},
          textColor={28,108,200},
          textString="Find sourceB.m_flow such that T_mix = 25 °C")}),
    Documentation(info="<html>
  <p>
    This example demonstrates the mixing of two fluid streams, A and B, assuming constant specific heat capacities <code>c_p</code>. 
    The mixing equation is:
  </p>

  <pre>
m_flow_A * T_A + m_flow_B * T_B = (m_flow_A + m_flow_B) * T_mix;
  </pre>

  <p>
    It can be easily solved for one unknown. This test demonstrates the \"TFS way\" of determining the mass flow rate 
    <code>m_flow_B</code> such that the mixing temperature <code>T_mix = 25&nbsp;°C</code>.
  </p>

  <p>
    Instead of using a nonlinear equation solver (e.g., <code><a href=\"modelica://ThermoFluidStream.Idealized.Tests.Inversion.Inversion1\">Inversion1</a></code>), 
    the TFS approach uses the time integration solver to solve the \"nonlinear equation\".
  </p>

  <p>
    With a reasonable start value <code>integrator.y_start</code> and integrator gain <code>integrator.k</code>, the time integration solver will converge.
    Specifically, convergence occurs for <code>y_start &gt;= 0, k &gt; 0</code> or <code>y_start &lt; 0, k &lt; 0</code>, and divergence otherwise.
  </p>

  <p>
    A larger integrator gain <code>k</code> results in faster convergence.
  </p>

  <p>
    Mathematically, we introduce an auxiliary equation:
  </p>
  
  <pre>der(m_flow_B) = f(m_flow_B)</pre>

  <p>
    Because the time integrator is usually implicit, it also solves a nonlinear equation system:
  </p>

  <pre>m_flow_B_k+1 = m_flow_B_k + F(f(m_flow_B_k+1))</pre>

  <p>For example, using implicit Euler:</p>

  <pre>m_flow_B_k+1 = m_flow_B_k + dt * f(m_flow_B_k+1)</pre>

  <p>
    This effectively iterates in time. An explicit solver would limit the integrator gain <code>k</code> and is therefore not recommended
    when aiming for high gains. In essence, this defines a custom algorithm for solving nonlinear equation systems.
  </p>

  <p>The advantages of this approach are:</p>
  <ul>
    <li>Start values can be more explicitly defined than with, for example, <code><a href=\"modelica://ThermoFluidStream.Idealized.Tests.Inversion.Inversion1\">Inversion1</a></code>.</li>
    <li>The approach can handle limitations and resembles a model-based feed-forward control, instead of an explicit inversion <code>G⁻¹(s)</code>.</li>
  </ul>

  <p>The disadvantages are:</p>
  <ul>
    <li>It introduces \"pseudo\" transients that might be undesirable.</li>
    <li>The time integration solver may have a lower convergence order. Step-size adaptive solvers may be strong, but using a controller essentially defines a custom nonlinear solver, which is usually less robust than established algorithms. Large gains or small time constants may result in stiff systems that are difficult to solve.</li>
    <li>The model-based feed-forward should ideally be stable, fast, without steady-state error, and should not introduce oscillations.</li>
    <li>It cannot produce an exact inverse model like <code>G⁻¹(s)</code>.</li>
  </ul>

  <p>
    For design purposes, inversion is beneficial when only the quasi-stationary solution is sought.
    For dynamic simulations, especially with limitations, the model-based feed-forward approach can be very effective.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end PseudoInversion1;
