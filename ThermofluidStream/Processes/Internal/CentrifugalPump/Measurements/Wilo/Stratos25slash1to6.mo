within ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo;
record Stratos25slash1to6 "Pump data for a Wilo Stratos 25/1-6 pump"
  extends ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump(
    rho_ref=1000,
    w_ref=Modelica.Units.Conversions.from_rpm(2540),
    V_flow={8.4618254914e-06,0.000274485730449,0.000555832400486,0.000837082776634,0.00110292011218,0.00138657181719,0.00166761756882,0.00187198329301},
    P={27.7850423935,35.9020280633,46.212011386,55.5493899809,62.3704820257,68.7045763872,73.3263927089,75.1773568358},

    dp={34808.1176471,34738.9411765,34508.1176471,32430.7058824,29083.7647059,24005.6470588,18004.2352941,13041.5294118},

    final setHead=false,
    final head={0});

                      // head ist not used since setHead=false. I set final head = {0}; to hide it in the parameter window (for less confusion i hope)

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos25_1-6_data.pdf\">Data sheet of Wilo Stratos 25/1-6</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos25_1-6_head.png\" alt=\"Wilo Stratos 25/1-6 head\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos25_1-6_power.png\" alt=\"Wilo Stratos 25/1-6 power\" width=\"500\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos25_1-6_efficiency.png\" alt=\"Wilo Stratos 25/1-6 efficiency\" width=\"500\">
</p>
</html>", revisions="<html>
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
<li>April 17, 2014
    by Filip Jorissen:<br>
       Initial version
</li>
</ul>
</html>"));
end Stratos25slash1to6;
