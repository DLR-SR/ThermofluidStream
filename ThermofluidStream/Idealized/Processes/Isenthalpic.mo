within ThermofluidStream.Idealized.Processes;
model Isenthalpic "Isenthalpic process"
  extends ThermofluidStream.Interfaces.SISOFlow(clip_p_out = false);

  import OutletSpecification = ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic;
  import ValueSpecification = ThermofluidStream.Types.ValueSpecification;

  parameter OutletSpecification outletSpec = ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.PressureLoss "Quantity used to define the outlet state" annotation(
    Dialog(group="Specification"), Evaluate=true);
  parameter ValueSpecification outletValueSpec = ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the quantity is fixed or prescribed" annotation(
    Dialog(group="Specification"), Evaluate=true);
  parameter SI.PressureDifference dpLoss_fixed = 0 "Fixed pressure loss (dpLoss = p_in - p_out)" annotation(
    Dialog(group="Specification",
      enable = outletValueSpec == ValueSpecification.Fixed  and outletSpec == OutletSpecification.PressureLoss),
    HideResult = not outletValueSpec == ValueSpecification.Fixed or not outletSpec == OutletSpecification.PressureLoss);
  parameter Real prLoss_fixed = 0 "Fixed relative pressure loss (prLoss = dpLoss/p_in)" annotation(
    Dialog(group="Specification",
      enable = outletValueSpec ==ValueSpecification.Fixed  and outletSpec == OutletSpecification.RelativePressureLoss),
      HideResult = not outletValueSpec == ValueSpecification.Fixed or not outletSpec == OutletSpecification.RelativePressureLoss);
  parameter Medium.AbsolutePressure p_out_fixed = Medium.p_default "Fixed outlet pressure" annotation(
    Dialog(group="Specification",
      enable = outletValueSpec == ValueSpecification.Fixed  and outletSpec == OutletSpecification.OutletPressure),
      HideResult = not outletValueSpec == ValueSpecification.Fixed or not outletSpec == OutletSpecification.OutletPressure);
  parameter Boolean enforcePressureDrop = false "= true, if pressure drop in flow direction is enforced; use =false for inverse calculations" annotation(
    Dialog(group="Advanced specification"), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter AssertionLevel assertionLevel = AssertionLevel.warning "Assertion level (pressure drop)" annotation(
    Dialog(group="Warnings"));
  parameter Boolean showOutletSpecification = true "= true to show the fixed outlet specification value (either dpLoss_fixed, prLoss_fixed or p_out_fixed)" annotation(
    Dialog(tab="Layout", group="Display parameters", enable = displayParameters and outletValueSpec ==ValueSpecification.Fixed),  Evaluate=true, HideResult=true, choices(checkBox=true));

  Modelica.Blocks.Interfaces.RealInput outletSpec_prescribed if outletValueSpec ==ValueSpecification.Prescribed  "Prescribed outlet specification [SI-units]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={100,-120})));

  Real isDPLossSetAligned = sign(m_flow*dpLoss_set) "= 1.0, if set pressure loss is aligned with flow direction"; // Real to avoid events
  Real isDPLossAligned = sign(m_flow*dpLoss) "= 1.0, if pressure loss is aligned with flow direction"; // Real to avoid events

  SI.PressureDifference dpLoss = p_in - p_out "Pressure loss";
  SI.PressureDifference dpLoss_set "Set pressure loss";
  Real prLoss = dpLoss/p_in "Relative pressure loss";
  Real prLoss_set "Set relative pressure loss" annotation(
    HideResult=true);
  SI.Pressure p_out_set "Set outlet pressure" annotation(
    HideResult=true);

protected
  Modelica.Blocks.Interfaces.RealInput outletSpec_actual "Actual outlet specification [SI-units], required due to the conditional connector outletSpec_prescribed";

equation
  if enforcePressureDrop then
    assert(noEvent(m_flow*dpLoss_set >= -Modelica.Constants.eps),
      "In \"" + instanceName + "\" the prescribed pressure loss would cause a pressure rise in flow direction and was clipped.", assertionLevel);
  end if;
  assert(noEvent(m_flow*dpLoss >= -Modelica.Constants.eps),
    "In \"" + instanceName +"\" the pressure rises in the direction of the flow. \n"
    + " An isenthalpic pressure increase however violates the second law of thermodynamics.",
    assertionLevel);

  connect(outletSpec_actual, outletSpec_prescribed);
  if outletValueSpec == ValueSpecification.Fixed  then
    if outletSpec == OutletSpecification.PressureLoss  then
      outletSpec_actual = dpLoss_fixed;
    end if;
    if outletSpec == OutletSpecification.RelativePressureLoss  then
      outletSpec_actual = prLoss_fixed;
    end if;
    if outletSpec == OutletSpecification.OutletPressure  then
      outletSpec_actual = p_out_fixed;
    end if;
  end if;
  if outletSpec == OutletSpecification.PressureLoss  then
    dpLoss_set = outletSpec_actual;
  elseif outletSpec == OutletSpecification.RelativePressureLoss  then
    prLoss_set = outletSpec_actual;
  else // OutletSpecification.OutletPressure
    p_out_set = outletSpec_actual;
  end if;

  prLoss_set = dpLoss_set/p_in;
  p_out_set = p_in - dpLoss_set;
  if enforcePressureDrop then
    dpLoss = if noEvent(m_flow*dpLoss_set >= 0) then dpLoss_set else 0;
  else
    dpLoss = dpLoss_set;
  end if;

  h_out = h_in;
  Xi_out = Xi_in;

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
          textString=if displayInstanceName then "%instanceName" else "",
          textColor=dropOfCommons.instanceNameColor),
        Text(
          extent={{-30,30},{30,-30}},
          textColor={28,108,200},
          textString="h"),
        Text(
          extent={{-150,-100},{150,-70}},
          textColor={0,0,0},
          textString = if not displayParameters or not showOutletSpecification or not outletValueSpec == ThermofluidStream.Types.ValueSpecification.Fixed then ""
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.PressureLoss then "ΔpLoss = %dpLoss_fixed"
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.RelativePressureLoss then "prLoss = %prLoss_fixed"
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure then "p_out = %p_out_fixed"
          else "error"),
        Line(
          points = if outletValueSpec == ThermofluidStream.Types.ValueSpecification.Prescribed then {{100,0},{100,-100}} else {{0,0}},
          color={0,0,127}),
        Ellipse(visible = DynamicSelect(false, enforcePressureDrop and m_flow*dpLoss_set < 0),
          extent={{60,60},{80,80}},
          lineColor={0,0,0},
          fillColor = {238,46,47},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,50},{100,-50}},
          textColor={238,46,47},
          textString = DynamicSelect("",if m_flow*dpLoss < 0 then "dp" else ""))}),
    Documentation(
      info="<html>
  <p>
    Isenthalpic process (<code>h_in = h_out</code>) suitable for modeling a valve.
  </p>

  <p>
    The following quantities can be specified either as parameters or as time-varying input signals:
  </p>

  <ul>
    <li>Pressure loss: <code>dpLoss = p_in - p_out</code></li>
    <li>Relative pressure loss: <code>prLoss = dpLoss / p_in = 1 - p_out/p_in</code></li>
    <li>Outlet pressure: <code>p_out</code></li>
  </ul>

  <p>
    Further assumptions for the isenthalpic process:
  </p>

  <ul>
    <li>
      Steady-state conditions: <code>dE_sys/dt = 0, dm_sys/dt = 0</code>
    </li>
    <li>
      No heat transfer: <code>Q_flow = 0</code>
    </li>
    <li>
      No net external forces on the system: The control volume is not subject to acceleration as a rigid body, i.e. 
      <code>\\sum F_external = 0</code>.
    </li>
    <li>
      Rigid boundary,  no expansion work: <code>w_exp = 0</code>
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
    Under these assumptions, an increase in pressure in the direction of the flow
    violates the second law of thermodynamics; for example, the pressure must not increase within a valve.
    This condition can be enforced with <code>enforcePressureDrop</code>. 
    Then, a red circle highlights if the prescribed pressure loss would cause a pressure rise in flow direction and is clipped.
    If <code>enforcePressureDrop = false</code>, violation only triggers an assert, which is also indicated on the icon layer.
    For inverse calculations, <code>enforcePressureDrop = false</code> is recommended, as this simplifies the equation system.
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      06/2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      The default value of <code>enforcePressureDrop</code> was changed from <code>true</code> to <code>false</code> to improve numerical robustness in inverse calculations. 
      Models that require the previous behavior must now explicitly set <code>enforcePressureDrop=true</code>.
    </li>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Isenthalpic;
