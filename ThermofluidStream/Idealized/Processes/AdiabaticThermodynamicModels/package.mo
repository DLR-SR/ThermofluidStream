within ThermofluidStream.Idealized.Processes;
package AdiabaticThermodynamicModels
  extends Modelica.Icons.UtilitiesPackage;
  annotation(
    Documentation(
      info="<html>
  <p>
    Package of adiabatic assumption models used in 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a>.
  </p>
  
  <p>
    The models calculate the outlet specific enthalpy based on:
  </p>
  
  <ul>
    <li>Inlet state</li>
    <li>Outlet pressure</li>
    <li>Isentropic efficiency</li>
  </ul>
</html>",
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end AdiabaticThermodynamicModels;
