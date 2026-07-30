within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model PartialFixed "Base class"

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  parameter SI.MassFlowRate m_flow=1   "Mass flow rate";
  parameter Medium.AbsolutePressure p_in=100000 "Inlet pressure";
  parameter Medium.Temperature T_in=293.15 "Inlet temperature";
  parameter SI.TemperatureDifference dT=20   "Temperature difference";
  final parameter Medium.Temperature T_out=T_in + dT "Outlet temperature";
  final parameter Medium.SpecificHeatCapacity cv = Medium.specificHeatCapacityCv(Medium.setState_pT(p_in, T_in));
  final parameter SI.HeatFlowRate Q_flow = m_flow*cv*dT "Heat flow rate";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

equation

  annotation(
    Documentation(
      info="<html>
  <p>
    Defines the parameters
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
end PartialFixed;
