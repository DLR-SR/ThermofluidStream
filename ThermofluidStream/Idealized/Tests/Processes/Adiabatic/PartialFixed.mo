within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model PartialFixed "Base class"

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir  constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  parameter SI.MassFlowRate m_flow=1 "Mass flow rate";
  parameter Medium.AbsolutePressure p_in=100000 "Inlet pressure";
  parameter Medium.Temperature T_in=293.15 "Inlet temperature";
  parameter SI.PressureDifference dp=100000 "Pressure difference";
  parameter SI.Efficiency eta_is=0.8 "Isentropic efficiency";

  final parameter Medium.AbsolutePressure p_out= p_in + dp "Outlet pressure";
  final parameter Real pRatio = p_out/p_in "Pressure ratio";
  final parameter Medium.ThermodynamicState state_in = Medium.setState_pT(p_in,T_in);

  ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium adiabaticModel(
    redeclare final package Medium = Medium,
    final state_in=state_in,
    final p_out=p_out,
    final eta_is=eta_is) "Adiabatic process calculation";
  Medium.SpecificEnthalpy h_out = adiabaticModel.h_out "Outlet specific enthalpy";
  Medium.SpecificEnthalpy h_in = Medium.specificEnthalpy(state_in) "Inlet specific enthalpy";
  SI.SpecificEnthalpy dh = h_out - h_in "Specific enthalpy difference";

  SI.Power P = m_flow*dh "Power";

  inner ThermofluidStream.DropOfCommons dropOfCommons annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

  annotation(
    Documentation(
      info="<html>
  <p>
    Defines the parameters.
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
