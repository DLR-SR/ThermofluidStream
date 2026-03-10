within ThermofluidStream.Processes.Internal.Types;
type PressureUnit = enumeration(
    Pa  "Pa",
    kPa "kPa",
    bar "bar")
"Display the pressure in different units (Pa, kPa, bar)" annotation (Documentation(revisions="<html>
<ul>
<li>
March 2026, by Tobias Reischl (tobias.reischl@dlr.de):<br>
Initial version.
</li>
</ul>
</html>", info="<html>
<p>
  The <code>PressureUnit</code> type defines an enumeration for displaying pressure values
  in different units. It provides three supported options:
  <code>Pa</code>, <code>kPa</code>, and <code>bar</code>.
</p>
</html>"));
