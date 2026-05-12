within ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow;
model IsothermalReference "Adiabatic process, isothermal reference (incompressible fluid -> T_out_is = T_in), isentropic enthalpy h_out_is = h(p_out, T_in)"

  extends ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.BaseClasses.PartialIncompressibleFluid;
  // unknowns - equations = 1

  Medium.SpecificEnthalpy h_out_is "Isentropic outlet specific enthalpy";

equation
  h_out_is = Medium.specificEnthalpy(Medium.setState_pTX(p_out,T_out_is,Xi_in)); // OM Workaround
  w_t_is = h_out_is - h_in;

  annotation(Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    The model computes the outlet specific enthalpy based on:
  </p>
  
  <ul>
    <li>Inlet state</li>
    <li>Outlet pressure</li>
    <li>Isentropic efficiency</li>
  </ul>
  
  <p>
    The model assumes an incompressible fluid (<code>rho = const.</code>) to compute the adiabatic reversible reference process (which implies <code>T = const.</code>).
    In contrast to <a href=\"modelica://ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IncompressibleFluid\">IncompressibleFluid1</a>, 
    it uses the medium model to calculate the outlet specific enthalpy of the isentropic process <code>h_out_is = h(p_out,T)</code>.
  </p>
</html>"));
end IsothermalReference;
