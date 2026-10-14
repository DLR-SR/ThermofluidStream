within ;
package ThermofluidStreamTest "Library to test components of package ThermofluidStream"
  extends Modelica.Icons.Package;
  annotation (
    preferredView="info",
    version="1.1.0",
    versionDate="2024-02-05",
    dateModified = "2024-02-05 11:00:00Z",
    revisionId="$Format:%h %ci$",
    uses(
      ThermofluidStream(version="1.1.0"),
      Modelica(version="4.0.0")),
    Documentation(
      info="<html>
<p>
This library provides models and functions to test components of
<strong>package <a href=\"modelica://ThermofluidStream\">ThermofluidStream</a></strong>.
</p>

<p>
Further development of this library should be performed in the following
way:
</p>

<ul>
  <li>
    <em>Functions</em> that are added to this library to test functions of the
    ThermofluidStream Library, should be called in \"ThermofluidStreamTest.testAllFunctions()\".
    The idea is that all test functions are called, when calling
    \"testAllFunctions()\".
  </li>
  <li>
    <em>Models</em> that are added to this library should have the annotation
    (with an appropriate StopTime):
    <blockquote><pre>
<strong>annotation</strong>(experiment(StopTime=1.1));
    </pre></blockquote>
    This gives the tool vendors the possibility to automatically identify
    the models that shall be simulated and, e.g., that shall be used in an automatic
    regression tests.
  </li>
</ul>

<p>
<em>
This Modelica package is <u>free</u> software and the use is completely at
<strong>your own risk</strong>; it can be redistributed and/or modified under the terms
of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty)
visit <a href=\"modelica://ThermofluidStream.UsersGuide.License\">ThermofluidStream.UsersGuide.License</a>.
</em>
</p>
</html>",
      revisions="<html>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
  <tr>
    <td valign=\"middle\">
      <img width=\"72\" src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\" alt=\"Logo DLR\">
    </td>
    <td valign=\"middle\">
      <strong>Copyright &copy; 2024, DLR Institut f&uuml;r Systemdynamik und Regelungstechnik</strong>
    </td>
  </tr>
</table>
</html>"));
end ThermofluidStreamTest;
