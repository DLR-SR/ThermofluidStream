within ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.Wilo;
record TopS40slash7 "Pump coefficients of a staged Wilo-Top-S 40/7 pump"
  extends ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump(
    final setHead=false,
    final head_ref=0,
    w_ref=Modelica.Units.Conversions.from_rpm(2600),
    rho_ref=1000.000000,
    V_flow_ref=0.005367,
    dp_ref=71281.237715,
    eta_ref=0.383891,
    c2_head=-0.080345,
    c3_power=-0.178671,
    Vr_peak=0.533481);
// For your information
// c_power={0.251279,0.319702,-0.178671}
// dpr_peak = 0.533481; Pressure rise ratio (dp/dp_ref) at peak efficiency

  annotation (
defaultComponentPrefixes="parameter",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS40_7_data.pdf\">Data sheet of Wilo-Top-S 40/7</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS40_7_head.png\" alt=\"Wilo-Top-S 40/7 head\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS40_7_power.png\" alt=\"Wilo-Top-S 40/7 power\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS40_7_efficiency.png\" alt=\"Wilo-Top-S 40/7 efficiency\" width=\"800\">
</p>
</html>",
  revisions="<html>
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
February 17, 2016, by Michael Wetter:<br>
Updated parameter names for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/396\">#396</a>.
</li>
<li>
February 17, 2016, by Michael Wetter:<br>
Updated parameter names for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/396\">#396</a>.
</li>
<li>
January 19, 2016, by Filip Jorissen:<br>
First implementation.
</li>
</ul>
</html>"));
end TopS40slash7;
