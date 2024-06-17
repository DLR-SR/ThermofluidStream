within ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.Wilo;
record CronolineIL80slash220dash4slash4 "Pump coefficients of a Wilo Cronoline-IL 80/220-4/4 pump"
  extends
    ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.GenericPumpCoefficients(
    final setHead=false,
    final head_ref=0,
    w_ref=Modelica.Units.Conversions.from_rpm(1450),
    rho_ref=1000.000000,
    V_flow_ref=0.038515,
    dp_ref=163601.311487,
    eta_ref=0.765867,
    c2_head=0.360952,
    c3_power=-0.436347,
    Vr_peak=0.524686);
// For your information
// c_power={0.173670,0.712670,-0.436347}; Coefficients of second order power approximation polynomial
// dpr_peak = 0.524686; Pressure rise ratio (dp/dp_ref) at peak efficiency

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloCronoline-IL80_220-4_4_data.pdf\">Data sheet of Wilo Cronoline-IL 80/220-4/4</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloCronoline-IL80_220-4_4_head.png\" alt=\"Wilo Cronoline-IL 80/220-4/4 head\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloCronoline-IL80_220-4_4_power.png\" alt=\"Wilo Cronoline-IL 80/220-4/4 power\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/WiloCronoline-IL80_220-4_4_efficiency.png\" alt=\"Wilo Cronoline-IL 80/220-4/4 efficiency\" width=\"800\">
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
