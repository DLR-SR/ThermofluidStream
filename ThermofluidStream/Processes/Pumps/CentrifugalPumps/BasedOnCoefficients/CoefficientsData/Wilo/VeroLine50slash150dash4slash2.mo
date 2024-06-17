within ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.Wilo;
record VeroLine50slash150dash4slash2 "Pump coefficients of a Wilo Veroline IP-E 50/150-4/2 pump"
  extends
    ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.GenericPumpCoefficients(
    final setHead=false,
    final head_ref=0,
    w_ref=Modelica.Units.Conversions.from_rpm(2900.000000),
    rho_ref=1000.000000,
    V_flow_ref=0.024686,
    dp_ref=250432.613852,
    eta_ref=0.634651,
    c2_head=0.431495,
    c3_power=-0.344428,
    Vr_peak=0.496552);
// For your information
// c_power={0.159207,0.711707,-0.344428}
// dpr_peak = 0.496552; Pressure rise ratio (dp/dp_ref) at peak efficiency

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloVerolineIP-E50_150-4_2_data.pdf\">Data sheet of Wilo Veroline IP-E 50/150-4/2</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloVerolineIP-E50_150-4_2_head.png\" alt=\"Wilo Veroline IP-E 50/150-4/2 head\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloVerolineIP-E50_150-4_2_power.png\" alt=\"Wilo Veroline IP-E 50/150-4/2 power\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloVerolineIP-E50_150-4_2_efficiency.png\" alt=\"Wilo Veroline IP-E 50/150-4/2 efficiency\" width=\"800\">
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
May 28, 2017, by Iago Cupeiro:
<br>
Initial version
</li>
</ul>
</html>"));
end VeroLine50slash150dash4slash2;
