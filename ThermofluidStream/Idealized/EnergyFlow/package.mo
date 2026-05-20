within ThermofluidStream.Idealized;
package EnergyFlow
  extends Modelica.Icons.Package;

  annotation(Icon(graphics={
        Rectangle(
          extent={{-80,60},{0,-60}},
          lineColor={243,243,243},
          lineThickness=1,
          fillColor={255,170,85},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{0,60},{80,-60}},
          lineColor={244,244,244},
          lineThickness=1,
          fillColor={255,170,85},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-40,60},{40,-60}},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          fillColor={239,239,239},
          pattern=LinePattern.None),
        Polygon(
          points={{-6,14},{-6,-16},{20,0},{-6,14}},
          lineColor={255,170,85},
          lineThickness=1,
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-56,0},{56,0}},
          color={255,170,85},
          thickness=1)}), Documentation(info="<html>
  <p>
    This package includes idealized energy flow (power and heat flow) transfer.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end EnergyFlow;
