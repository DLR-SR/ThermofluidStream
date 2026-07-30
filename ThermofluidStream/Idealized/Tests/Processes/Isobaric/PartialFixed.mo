within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model PartialFixed "Base Class"
  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  parameter SI.MassFlowRate m_flow=1 "Mass flow rate";
  parameter Medium.AbsolutePressure p=200000 "Pressure (inlet = outlet)";
  parameter Medium.Temperature T_in=293.15 "Inlet temperature";
  parameter SI.TemperatureDifference dT=10 "Temperature difference";
  parameter SI.AbsolutePressure p_inf=100000 "Ambient pressure";

  final parameter Medium.Temperature T_out = T_in + dT "Outlet temperature";

  final parameter Medium.ThermodynamicState state_in = Medium.setState_pTX(p, T_in, Medium.X_default) "Inlet state";
  final parameter Medium.ThermodynamicState state_out = Medium.setState_pTX(p, T_out, Medium.X_default) "Outlet state";

  final parameter Medium.Density rho_in = Medium.density(state_in) "Inlet density";
  final parameter Medium.Density rho_out = Medium.density(state_in) "Outlet density";

  final parameter SI.SpecificVolume v_in = 1/rho_in "Inlet density";
  final parameter SI.SpecificVolume v_out = 1/rho_out "Outlet density";

  final parameter Medium.SpecificEnthalpy h_in = Medium.specificEnthalpy(state_in) "Inlet specific enthalpy";
  final parameter Medium.SpecificEnthalpy h_out = Medium.specificEnthalpy(state_out) "Outlet specific enthalpy";
  final parameter Medium.SpecificEnthalpy dh = h_out - h_in "Specific enthalpy difference";

  final parameter Medium.SpecificEnergy q = dh "Specific heat flow rate";
  final parameter SI.HeatFlowRate Q_flow = m_flow*q "Heat flow rate";

  // Periodic closed cycle system process
  final parameter Medium.SpecificEnergy u_in = h_in - p/rho_in "Inlet specific internal energy";
  final parameter Medium.SpecificEnergy u_out = h_out - p/rho_out "Outlet specific internal energy";
  final parameter Medium.SpecificEnergy du = u_out - u_in "Specific internal energy difference";
  final parameter SI.SpecificEnergy w_exp = - p*(v_out - v_in)  "Specific expansion work";
  final parameter SI.SpecificEnergy w_amb = - p_inf*(v_out - v_in) "Specific ambient pressure work";
  final parameter SI.SpecificEnergy w_exp_net = w_exp - w_amb  "Net specific expansion work";
  final parameter SI.Power P = m_flow*w_exp_net "Net power (net expansion work flow rate)";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

equation

  annotation(
    Documentation(
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>",
      info="<html>
  <p>
    Defines the parameters.
  </p>
</html>"));
end PartialFixed;
