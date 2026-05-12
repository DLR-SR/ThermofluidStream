within ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.BaseClasses;
partial model PartialAdiabatic "Base class for adiabatic thermodynamic models for given outlet pressure"
  // unknowns - equations = 2

  extends Modelica.Blocks.Icons.Block;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model (automatically inherited from enclosing component; not required to be configured; can be ignored)"
    annotation(Dialog(enable=false));
  input Medium.ThermodynamicState state_in "Inlet state";
  input Medium.AbsolutePressure p_out "Outlet pressure";
  input SI.Efficiency eta_is "Isentropic efficiency";
  output Medium.SpecificEnthalpy h_out "Outlet specific enthalpy";

  SI.SpecificEnthalpy w_t "Specific technical work";
  SI.SpecificEnthalpy w_t_is "Specific isentropic technical work";

  Medium.AbsolutePressure p_in = Medium.pressure(state_in) "Inlet pressure"
    annotation(HideResult=true);
  Medium.MassFraction Xi_in[Medium.nXi] = Medium.massFraction(state_in) "Inlet mass fractions"
    annotation(HideResult=true);

equation
  if p_out >= p_in then
    w_t = w_t_is/eta_is; // Compressor or pump
  else
    w_t = w_t_is*eta_is; // Turbine
  end if;

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

</html>"));
end PartialAdiabatic;
