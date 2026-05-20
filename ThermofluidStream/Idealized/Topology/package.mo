within ThermofluidStream.Idealized;
package Topology
  extends Modelica.Icons.Package;
  annotation(
    Icon(
      graphics={
        Rectangle(
          lineColor={128,128,128},
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Line(
          points={{-80,0},{12,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{12,0},{80,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{12,0},{80,80}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{6,6},{18,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5)}),
    Documentation(
      info="<html>
  <p>
    This package includes junctions that have to be used if the mass flow rate is set at one or both inlets.
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
end Topology;
