within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine;
model BaseModel
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation(choicesAllMatching=true);
  parameter Medium.AbsolutePressure p1 = 100000 "Pressure before compression";
  parameter Medium.Temperature T1(displayUnit="K") = 300 "Temperature before compression";
  parameter Real compressionRatio = 10 "Compression ratio";
  parameter Medium.Temperature T3(displayUnit="K") = 2200 "Temperature after combustion";

  final parameter Medium.Density d1 = Medium.density_pTX(p1,T1,Medium.X_default) "Density before compression";
  final parameter Medium.Density d2 = d1*compressionRatio "Density after compression";
  final parameter SI.SpecificVolume v1 = 1/d1 "Specific volume before compression";
  final parameter SI.SpecificVolume v2 = 1/d2 "Specific volume after compression";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation(Placement(transformation(extent={{160,80},{180,100}})));

  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-100},{180,100}})),
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
