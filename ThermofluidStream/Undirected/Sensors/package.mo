within ThermofluidStream.Undirected;
package Sensors "Sensors package for undirected thermofluid simulation"
  extends Modelica.Icons.SensorsPackage;

import ThermofluidStream.Sensors.Internal;


  annotation (Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\"/>(c) 2020-2021, DLR, Institute of System Dynamics and Control</p>

</html>", info="<html>
<p>Sensors&nbsp;package&nbsp;for&nbsp;undirected&nbsp;thermofluid&nbsp;simulation. For undirected flow, the massflow must always be measured, since it determines if the forward or the backward flow is valid. Therfore the fluid must flow through the sensor.</p>
</html>"));
end Sensors;
