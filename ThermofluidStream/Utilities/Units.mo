within ThermofluidStream.Utilities;
package Units "Units package for the thermofluid library"
  extends Modelica.Icons.Package;

  type Inertance = Real(quantity="Inertance", unit="1/m", min=0) "Unit of Inertance"
    annotation (Documentation(info="<html>
<p>Unit of Inertance.</p>
</html>"));
  type MassFlowAcceleration = Real(quantity="MassFlowAcceleration", unit="kg/s2") "Acceleration Unit for a MassFlow"
    annotation (Documentation(info="<html>
    <p>Acceleration Unit for a MassFlow</p>
    </html>"));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
      Polygon(
        fillColor = {128,128,128},
        pattern = LinePattern.None,
        fillPattern = FillPattern.Solid,
        points = {{-80,-40},{-80,-40},{-55,50},{-52.5,62.5},{-65,60},{-65,65},{-35,77.5},{-32.5,60},{-50,0},{-50,0},{-30,15},{-20,27.5},{-32.5,27.5},{-32.5,27.5},{-32.5,32.5},{-32.5,32.5},{2.5,32.5},{2.5,32.5},{2.5,27.5},{2.5,27.5},{-7.5,27.5},{-30,7.5},{-30,7.5},{-25,-25},{-17.5,-28.75},{-10,-25},{-5,-26.25},{-5,-32.5},{-16.25,-41.25},{-31.25,-43.75},{-40,-33.75},{-45,-5},{-45,-5},{-52.5,-10},{-52.5,-10},{-60,-40},{-60,-40}},
        smooth = Smooth.Bezier),
      Polygon(
        fillColor = {128,128,128},
        pattern = LinePattern.None,
        fillPattern = FillPattern.Solid,
        points = {{87.5,30},{62.5,30},{62.5,30},{55,33.75},{36.25,35},{16.25,25},{7.5,6.25},{11.25,-7.5},{22.5,-12.5},{22.5,-12.5},{6.25,-22.5},{6.25,-35},{16.25,-38.75},{16.25,-38.75},{21.25,-41.25},{21.25,-41.25},{45,-48.75},{47.5,-61.25},{32.5,-70},{12.5,-65},{7.5,-51.25},{21.25,-41.25},{21.25,-41.25},{16.25,-38.75},{16.25,-38.75},{6.25,-41.25},{-6.25,-50},{-3.75,-68.75},{30,-76.25},{65,-62.5},{63.75,-35},{27.5,-26.25},{22.5,-20},{27.5,-15},{27.5,-15},{30,-7.5},{30,-7.5},{27.5,-2.5},{28.75,11.25},{36.25,27.5},{47.5,30},{53.75,22.5},{51.25,8.75},{45,-6.25},{35,-11.25},{30,-7.5},{30,-7.5},{27.5,-15},{27.5,-15},{43.75,-16.25},{65,-6.25},{72.5,10},{70,20},{70,20},{80,20}},
        smooth = Smooth.Bezier)}));
end Units;
