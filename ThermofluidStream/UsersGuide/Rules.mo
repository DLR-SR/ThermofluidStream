within ThermofluidStream.UsersGuide;
class Rules "Basic composition rules"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
First of all we recommend to study the example models provided in
<a href=\"modelica://ThermofluidStream.Examples\">Examples</a>.
</p>

<h4>For basic directional flows</h4>
<p>
The library is designed to avoid a favourable structure of the equation system so
that non-linear systems are confined to their components. In order to enable this
the modeller shall follow the following rules:
</p>
<ul>
  <li>
    Streams shall start at a source and end at a sink. Do not leave outlets unconnected.
    Volume elements may act as source and/or sink.
  </li>
  <li>
    Compose your topology using splitters and junctions from package
    <a href=\"modelica://ThermofluidStream.Topology\">Topology</a>. Splitting directly
    using the connector is only recommended for the use of sensors.
  </li>
  <li>
    Break cyclic loops by using volume elements. Each cyclic flow must be broken by at
    least one volume element. Mere bypasses are not cyclic flows and do not need to be
    torn apart.
  </li>
</ul>
<p>
That&apos;s it. Simply memorize these simple rules and check the structure of your
equation system to be sure.
</p>

<h4>Noteworthy comments</h4>
<ul>
  <li>
    Some classes implement asserts. Most of them represent checks that when not
    fulfilled result in a non-physical, but well behaved (numerically stable)
    simulation (e.g. reversed flow conditions for directed components), and some result
    in stopping of the simulation (e.g. zero/negative mass in a&nbsp;volume). While
    asserts for the latter always are done with AssertionLevel.error, the assertion
    level for the former can be set in the
    <a href=\"modelica://ThermofluidStream.DropOfCommons\">DropOfCommons</a> globally.
    So if the simulation stops because one of the former asserts is violated, insert
    a&nbsp;DropOfCommons model and set the assertionLevel to warning.
  </li>
  <li>
    Many models rely on mass-flow normalization for zero or small mass-flow.
    The normalization-mass-flow used in the components is set globally in the
    <a href=\"modelica://ThermofluidStream.DropOfCommons\">DropOfCommons</a>.
    Always make sure it is between one and two orders of magnitude smaller than the
    typical mass-flows of your system.
  </li>
</ul>

<h4>For undirected flows</h4>
<p>
There is a&nbsp;<a href=\"modelica://ThermofluidStream.Undirected\">special sub-package</a>
if the flow direction is unknown. Basically the rules
are the same but please be aware that without knowledge of the flow-direction, loops
are more likely to occur. Hence, only use these components when needed.
</p>
</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\"/>(c) 2020-2021, DLR, Institute of System Dynamics and Control</p>
</html>"));
end Rules;
