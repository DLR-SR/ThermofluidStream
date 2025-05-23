within ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo;
record VeroLine80slash115dash2comma2slash2
  "Pump data for a Wilo Veroline IP-E 80/115-2,2/2 pump"
  extends ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump(
    rho_ref=1000,
    w_ref=Modelica.Units.Conversions.from_rpm(2900),
    V_flow={0.0,0.00381944444444,0.00770833333333,0.0111111111111,0.014375,0.0171527777778,0.0197916666667,0.0220138888889},
    P={1712.23021583,1939.82995422,2319.7768316,2599.92683819,2775.17985612,2815.09529219,2709.57970466,2571.61543492},

    dp={157548.6,150053.76,139302.0,127431.9,113011.2,97943.04,76596.48,57133.44},
    final setHead=false,
    final head={0});

                      // head ist not used since setHead=false. I set final head = {0}; to hide it in the parameter window (for less confusion i hope)

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloVerolineIP-E80_115-2_2comma2_2_data.pdf\">Data sheet of Wilo Veroline IP-E 80/115-2,2/2</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloVerolineIP-E80_115-2_2comma2_2_head.png\" alt=\"Wilo Veroline IP-E 80/115-2,2/2 head\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloVerolineIP-E80_115-2_2comma2_2_power.png\" alt=\"Wilo Veroline IP-E 80/115-2,2/2 power\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloVerolineIP-E80_115-2_2comma2_2_efficiency.png\" alt=\"Wilo Veroline IP-E 80/115-2,2/2 efficiency\" width=\"500\">
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
Changed data link to the English version
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
end VeroLine80slash115dash2comma2slash2;
