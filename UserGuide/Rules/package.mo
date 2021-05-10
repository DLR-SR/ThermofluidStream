within ThermofluidStream.UserGuide;
package Rules "Basic Composition Rules"
    extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p><b>First of all we recommend to study the Example models provided in the library.</b></p>
<p><a href=\"ThermofluidStream.Examples\">ThermofluidStream.Examples</a></p>
<p><b>For basic directional flows:</b></p>
<p>The library is designed to avoid a favourable structure of the equation system so that non-linear systems are confined to their components. In order to enable this the modeller shall follow the following rules:</p>
<ul>
<li>Streams shall start at a source and end at a sink. Do not leave outlets unconnected. Volume elements may act as source and/or sink.</li>
<li>Compose your topology using splitters and junctions. Splitting directly using the connector is only recommended for the use of sensors.</li>
<li>Break cyclic loops by using volume elements. Each cyclic flow must be broken by at least one volume element. Mere bypasses are not cyclic flows and do not need to be torn apart.</li>
</ul>
<p><br>That&apos;s it. Simply memorize these simple rules and check the structure of your equation system to be sure.</p>
<p><b>For undirected flows:</b></p>
<p>There is a special sub-package if the flow direction is unknown. Basically the rules are the same but please be aware that without knowledge of the flow-direction, loops are more likely to occur. Hence only use these componenents when needed.</p>
</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\"/>(c) 2020-2021, DLR, Institute of System Dynamics and Control</p>
</html>"));
end Rules;
