within ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnMeasurements.MeasurementData.Wilo;
record Stratos30slash1to4 "Pump data for a Wilo Stratos 30/1-4 pump"
  extends ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnMeasurements.MeasurementData.GenericPump(
    setHead=false,
    rho_ref=1000,
    w_ref=Modelica.Units.Conversions.from_rpm(1800),
    V_flow={5.55555555556e-07,0.000402190923318,0.00052269170579,0.000643192488263,0.000752738654147,0.000866979655712,
        0.000973395931142,0.00108607198748,0.00115962441315},
    P={14.2085618951,21.2596204596,23.3573239437,25.1349149442,26.581943662,27.9121571534,28.8498841148,29.4981726255,
        29.7520982304},
    dp={17066.9518717,16997.0053476,16437.4331551,15528.1283422,14408.9839572,13149.9465241,11681.0695187,9932.40641711,
        8533.47593583});
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos30_1-4_data.pdf\">Data sheet of Wilo Stratos 30/1-4</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos30_1-4_head.png\" alt=\"Wilo Stratos 30/1-4 head\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos30_1-4_power.png\" alt=\"Wilo Stratos 30/1-4 power\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos30_1-4_efficiency.png\" alt=\"Wilo Stratos 30/1-4 efficiency\" width=\"800\">
</p>
</html>",   revisions="<html>
<ul>
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
end Stratos30slash1to4;
