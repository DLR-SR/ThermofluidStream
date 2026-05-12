within ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels;
package Flow
  extends Modelica.Icons.Package;

  annotation(Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Package of adiabatic assumption models used in 
    <a href=\"modelica://ThermoFluidStream.Idealized.Processes.BaseClasses.Adiabatic\">BaseClasses.Adiabatic</a>:
  </p>
  
  <p>
    The models calculate the outlet specific enthalpy based on:
  </p>
  
  <ul>
    <li>Inlet state</li>
    <li>Outlet pressure</li>
    <li>Isentropic efficiency</li>
  </ul>
</html>"));
end Flow;
