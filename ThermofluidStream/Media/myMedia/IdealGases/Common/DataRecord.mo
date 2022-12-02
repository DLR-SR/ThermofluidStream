within ThermofluidStream.Media.myMedia.IdealGases.Common;
record DataRecord
  "Coefficient data record for properties of ideal gases based on NASA source"
  extends Modelica.Icons.Record;
  String name "Name of ideal gas";
  SI.MolarMass MM "Molar mass";
  SI.SpecificEnthalpy Hf "Enthalpy of formation at 298.15K";
  SI.SpecificEnthalpy H0 "H0(298.15K) - H0(0K)";
  SI.Temperature Tlimit "Temperature limit between low and high data sets";
  Real alow[7] "Low temperature coefficients a";
  Real blow[2] "Low temperature constants b";
  Real ahigh[7] "High temperature coefficients a";
  Real bhigh[2] "High temperature constants b";
  SI.SpecificHeatCapacity R_s "Gas constant";
  annotation (Documentation(info="<html>
<p>
This data record contains the coefficients for the
ideal gas equations according to:
</p>
<blockquote>
  <p>McBride B.J., Zehe M.J., and Gordon S. (2002): <strong>NASA Glenn Coefficients
  for Calculating Thermodynamic Properties of Individual Species</strong>. NASA
  report TP-2002-211556</p>
</blockquote>
<p>
The equations have the following structure:
</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/Common/singleEquations.png\"></div>
<p>
The polynomials for h(T) and s0(T) are derived via integration from the one for cp(T)  and contain the integration constants b1, b2 that define the reference specific enthalpy and entropy. For entropy differences the reference pressure p0 is arbitrary, but not for absolute entropies. It is chosen as 1 standard atmosphere (101325 Pa).
</p>
<p>
For most gases, the region of validity is from 200 K to 6000 K.
The equations are split into two regions that are separated
by Tlimit (usually 1000 K). In both regions the gas is described
by the data above. The two branches are continuous and in most
gases also differentiable at Tlimit.
</p>
</html>"));
end DataRecord;
