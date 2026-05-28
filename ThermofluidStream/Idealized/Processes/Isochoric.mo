within ThermofluidStream.Idealized.Processes;
model Isochoric "Stationary flow representation of isochoric cycle process"
  extends ThermofluidStream.Interfaces.SISOFlow(clip_p_out = false, dp(start = dp_start));

  import SystemSpecification = ThermofluidStream.Idealized.Types.SystemModel;
  import OutletSpecification = ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric;
  import HeatFlowSignal = ThermofluidStream.Idealized.Types.EnergyFlowSignalMode;
  import ValueSpecification = ThermofluidStream.Types.ValueSpecification;
  import Modelica.Constants.eps;

  parameter HeatFlowSignal heatFlowSignal = ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Disabled "Heat flow signal configuration" annotation(
    Dialog(group="Specification"), HideResult=true, Evaluate=true);
  parameter SystemSpecification systemSpec = ThermofluidStream.Idealized.Types.SystemModel.Cycle "Select whether the system is steady-flow (open) or a closed cycle (periodic)" annotation(
    Dialog(group="Specification"), Evaluate=true);
  parameter Boolean specifyOutlet = true "= true, if the outlet state is explicitly specified" annotation(
    Dialog(group="Specification"), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter OutletSpecification outletSpec = ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference "Quantity used to define the outlet state" annotation(
    Dialog(group="Specification", enable=specifyOutlet), Evaluate=true, HideResult = not specifyOutlet);
  parameter ValueSpecification outletValueSpec = ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the quantity is fixed or prescribed" annotation(
    Dialog(group="Specification", enable=specifyOutlet), Evaluate=true, HideResult = not specifyOutlet);
  parameter SI.TemperatureDifference dT_fixed = 0 "Fixed temperature difference (dT = T_out - T_in) (OM-Bug)" annotation(
    Dialog(group="Specification",
      enable = outletValueSpec == ValueSpecification.Fixed  and outletSpec == OutletSpecification.TemperatureDifference and specifyOutlet),
    HideResult = not outletValueSpec == ValueSpecification.Fixed or not outletSpec == OutletSpecification.TemperatureDifference or not specifyOutlet);
  parameter Medium.Temperature T_out_fixed = Medium.T_default "Fixed outlet temperature" annotation(
    Dialog(group="Specification",
      enable = outletValueSpec == ValueSpecification.Fixed and outletSpec == OutletSpecification.OutletTemperature and specifyOutlet),
    HideResult = not outletValueSpec == ValueSpecification.Fixed or not outletSpec == OutletSpecification.OutletTemperature or not specifyOutlet);
  parameter AssertionLevel assertionLevel = AssertionLevel.warning "Assertion level" annotation(
    Dialog(group="Warnings",
      enable = heatFlowSignal == HeatFlowSignal.Input),
      HideResult = not heatFlowSignal == HeatFlowSignal.Input);
  parameter SI.PressureDifference dp_start = 0 "Pressure difference start value (for nonlinear iteration)" annotation(
    Dialog(group="Nonlinear iteration (specifyOutlet == false and heatFlowSignal == Input)",
      enable = not specifyOutlet and heatFlowSignal == HeatFlowSignal.Input),
    HideResult = specifyOutlet or not heatFlowSignal == HeatFlowSignal.Input);
  parameter Boolean showOutletSpecification = true "= true to show the fixed outlet specification value (either dT_fixed or T_out_fixed)" annotation(
    Dialog(tab="Layout", group="Display parameters", enable = displayParameters and outletValueSpec == ValueSpecification.Fixed and specifyOutlet), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean showHeatFlowDirection = true "= true to show the actual heat flow direction" annotation(
    Dialog(tab="Layout", group="Display parameters", enable=displayParameters), Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter String name = getInstanceName() "Instance name";

  Modelica.Blocks.Interfaces.RealInput outletSpec_prescribed if specifyOutlet and outletValueSpec ==ValueSpecification.Prescribed  "Prescribed outlet specification [SI-units]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={-100,-120})));
  EnergyFlow.Interfaces.EnergyFlowInput Q_flow_in = Q_flow if heatFlowSignal == HeatFlowSignal.Input "Heat flow rate, dircted into the system [W]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,-80})));
  EnergyFlow.Interfaces.EnergyFlowOutput Q_flow_out = -Q_flow if heatFlowSignal == HeatFlowSignal.Output "Heat flow rate, directed out of the system [W]" annotation(
    Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={0,-70})));
  EnergyFlow.Interfaces.EnergyFlowOutput P_out = -P if systemSpec == SystemSpecification.Flow "Power, directed out of the system [W]" annotation(
    Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={100,-110})));

  Medium.Temperature T_in = Medium.temperature(inlet.state) "Inlet state temperature" annotation(
    HideResult=true);
  Medium.Temperature T_out "Outlet state temperature" annotation(
    HideResult=true);
  SI.TemperatureDifference dT = T_out - T_in "Temperature difference (T_out - T_in)";

  Medium.SpecificEnergy du = u_out - u_in "Difference in specific internal energy (u_out - u_in)";
  Medium.SpecificEnergy u_in = h_in - p_in/rho "Inlet state specific internal energy";
  Medium.SpecificEnergy u_out = h_out - p_out/rho "Outlet state specific internal energy";

  SI.SpecificEnergy w_p = (p_out - p_in)/rho "Specific pressure work (dp/rho) of a steady flow system";

  Medium.Density rho = Medium.density(inlet.state) "Density (inlet = outlet)";

  SI.HeatFlowRate Q_flow "Heat flow rate";
  SI.Power P "Power";

  Real singularityRegime "=+1.0 for du:=Q_flow/m_flow -> infty, =-1 for m_flow:=Q_flow/du -> infty, =0.0 else";

  constant Medium.SpecificEnergy eps_du = Modelica.Constants.eps annotation(
    HideResult=true);
  constant SI.MassFlowRate eps_m_flow = Modelica.Constants.eps annotation(
    HideResult=true);
  constant SI.HeatFlowRate eps_Q_flow = Modelica.Constants.eps annotation(
    HideResult=true);
