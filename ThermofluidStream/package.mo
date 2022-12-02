within ;
package ThermofluidStream "Library for the Modelling of Thermofluid Streams"
  extends Modelica.Icons.Package;

  import      Modelica.Units.SI;

annotation (
  version="1.0.0",
  uses(Modelica(version="4.0.0"), ObsoleteModelica4(version="4.0.0"),
    Complex(version="4.0.0")),
  conversion(
  noneFromVersion="0.4.1",
  from(
      version="0.2.1",
      to="0.3.0",
      script="modelica://ThermofluidStream/Resources/ConversionSkripts/convert0_2_1to0_3_0.mos")),
  Documentation(info="<html>

</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\"/>(c) 2020-2021, DLR, Institute of System Dynamics and Control</p>
</html>"),
  Icon(graphics={Bitmap(extent={{-100,-100},{100,100}}, fileName="modelica://ThermofluidStream/Resources/logo_lib.png")}));
end ThermofluidStream;
