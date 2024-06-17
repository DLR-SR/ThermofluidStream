within ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.Wilo;
record Stratos50slash1to12 "Pump coefficients of a Wilo Stratos 50/1-12 pump"
  extends
    ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.GenericPumpCoefficients(
    final setHead=false,
    final head_ref=0,
    w_ref=Modelica.Units.Conversions.from_rpm(3690),
    rho_ref=1000.000000,
    V_flow_ref=0.009121,
    dp_ref=72829.500295,
    eta_ref=0.630773,
    c2_head=0.616064,
    c3_power=-0.446508,
    Vr_peak=0.532040);
// For your information
// c_power={0.185989,0.758300,-0.446508}
// dpr_peak = 0.532040; Pressure rise ratio (dp/dp_ref) at peak efficiency

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos50_1-12_data.pdf\">Data sheet of Wilo Stratos 50/1-12</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos50_1-12_head.png\" alt=\"Wilo Stratos 50/1-12 head\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos50_1-12_power.png\" alt=\"Wilo Stratos 50/1-12 power\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloStratos50_1-12_efficiency.png\" alt=\"Wilo Stratos 50/1-12 efficiency\" width=\"800\">
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
end Stratos50slash1to12;
