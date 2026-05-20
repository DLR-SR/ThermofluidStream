within ThermofluidStream.Idealized.Examples.TurboChargedEngine;
model BaseModel "Defines the parameters"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  parameter SI.AngularVelocity w(displayUnit="rpm")=261.79938779915 "Engine speed";
  parameter SI.Volume V3(displayUnit="l")=0.002  "Volume bottom dead center (total)";

  parameter Medium.Temperature T1(displayUnit="degC")=293.15 "Environmental temperature";
  parameter Medium.AbsolutePressure p1=100000 "Environmental pressure";

  parameter Medium.AbsolutePressure p2=120000 "Compressor outlet pressure";
  parameter Medium.AbsolutePressure rhoRatio = 20 "Compression ratio";
  parameter Medium.Temperature T5(displayUnit="degC")=2273.15 "Temperature after combustion";

  final parameter Medium.ThermodynamicState state3 = Medium.setState_pT(p2,T1) "Engine inlet state";
  final parameter Medium.Density rho3 = Medium.density(state3) "Density before compression";
  final parameter SI.Mass m3 = rho3*V3 "Mass bottom dead center (total)";

  annotation(
    Documentation(
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end BaseModel;
