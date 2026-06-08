within ThermofluidStream.Idealized.Processes;
model MassFractionModifier "Mass fraction modifier"
  extends ThermofluidStream.Interfaces.SISOFlow(final clip_p_out=false);

  import OutletSpecification = ThermofluidStream.Idealized.Types.OutletSpecification.Composition;
  import ValueSpecification = ThermofluidStream.Types.ValueSpecification;

  parameter OutletSpecification outletSpec = ThermofluidStream.Idealized.Types.OutletSpecification.Composition.MassFractionsDifference "Quantity used to define the outlet state" annotation(
    Dialog(group="Specification"), Evaluate=true);
  parameter ValueSpecification outletValueSpec = ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the quantity is fixed or prescribed" annotation(
    Dialog(group="Specification"), Evaluate=true);
  parameter ThermofluidStream.Units.MassFractionDifference dXi_fixed[Medium.nXi] = fill(0, Medium.nXi) "Fixed difference in mass fractions (dXi = Xi_out - Xi_in)" annotation(
    Dialog(group="Specification",
      enable=outletValueSpec == ValueSpecification.Fixed and outletSpec ==OutletSpecification.MassFractionsDifference),
    HideResult=not outletValueSpec == ValueSpecification.Fixed or not outletSpec == OutletSpecification.MassFractionsDifference);
  parameter Medium.MassFraction Xi_out_fixed[Medium.nXi] = Medium.X_default[1:Medium.nXi] "Fixed outlet mass fractions" annotation(
    Dialog(group="Specification",
      enable = outletValueSpec == ValueSpecification.Fixed  and outletSpec == OutletSpecification.OutletMassFractions),
    HideResult = not outletValueSpec == ValueSpecification.Fixed or not outletSpec == OutletSpecification.OutletMassFractions);
  parameter Boolean showOutletSpecification = true "= true to show the fixed outlet specification value (either dXi_fixed or Xi_out_fixed)" annotation(
    Dialog(tab="Layout",group="Display parameters",enable = displayParameters and outletValueSpec == ValueSpecification.Fixed), Evaluate=true, HideResult=true, choices(checkBox=true));

  Modelica.Blocks.Interfaces.RealInput outletSpec_prescribed[Medium.nXi] if outletValueSpec == ValueSpecification.Prescribed "Prescribed outlet specification [kg/kg]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={100,-120})));

  ThermofluidStream.Units.MassFractionDifference dXi[Medium.nXi] "Difference in mass fractions";
  Medium.Temperature T_in = Medium.temperature(inlet.state) "Inlet temperature" annotation(
    HideResult=true);

protected
  Modelica.Blocks.Interfaces.RealInput outletSpec_actual[Medium.nXi] "Actual outlet specification [kg/kg], required due to the conditional connector outletSpec_prescribed";

equation
  for i in 1:Medium.nXi loop
    assert(noEvent(Xi_out[i] >= 0), "Xi_out[i] must not be negative.", AssertionLevel.error);
  end for;
  assert(noEvent(sum(Xi_out) <= 1), "sum(Xi_out) may not exceed one.", AssertionLevel.error);

  connect(outletSpec_actual, outletSpec_prescribed);
  if outletValueSpec == ValueSpecification.Fixed  then
    if outletSpec == OutletSpecification.MassFractionsDifference  then
      outletSpec_actual = dXi_fixed;
    end if;
    if outletSpec == OutletSpecification.OutletMassFractions  then
      outletSpec_actual = Xi_out_fixed;
    end if;
  end if;
  if outletSpec == OutletSpecification.MassFractionsDifference  then
    dXi = outletSpec_actual;
  else // OutletSpecification.OutletMassFractions
    Xi_out = outletSpec_actual;
  end if;

  dXi = Xi_out - Xi_in;
  dp = 0;
  h_out = Medium.specificEnthalpy_pTX(p_out, T_in, Xi_out); // To be compatible with SISOFlow

  annotation(
    defaultComponentName = "composition",
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
          extent={{-30,30},{30,-30}},
          textColor={28,108,200},
          textString="X"),
        Text(
          extent={{-150,-100},{150,-70}},
          textColor={0,0,0},
          textString = if not displayParameters or not showOutletSpecification or not outletValueSpec == ThermofluidStream.Types.ValueSpecification.Fixed then ""
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Composition.MassFractionsDifference then "ΔXi = %dXi_fixed"
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Composition.OutletMassFractions then "Xi_out = %Xi_out_fixed"
          else "error"),
        Line(
          points = if outletValueSpec == ThermofluidStream.Types.ValueSpecification.Prescribed then {{100,0},{100,-100}} else {{0,0}},
          color={0,0,127})}),
    Documentation(info="<html>
  <p>
    Process to achieve a change in composition. Further assumptions:
  </p>  

  <ul>
    <li>Isobaric: <code>p_out = p_in</code></li>
    <li>Isothermal: <code>T_out = T_in</code>. This can lead to errors in the two-phase region, where temperature alone does not uniquely define the thermodynamic state..</li>
    <li>Steady-state conditions: <code>dE_sys/dt = 0, dm_sys/dt = 0</code></li>
  </ul>


  <p>
    The following quantities can be specified either as parameters or as time-varying input signals:
  </p>
  <ul>
    <li>Difference in mass fractions: <code>dXi = X_out - X_in</code></li>
    <li>Outlet mass fractions: <code>X_out</code></li>
  </ul>

  <p>
    See the example <a href=\"modelica://ThermofluidStream.Idealized.Tests.Processes.MassFractionModifier.Working\">Tests.Processes.MassFractionModifier</a>.
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
end MassFractionModifier;
