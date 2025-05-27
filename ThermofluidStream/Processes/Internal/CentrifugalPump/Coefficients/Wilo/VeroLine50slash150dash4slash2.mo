within ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.Wilo;
record VeroLine50slash150dash4slash2 "Pump coefficients of a Wilo Veroline IP-E 50/150-4/2 pump"
  extends ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump
                                                                               (
    final setHead=true,
    final dp_peak=0,
    w_ref=Modelica.Units.Conversions.from_rpm(2900.000000),
    rho_ref=1000,
    V_flow_peak=0.012258,
    head_peak=22.00,
    eta_peak=0.635,
    V_0n=2.014,
    h_0n=1.161,
    P_0n=0.372);

  annotation (
defaultComponentPrefixes="parameter",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloVerolineIP-E50_150-4_2_data.pdf\">Data sheet of Wilo Veroline IP-E 50/150-4/2</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloVerolineIP-E50_150-4_2_head.png\" alt=\"Wilo Veroline IP-E 50/150-4/2 head\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloVerolineIP-E50_150-4_2_power.png\" alt=\"Wilo Veroline IP-E 50/150-4/2 power\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloVerolineIP-E50_150-4_2_efficiency.png\" alt=\"Wilo Veroline IP-E 50/150-4/2 efficiency\" width=\"500\">
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
May 28, 2017, by Iago Cupeiro:
<br>
Initial version
</li>
</ul>
</html>"));
end VeroLine50slash150dash4slash2;
