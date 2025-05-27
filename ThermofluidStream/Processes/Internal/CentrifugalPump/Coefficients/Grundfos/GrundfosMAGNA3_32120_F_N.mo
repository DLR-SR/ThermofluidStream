within ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.Grundfos;
record GrundfosMAGNA3_32120_F_N "Pump data for a Grundfos MAGNA3 32-120 F N pump, used in ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal"
  extends ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump
                                                                               (
    final setHead=true,
    final dp_peak=0,
    w_ref=Modelica.Units.Conversions.from_rpm(3000),
    rho_ref=1000,
    V_flow_peak=0.002565,
    head_peak=4.35,
    eta_peak=0.748,
    V_0n=1.831,
    h_0n=1.104,
    P_0n=0.382);

  annotation (
defaultComponentPrefixes="parameter",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/Grundfos_MAGNA3_32120_F_N_data.pdf\">Data sheet of Grundfos MAGNA3 32-120 F N</a> also used in
 <a href=\"modelica://ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal\">ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/Grundfos_MAGNA3_32120_F_N_head.png\" alt=\"Grundfos MAGNA3 32-120 F N head\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/Grundfos_MAGNA3_32120_F_N_power.png\" alt=\"Grundfos MAGNA3 32-120 F N power\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/Grundfos_MAGNA3_32120_F_N_efficiency.png\" alt=\"Grundfos MAGNA3 32-120 F N efficiency\" width=\"500\">
</p>
</html>",   revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
end GrundfosMAGNA3_32120_F_N;
