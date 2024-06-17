within ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.Wilo;
record TopS30slash5 "Pump coefficients of a staged Wilo-Top-S 30/5 pump"
  extends
    ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.GenericPumpCoefficients(
    final setHead=false,
    final head_ref=0,
    w_ref=Modelica.Units.Conversions.from_rpm(2320.000000),
    rho_ref=1000.000000,
    V_flow_ref=0.001755,
    dp_ref=52685.562839,
    eta_ref=0.239587,
    c2_head=-0.294939,
    c3_power=-0.164272,
    Vr_peak=0.503990);
// For your information
// c_power={0.213709,0.331021,-0.164272}
// dpr_peak = 0.503990; Pressure rise ratio (dp/dp_ref) at peak efficiency

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS30_5_data.pdf\">Data sheet of Wilo-Top-S 30/5</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS30_5_head.png\" alt=\"Wilo-Top-S 30/5 head\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS30_5_power.png\" alt=\"Wilo-Top-S 30/5 power\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloTopS30_5_efficiency.png\" alt=\"Wilo-Top-S 30/5 efficiency\" width=\"800\">
</p>
</html>",
  revisions="<html>
<ul>
<li>
March 29, 2023, by Hongxiang Fu:<br/>
Deleted angular speed parameters with the unit rpm.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1704\">IBPSA, #1704</a>.
</li>
<li>
October 14, 2021, by Hongxiang Fu:<br/>
Rewrote the statements using <code>use_powerCharacteristic</code>
to support the implementation of
<a href=\"Modelica://Buildings.Fluid.Movers.BaseClasses.Euler\">
<code>Buildings.Fluid.Movers.BaseClasses.Euler</code></a>.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2668\">#2668</a>.
</li>
<li>
February 17, 2016, by Michael Wetter:<br/>
Updated parameter names for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/396\">#396</a>.
</li>
<li>
February 17, 2016, by Michael Wetter:<br/>
Updated parameter names for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/396\">#396</a>.
</li>
<li>
January 19, 2016, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end TopS30slash5;
