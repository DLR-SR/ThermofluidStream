within ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.BaseClasses;
partial model PartialIncompressibleFluid "Base class for adiabatic thermodynamic models assuming an incompressible fluid (rho = const)"
  // unbalanced by unknowns - equations = 1

  extends ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.BaseClasses.PartialAdiabatic;
  // unbalanced by unknowns - equations = 2

  parameter AssertionLevel assertionLevel = AssertionLevel.warning "Assertion level" annotation(
    Dialog(group="Warnings"));
  parameter Real relTolDensity = 1e-2 "Relative tolerance for densities rho_in, rho_out" annotation(
    Dialog(group="Warnings"));
  final parameter String name = getInstanceName();

  Medium.Temperature T_in = Medium.temperature(state_in) "Inlet temperature";
  Medium.Temperature T_out_is "Isentropic outlet temperature";
  Medium.SpecificEnthalpy h_in = Medium.specificEnthalpy(state_in) "Inlet specific enthalpy";

  Medium.Density rho_in = Medium.density(state_in) "Inlet density";
  Medium.Density rho_out = Medium.density(Medium.setState_phX(p_out,h_out,Xi_in)) "Outlet density"; // OM workaround
  Real deltaDensityRel = abs(rho_in - rho_out)/max(rho_in,rho_out) "Relative difference of densities rho_in, rho_out";
  Real isDensityWithinTol = sign(relTolDensity - deltaDensityRel) "= 1.0 if density within tolerance, = -1.0 if tolerance is exceeded";

equation
  assert(noEvent(deltaDensityRel < relTolDensity),
    "In \"" + name +"\" the density varies between inlet and outlet beyond the specified tolerance.",
    assertionLevel);

  T_out_is = T_in;
  w_t = h_out - h_in;

  annotation(Documentation(revisions="<html>
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
    The model assumes an incompressible fluid (<code>rho = const</code>) to
    compute the adiabatic reversible reference process.
  </p>

</html>"));
end PartialIncompressibleFluid;
