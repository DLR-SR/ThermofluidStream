within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDieselEngine;
model BaseModel "Defines the parameters"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  parameter SI.AngularVelocity w(displayUnit="rpm")=209.43951023932 "Engine speed";
  parameter Integer z = 6 "Number of cylinders";
  parameter SI.Volume V3(displayUnit="ml")=0.0025 "Volume bottom dead center (per cylinder)";
  parameter Medium.Temperature T1(displayUnit="K")=300 "Environmental temperature";
  parameter Medium.AbsolutePressure p1=100000 "Environmental pressure";
  parameter Medium.AbsolutePressure p2=120000 "Compressor outlet pressure";
  parameter Medium.AbsolutePressure p4=80.62e5 "Pressure after engine compression";
  parameter Medium.Temperature T5(displayUnit="K")=1700 "Temperature after combustion";

  final parameter Medium.ThermodynamicState state3 = Medium.setState_pT(p2,T1) "Engine inlet state";
  final parameter Medium.Density rho3 = Medium.density(state3) "Density before compression";
  final parameter SI.Mass m3 = rho3*V3 "Mass bottom dead center (per cylinder)";

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
