within ThermofluidStream.Idealized.Types.OutletSpecification;
type Composition = enumeration(
  MassFractionsDifference,
  OutletMassFractions) "Options for specifying the outlet mass fractions in MassFractionModifier"
annotation(choices(__Dymola_radioButtons=true,
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Composition.MassFractionsDifference "Mass fractions difference",
  choice = ThermofluidStream.Idealized.Types.OutletSpecification.Composition.OutletMassFractions "Outlet mass fractions"),
  Documentation(
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
