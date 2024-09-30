within ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.Grundfos;
record GrundfosMAGNA3_32120_F_N "Pump data for a Grundfos MAGNA3 32-120 F N pump, used in ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal"
  extends ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump(
    final setHead=false,
    final head_ref=0,
    w_ref=Modelica.Units.Conversions.from_rpm(3000),
    rho_ref=1000.000000,
    V_flow_ref=0.004697,
    dp_ref=47089.773689,
    eta_ref=0.748209,
    c2_head=0.822790,
    c3_power=-0.713646,
    Vr_peak=0.546026);

// For your information
// c_power={0.252570, 1.137747, -0.713646}; Coefficients of second order power approximation polynomial
// dpr_peak = 0.905810; Pressure rise ratio (dp/dp_ref) at peak efficiency

  annotation (
defaultComponentPrefixes="parameter",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/Grundfos_MAGNA3_32120_F_N_data.pdf\">Data sheet of Grundfos MAGNA3 32-120 F N</a> also used in
 <a href=\"modelica://ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal\">ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/Grundfos_MAGNA3_32120_F_N_head.png\" alt=\"Grundfos MAGNA3 32-120 F N head\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/Grundfos_MAGNA3_32120_F_N_power.png\" alt=\"Grundfos MAGNA3 32-120 F N power\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/Grundfos_MAGNA3_32120_F_N_efficiency.png\" alt=\"Grundfos MAGNA3 32-120 F N efficiency\" width=\"800\">
</p>
</html>",   revisions="<html>
<ul>
<li>
June 17, 2024, by Raphael Gebhart:
<br>
Transferred from <a href=\"https://github.com/lbl-srg/modelica-buildings\">Buildings Library</a> to  <a href=\"https://github.com/DLR-SR/ThermofluidStream\">ThermofluidStream Library</a>.
</li>
<li>
March 29, 2023, by Hongxiang Fu:<br>
Deleted angular speed parameters with the unit rpm.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1704\">IBPSA, #1704</a>.
</li>
<li>
October 14, 2021, by Hongxiang Fu:<br>
Rewrote the statements using <code>use_powerCharacteristic</code>
to support the implementation of
<a href=\"Modelica://Buildings.Fluid.Movers.BaseClasses.Euler\">
<code>Buildings.Fluid.Movers.BaseClasses.Euler</code></a>.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2668\">#2668</a>.
</li>
<li>
June 01, 2017, by Iago Cupeiro:
<br>
Changed data link to English version
</li>
<li>
February 17, 2016, by Michael Wetter:<br>
Updated parameter names for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/396\">#396</a>.
</li>
<li>
December 12, 2014, by Michael Wetter:<br>
Added <code>defaultComponentPrefixes</code> and
<code>defaultComponentName</code> annotations.
</li>
<li>April 22, 2014
    by Filip Jorissen:<br>
       Initial version
</li>
</ul>
</html>"));
end GrundfosMAGNA3_32120_F_N;
