within ThermofluidStream.Media.myMedia.GasAndIncompressible;
package JP8DryAir "Jet propulsion JP8 combined with dry air"
  extends
    ThermofluidStream.Media.myMedia.GasAndIncompressible.PartialGasAndIncompressible(
    mediumName="JP8 and DryAir",
    substanceNames=cat(
        1,
        Gas.substanceNames,
        Liquid.substanceNames),
    reference_X={0.0001,0.9999},
    reference_p=1e5,
    reference_T=273.15 + 15,
    reducedX=false,
    AbsolutePressure(displayUnit="kPa"));
    //nS=2, 1 from DryAir, 1 from JP8
  redeclare package Gas =
      ThermofluidStream.Media.myMedia.Air.DryAirNasa;
  redeclare package Liquid =
      ThermofluidStream.Media.myMedia.Incompressible.Examples.JP8;
   annotation (Documentation(info="<html>
<h4>JP8DryAir</h4>
<p>A combination of the DryAirNASA medium and the JP8 medium.</p>
<p><span style=\"font-family: Courier New;\">The reference blend is 0.01&percnt; Air at reference pressure 100000 Pa and 15 deg C.</span></p>
</html>"));
end JP8DryAir;
