within ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow;
model FullMedium "Full medium model (entropy-based, no thermodynamic simplifications)"

  extends ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.BaseClasses.PartialAdiabatic;
  // unknowns - equations = 2

  Medium.SpecificEntropy s_in = Medium.specificEntropy(state_in) "Inlet specific entropy";
  Medium.SpecificEnthalpy h_in = Medium.specificEnthalpy(state_in) "Inlet specific enthalpy";
  Medium.SpecificEnthalpy h_out_is = Medium.specificEnthalpy_psX(p_out,s_in,Xi_in) "Isentropic specific enthalpy";

equation
  w_t_is = h_out_is - h_in;
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
    The model calculates the outlet specific enthalpy based on:
  </p>
  
  <ul>
    <li>Inlet state</li>
    <li>Outlet pressure</li>
    <li>Isentropic efficiency</li>
  </ul>
  
  <p>
    It uses the medium's specific entropy function to determine the adiabatic reversible reference process.
  </p>
</html>"));
end FullMedium;
