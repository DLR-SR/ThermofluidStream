within ThermofluidStream.Idealized.Processes;
model FlowWork "Process to consider flow work p*v (switching between open <-> closed cycle system)"
  extends ThermofluidStream.Interfaces.SISOFlow(clip_p_out = false);

  import FlowWorkBoundary = ThermofluidStream.Idealized.Types.FlowWorkBoundary;

  parameter FlowWorkBoundary boundary = ThermofluidStream.Idealized.Types.FlowWorkBoundary.Outlet "Flow work to be considered" annotation(
    Evaluate=true, HideResult=true);

  EnergyFlow.Interfaces.EnergyFlowOutput P_inlet_out = -P_inlet if boundary == FlowWorkBoundary.Inlet "Flow work of the inlet flow (directed out of the system) [W]" annotation(
    Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={-100,-110})));
  EnergyFlow.Interfaces.EnergyFlowOutput P_outlet_out = -P_outlet if boundary == FlowWorkBoundary.Outlet "Flow work of the outlet flow (directed out of the system) [W]" annotation(
    Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={100,-110})));

  Medium.SpecificEnergy w_flow "Flow work";
  SI.Power P_inlet "Flow work rate of the inlet flow";
  SI.Power P_outlet "Flow work rate of the outlet flow";

protected
  Medium.Density rho = Medium.density(inlet.state) "Density (inlet = outlet)";
  SI.SpecificVolume v = 1/rho "Specific volume (inlet = outlet)";
  Medium.AbsolutePressure p = p_in "Pressure (inlet = outlet)";

equation
  p_out = p_in;
  h_out = h_in;
  Xi_out = Xi_in;
  w_flow = p*v;
  P_inlet = -m_flow*w_flow;
  P_outlet = m_flow*w_flow;

  annotation(
    Icon(
      graphics={
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
      Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={28,108,200},
          lineThickness=0.5),
      Text(
        extent={{-150,120},{150,80}},
        textString = if displayInstanceName then "%name" else "",
        textColor=dropOfCommons.instanceNameColor),
      Text(
        extent={{-40,30},{40,-30}},
        textColor={28,108,200},
        textString="pv"),
      Line(
        points = if boundary == ThermofluidStream.Idealized.Types.FlowWorkBoundary.Outlet then {{100,0},{100,-100}} else {{0,0}},
        color={255,170,85}),
      Line(
        points = if boundary == ThermofluidStream.Idealized.Types.FlowWorkBoundary.Inlet then {{-100,0},{-100,-100}} else {{0,0}},
        color={255,170,85})}),
    Documentation(
      info="<html>
  <p>
    Process used to account for the flow work <code>w_flow = p*v</code>, which
    represents the difference between the specific enthalpy <code>h</code> and
    the specific internal energy <code>u</code>: <code>h = u + p*v</code>,
    where <code>p</code> denotes the pressure and <code>v</code> the specific
    volume.
  </p>

  <p>
    This process is required to properly account for work when switching
    between an open-cycle and a closed-cycle perspective, and vice versa.
    See, for example,
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDieselEngine.Cycle\">Examples.TurboChargedEngine.Cycle</a>.
  </p>

  <p>
    The flow work rate <code>P = -m_flow * w_flow</code> 
    is required where fluid enters the closed-cycle system, and the
    flow work rate <code>P = m_flow * w_flow</code> is
    required where fluid leaves the closed-cycle system.
    Most processes already account for the flow work if they are formulated
    using inlet and outlet specific enthalpy <code>h_in</code> and <code>h_out</code> rather than
    initial and final specific internal energy <code>u1</code> and <code>u2</code>.
  </p>

  <p>
    The sign of the flow work can be derived from the conservation of energy.
    For a closed system, the change in specific internal energy between the
    initial and final state is
    <code>u2 - u1 = q + w_cycle</code>,
    where <code>q</code> is the specific heat transfer and
    <code>w_cycle</code> is the specific work of the cycle process.<br>
    When switching to an open-system formulation, the energy balance is
    written in terms of specific enthalpy:
    <code>h2 - h1 = q + w_open</code>,
    where <code>w_open</code> denotes the specific work of the open process. 
    Alternatively one could write <code>0 = q + w_open + h_in - h_out</code> 
    and identify <code>h_in = h1</code> and <code>h_out = h2</code>.<br>
    Combining both formulations yields
    <code>w_open = w_cycle + (pv)2 - (pv)1</code>.
    Consequently, at the outlet <code>(2)</code> a
    <strong>positive</strong> flow work contribution
    <code>w_flow2 = (pv)2</code> must be considered, whereas at the inlet
    <code>(1)</code> a <strong>negative</strong> flow work contribution
    <code>-w_flow1 = -(pv)1</code> must be taken into account.
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
end FlowWork;
