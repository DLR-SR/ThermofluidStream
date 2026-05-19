within ThermofluidStream.Idealized.Examples.OttoCycle;
model BaseModel
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);
  parameter Medium.AbsolutePressure p1=100000   "Pressure before compression";
  parameter Medium.Temperature T1(displayUnit="degC")=293.15
                                                         "Temperature before compression";
  parameter Real compressionRatio = 10 "Compression ratio";
  parameter Medium.Temperature T3(displayUnit="degC")=2473.15
                                                          "Temperature after combustion";

  final parameter Medium.Density rho1 = Medium.density_pTX(p1,T1,Medium.X_default) "Density before compression";
  final parameter Medium.Density rho2 = rho1*compressionRatio "Density after compression";
  final parameter SI.SpecificVolume v1 = 1/rho1 "Specific volume before compression";
  final parameter SI.SpecificVolume v2 = 1/rho2 "Specific volume after compression";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

  annotation(
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Definition of parameters for the examples in this package.
  </p>
</html>"));
end BaseModel;
