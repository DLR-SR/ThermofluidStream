within ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo;
record TopS30slash5 "Pump data for a staged Wilo-Top-S 30/5 pump"
  extends ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump(
    rho_ref=1000,
    w_ref=Modelica.Units.Conversions.from_rpm(2320),
    V_flow={4.24448217317e-06,0.000275419732126,0.000501792114695,0.000688077721185,0.000827202414639,0.00101584606678,0.0011714770798,0.00132710809281,0.00148981324278,0.00166195057536},
    P={83.0171256559,101.117659669,113.263045942,122.28302674,128.764680916,135.257448954,139.852003784,143.350736549,145.269964752,146.115128625},
    dp={52688.1456954,49223.2450331,45151.986755,40994.1059603,37269.3377483,31205.7615894,25661.9205298,19598.3443709,12755.1655629,4699.27152318},
    final setHead=false,
    final head={0});  // head ist not used since setHead=false. I set final head = {0}; to hide it in the parameter window (for less confusion i hope)
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS30_5_data.pdf\">Data sheet of Wilo-Top-S 30/5</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS30_5_head.png\" alt=\"Wilo-Top-S 30/5 head\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS30_5_power.png\" alt=\"Wilo-Top-S 30/5 power\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS30_5_efficiency.png\" alt=\"Wilo-Top-S 30/5 efficiency\" width=\"500\">
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
end TopS30slash5;
