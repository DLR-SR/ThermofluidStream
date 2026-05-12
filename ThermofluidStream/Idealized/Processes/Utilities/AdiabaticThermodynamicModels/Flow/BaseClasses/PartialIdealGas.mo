within ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.BaseClasses;
partial model PartialIdealGas "Base class for adiabatic thermodynamic models assuming an ideal gas (p*v = R*T)"
  // unknowns - equations = 2

  extends ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.BaseClasses.PartialAdiabatic;
  // unknowns - equations = 2

  import ValueSpecification = ThermofluidStream.Types.ValueSpecification2;

  parameter ValueSpecification gammaSpec=ThermofluidStream.Types.ValueSpecification2.State "Specifies whether the isentropic exponent is fixed or obtained from the inlet state" annotation (Dialog(group="Assumptions"), Evaluate=true);
  parameter Medium.IsentropicExponent gamma_fixed = 1.4 "Fixed isentropic exponent" annotation(
    Dialog(group="Assumptions",
      enable = gammaSpec ==ValueSpecification.Fixed),
      HideResult = not gammaSpec == ValueSpecification.Fixed);
  parameter AssertionLevel assertionLevel = AssertionLevel.warning "Assertion level" annotation(
    Dialog(group="Warnings"));
  parameter Real relTolZ = 0.05 "Relative tolerance of compressibility factor at inlet and outlet (tolerance for ideal gas behaviour)" annotation(
    Dialog(group="Warnings"));
  parameter Real relTolGamma = 1e-2 "Relative tolerance for isentropic exponent gamma_in, gamma_out" annotation(
    Dialog(group="Warnings",
      enable = gammaSpec ==ValueSpecification.State),
      HideResult = not gammaSpec == ValueSpecification.State);
  final parameter String name = getInstanceName();

  Medium.Temperature T_in = Medium.temperature(state_in) "Inlet temperature" annotation(
    HideResult=true);
  Medium.Temperature T_out_is "Isentropic outlet temperature";

  Medium.IsentropicExponent gamma "Isentropic exponent";
  Medium.IsentropicExponent gamma_in = Medium.isentropicExponent(state_in) "Isentropic exponent (inlet)";
  Medium.IsentropicExponent gamma_out = Medium.isentropicExponent(Medium.setState_phX(p_out,h_out,Xi_in)) "Isentropic exponent (outlet)";

  Real delta_gamma_rel = abs(gamma_out - gamma_in)/max(gamma_out,gamma_in) "Relative difference of isentropic exponents gamma_in, gamma_out" annotation(
    HideResult = not gammaSpec == ValueSpecification.State);

  Real Z_in  "Compressibility factor at inlet";
  Real Z_out "Compressibility factor at outlet";

  Medium.ThermodynamicState state_out = Medium.setState_phX(p_out, h_out, Xi_in) "Outlet state";

  SI.Density rho_in = Medium.density(state_in) "Inlet density" annotation(
    HideResult=true);
  SI.Density rho_out = Medium.density(state_out) "Outlet density" annotation(
    HideResult=true);
  SI.MolarMass M = Medium.molarMass(state_in) "Molar mass" annotation(
    HideResult=true); // M = M_in = M_out

  Real isInletIdealGas = sign(Z_in - 1/(1 + relTolZ))*sign(1 + relTolZ - Z_in) "= 1.0 if Z_in within tolerance, = -1.0 if tolerance is exceeded"; // Real instead of Boolean to avoid events
  Real isOutletIdealGas = sign(Z_out - 1/(1 + relTolZ))*sign(1 + relTolZ - Z_out) "= 1.0 if Z_out within tolerance, = -1.0 if tolerance is exceeded"; // Real instead of Boolean to avoid events
  Real isGammaWithinTol = sign(relTolGamma - delta_gamma_rel) "= 1.0 if gamma within tolerance, = -1.0 if tolerance is exceeded" annotation(
    HideResult = not gammaSpec == ValueSpecification.State);// Real instead of Boolean to avoid events

equation
  assert(noEvent(Z_in >= 1/(1 + relTolZ) and Z_in <= 1 + relTolZ),
    "In \"" + name + "\" the inlet state deviates from ideal gas behaviour beyond the specified tolerance.",
    assertionLevel);
  assert(noEvent(Z_out >= 1/(1 + relTolZ) and Z_out <= 1 + relTolZ),
    "In \"" + name + "\" the outlet state deviates from ideal gas behaviour beyond the specified tolerance.",
    assertionLevel);
  if gammaSpec ==ValueSpecification.State  then
    assert(noEvent(delta_gamma_rel < relTolGamma),
      "In \"" + name +"\" the isentropic exponent varies between inlet and outlet beyond the specified tolerance.",
      assertionLevel);
  end if;

  gamma = if gammaSpec ==ValueSpecification.State  then gamma_in else gamma_fixed;
  T_out_is = T_in*(p_out/p_in)^((gamma - 1)/gamma);

  Z_in  = p_in*M/(rho_in*T_in*Modelica.Constants.R);
  Z_out = p_out*M/(rho_out*Medium.temperature(state_out)*Modelica.Constants.R);

  annotation (Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Base model of an adiabatic process. The model is supposed to compute the outlet specific enthalpy based on:
  </p>
  
  <ul>
    <li>Inlet state</li>
    <li>Outlet pressure</li>
    <li>Isentropic efficiency</li>
  </ul>

  <p>
    The model assumes ideal gas <code>p*v = R*T</code> and constant isentropic exponent <code>gamma = const.</code>.
  </p>

</html>"));
end PartialIdealGas;
