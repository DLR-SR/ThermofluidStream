within ThermofluidStream.UsersGuide;
package ReleaseNotes "Release notes"
extends Modelica.Icons.ReleaseNotes;

class VersionManagement "Version Management"
extends Modelica.Icons.ReleaseNotes;

annotation (Documentation(info="<html>

<h4>Version management</h4>

<p>
The ThermofluidStream library uses semantic versioning following the convention:
</p>

<blockquote><strong><code>MAJOR.MINOR.PATCH</code></strong></blockquote>
<ul>
  <li>
    <strong>MAJOR</strong> versions may contain incompatible changes that require users
    to adapt existing models.
  </li>
  <li>
    <strong>MINOR</strong> versions may add new models, packages, parameters or
    functionality in a generally backward compatible way.
  </li>
  <li>
    <strong>PATCH</strong> versions contain bug fixes, documentation updates and
    small maintenance changes.
  </li>
</ul>

<p>
For each release, the version information in the top-level package annotation
should be updated, especially <code>version</code>, <code>versionDate</code>,
<code>dateModified</code> and, if used, <code>revisionId</code>.
</p>

<blockquote><pre>
annotation(version      = &quot;1.4.0&quot;,
           versionDate  = &quot;YYYY-MM-DD&quot;,
           dateModified = &quot;YYYY-MM-DD&quot;,
           revisionId   = &quot;$F&#8203;ormat:%h %ci$&quot;)
</pre></blockquote>

<p>
The <code>revisionId</code> field is intended to identify the exact commit that
the released version represents when the library is exported from a Git tag.
</p>

<h4>Recommended release procedure</h4>
<ol>
  <li>Update the release notes.</li>
  <li>Update the top-level package annotation to the new version.</li>
  <li>Update tool-specific metadata, for example Dymola or Modelon Impact metadata, if present.</li>
  <li>Run the regression tests and tool checks.</li>
  <li>Create and push the Git tag, for example <code>v1.4.0</code>.</li>
  <li>Create the GitHub release from the tag.</li>
</ol>

</html>"));
end VersionManagement;

class Version_1_4_0 "Version 1.4.0 (August 2026)"
extends Modelica.Icons.ReleaseNotes;

annotation (Documentation(info="<html>

<p>
Version 1.4.0 is a minor release of the DLR Thermofluid Stream Library.
It introduces the new <code>ThermofluidStream.Idealized</code> package,
new flow-control functionality and major improvements to sensors, valves,
heat exchangers and examples.
</p>

<p>
No conversion script is required. Existing models may nevertheless require
parameter adjustments because of changed defaults and new validation checks.
</p>

<h4>Highlights</h4>
<ul>
  <li>
    Added the new
    <a href=\"modelica://ThermofluidStream.Idealized\">ThermofluidStream.Idealized</a>
    package for simplified thermodynamic process and cycle modeling.
  </li>
  <li>
    Added
    <a href=\"modelica://ThermofluidStream.FlowControl.ThreeWayValve\">ThreeWayValve</a>;
    the previous
    <a href=\"modelica://ThermofluidStream.FlowControl.Switch\">Switch</a>
    model is now obsolete.
  </li>
  <li>
    Substantially improved sensor icons, connector placement, dynamic value
    displays, numerical formatting and selectable display units.
  </li>
  <li>
    Improved valve diagnostics and added validation of standardized
    flow-coefficient reference values.
  </li>
  <li>
    Improved heat-exchanger icons, assertions and OpenModelica compatibility.
  </li>
  <li>
    Updated the <code>SimpleAirCycle</code> example and several media,
    pump and heat-exchanger examples.
  </li>
</ul>

<h4>New functionality</h4>

<h5>Idealized thermodynamic modeling</h5>
<p>
The new <code>ThermofluidStream.Idealized</code> package provides boundaries,
thermofluid components, energy-flow models, idealized thermodynamic processes,
topology models, utilities, examples and tests for conceptual thermodynamic
system analysis.
</p>
<p>
Dynamic icons for visibility in Dymola and OpenModelica.
</p>
  
<h5>Three-way valve</h5>
<p>
A new <code>ThreeWayValve</code> based on <code>BasicControlValve</code>
has been added. It provides parameterization similar to the previous
<code>Switch</code> model and includes a graphical indication of the valve
position. The previous <code>Switch</code> model remains available but is
marked obsolete.
</p>
  
<h4>Improvements and fixes</h4>

<h5>Sensors</h5>
<ul>
  <li>
    Improved icons, connector placement, numerical formatting and dynamic
    measurement-value displays.
  </li>
  <li>
    Added display units for specific enthalpy, specific entropy, molar mass,
    enthalpy flow and entropy flow.
  </li>
  <li>
    Corrected the mass-flow output unit in <code>MultiSensor_Tpm</code>.
  </li>
</ul>

<h5>Flow control</h5>
<ul>
  <li>
    Added visual indications to <code>MCV</code> and <code>PCV</code>
    when the requested set point cannot be reached.
  </li>
  <li>
    Assertion messages now identify the affected component instance.
  </li>
  <li>
    Deprecated the <code>Cvs_UK</code> flow-coefficient option while
    retaining it for compatibility.
  </li>
  <li>
    Added validation of <code>dp_ref</code> and <code>rho_ref</code>
    when standardized flow coefficients are used.
  </li>
  <li>
    Improved valve icon compatibility with OpenModelica.
  </li>
</ul>

<h5>Heat exchangers</h5>
<ul>
  <li>
    Improved connector handling and OpenModelica compatibility of
    discretized heat exchangers.
  </li>
  <li>
    Redesigned counter-flow and cross-flow heat-exchanger icons.
  </li>
  <li>
    Corrected mass-flow assertions in <code>PartialDiscretizedHEX</code>.
  </li>
</ul>

<h5>Test and examples</h5>
<ul>
  <li>
    Updated media, pump and heat-exchanger examples.
  </li>
  <li>
    Updated <code>SimpleAirCycle</code> for a regional-aircraft cruise
    operating point and added additional sensor and cooling-power displays.
  </li>
</ul>

<h4>Migration notes</h4>

<h5>Isenthalpic pressure-drop enforcement</h5>
<p>
Only for the ones using the idealized package before: The default value of
<code>ThermofluidStream.Idealized.Processes.Isenthalpic.enforcePressureDrop</code>
has changed from <code>true</code> to <code>false</code> to improve numerical
robustness. Models requiring the previous behavior must explicitly set:
</p>

<blockquote><pre>
enforcePressureDrop = true
</pre></blockquote>

<h5>Valve reference values</h5>
<p>
When using <code>Kvs</code>, <code>Cvs_US</code> or <code>Cvs_UK</code>,
the following reference values must not be modified:
</p>

<ul>
  <li><code>dp_ref = 1 bar</code></li>
  <li><code>rho_ref = 1000 kg/m3</code></li>
</ul>

<p>
New assertions detect modified reference values because these currently lead
to incorrect model behavior. Reducing the corresponding assertion level to a
warning does not correct an invalid parameterization.
</p>

<h5>Deprecated and obsolete functionality</h5>
<ul>
  <li>
    <code>ThermofluidStream.FlowControl.Switch</code> is obsolete;
    use <code>ThreeWayValve</code>.
  </li>
  <li>
    <code>ThermofluidStream.Utilities.RealVector</code> is obsolete.
  </li>
  <li>
    The <code>Cvs_UK</code> flow-coefficient option is deprecated.
  </li>
</ul>

<p>
These elements have not been removed, so existing models remain loadable.
</p>

</html>"));
end Version_1_4_0;

class Version_1_3_0 "Version 1.3.0 (April 30, 2026)"
extends Modelica.Icons.ReleaseNotes;

annotation (Documentation(info="<html>

<p>
Version 1.3.0 is a minor release of the DLR Thermofluid Stream Library.
No conversion script is required. Simulation results may nevertheless be affected
by corrected equations, improved regularization and updated media functions.
</p>

<h4>Short overview</h4>
<ul>
  <li>New centrifugal pump model with characteristic-based parameterization.</li>
  <li>New static head and tank-related components.</li>
  <li>Improved heat transfer and heat exchanger modeling.</li>
  <li>Extended media property support for incompressible media.</li>
  <li>Improved moist-air media functions and media declarations.</li>
  <li>Improved pressure-drop visualization for flow resistances and valves.</li>
  <li>Improved sensor compatibility with OMEdit.</li>
  <li>Improved <code>CentrifugalPump</code> compatibility with OpenModelica/OMEdit.</li>
  <li>New and updated tool metadata for Dymola and Modelon Impact.</li>
  <li>Several bug fixes in media, pressure-loss calculations, pumps, tests and documentation assets.</li>
  <li>Updated dependency to Modelica Standard Library 4.1.0 and Complex 4.1.0.</li>
  <li>New valve icon in FlowControl</li>
</ul>

<h4>New components and functionality</h4>

<h5>ThermofluidStream.Processes</h5>
<ul>
  <li>
    Added
    <a href=\"modelica://ThermofluidStream.Processes.CentrifugalPump\">CentrifugalPump</a>,
    including pump characteristics, coefficient- and measurement-based parameterization,
    manufacturer data, documentation and test models.
  </li>
  <li>
    Added
    <a href=\"modelica://ThermofluidStream.Processes.StaticHead\">StaticHead</a>
    for modeling static pressure head effects.
  </li>
</ul>

<h5>ThermofluidStream.Boundaries</h5>
<ul>
  <li>
    Added
    <a href=\"modelica://ThermofluidStream.Boundaries.TankCuboid\">TankCuboid</a>
    and related tank test examples.
  </li>
</ul>

<h4>Improved existing components</h4>

<h5>ThermofluidStream.Processes</h5>
<ul>
  <li>
    Added support for variable heat transfer properties in
    <a href=\"modelica://ThermofluidStream.Processes.ConductionElement\">ConductionElement</a>
    via an input connector.
  </li>
  <li>
    Added and improved pressure-drop visualization for
    <a href=\"modelica://ThermofluidStream.Processes.FlowResistance\">FlowResistance</a>,
    including unit selection and optional color-coded display using
    <code>dropOfCommons.displayColor</code> and <code>dp_ref_color</code>.
  </li>
  <li>
    Improved OpenModelica/OMEdit compatibility of
    <a href=\"modelica://ThermofluidStream.Processes.CentrifugalPump\">CentrifugalPump</a>.
    The pump test models now compile and simulate in OMEdit. The update includes an
    <code>each</code> modifier for <code>displayUnit</code> in <code>GenericPump</code>
    and an adapted <code>res_detadV</code> function interface.
  </li>
</ul>

<h5>ThermofluidStream.FlowControl</h5>
<ul>
  <li>
    Added and improved pressure-drop visualization for valve components.
  </li>
</ul>

<h5>ThermofluidStream.HeatExchangers</h5>
<ul>
  <li>
    Improved NTU heat exchanger models, including documentation of the heat exchanger
    time constant and simplification of the <code>PartialNTU</code> equation structure.
  </li>
</ul>

<h5>ThermofluidStream.Sensors</h5>
<ul>
  <li>
    Improved compatibility of
    <a href=\"modelica://ThermofluidStream.Sensors.SingleSensorSelect\">SingleSensorSelect</a>
    with OMEdit by introducing <code>GetQuantityBlock</code> and avoiding evaluation
    of inactive medium-property branches. The previous <code>getQuantity</code>
    implementation is obsolete.
  </li>
</ul>

<h5>Media</h5>
<ul>
  <li>
    Extended incompressible media with additional thermodynamic properties,
    including density derivatives and the isobaric expansion coefficient.
  </li>
  <li>
    Removed <code>final</code> from the redeclared <code>FluidConstants</code> record
    in <code>SingleGasNasa</code> to avoid Dymola pedantic-check warnings for media
    that modify this base class, for example <code>DryAirNasa</code>.
  </li>
</ul>

<h5>Documentation and layout</h5>
<ul>
  <li>
    Improved documentation for <code>DropOfCommons</code> and the <code>Topology</code> package.
  </li>
  <li>
    Changed the default display of instance names and parameters to <code>true</code>
    for improved Modelica-standard-compliant diagram display.
  </li>
</ul>

<h4>Fixed errors and relevant bugs</h4>

<h5>Media</h5>
<ul>
  <li>
    Fixed <code>MoistAir.T_pSX</code> for reduced mass-fraction vectors.
  </li>
  <li>
    Improved <code>MoistAir.isentropicExponent</code> and
    <code>MoistAir.specificEntropy</code>, especially around saturation and
    oversaturation. Added verification models for both functions.
  </li>
  <li>
    Fixed <code>PartialSimpleIdealGasMedium.setState_psX</code>.
  </li>
</ul>

<h5>Pressure loss and pumps</h5>
<ul>
  <li>
    Fixed Reynolds-number limiting in the Haaland pressure-loss formulation.
  </li>
  <li>
    Fixed an incorrect Reynolds-number calculation in <code>dp_tau_centrifugal</code>.
    The Reynolds number was previously overestimated by a factor equal to the density
    in kg/m3, which caused overly strong viscosity effects and incorrect pump results.
    Related test models and examples were checked and updated.
  </li>
  <li>
    Fixed <code>CentrifugalPump</code> behavior for multiphase media and improved
    pump regularization for measurement- and coefficient-based parameterizations.
  </li>
</ul>

<h5>Tests and documentation assets</h5>
<ul>
  <li>
    Fixed initialization in the Piston example test.
  </li>
  <li>
    Fixed documentation image links and file name casing issues.
  </li>
</ul>

<h4>Further updates</h4>
<ul>
  <li>Added Dymola library browser support.</li>
  <li>Added Modelon Impact metadata.</li>
  <li>Updated README files, examples, documentation assets and example graphics.</li>
  <li>Excluded an intentionally failing model from regression testing.</li>
  <li>
    Updated the required Modelica Standard Library version from 4.0.0 to 4.1.0.
    No Modelica conversion script is expected to be required for this dependency update,
    but simulation results may change due to fixes and changes in the Modelica Standard Library.
  </li>
</ul>

</html>"));
end Version_1_3_0;

class Version_1_2_0 "Version 1.2.0 (November 18, 2024)"
extends Modelica.Icons.ReleaseNotes;

annotation (Documentation(info="<html>

<p>
Version 1.2.0 of the DLR Thermofluid Stream Library.
</p>

<h4>Improvements of the library</h4>
<ul>
  <li>
    Velocity of sound can be measured with
    <a href=\"modelica://ThermofluidStream.Sensors.SingleSensorSelect\">SingleSensorSelect</a>
    and
    <a href=\"modelica://ThermofluidStream.Undirected.Sensors.SingleSensorSelect\">undirected SingleSensorSelect</a>.
  </li>
  <li>
    Added the ability to display class instance names and relevant parameters by a global parameter in <code>dropOfCommons</code>.
    The parameter can be overwritten on component level, on the layout tab, to only display the names of selected class instances
    and/or parameters.
  </li>
  <li>
    Improved compressible media assert and include <code>assertionLevel</code> from <code>dropOfCommons</code>.
  </li>
  <li>
    Added <a href=\"modelica://ThermofluidStream.Processes.Pipes\">pipes package</a> provided by HTWG Konstanz.
    The package consists of regular straight pipes, bends, flow contraction and expansion as well as flow con- and diverging components.
  </li>
  <li>
    Added default values for valve parameters and asserts for check.
  </li>
</ul>

<h4>Further updates</h4>
<ul>
  <li>
    Added <code>TILMediaWrapper</code> to repository. Interface for the usage of TILMedia in the TFS.
    A separate TILMedia license is necessary.
  </li>
  <li>
    Added guideline on how to contribute to the library.
  </li>
</ul>

</html>"));
end Version_1_2_0;

class Version_1_1_0 "Version 1.1.0 (October 6, 2023)"
extends Modelica.Icons.ReleaseNotes;

annotation (Documentation(info="<html>

<p>
Version 1.1.0 of the DLR Thermofluid Stream Library.
</p>

<ul>
  <li>
    Updated graphical layout, both diagram and icon, of connectors
    <a href=\"modelica://ThermofluidStream.Interfaces.Inlet\">Inlet</a>
    and
    <a href=\"modelica://ThermofluidStream.Interfaces.Outlet\">Outlet</a>
    to be structured according to the convention of the Modelica Standard Library.
  </li>
  <li>
    Updated
    <a href=\"modelica://ThermofluidStream.Processes.FlowResistance\">flow resistance model</a>
    that now provides the ability to choose different shapes for cross sectional area
    and additional pressure loss functions collected in
    <a href=\"modelica://ThermofluidStream.Processes.Internal.FlowResistance\">FlowResistance</a>
    sub-package.
  </li>
  <li>
    Fixed bug in
    <a href=\"modelica://ThermofluidStream.HeatExchangers.DiscretizedCrossFlowHEX\">cross-flow heat exchanger</a>:
    solution not converging for increasing number of discretization elements.
    <ul>
      <li>Scale reference mass-flow for heat transfer coefficient if stream is split into parallel streams.</li>
      <li>Introduce parameter <code>nCellsParallel</code> for general usage in all discretized heat exchangers.</li>
    </ul>
  </li>
  <li>
    Updated discretized and NTU heat exchangers to inherit from common base components.
    <ul>
      <li>Added summary record to NTU heat exchangers.</li>
      <li>
        Changed direction of the <code>ThermalConductor</code> in cross-flow heat exchangers.
        This causes heat flow from A to B to be positive, similar to the counter-flow heat exchangers.
      </li>
      <li>
        Corrected an error in the
        <a href=\"modelica://ThermofluidStream.Undirected.HeatExchangers.DiscretizedCounterFlowHEX\">undirected counter-flow heat exchanger</a>.
        Now <code>m_flow_A</code> and <code>m_flow_B</code> correspond to the flow through channel A and B respectively.
      </li>
    </ul>
  </li>
  <li>
    Fixed bug in
    <a href=\"modelica://ThermofluidStream.Boundaries.Internal.PartialVolumeM\">PartialVolumeM</a>
    and
    <a href=\"modelica://ThermofluidStream.Boundaries.Internal.PartialVolumeN\">PartialVolumeN</a>:
    <code>noEvent</code> operator now works on mass-flow-related if-statements.
  </li>
  <li>
    Fixed wrong handling of conditional connectors by removing input binding for conditional connectors
    and enabling or disabling conditional connectors which depend on the <code>setEnthalpy</code> parameter.
  </li>
</ul>

</html>"));
end Version_1_1_0;

class Version_1_0_0 "Version 1.0.0 (December 2, 2022)"
extends Modelica.Icons.ReleaseNotes;

annotation (Documentation(info="<html>

<p>
Version 1.0.0 of the DLR Thermofluid Stream Library.
</p>

<ul>
  <li>Converted library to MSL 4.0.0.</li>
  <li>Synchronized local copy, <code>myMedia</code>, of MSL Media package.</li>
  <li>Updated XRG Media package to be compatible.</li>
  <li>Minor unit fixes.</li>
</ul>

</html>"));
end Version_1_0_0;

class Version_0_5_0 "Version 0.5.0 (November 10, 2022)"
extends Modelica.Icons.ReleaseNotes;

annotation (Documentation(info="<html>

<p>
Version 0.5.0 of the DLR Thermofluid Stream Library.
</p>

<ul>
  <li>First official release of the library.</li>
  <li>Compatible with MSL 3.2.3.</li>
</ul>

</html>"));
end Version_0_5_0;

annotation (Documentation(info="<html>

<p>
This section summarizes the changes that have been performed on the
DLR Thermofluid Stream Library. Versioning and release handling are described in
<a href=\"modelica://ThermofluidStream.UsersGuide.ReleaseNotes.VersionManagement\">ThermofluidStream.UsersGuide.ReleaseNotes.VersionManagement</a>.
</p>

<ul>
  <li>
    <a href=\"modelica://ThermofluidStream.UsersGuide.ReleaseNotes.Version_1_4_0\">Version 1.4.0</a>
    — August 2026
  </li>
  <li>
    <a href=\"modelica://ThermofluidStream.UsersGuide.ReleaseNotes.Version_1_3_0\">Version 1.3.0</a>
    — April 30, 2026
  </li>
  <li>
    <a href=\"modelica://ThermofluidStream.UsersGuide.ReleaseNotes.Version_1_2_0\">Version 1.2.0</a>
    — November 18, 2024
  </li>
  <li>
    <a href=\"modelica://ThermofluidStream.UsersGuide.ReleaseNotes.Version_1_1_0\">Version 1.1.0</a>
    — October 6, 2023
  </li>
  <li>
    <a href=\"modelica://ThermofluidStream.UsersGuide.ReleaseNotes.Version_1_0_0\">Version 1.0.0</a>
    — December 2, 2022
  </li>
  <li>
    <a href=\"modelica://ThermofluidStream.UsersGuide.ReleaseNotes.Version_0_5_0\">Version 0.5.0</a>
    — November 10, 2022
  </li>
</ul>

</html>", revisions="<html>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
  <tr>
    <td valign=\"middle\">
      <img width=\"72\" src=\"modelica://ThermofluidStream/Resources/dlr_logo.png\" alt=\"Logo DLR\">
    </td>
    <td valign=\"middle\">
      <strong>Copyright &copy; Deutsches Zentrum f&uuml;r Luft- und Raumfahrt e.V. (DLR)</strong>
    </td>
  </tr>
</table>
</html>"));
end ReleaseNotes;
