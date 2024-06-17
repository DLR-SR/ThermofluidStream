within ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.Wilo;
record Stratos30slash1to4 "Pump coefficients of a Wilo Stratos 30/1-4 pump"
  extends
    ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.GenericPumpCoefficients(
    final setHead=false,
    final head_ref=0,
    w_ref=Modelica.Units.Conversions.from_rpm(1800),
    rho_ref=1000.000000,
    V_flow_ref=0.001549,
    dp_ref=17061.807917,
    eta_ref=0.413686,
    c2_head=0.337359,
    c3_power=-0.250291,
    Vr_peak=0.521800);
// For your information
// c_power={0.220003,0.520883,-0.250291};
// dpr_peak = 0.521800; Pressure rise ratio (dp/dp_ref) at peak efficiency

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
