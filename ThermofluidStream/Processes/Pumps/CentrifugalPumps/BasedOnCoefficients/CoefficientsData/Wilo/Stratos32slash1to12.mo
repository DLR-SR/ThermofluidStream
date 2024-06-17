within ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.Wilo;
record Stratos32slash1to12 "Pump coefficients of a Wilo Stratos 32/1-12 pump"
  extends
    ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.GenericPumpCoefficientsEfficiency(
    final setHead=false,
    final head_ref=0,
    w_ref=Modelica.Units.Conversions.from_rpm(3580),
    rho_ref=1000.000000,
    V_flow_ref=0.004888,
    dp_ref=58744.562822,
    eta_ref=0.540122,
    c2_head=0.259953,
    c3_power=-0.277826,
    Vr_peak=0.503739);
// For your information
// c_power={0.185644,0.582651,-0.277826}
// dpr_peak = 0.503739; Relative pressure rise (dp_peak/dp_ref) at peak efficiency

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos32_1-12_data.pdf\">Data sheet of Wilo Stratos 32/1-12</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos32_1-12_head.png\" alt=\"Wilo Stratos 32/1-12 head\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos32_1-12_power.png\" alt=\"Wilo Stratos 32/1-12 power\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos32_1-12_efficiency.png\" alt=\"Wilo Stratos 32/1-12 efficiency\" width=\"800\">
</p>
</html>",   revisions="<html>
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
December 12, 2014, by Michael Wetter:<br/>
Added <code>defaultComponentPrefixes</code> and
<code>defaultComponentName</code> annotations.
</li>
<li>April 22, 2014
    by Filip Jorissen:<br/>
       Initial version
</li>
</ul>
</html>"));
end Stratos32slash1to12;
