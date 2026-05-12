within ThermofluidStream.Idealized;
class UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

class AdiabaticThermodynamicModels
  extends Modelica.Icons.Information;
  annotation(
    Documentation(info="<html>
  <p>
    Various models from
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels\">Processes.Utilities.AdiabaticThermodynamicModels</a>
    can be used to calculate the isentropic reference process required for an adiabatic process with a given isentropic efficiency
    (<a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Processes.Adiabatic</a>
    and
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticCycle\">AdiabaticCycle</a>):
  </p>

  <ul>
    <li>
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium\">FullMedium</a> -
      entropy-based model with no thermodynamic simplifications. Computes <code>h_out_is = h(p_out, s_in)</code>.
    </li>
    <li>
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IdealGasConstantGamma\">IdealGasConstantGamma</a> -
      assumes ideal gas (<code>p*v = R*T</code>) with constant isentropic exponent <code>gamma</code>.
      Computes <code>h_out_is = h(p_out, T_out_is)</code>, where
      <code>T_out_is = T_in*(p_out/p_in)^((gamma-1)/gamma)</code>.
    </li>
    <li>
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas\">PerfectGas</a> - 
      assumes perfect gas (<code>p*v = R*T</code>, <code>cp = const</code>).
      Computes <code>h_out_is = h_in + cp*(T_out_is - T_in)</code>, where
      <code>T_out_is = T_in*(p_out/p_in)^((gamma-1)/gamma)</code>.
    </li>
    <li>
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IncompressibleFluid\">IncompressibleFluid</a> -
      assumes incompressible fluid (<code>rho = const</code>).
      Computes <code>h_out_is = dp/rho_in + h_in</code>.
    </li>
    <li>
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IsothermalReference\">IsothermalReference</a> - 
      assumes constant temperature (<code>T = const</code>) for the isentropic reference process, which is true for incompressible fluid. It then computes
      <code>h_out_is = h(p_out, T_in)</code>.
    </li>
  </ul>

  <p>
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> and
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticCycle\">AdiabaticCycle</a>
    differ in that the former model sets the outlet pressure <code>p_out</code>, while the latter sets the outlet density <code>rho_out</code>.
    For AdiabaticCycle, only FullMedium, IdealGasConstantGamma, and PerfectGas are appropriate,
    since adiabatic compression or expansion of an incompressible fluid is not physically reasonable.
  </p>

  <p>
    The most suitable adiabatic thermodynamic model depends on the chosen media model.
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.AdiabaticProcess\">Examples.AdiabaticProcess</a>
    compares the results for different media models.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end AdiabaticThermodynamicModels;

class BalancedModels
  extends Modelica.Icons.Information;
  annotation(
    Documentation(info="<html>
 <p>
    Some models are not balanced:
  </p>

  <ul>
    <li>
      Underdetermined by one equation:
      <a href=\"modelica://ThermofluidStream.Idealized.Sources.Sink_free\">Sink_free</a>,
      <a href=\"modelica://ThermofluidStream.Idealized.Sources.LoopBreaker\">LoopBreaker</a>,
      <a href=\"modelica://ThermofluidStream.Idealized.Topology.JunctionT1\">JunctionT1</a>
      and
      <a href=\"modelica://ThermofluidStream.Idealized.Topology.JunctionT2\">JunctionT2</a>.
    </li>

    <li>
      Overdetermined by one equation:
      <a href=\"modelica://ThermofluidStream.Idealized.Sources.MassFlowRate\">MassFlowRate</a>
      and
      <a href=\"modelica://ThermofluidStream.Idealized.Components.Separator\">Separator</a>.
    </li>
  </ul>
  <p>
    Processes such as <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> or
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isobaric\">Isobaric</a> can be either determined, overdetermined or underdetermined. 
    If the process model is underdetermined it cannot be balanced, which is indicated by a prominent red lightning symbol.
  </p>
  <p>
    Over- and underdetermination are indicated on icon layer by plus and minus.
  </p>
  <p>
    Combine under- and overdetermined models to obtain a balanced overall model, i.e. plus and minus have to cancel eachother out.
    See examples such as
  </p>

  <ul>
    <li><a href=\"modelica://ThermofluidStream.Idealized.Examples.JouleBrayton.Step3Staged\">Examples.JouleBrayton.Step3Staged</a>,</li>
    <li><a href=\"modelica://ThermofluidStream.Idealized.Examples.VaporCycle.Step4Separator\">Examples.VaporCycle.Step4Separator</a>,</li>
    <li><a href=\"modelica://ThermofluidStream.Idealized.Examples.AirCycle.Step7BootStrapCycle\">Examples.AirCycle.Step7BootStrapCycle</a> or</li> 
    <li><a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Adiabatic.Step7Compressor2\">Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Step7Compressor2</a>,</li>
  </ul>

  <p>
    as well as test models such as
  </p>
  
  <ul>
    <li><a href=\"modelica://ThermofluidStream.Idealized.Tests.Processes.Adiabatic.Compressor1\">Tests.Processes.Adiabatic.Compressor1</a> or</li>
    <li><a href=\"modelica://ThermofluidStream.Idealized.Tests.Sources.Sink_free\">Tests.Sources.Sink_free</a>.</li>
  </ul>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end BalancedModels;

class EnergyFlow
  extends Modelica.Icons.Information;
                                     annotation(
    Documentation(info="<html>
  <p>
    The energy flow connector is compatible with standard Modelica Real input and output connectors. 
    It was introduced to emphasize its physical meaning and to clearly differentiate power and heat flow from, for example, control signals.
  </p>
  <p>
    The input and output connectors define the direction of information flow and must not be confused with the
    physical positive direction of energy flow, which can be indicated next to the connector on the icon layer
    during simulation.<br>
    <code>EnergyFlowInput</code> is defined as energy flowing <strong>into</strong> the system.<br>
    <code>EnergyFlowOutput</code> is defined as energy flowing <strong>out</strong> of the system.<br>
    This definition allows inputs and outputs to be connected directly.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end EnergyFlow;

class InertanceNeglect
  extends Modelica.Icons.Information;
  annotation(
    Documentation(info="<html>
  <p>
    Inverse calculations are supported, for example, determining the mass flow rate
    from a specified temperature difference and heat flow.<br>

    Such inverse calculations may require removing the derivative of the mass flow
    rate <code>der(m_flow)</code>. This can be achieved by setting
    <code>considerInertance = false</code> for all affected models, e.g., via
    <code>dropOfCommons.considerInertance</code>. See
    <a href=\"modelica://ThermofluidStream.DropOfCommons\">DropOfCommons</a>.<br>

    Setting <code>considerInertance = false</code> is intended for advanced use only.<br>

    Examples using <code>considerInertance = false</code> are marked with a red
    <strong>L</strong>.<br>

    Components with <code>considerInertance = false</code> are highlighted by a red
    dot in the graphical layer.<br>

    Various approaches for inverse calculations are documented in the
    <a href=\"modelica://ThermofluidStream.Idealized.Tests.Inversion\">Inversion</a>
    package.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end InertanceNeglect;

class References "References"
  extends Modelica.Icons.References;

  annotation(Documentation(info="<html>
<p>
References for idealized processes.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
  <td>[TUM2019]</td>
    <td>T. Sattelmayer, J. Kaufmann, D. Heilbronn, M. Bruder,
    <em>Thermodynamik I Übungsaufgaben</em>,
      TU München, 2019.
    </td>
  </tr> 
 
</table>
</html>", revisions="<html>
<ul>
<li>
2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
end References;

  annotation(DocumentationClass=true, Documentation(info="<html>
<p>This package provides idealized state-change components, enabling the simulation of ideal thermodynamic processes such as isentropic, adiabatic, isenthalpic or isobaric state changes. It also allows users to prescribe mass flow rates and to combine components via ideal power flow connectors, facilitating heat exchange between components or the coupling of turbines and compressors. </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));

end UsersGuide;
