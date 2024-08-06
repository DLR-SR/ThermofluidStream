within ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnMeasurements.MeasurementData.Grundfos;
record GrundfosMAGNA3_32120_F_N "Pump data for a Grundfos MAGNA3 32-120 F N pump, also used in ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal"
  extends ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnMeasurements.MeasurementData.GenericPump(
    rho_ref=1000,
    w_ref=Modelica.Units.Conversions.from_rpm(1450),
    V_flow = {0, 0.000459, 0.000918, 0.001377, 0.001836, 0.002295, 0.002754, 0.003213, 0.003672, 0.004131,0.004590},
    P = {55.866142, 78.950351, 99.019996, 116.075076, 130.115592, 141.141543, 149.152930, 154.149752, 156.132010, 155.099703, 151.052832},
    dp = {47089.773689, 50056.225473, 51383.453487, 51071.457733, 49120.238210, 45529.794918, 40300.127856, 33431.237026, 24923.122426, 14775.784058, 2989.221920},
    final setHead=false,
    final head = {0});// head ist not used since setHead=false. I set final head = {0}; to hide it in the parameter window (for less confusion i hope)

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
<a href=\"modelica://ThermofluidStream/Resources/Doku/Pumps/Grundfos_MAGNA3_32120_F_N_data.pdf\">Data sheet of Grundfos MAGNA3 32-120 F N</a> also used in
 <a href=\"modelica://ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal\">ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal</a>
</p>
<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/Grundfos_MAGNA3_32120_F_N_head.png\" alt=\"Grundfos MAGNA3 32-120 F N head\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/Grundfos_MAGNA3_32120_F_N_power.png\" alt=\"Grundfos MAGNA3 32-120 F N power\" width=\"800\">
<img src=\"modelica://ThermofluidStream/Resources/Doku/Pumps/Grundfos_MAGNA3_32120_F_N_efficiency.png\" alt=\"Grundfos MAGNA3 32-120 F N efficiency\" width=\"800\">
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
end GrundfosMAGNA3_32120_F_N;
