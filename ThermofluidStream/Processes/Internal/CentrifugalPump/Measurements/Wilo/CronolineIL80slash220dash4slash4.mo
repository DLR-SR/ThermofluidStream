within ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo;
record CronolineIL80slash220dash4slash4 "Pump data for a Wilo Cronoline-IL 80/220-4/4 pump"
  extends ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump(
    rho_ref=1000,
    w_ref=Modelica.Units.Conversions.from_rpm(1450),
    V_flow={0.00303454715219,0.00578898225957,0.00863678804855,0.0113912231559,0.0146125116713,0.0181605975724,0.0214285714286,0.0248366013072,0.0274042950514,0.0282446311858},
    P={1905.29339941,2202.03582759,2548.86483304,2812.07908132,3146.06691483,3435.07911022,3592.75276695,3710.09774539,3774.78991597,3793.34692457},
    dp={168215.17064,166653.242326,164291.843595,161128.282627,154367.77774,142807.085577,128439.498542,108468.216086,92889.3102384,86895.3009775},
    final setHead=false,
    final head={0});  // head ist not used since setHead=false. I set final head = {0}; to hide it in the parameter window (for less confusion i hope)
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloCronoline-IL80_220-4_4_data.pdf\">Data sheet of Wilo Cronoline-IL 80/220-4/4</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloCronoline-IL80_220-4_4_head.png\" alt=\"Wilo Cronoline-IL 80/220-4/4 head\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloCronoline-IL80_220-4_4_power.png\" alt=\"Wilo Cronoline-IL 80/220-4/4 power\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloCronoline-IL80_220-4_4_efficiency.png\" alt=\"Wilo Cronoline-IL 80/220-4/4 efficiency\" width=\"500\">
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
end CronolineIL80slash220dash4slash4;
