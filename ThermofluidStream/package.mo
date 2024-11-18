within ;
package ThermofluidStream "Library for the modeling of thermofluid streams"
  extends Modelica.Icons.Package;

  import Modelica.Units.SI;

  annotation (
    version = "1.2.0",
    versionDate = "2024-11-18",
    dateModified = "2024-11-18 16:54:00Z",
    uses(
      Modelica(version="4.0.0"),
      Complex(version="4.0.0")),
    conversion(
      noneFromVersion="1.1.0",
      from(
        version="1.0.0",
        script="modelica://ThermofluidStream/Resources/Scripts/Conversion/ConvertTFS_from_1.0.0_to_1.1.0.mos"),
      noneFromVersion="0.5.0",
      noneFromVersion="0.4.1",
      noneFromVersion="0.3.0",
      from(
        version="0.2.1",
        to="0.3.0",
        script="modelica://ThermofluidStream/Resources/Scripts/Conversion/ConvertTFS_from_0.2.1_to_0.3.0.mos.mos")),
    Documentation(info="<html>
<p>
The DLR ThermofluidStream Library is a&nbsp;free open-source library for the
robust modeling of complex thermofluid architectures. Designed to be easy to
use and easy to adapt and enriched by a&nbsp;number of examples, this library
can be used as basis for many different applications such as thermal management
of electric cars, power plants, or building physics.
</p>

<p>
For copyright and license, see
<a href=\"modelica://ThermofluidStream.UsersGuide.License\">Copyright and license agreement</a>.
</p>
</html>", revisions="<html>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
  <tr>
    <td valign=\"middle\">
      <img width=\"72\" src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\" alt=\"Logo DLR\">
    </td>
    <td valign=\"middle\">
      <strong>Copyright &copy; DLR Institut f&uuml;r Systemdynamik und Regelungstechnik</strong>
    </td>
  </tr>
</table>
</html>"),
    Icon(
      graphics={
        Bitmap(
          extent={{-100,-100},{100,100}},
          fileName="modelica://ThermofluidStream/Resources/logo_lib.png")}));
end ThermofluidStream;
