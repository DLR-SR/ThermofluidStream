within ThermofluidStream;
package Idealized "Package with idealized components"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
  <p>
    This package includes:
  </p>
  <ul>
    <li>
      Idealized <a href=\"modelica://ThermoFluidStream.Idealized.Processes\">Processes</a>, e.g. adiabatic, isobaric, isenthalpic, isochoric
    </li>
    <li>
      Idealized mass flow rate <a href=\"modelica://ThermoFluidStream.Idealized.Sources\">Sources</a>
    </li>
    <li>
      Idealized heat and power transfer, see <a href=\"modelica://ThermoFluidStream.Idealized.EnergyFlow\">EnergyFlow</a>
    </li>
    <li>
      <a href=\"modelica://ThermoFluidStream.Idealized.Examples\">Examples</a> of thermodynamic cycles:  
      Clausius-Rankine (CR), Joule-Brayton (JB), vapor cycle (inverse CR), air cycle (inverse JB), closed cycles (otto, diesel), combi cycles;  
      both simple and advanced configurations (multi-stage, etc.)
    </li>
  </ul>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"), Icon(graphics={Bitmap(extent={{-98,-98},{98,98}}, fileName="modelica://ThermofluidStream/Resources/Idealized/Pictures/Book_thermo.png")}));
end Idealized;
