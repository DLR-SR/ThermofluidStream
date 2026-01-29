within ThermofluidStream.UsersGuide;
class ReleaseNotes "Release notes"
  extends Modelica.Icons.ReleaseNotes;

  annotation (
    Documentation(
      info="<html>
<p>
This section summarizes the changes that have been performed on the library.
</p>

<h4>Version 1.2.0 (2024-11-18)</h4>
<ul>
  <li>
    Velocity of sound can be measured with
    <a href=\"modelica://ThermofluidStream.Sensors.SingleSensorSelect\">SingleSensorSelect</a>
    and
    <a href=\"modelica://ThermofluidStream.Undirected.Sensors.SingleSensorSelect\">undirected SingleSensorSelect</a>.
  </li>
  <li>
    Added the ability to display class instance names and relevant parameters by a global parameter in <code>dropOfCommons</code>.
    The parameter can be overwritten on component level (layout tab) to only display the names of selected class instances and/or parameters.
  </li>
  <li>
    Improved compressible media assert and include <code>assertionLevel</code> from <code>dropOfCommons</code>.
  </li>
  <li>
    Added <a href=\"modelica://ThermofluidStream.Processes.Pipes\">pipes package</a> provided by HTWG Konstanz. The package consists of regulary straight pipes, bends, flow contraction and expansion as well as flow con- and diverging components.
  </li>
  <li>
    Add default values for valve parameters and asserts for check. 
  </li>
</ul>

<h4>Version 1.1.0 (2023-10-06)</h4>
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
  <li>
    Fix bug in
    <a href=\"modelica://ThermofluidStream.HeatExchangers.DiscretizedCrossFlowHEX\">cross-flow heat exchanger</a>:
    solution not converging for increasing number of discretization elements.
    <ul>
      <li>
        Scale reference mass-flow for heat transfer coefficient if stream
        is split into parallel streams.
      </li>
      <li>
        Introduce parameter <code>nCellsParallel</code> for general usage
        in all discretized heat exchangers.
      </li>
    </ul>
  </li>
  <li>
    Updated discretized and NTU heat exchangers to inherit from common base
    components.
    <ul>
      <li>
        Added summary record to NTU heat exchangers
      </li>
      <li>
        Changed direction of the <code>ThermalConductor</code> in the
        <a href=\"modelica://ThermofluidStream.HeatExchangers.DiscretizedCrossFlowHEX\">cross-flow heat exchanger</a>,
        <a href=\"modelica://ThermofluidStream.HeatExchangers.DiscretizedCrossFlowHEX_FR\">cross-flow heat exchanger with flow resistance</a> and <a href=\"modelica://ThermofluidStream.Undirected.HeatExchangers.DiscretizedCrossFlowHEX\">undirected cross-flow heat exchanger</a>.
        This causes heat flow from A to B to be positive, similar to the
        counter-flow heat exchangers.
      </li>
      <li>
        Corrected an error in the
        <a href=\"modelica://ThermofluidStream.Undirected.HeatExchangers.DiscretizedCounterFlowHEX\">undirected counter-flow heat exchanger</a>.
        Now <code>m_flow_A</code> and <code>m_flow_B</code> corresponds to
        the flow through channel A and B respectively, instead of the other
        way around.
      </li>
    </ul>
  </li>
  <li>
    Fix bug in
    <a href=\"modelica://ThermofluidStream.Boundaries.Internal.PartialVolumeM\">PartialVolumeM</a> and <a href=\"modelica://ThermofluidStream.Boundaries.Internal.PartialVolumeN\">PartialVolumeN</a>:
    <code>noEvent</code> operator now works on mass flow related if-statements.
  </li>
  <li>
    Fix wrong handling of conditional connectors:
    <ul>
      <li>
        remove input binding for conditional connectors and
      </li>
      <li>
        enable/disable conditional connectors which depend on <code>setEnthalpy</code>
        parameter.
      </li>
    </ul>
    This concerns:
    <ul>
      <li>
        Boundaries: 
        <a href=\"modelica://ThermofluidStream.Boundaries.CreateState\">CreateState</a>,
        <a href=\"modelica://ThermofluidStream.Boundaries.DynamicPressureInflow\">DynamicPressureInflow</a>,
        <a href=\"modelica://ThermofluidStream.Boundaries.DynamicPressureOutflow\">DynamicPressureOutflow</a>,
        <a href=\"modelica://ThermofluidStream.Boundaries.Sink\">Sink</a>,
        <a href=\"modelica://ThermofluidStream.Boundaries.Source\">Source</a>.
      </li>
      <li>
        FlowControl: 
        <a href=\"modelica://ThermofluidStream.FlowControl.MCV\">MCV</a>,
        <a href=\"modelica://ThermofluidStream.FlowControl.PCV\">PCV</a>.
      </li>
      <li>
        Undirected:
        <a href=\"modelica://ThermofluidStream.Undirected.Boundaries.BoundaryFore\">BoundaryFore</a>,
        <a href=\"modelica://ThermofluidStream.Undirected.Boundaries.BoundaryRear\">BoundaryRear</a>,
        <a href=\"modelica://ThermofluidStream.Undirected.FlowControl.MCV\">MCV</a>.
      </li>
    </ul>
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
