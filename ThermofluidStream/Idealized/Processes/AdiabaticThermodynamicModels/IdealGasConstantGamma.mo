within ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels;
model IdealGasConstantGamma "Adiabatic process, ideal gas (p*v = R*T), gamma = const"

  extends ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.BaseClasses.PartialIdealGas;
  // unbalenced by unknowns - equations = 2

  Medium.SpecificEnthalpy h_in = Medium.specificEnthalpy(state_in) "Inlet specific enthalpy";
  Medium.SpecificEnthalpy h_out_is "Isentropic outlet specific enthalpy";

equation
  h_out_is = Medium.specificEnthalpy(Medium.setState_pTX(p_out,T_out_is,Xi_in)); // OM Workaround
  w_t_is = h_out_is - h_in;
  w_t = h_out - h_in;

  annotation(
    Documentation(
      info="<html>
  <p>
    The model calculates the outlet specific enthalpy based on:
  </p>
  
  <ul>
    <li>Inlet state</li>
    <li>Outlet pressure</li>
    <li>Isentropic efficiency</li>
  </ul>
  
  <p>
    The model assumes an ideal gas (<code>p*v = R*T</code>) with a constant isentropic exponent (<code>gamma = const.</code>).
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
end IdealGasConstantGamma;
