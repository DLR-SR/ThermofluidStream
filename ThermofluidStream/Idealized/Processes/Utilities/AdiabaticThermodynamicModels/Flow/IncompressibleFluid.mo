within ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow;
model IncompressibleFluid "Adiabatic process, incompressible fluid (rho = const): h_out_is = dp/rho_in + h_in"

  extends ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.BaseClasses.PartialIncompressibleFluid;
  // unknowns - equations = 1

equation
  w_t_is = (p_out - p_in)/rho_in;

  annotation (Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    The model calculates the outlet specific enthalpy based on:
  </p>
  
  <ul>
    <li>Inlet state</li>
    <li>Outlet pressure</li>
    <li>Isentropic efficiency</li>
  </ul>
  
  <p>
    The model assumes an incompressible fluid (<code>rho = const.</code>) to compute the adiabatic reversible reference process, which implies <code>T = const.</code> and <code>w_t_is = dp / rho</code>.
  </p>
</html>"));
end IncompressibleFluid;
