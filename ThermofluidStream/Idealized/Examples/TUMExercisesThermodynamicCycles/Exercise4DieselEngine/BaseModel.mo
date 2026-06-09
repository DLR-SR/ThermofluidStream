within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise4DieselEngine;
model BaseModel "Defines the parameters"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir (T_max=2000)
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  parameter Medium.AbsolutePressure p1=100000 "Pressure before compression";
  parameter Medium.Temperature T1(displayUnit="K")=300 "Temperature before compression";
  parameter Real compressionRatio=23 "Compression ratio";
  parameter SI.Temperature T3(displayUnit="K")=1700 "Temperature after combustion";
  parameter SI.MassFlowRate m_flow = 1 "Mass flow rate";
  final parameter Medium.Density rho1 = Medium.density_pT(p1,T1) "Density before compression";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

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