protected
  Modelica.Blocks.Interfaces.RealInput outletSpec_actual "Actual outlet specification [SI-units], required due to the conditional connector outletSpec_prescribed";

equation
  connect(outletSpec_actual, outletSpec_prescribed);
  if specifyOutlet and outletValueSpec ==ValueSpecification.Fixed then
    if outletSpec == OutletSpecification.TemperatureDifference then
      outletSpec_actual = dT_fixed;
    else // OutletSpecification.OutletTemperature
      outletSpec_actual = T_out_fixed;
    end if;
  end if;
  if outletSpec == OutletSpecification.TemperatureDifference then
    dT = outletSpec_actual;
  else //OutletSpecification.OutletTemperature
    T_out = outletSpec_actual;
  end if;

  Xi_out = Xi_in;

  if specifyOutlet or not heatFlowSignal == HeatFlowSignal.Input then
    h_out = Medium.specificEnthalpy(Medium.setState_dTX(rho,T_out,Xi_out)); // Required to be compatible to SISOFlow
    p_out = Medium.pressure(Medium.setState_dTX(rho,T_out,Xi_out)); // Required to be compatible to SISOFlow
  else // if not specifyOutlet and heatFlowSignal == HeatFlowSignal.Input then
    T_out = Medium.temperature(outlet.state);
    dp = Medium.pressure(Medium.setState_dTX(rho,T_out,Xi_out)) - p_in; // Required to 'force' Dymola to use dp(start = dp_start) as iteration variable
  end if;

  if specifyOutlet and not heatFlowSignal == HeatFlowSignal.Input  then
    Q_flow = m_flow*du;
  elseif specifyOutlet then // and heatFlowSignal == HeatFlowSignal.Input
    m_flow = Q_flow * du/(du^2 + eps_du^2);
    assert(noEvent(abs(Q_flow) < eps_Q_flow or abs(du) > eps_du), "The heat flow rate in "+name+" is non zero, but the difference in specific internal energy is zero, implying that the mass flow rate m_flow := Q_flow/du is infinite.\n The result is regularized.", assertionLevel);
  else // not specifyOutlet and heatFlowSignal == HeatFlowSignal.Input
    du = Q_flow * m_flow / (m_flow^2 + eps_m_flow^2);
    assert(noEvent(abs(Q_flow) < eps_Q_flow or abs(m_flow) > eps_m_flow), "The heat flow rate in "+name+" is non zero, but the mass flow rate is zero, implying that the difference in specific internal energy du := Q_flow/m_flow is infinite. \n The result is regularized.", assertionLevel);
  end if;

  singularityRegime =
    if noEvent(heatFlowSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input and not specifyOutlet and abs(Q_flow) > eps and abs(m_flow) < eps) then 1.0
    elseif noEvent(heatFlowSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input and specifyOutlet and abs(Q_flow) > eps and abs(du) < eps) then -1.0
    else 0;

  P = if systemSpec == SystemSpecification.Flow then m_flow*w_p else 0;

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
        Text(visible = systemSpec == ThermofluidStream.Idealized.Types.SystemModel.Flow,
          extent={{-30,30},{30,-30}},
          textColor={28,108,200},
          textString="v"),
        Text(
          extent={{-40,30},{40,-30}},
          textColor={28,108,200},
          textString = if systemSpec == ThermofluidStream.Idealized.Types.SystemModel.Cycle then "v-c" else ""),
        Text(
          extent={{-150,-100},{150,-70}},
          textColor={0,0,0},
          textString = if not displayParameters or not showOutletSpecification or not specifyOutlet or not outletValueSpec == ThermofluidStream.Types.ValueSpecification.Fixed then ""
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference then "ΔT = %dT_fixed"
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature then "T_out = %T_out_fixed"
          else "error"),
        Line(
          points = if specifyOutlet and outletValueSpec == ThermofluidStream.Types.ValueSpecification.Prescribed then {{-100,0},{-100,-100}} else {{0,0}},
          color={0,0,127}),
        Line(
          points = if systemSpec == ThermofluidStream.Idealized.Types.SystemModel.Flow then {{100,0},{100,-100}} else {{0,0}},
          color={255,170,85}),
        Polygon(visible = showHeatFlowDirection,
          origin={-40,-50},
          rotation = if Q_flow >= 0 then 90 else -90,
          points={{-18,3},{4,3},{4,10},{18,0},{4,-10},{4,-3},{-18,-3},{-18,3}},
          fillColor = {191,0,0},
          fillPattern = if abs(Q_flow) >= 1e-8 then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None),
        Text(visible = showHeatFlowDirection,
          origin={-60,-70},
          extent={{0,0},{36,36}},
          textColor={191,0,0},
          textStyle={TextStyle.Bold},
          textString = if abs(Q_flow) < 1e-8 then "0" else ""),
        Polygon(visible = showHeatFlowDirection and systemSpec == ThermofluidStream.Idealized.Types.SystemModel.Flow,
          origin={80,-118},
          rotation =  if P >= 0 then 90 else -90,
          points={{-18,3},{4,3},{4,10},{18,0},{4,-10},{4,-3},{-18,-3},{-18,3}},
          fillColor = {255,170,85},
          fillPattern = if abs(P) >= 1e-8 then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None),
        Text(visible = showHeatFlowDirection and systemSpec == ThermofluidStream.Idealized.Types.SystemModel.Flow,
          origin={62,-138},
          extent={{0,0},{36,36}},
          textColor={255,170,85},
          textStyle={TextStyle.Bold},
          textString = if abs(P) < 1e-8 then "0" else ""),
        Text(
          extent={{-150,100},{150,60}},
          textString= if not specifyOutlet and not heatFlowSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input then "can't be balanced" else "",
          textColor={238,46,47}),
        Polygon(
          points={{-6,44},{-22,-8},{-2,-8},{-18,-50},{28,8},{2,8},{20,44},{-6,44}},
          fillPattern = if not specifyOutlet and not heatFlowSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input then FillPattern.Solid else FillPattern.None,
          fillColor={238,46,47},
          pattern=LinePattern.None),
        Text(
          extent={{-150,100},{150,60}},
          textString = DynamicSelect("", if singularityRegime > 0.5 then "infinite du"
            elseif singularityRegime < -0.5 then "infinte m_flow"
            else ""),
          textColor={238,46,47}),
        Polygon(
          points={{-6,44},{-22,-8},{-2,-8},{-18,-50},{28,8},{2,8},{20,44},{-6,44}},
          fillPattern = DynamicSelect(FillPattern.None, if singularityRegime > 0.5 then FillPattern.Solid
            elseif singularityRegime < -0.5 then FillPattern.Solid
            else FillPattern.None),
          fillColor={238,46,47},
          pattern=LinePattern.None),
        Ellipse(
          extent={{-98,58},{-62,22}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern = if specifyOutlet and heatFlowSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input then FillPattern.Solid else FillPattern.None),
        Rectangle(
          extent={{-78,24},{-82,56}},
          fillColor={28,108,200},
          fillPattern = if specifyOutlet and heatFlowSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-96,42},{-64,38}},
          fillColor={28,108,200},
          fillPattern = if specifyOutlet and heatFlowSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None)}),
    Documentation(
      info="<html>
  <p>
    Isochoric process (density <code>rho_in = rho_out</code>, specific volume <code>v_in = v_out</code>) mainly
    suitable for representing stationary-flow representations of isochoric periodic heat transfer in a closed cycle system (<code>systemSpec==Cycle</code>). 
    <code>Inlet</code> amd <code>Outlet</code> refer to the initial and final state of the process. Alternatively it can be used to represent a pseudo stationary-flow isochoric process (<code>systemSpec==Flow</code>). 
  </p>

  <p>
    The following quantities can be specified either as parameters or as time-varying input signals:
  </p>

  <ul>
    <li>Temperature difference: <code>dT = T_out - T_in</code></li>
    <li>Outlet temperature: <code>T_out</code></li>
  </ul>

  <p>
    Specifying the outlet specific enthalpy <code>h_out</code>, specific enthalpy difference <code>dh</code>, 
    outlet specific internal energy <code>u_out</code> or specific internal energy difference <code>du</code> 
    would create a system of nonlinear equations, as there is no function 
    <code>Medium.setState_dhX(state)</code> or <code>Medium.setState_duX(state)</code> available. This feature is therefore currently not included.
  </p>

  <p>
    The heat flow rate can optionally be an <code>EnergyFlowInput</code> or an
    <code>EnergyFlowOutput</code>; see
    <a href=\"modelica://ThermofluidStream.Idealized.UsersGuide.EnergyFlow\">
      UsersGuide.EnergyFlow
    </a>
    for details.
    During simulation, the physical positive direction of the heat flow rate is visualized on the icon layer
    by a red arrow.
  </p>

  <p>
    The model supports four possible operating modes:
  </p>

  <ol>
    <li>
      If the <strong>outlet state is set</strong> and the <strong>heat flow rate is not an input</strong>,
      the model is <strong>balanced</strong>.<br>
      In this case, the heat flow rate <code>Q_flow</code> is computed from the given specific internal energy difference
      <code>du</code> and mean mass flow rate <code>m_flow</code>:
      <code>Q_flow = m_flow*du</code>.
    </li>

    <li>
      If the <strong>outlet state is set</strong> and the <strong>heat flow rate is an input</strong>,
      the model is locally <strong>overdetermined</strong>.<br>
      This condition is indicated by a plus symbol on the icon layer.
      The mean mass flow rate is then computed from the given heat flow rate <code>Q_flow</code> and specific internal energy
      difference <code>du</code>:
      <code>m_flow = Q_flow/du</code>.
      To obtain an overall balanced system, a locally underdetermined component,
      such as
      <a href=\"modelica://ThermofluidStream.Idealized.Boundaries.Sink_free\">
        Sink_free
      </a>,
      must be connected.
    </li>

    <li>
      If the <strong>outlet state is not set</strong> and the <strong>heat flow rate is an input</strong>,
      the model is <strong>balanced</strong>.<br>
      In this case, the specific internal energy difference <code>du</code> is calculated from the given
      mass flow rate <code>m_flow</code> and heat flow rate <code>Q_flow</code>:
      <code>du = Q_flow/m_flow</code>.
      Determining the outlet state <code>(p,h)</code> from <code>du</code> introduces one implicit
      nonlinear equation. The parameter <code>dp_start</code> is used to initialize the nonlinear equation solver iteration.
    </li>

    <li>
      If the <strong>outlet state is not set</strong> and the <strong>heat flow rate is not an input</strong>,
      the model is <strong>not permissible</strong>.<br>
      In this case, both the heat flow rate <code>Q_flow</code> and the specific internal energy difference <code>du</code>
      are unknown, and the equation
      <code>Q_flow = m_flow*du</code>
      cannot be balanced.
      This condition is indicated by a prominent red lightning symbol.
    </li>
  </ol>

  <p>
    Assumptions for the isochoric process (closed system, cyclic operation, <code>systemSpec == Cycle</code>):
  </p>

  <ul>
    <li>
      Cycle-averaged steady state: Over multiple consecutive cycles, the system satisfies 
      <code>dE_sys/dt = 0</code> and <code>dm_sys/dt = 0</code>. 
    </li>
    <li>
      The mass flow rate <code>m_flow</code> represents the cycle-averaged mass throughput of the system.
    </li>
    <li>
      No net external forces on the system: The control volume is not subject to acceleration as a rigid body, i.e. 
      <code>\\sum F_external = 0</code>.
    </li>
    <li>
      No boundary work: <code>w_exp = p*dv = 0</code>.
    </li>
    <li>
      Negligible kinetic and potential energy changes: Differences between inlet and outlet are neglected, i.e. 
      <code>g*z_2 + 1/2*c_2^2 ≈ g*z_1 + 1/2*c_1^2</code>.
    </li>
    <li>
      Constant composition: No change in species mass fractions across the control volume, i.e. 
      <code>X_in = X_out</code>.
    </li>
  </ul>

  <p>
    Assumptions for the isochoric process (open system, steady-flow, <code>systemSpec == Flow</code>):
  </p>

  <ul>
    <li>
      Steady-state conditions: <code>dE_sys/dt = 0, dm_sys/dt = 0</code>
    </li>
    <li>
      No net external forces on the system: The control volume is not subject to acceleration as a rigid body, i.e. 
      <code>\\sum F_external = 0</code>.
    </li>
    <li>
      Isochoric pressure work (pseudo shaft work): <code>w_p = v*dp</code>.
    </li>
    <li>
      Negligible kinetic and potential energy changes: Differences between inlet and outlet are neglected, i.e. 
      <code>g*z_2 + 1/2*c_2^2 ≈ g*z_1 + 1/2*c_1^2</code>.
    </li>
    <li>
      Constant composition: No change in species mass fractions across the control volume, i.e. 
      <code>X_in = X_out</code>.
    </li>
  </ul>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Isochoric;
