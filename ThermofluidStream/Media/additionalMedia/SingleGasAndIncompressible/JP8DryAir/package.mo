within ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible;
package JP8DryAir "Jet propulsion JP8 combined with dry air"
  extends
    ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.PartialSingleGasAndIncompressible(
    mediumName="JP8 and DryAir",
    substanceNames=cat(
        1,
        SingleGas.substanceNames,
        Incompressible.substanceNames),
    reference_X={0.0001,0.9999},
    reference_p=1e5,
    reference_T=273.15 + 15,
    reducedX=false,
    AbsolutePressure(displayUnit="kPa"));
  redeclare package SingleGas =
      ThermofluidStream.Media.myMedia.Air.DryAirNasa;
  redeclare package Incompressible =
      ThermofluidStream.Media.additionalMedia.Incompressible.JP8;
   annotation (Documentation(info="<html>
<h4>JP8DryAir</h4>
<p>A combination of the DryAirNASA medium and the JP8 medium.</p>
<p>The reference blend is 0.01&percnt; Air at reference pressure 100000 Pa and 15 deg C.</p>
<p>A discussion of the approximation by linear combination of fuel and air flowing in a pipe can be found in </p>
<p>https://www.diva-portal.org/smash/record.jsf?pid=diva2&percnt;3A17182&amp;dswid=6825.</p>
</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end JP8DryAir;
