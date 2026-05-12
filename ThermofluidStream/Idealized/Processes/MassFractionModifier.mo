within ThermofluidStream.Idealized.Processes;
model MassFractionModifier "Mass fraction modifier"
  extends ThermofluidStream.Interfaces.SISOFlow(final clip_p_out=false);

  import OutletSpecification = ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Composition;
  import ValueSpecification = ThermofluidStream.Idealized.Utilities.Types.ValueSpecification;

  parameter OutletSpecification outletSpec =ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Composition.MassFractionsDifference      "Quantity used to define the outlet state"
    annotation (Dialog(group="Specification"), Evaluate=true);
  parameter ValueSpecification outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Fixed "Specifies whether the quantity is fixed or prescribed" annotation (Dialog(group="Specification"), Evaluate=true);
  parameter ThermofluidStream.Idealized.Utilities.Types.MassFractionDifference dXi_fixed[Medium.nXi]=fill(0, Medium.nXi) "Fixed difference in mass fractions (dXi = Xi_out - Xi_in)" annotation (Dialog(group="Specification", enable=outletValueSpec == ValueSpecification.Fixed and outletSpec == OutletSpecification.MassFractionsDifference), HideResult=not outletValueSpec == ValueSpecification.Fixed or not outletSpec == OutletSpecification.MassFractionsDifference);
  parameter Medium.MassFraction Xi_out_fixed[Medium.nXi] = Medium.X_default[1:Medium.nXi] "Fixed outlet mass fractions"
    annotation(Dialog(group="Specification",
      enable = outletValueSpec == ValueSpecification.Fixed and outletSpec ==OutletSpecification.OutletMassFractions),
      HideResult = not outletValueSpec == ValueSpecification.Fixed or not outletSpec == OutletSpecification.OutletMassFractions);
  parameter Boolean showOutletSpecification = true "= true to show the fixed outlet specification value (either dXi_fixed or Xi_out_fixed)"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and outletValueSpec == ValueSpecification.Fixed),Evaluate=true, HideResult=true, choices(checkBox=true));

  Modelica.Blocks.Interfaces.RealInput outletSpec_prescribed[Medium.nXi] if outletValueSpec == ValueSpecification.Prescribed "Prescribed outlet specification [kg/kg]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90, origin={100,-120})));

  ThermofluidStream.Idealized.Utilities.Types.MassFractionDifference dXi[Medium.nXi] "Difference in mass fractions";
  Medium.Temperature T_in = Medium.temperature(inlet.state) "Inlet temperature"
    annotation(HideResult=true);

protected
  Modelica.Blocks.Interfaces.RealInput outletSpec_actual[Medium.nXi] "Actual outlet specification [kg/kg], required due to the conditional connector outletSpec_prescribed";

equation
  for i in 1:Medium.nXi loop
    assert(noEvent(Xi_out[i] >= 0), "Xi_out[i] must not be negative.", AssertionLevel.error);
  end for;
  assert(noEvent(sum(Xi_out) <= 1), "sum(Xi_out) may not exceed one.", AssertionLevel.error);

  connect(outletSpec_actual, outletSpec_prescribed);
  if outletValueSpec == ValueSpecification.Fixed then
    if outletSpec == OutletSpecification.MassFractionsDifference then
      outletSpec_actual = dXi_fixed;
    end if;
    if outletSpec == OutletSpecification.OutletMassFractions then
      outletSpec_actual = Xi_out_fixed;
    end if;
  end if;
  if outletSpec == OutletSpecification.MassFractionsDifference then
    dXi = outletSpec_actual;
  else // OutletSpecification.OutletMassFractions
    Xi_out = outletSpec_actual;
  end if;

  dXi = Xi_out - Xi_in;
  dp = 0;
  h_out = Medium.specificEnthalpy_pTX(p_out, T_in, Xi_out); // To be compatible with SISOFlow

  annotation (defaultComponentName = "composition", Icon(graphics={
        Text(visible=displayInstanceName,
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
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
        Text(
          extent={{-20,20},{20,-20}},
          textColor={28,108,200},
          textString="X"),
        Text(visible = displayParameters and showOutletSpecification and outletValueSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Fixed and outletSpec == ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Flow.Composition.MassFractionsDifference,
          extent={{-150,-70},{150,-100}},
          textColor={0,0,0},
          textString="ΔXi = %dXi_fixed"),
        Text(visible = displayParameters and showOutletSpecification and outletValueSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Fixed and outletSpec == ThermoFluidStreamPlus.Idealized.Types.OutletSpecification.Flow.Composition.OutletMassFractions,
          extent={{-150,-70},{150,-100}},
          textColor={0,0,0},
          textString="Xi_out = %Xi_out_fixed"),
        Line(visible = outletValueSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Prescribed,
          points={{100,0},{100,-100}},
          color={0,0,127})}), Documentation(info="<html>
  <p>
    Process to achieve a change in mass fractions. Further assumptions:
  </p>  

  <ul>
    <li>Isobaric: <code>p_out = p_in</code></li>
    <li>Isothermal: <code>T_out = T_in</code></li>
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
    See the example <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Tests.Processes.MassFractionModifier.Working\">Tests.Processes.MassFractionModifier</a>.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end MassFractionModifier;
