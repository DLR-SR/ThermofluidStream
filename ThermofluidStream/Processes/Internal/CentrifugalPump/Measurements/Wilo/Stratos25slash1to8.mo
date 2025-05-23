within ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo;
record Stratos25slash1to8 "Pump data for a Wilo Stratos 25/1-8 pump"
  extends ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump(
    rho_ref=1000,
    w_ref=Modelica.Units.Conversions.from_rpm(3040),
    V_flow={2.66111582909e-06,0.000621486635037,0.000887056469533,0.0011525489114,0.00140859349908,0.00168018209891,0.00191740837085,0.00219831980599},
    P={42.7878285797,72.7712666315,87.0576021552,99.7562542248,108.565085499,117.461493336,123.188074537,128.511579716},

    dp={50002.7035151,49603.919395,47783.2940685,44505.1908368,39882.6694921,33688.9797121,27835.1000463,20631.4409942},

    final setHead=false,
    final head={0});

                      // head ist not used since setHead=false. I set final head = {0}; to hide it in the parameter window (for less confusion i hope)

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos25_1-8_data.pdf\">Data sheet of Wilo Stratos 25/1-8</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos25_1-8_head.png\" alt=\"Wilo Stratos 25/1-8 head\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos25_1-8_power.png\" alt=\"Wilo Stratos 25/1-8 power\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos25_1-8_efficiency.png\" alt=\"Wilo Stratos 25/1-8 efficiency\" width=\"500\">
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
end Stratos25slash1to8;
