within ThermofluidStream.Idealized;
package Processes
  extends Modelica.Icons.Package;

  annotation (Icon(graphics={
         Ellipse(
          extent={{-60,54},{60,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-94,0},{94,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-64,60},{56,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
  <p>
    Package of idealized processes, including:
  </p>
  <ul>
    <li> 
      <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Processes.Adiabatic\">Adiabatic</a> compression and expansion 
      with a fixed isentropic efficiency for both compressible and incompressible media
    </li>
    <li> 
      <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Processes.Isobaric\">Isobaric</a> heat transfer
    </li>
    <li> 
      <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Processes.Isenthalpic\">Isenthalpic</a> expansion
    </li>
    <li>
      Stationary flow representations of closed systems (<a href=\"modelica://ThermoFluidStreamPlus.Idealized.Processes.AdiabaticCycle\">AdiabaticCycle</a> 
      and <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Processes.Isochoric\">Isochoric</a>)
    </li>
    <li> 
      <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Processes.MassFractionModifier\">MassFractionModifier</a> (isotherm, isobar)
    </li>
    <li> 
      <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Processes.PseudoSource\">PseudoSource</a>, setting outlet pressure, temperature/specific enthalpy and mass fractions
    </li>
  </ul>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Processes;
