within ThermofluidStream.UserGuide;
class ReleaseNotes "Release notes"
  extends Modelica.Icons.ReleaseNotes;

  annotation (
    Documentation(
      info="<html>
<p>
This section summarizes the changes that have been performed on the library.
</p>

<h4>Version 1.1.0-dev (202Y-MM-DD)</h4>
<ul>
  <li>
    Updated graphical layout (both diagram and icon) of connectors
    <a href=\"modelica://ThermofluidStream.Interfaces.Inlet\">Inlet</a>
    and
    <a href=\"modelica://ThermofluidStream.Interfaces.Outlet\">Outlet</a>
    to be structured according to the convention of the Modelica
    Standard Library.
  </li>
  <li>
    Updated
    <a href=\"modelica://ThermofluidStream.Processes.FlowResistance\">flow resistance model</a>
    that now provides
    a) the ability to choose different shapes for cross sectional area and
    b) additional pressure loss functions (collected in
    <a href=\"modelica://ThermofluidStream.Processes.Internal.FlowResistance\">FlowResistance</a>
    sub-package).
  </li>
</ul>

<h4>Version 1.0.0 (2022-12-02)</h4>
<ul>
  <li>
    Converted library to MSL 4.0.0
  </li>
  <li>
    Synchronized local copy (myMedia) of MSL Media package
  </li>
  <li>
    Updated XRG Media package to be compatible
  </li>
  <li>
    Minor unit fixes
  </li>
</ul>

<h4>Version 0.5.0 (2022-11-10)</h4>
<ul>
  <li>
    First official release of the library.
  </li>
  <li>
    Compatible with MSL 3.2.3
  </li>
</ul>
</html>",
      revisions="<html>
</html>"));
end ReleaseNotes;
