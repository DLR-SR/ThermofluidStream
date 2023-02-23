within ThermofluidStream;
package Sensors "Package containing sensors for the thermofluid simulation"
  extends Modelica.Icons.SensorsPackage;

  annotation (Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\"/>(c) 2020-2021, DLR, Institute of System Dynamics and Control</p>
</html>", info="<html>
<p>This package contains idealized sensor models for the thermofluid simulation. Massflow / Enthalpy flow sensors must be incooperated into the loop. </p>
<p>Others can be connected without a junction. Sensors with two inputs can be used to sense the difference in a signal. </p>
</html>"));
end Sensors;
