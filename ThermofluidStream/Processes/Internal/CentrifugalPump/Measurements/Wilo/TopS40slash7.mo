within ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo;
record TopS40slash7 "Pump data for a staged Wilo-Top-S 40/7 pump"
  extends ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump(
    rho_ref=1000,
    w_ref=Modelica.Units.Conversions.from_rpm(2600),
    V_flow={9.97406742472e-07,0.000621384400559,0.00113006183922,0.00162078595651,0.00206961899062,0.00244663873928,0.0029074406543,0.00330241372432,0.00375723119888,0.00418212647117,0.00466686614802},
    P={254.806788065,282.40881459,303.06122449,330.952380952,347.819548872,360.093167702,372.657450077,380.261136713,386.328725038,390.607012036,391.047619048},
    dp={70951.3953488,69946.0659263,67225.7989228,63706.4291679,59843.4165588,54951.3185253,48807.3201536,42775.1388251,34577.6798464,26835.4759718,17270.2037493},
    final setHead=false,
    final head={0});  // head ist not used since setHead=false. I set final head = {0}; to hide it in the parameter window (for less confusion i hope)
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS40_7_data.pdf\">Data sheet of Wilo-Top-S 40/7</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS40_7_head.png\" alt=\"Wilo-Top-S 40/7 head\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS40_7_power.png\" alt=\"Wilo-Top-S 40/7 power\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS40_7_efficiency.png\" alt=\"Wilo-Top-S 40/7 efficiency\" width=\"500\">
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
