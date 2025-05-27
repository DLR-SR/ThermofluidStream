within ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo;
record VeroLine50slash150dash4slash2
  "Pump data for a Wilo Veroline IP-E 50/150-4/2 pump"
  extends ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump(
    rho_ref=1000,
    w_ref=Modelica.Units.Conversions.from_rpm(2900),
    V_flow={0.0,0.00277777,0.00555555,0.00833333,0.01111111,0.01388888,0.01666666},
    P={1607.8,2235.3,2862.7,3529.4,4078.4,4392.2,4666.7},
    dp={255400,253000,250600,248200,232010,199640,156470},
    final setHead=false,
    final head={0});  // head ist not used since setHead=false. I set final head = {0}; to hide it in the parameter window (for less confusion i hope)
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
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
