within ThermofluidStream.Media.myMedia;
package UsersGuide "User's Guide of Media Library"
  extends Modelica.Icons.Information;

  package MediumUsage "Medium usage"
    extends Modelica.Icons.Information;

    class BasicUsage "Basic usage"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<h4>Basic usage of medium model</h4>
<p>
Media models in Modelica.Media are provided by packages, inheriting from the
partial package Modelica.Media.Interfaces.PartialMedium. Every package defines:
</p>
<ul>
<li> Medium <strong>constants</strong> (such as the number of chemical substances,
     molecular data, critical properties, etc.).</li>
<li> A BaseProperties <strong>model</strong>, to compute the basic thermodynamic
     properties of the fluid;</li>
<li> <strong>setState_XXX</strong> functions to compute the thermodynamic state record from
     different input arguments (such as density, temperature, and composition which
     would be setState_dTX);</li>
<li> <strong>Functions</strong> to compute additional properties (such as saturation
     properties, viscosity, thermal conductivity, etc.).</li>
</ul>
<p>
There are - as stated above - two different basic ways of using the Media library which
will be described in more details in the following section. One way is to use the model BaseProperties.
Every instance of BaseProperties for any medium model provides <strong>3+nXi
equations</strong> for the following <strong>5+nXi variables</strong> that are declared in
the medium model (nXi is the number of independent mass fractions, see
explanation below):
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Variable</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>temperature</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>absolute pressure</td></tr>
  <tr><td>d</td>
      <td>kg/m3</td>
      <td>density</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy (h = u + p/d)</td></tr>
  <tr><td>Xi[nXi]</td>
      <td>kg/kg</td>
      <td>independent mass fractions m_i/m</td></tr>
  <tr><td>X[nX]</td>
      <td>kg/kg</td>
      <td>All mass fractions m_i/m. X is defined in BaseProperties by:<br>
          X = <strong>if</strong> reducedX <strong>then</strong> vector([Xi; 1-<strong>sum</strong>(Xi)])
          <strong>else</strong> Xi </td></tr>
</table>
<p>
<strong>Two</strong> variables out of p, d, h, or u, as well as the
<strong>mass fractions</strong> Xi are the <strong>independent</strong> variables and the
medium model basically provides equations to compute
the remaining variables, including the full mass fraction vector X
(more details to Xi and X are given further below).
</p>
<p>
In a component, the most basic usage of a medium model is as follows
</p>
<blockquote><pre>
<strong>model</strong> Pump
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium
                       \"Medium model\" <strong>annotation</strong> (choicesAllMatching = <strong>true</strong>);
  Medium.BaseProperties medium_a \"Medium properties at location a (e.g., port_a)\";
  // Use medium variables (medium_a.p, medium_a.T, medium_a.h, ...)
   ...
<strong>end</strong> Pump;
</pre></blockquote>
<p>
The second way is to use the setState_XXX functions to compute the thermodynamic state
record from which all other thermodynamic state variables can be computed (see
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.BasicDefinition\">
Basic definition of medium</a> for further details on ThermodynamicState). The setState_XXX functions
accept either X or Xi (see explanation below) and will decide internally which of these two compositions
is provided by the user. The four fundamental setState_XXX functions are provided in PartialMedium
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Function</strong></td>
      <td><strong>Description</strong></td>
      <td><strong>Short-form for<br>single component medium</strong></td></tr>
  <tr><td>setState_dTX</td>
      <td>computes ThermodynamicState from density, temperature, and composition X or Xi</td>
      <td>setState_dT</td></tr>
  <tr><td>setState_phX</td>
      <td>computes ThermodynamicState from pressure, specific enthalpy, and composition X or Xi</td>
      <td>setState_ph</td></tr>
  <tr><td>setState_psX</td>
      <td>computes ThermodynamicState from pressure, specific entropy, and composition X or Xi</td>
      <td>setState_ps</td></tr>
  <tr><td>setState_pTX</td>
      <td>computes ThermodynamicState from pressure, temperature, and composition X or Xi</td>
      <td>setState_pT</td></tr>
</table>
<p>
The simple example that explained the basic usage of BaseProperties would then become
</p>
<blockquote><pre>
<strong>model</strong> Pump
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium
                       \"Medium model\" <strong>annotation</strong> (choicesAllMatching = <strong>true</strong>);
  Medium.ThermodynamicState state_a \"Thermodynamic state record at location a (e.g., port_a)\";
  // Compute medium variables from thermodynamic state record (pressure(state_a), temperature(state_a),
  // specificEnthalpy(state_a), ...)
  ...
<strong>end</strong> Pump;
</pre></blockquote>
<p>
All media models are directly or indirectly a subpackage of package
Modelica.Media.Interfaces.PartialMedium. Therefore,
a medium model in a component should inherit from this
partial package. Via the annotation \"choicesAllMatching = true\" it
is defined that the tool should display a selection box with
all loaded packages that inherit from PartialMedium. An example
is given in the next figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/MediumUsage/mediumMenu.png\" alt=\"medium selection menu\">
</p>

<p>
A selected medium model leads, e.g., to the following equation:
</p>
<blockquote><pre>
Pump pump(<strong>redeclare package</strong> Medium = Modelica.Media.Water.SimpleLiquidWater);
</pre></blockquote>
<p>
Usually, a medium model is associated with the variables of a
fluid connector. Therefore, equations have to be defined in a model
that relate the variables in the connector with the variables
in the medium model:
</p>
<blockquote><pre>
<strong>model</strong> Pump
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium
                       \"Medium model\" <strong>annotation</strong> (choicesAllMatching = <strong>true</strong>);
  Medium.BaseProperties medium_a \"Medium properties of port_a\";
  // definition of the fluid port port_a
   ...
<strong>equation</strong>
  medium.p = port_a.p;
  medium.h = port_a.h;
  medium.Xi = port_a.Xi;
   ...
<strong>end</strong> Pump;
</pre></blockquote>
in the case of using BaseProperties or
<blockquote><pre>
<strong>model</strong> Pump
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium
                       \"Medium model\" <strong>annotation</strong> (choicesAllMatching = <strong>true</strong>);
  Medium.ThermodynamicState state_a \"Thermodynamic state record of medium at port_a\";
  // definition of the fluid port port_a
   ...
<strong>equation</strong>
  state_a = Medium.setState_phX(port_a.p, port_a.h, port_a.Xi) // if port_a contains the variables
                                                               // p, h, and Xi
   ...
<strong>end</strong> Pump;
</pre></blockquote>
<p>
in the case of using ThermodynamicState.
</p>
<p>
If a component model shall treat both single and multiple
substance fluids, equations for the mass fractions have to be
present (above: medium.Xi = port_a.Xi) in the model. According
to the Modelica semantics, the equations of the mass fractions
are ignored, if the dimension of Xi is zero, i.e., for a single-component
medium. Note, by specific techniques sketched in section
\"Medium definition\", the independent variables in the medium model
need not to be the same as the variables in the connector and still
get the same efficiency, as if the same variables would be used.
</p>

<p>
If a fluid consists of a single
substance, <strong>nXi = 0</strong> and the vector of mass fractions Xi is not
present. If a fluid consists of nS substances,
the medium model may define the number of independent
mass fractions <strong>nXi</strong> to be <strong>nS</strong>, <strong>nS-1</strong>, or zero.
In all cases, balance equations for nXi substances have to be
given in the corresponding component (see discussion below).
Note, that if nXi = nS, the constraint \"sum(Xi)=1\" between the mass
fractions is <strong>not</strong> present in the model; in that case, it is necessary to
provide consistent start values for Xi such that sum(Xi) = 1.
</p>

<p>
The reason for this definition of Xi is that a fluid component library
can be implemented by using only the independent mass fractions Xi and
then via the medium it is defined how Xi is interpreted:
</p>

<ul>
<li> If Xi = nS, then the constraint equation sum(X) = 1 is neglected
     during simulation. By making sure that the initial conditions of X
     fulfill this constraint, it can usually be guaranteed that small
     errors in sum(X) = 1 remain small although this constraint equation is
     not explicitly used during the simulation. This approach is usually useful
     if components of the mixture can become very small. If such a small
     quantity is computed via the equation 1 - sum(X[1:nX-1]), there might
     be large numerical errors and it is better to compute it via
     the corresponding balance equation.</li>
<li> If Xi = nS-1, then the true independent mass fractions are used
     in the fluid component and the last component of X is computed via
     X[nX] = 1 - sum(Xi). This is useful for, e.g., MoistAir, where the
     number of states should be as small as possible without introducing
     numerical problems.</li>
<li> If Xi = 0, then the reference value of composition reference_X is
     assumed. This case is useful to avoid composition states in all
     the cases when the composition will always be constant, e.g., with
     circuits having fixed composition sources.</li>
</ul>

<p>
The full vector of mass fractions <strong>X[nX]</strong> is computed in
PartialMedium.BaseProperties based on Xi, reference_X, and the information whether Xi = nS or nS-1. For single-substance media, nX = 0, so there's also no X vector. For multiple-substance media, nX = nS, and X always contains the full vector of mass fractions. In order to reduce confusion for the user of a fluid component library, \"Xi\" has the annotation \"HideResult=true\", meaning, that this variable is not shown in the plot window. Only X is shown in the plot window and this vector always contains all mass fractions.
</p>
</html>"));
    end BasicUsage;

    class BalanceVolume "Balance volume"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Fluid libraries usually have balance volume components with one fluid connector
port that fulfill the mass and energy balance and on a different grid components that
fulfill the momentum balance. A balance volume component, called junction
volume below, should be primarily implemented in the following way
(see also the implementation in
<a href=\"modelica://Modelica.Media.Examples.Utilities.PortVolume\">
Modelica.Media.Examples.Utilities.PortVolume</a>):
</p>
<blockquote><pre>
<strong>model</strong> JunctionVolume
  <strong>import</strong> Modelica.Units.SI;
  <strong>import</strong> Modelica.Media.Examples.Utilities.FluidPort_a;

  <strong>parameter</strong> SI.Volume V = 1e-6 \"Fixed size of junction volume\";
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium
                         \"Medium model\" <strong>annotation</strong> (choicesAllMatching = <strong>true</strong>);

  FluidPort_a port(<strong>redeclare package</strong> Medium = Medium);
  Medium.BaseProperties medium(preferredMediumStates = <strong>true</strong>);

  SI.Energy U              \"Internal energy of junction volume\";
  SI.Mass   M              \"Mass of junction volume\";
  SI.Mass   MX[Medium.nXi] \"Independent substance masses of junction volume\";
<strong>equation</strong>
  medium.p   = port.p;
  medium.h   = port.h;
  medium.Xi = port.Xi;

  M  = V*medium.d;                  // mass of JunctionVolume
  MX = M*medium.Xi;                 // mass fractions in JunctionVolume
  U  = M*medium.u;                  // internal energy in JunctionVolume

  <strong>der</strong>(M)  = port.m_flow;    // mass balance
  <strong>der</strong>(MX) = port.mX_flow;   // substance mass balance
  <strong>der</strong>(U)  = port.H_flow;    // energy balance
<strong>end</strong> JunctionVolume;
</pre></blockquote>
<p>
Assume the Modelica.Media.Air.SimpleAir medium model is used with
the JunctionVolume model above. This medium model uses pressure p
and temperature T as independent variables. If the flag
\"preferredMediumStates\" is set to <strong>true</strong> in the declaration
of \"medium\", then the independent variables of this medium model
get the attribute \"stateSelect = StateSelect.prefer\", i.e., the
Modelica translator should use these variables as states, if this
is possible. Basically, this means that
constraints between the
potential states p,T and the potential states U,M are present.
A Modelica tool will therefore <strong>automatically</strong>
differentiate medium equations and will use the following
equations for code generation (note the equations related to X are
removed, because SimpleAir consists of a single substance only):
</p>
<blockquote><pre>
M = V*medium.d;
U = M*medium.u;

// balance equations
<strong>der</strong>(M)  = port.m_flow;
<strong>der</strong>(U)  = port.H_flow;

// abbreviations introduced to get simpler terms
p = medium.p;
T = medium.T;
d = medium.d;
u = medium.u;
h = medium.h;

// medium equations
d = fd(p,T);
h = fh(p,T);
u = h - p/d;

// equations derived <strong>automatically</strong> by a Modelica tool due to index reduction
<strong>der</strong>(U) = <strong>der</strong>(M)*u + M*<strong>der</strong>(u);
<strong>der</strong>(M) = V*<strong>der</strong>(d);
<strong>der</strong>(u) = <strong>der</strong>(h) - <strong>der</strong>(p)/d - p/<strong>der</strong>(d);
<strong>der</strong>(d) = <strong>der</strong>(fd,p)*<strong>der</strong>(p) + <strong>der</strong>(fd,T)*<strong>der</strong>(T);
<strong>der</strong>(h) = <strong>der</strong>(fh,p)*<strong>der</strong>(p) + <strong>der</strong>(fd,T)*<strong>der</strong>(T);
</pre></blockquote>
<p>
Note, that \"der(y,x)\" is an operator that characterizes
in the example above the partial derivative of y with respect to x
(this operator will be included in one of the next Modelica language
releases).
All media models in this library are written in such a way that
at least the partial derivatives of the medium variables with
respect to the independent variables are provided, either because
the equations are directly given (= symbolic differentiation is possible)
or because the derivative of the corresponding function (such as fd above)
is provided. A Modelica tool will transform the equations above
in differential equations with p and T as states, i.e., will
generate equations to compute <strong>der</strong>(p) and <strong>der</strong>(T) as function of p and T.
</p>

<p>
Note, when preferredMediumStates = <strong>false</strong>, no differentiation
will take place and the Modelica translator will use the variables
appearing differentiated as states, i.e., M and U. This has the
disadvantage that for many media non-linear systems of equations are
present to compute the intrinsic properties p, d, T, u, h from
M and U.
</p>
</html>"));
    end BalanceVolume;

    class ShortPipe "Short pipe"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Fluid libraries have components with two ports that store
neither mass nor energy and fulfill the
momentum equation between their two ports, e.g., a short pipe. In most
cases this means that an equation is present relating the pressure
drop between the two ports and the mass flow rate from one to the
other port. Since no mass or energy is stored, no differential
equations for thermodynamic variables are present. A component model of this type
has therefore usually the following structure
(see also the implementation in
<a href=\"modelica://Modelica.Media.Examples.Utilities.ShortPipe\">
Modelica.Media.Examples.Utilities.ShortPipe</a>):
</p>
<blockquote><pre>
<strong>model</strong> ShortPipe
  <strong>import</strong> Modelica.Units.SI;
  <strong>import</strong> Modelica.Media.Examples.Utilities;

  // parameters defining the pressure drop equation

  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium
                         \"Medium model\" <strong>annotation</strong> (choicesAllMatching = <strong>true</strong>);

  Utilities.FluidPort_a port_a (<strong>redeclare package</strong> Medium = Medium);
  Utilities.FluidPort_b port_b (<strong>redeclare package</strong> Medium = Medium);

  SI.Pressure dp = port_a.p - port_b.p \"Pressure drop\";
  Medium.BaseProperties medium_a \"Medium properties in port_a\";
  Medium.BaseProperties medium_b \"Medium properties in port_b\";
<strong>equation</strong>
  // define media models of the ports
  medium_a.p  = port_a.p;
  medium_a.h  = port_a.h;
  medium_a.Xi = port_a.Xi;

  medium_b.p  = port_b.p;
  medium_b.h  = port_b.h;
  medium_b.Xi = port_b.Xi;

  // Handle reverse and zero flow (semiLinear is a built-in Modelica operator)
  port_a.H_flow   = <strong>semiLinear</strong>(port_a.m_flow, port_a.h, port_b.h);
  port_a.mXi_flow = <strong>semiLinear</strong>(port_a.m_flow, port_a.Xi, port_b.Xi);

  // Energy, mass and substance mass balance
  port_a.H_flow + port_b.H_flow = 0;
  port_a.m_flow + port_b.m_flow = 0;
  port_a.mXi_flow + port_b.mXi_flow = zeros(Medium.nXi);

  // Provide equation: port_a.m_flow = f(dp)
<strong>end</strong> ShortPipe;
</pre></blockquote>

<p>
The <strong>semiLinear</strong>(..) operator is basically defined as:
</p>
<blockquote><pre>
semiLinear(m_flow, ha, hb) = if m_flow &ge; 0 then m_flow*ha else m_flow*hb;
</pre></blockquote>

<p>
that is, it computes the enthalpy flow rate either from the port_a or
from the port_b properties, depending on flow direction. The exact
details of this operator are given in
<a href=\"modelica://ModelicaReference.Operators.'semiLinear()'\">
ModelicaReference.Operators.'semiLinear()'</a>. Especially, rules
are defined in the Modelica specification that m_flow = 0 can be treated
in a \"meaningful way\". Especially, if n fluid components (such as pipes)
are connected together and the fluid connector from above is used,
a linear system of equations appear between
medium1.h, medium2.h, medium3.h, ..., port1.h, port2.h, port3.h, ...,
port1.H_flow, port2.H_flow, port3.H_flow, .... The rules for the
semiLinear(..) operator allow the following solution of this
linear system of equations:
</p>

<ul>
<li> n = 2 (two components are connected):<br>
     The linear system of equations can be analytically solved
     with the result
     <blockquote><pre>
medium1.h = medium2.h = port1.h = port2.h
0 = port1.H_flow + port2.H_flow
     </pre></blockquote>
     Therefore, no problems with zero mass flow rate are present.</li>

<li> n &gt; 2 (more than two components are connected together):<br>
     The linear system of equations is solved numerically during simulation.
     For m_flow = 0, the linear system becomes singular and has an
     infinite number of solutions. The simulator could use the solution t
     that is closest to the solution in the previous time step
     (\"least squares solution\"). Physically, the solution is determined
     by diffusion which is usually neglected. If diffusion is included,
     the linear system is regular.</li>
</ul>

</html>"));
    end ShortPipe;

    class OptionalProperties "Optional properties"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the functions listed in the following table. They are
defined as partial functions within package
<a href=\"modelica://Modelica.Media.Interfaces.PartialMedium\">PartialMedium</a>,
and then (optionally) implemented in actual medium packages.
If a component calls such an optional function and the
medium package does not provide a new implementation for this
function, an error message is printed at translation time,
since the function is \"partial\", i.e., incomplete.
The argument of all functions is the <strong>state</strong> record,
automatically defined by the BaseProperties model or specifically computed using the
setState_XXX functions, which contains the
minimum number of thermodynamic variables needed to compute all the additional
properties. In the table it is assumed that there is a declaration of the
form:
</p>
<blockquote><pre>
<strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
Medium.ThermodynamicState state;
</pre></blockquote>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Function call</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>Medium.dynamicViscosity(state)</td>
      <td>Pa.s</td>
      <td>dynamic viscosity</td></tr>
  <tr><td>Medium.thermalConductivity(state)</td>
      <td>W/(m.K)</td>
      <td>thermal conductivity</td></tr>
  <tr><td>Medium.prandtlNumber(state)</td>
      <td>1</td>
      <td>Prandtl number</td></tr>
  <tr><td>Medium.specificEntropy(state)</td>
      <td>J/(kg.K)</td>
      <td>specific entropy</td></tr>
  <tr><td>Medium.specificHeatCapacityCp(state)</td>
      <td>J/(kg.K)</td>
      <td>specific heat capacity at constant pressure</td></tr>
  <tr><td>Medium.specificHeatCapacityCv(state)</td>
      <td>J/(kg.K)</td>
      <td>specific heat capacity at constant density</td></tr>
  <tr><td>Medium.isentropicExponent(state)</td>
      <td>1</td>
      <td>isentropic exponent</td></tr>
  <tr><td>Medium.isentropicEnthatlpy(pressure, state)</td>
      <td>J/kg</td>
      <td>isentropic enthalpy</td></tr>
  <tr><td>Medium.velocityOfSound(state)</td>
      <td>m/s</td>
      <td>velocity of sound</td></tr>
  <tr><td>Medium.isobaricExpansionCoefficient(state)</td>
      <td>1/K</td>
      <td>isobaric expansion coefficient</td></tr>
  <tr><td>Medium.isothermalCompressibility(state)</td>
      <td>1/Pa</td>
      <td>isothermal compressibility</td></tr>
  <tr><td>Medium.density_derp_h(state)</td>
      <td>kg/(m3.Pa)</td>
      <td>derivative of density by pressure at constant enthalpy</td></tr>
  <tr><td>Medium.density_derh_p(state)</td>
      <td>kg2/(m3.J)</td>
      <td>derivative of density by enthalpy at constant pressure</td></tr>
  <tr><td>Medium.density_derp_T(state)</td>
      <td>kg/(m3.Pa)</td>
      <td>derivative of density by pressure at constant temperature</td></tr>
  <tr><td>Medium.density_derT_p(state)</td>
      <td>kg/(m3.K)</td>
      <td>derivative of density by temperature at constant pressure</td></tr>
  <tr><td>Medium.density_derX(state)</td>
      <td>kg/m3</td>
      <td>derivative of density by mass fraction</td></tr>
  <tr><td>Medium.molarMass(state)</td>
      <td>kg/mol</td>
      <td>molar mass</td></tr>
</table>
<p>
There are also some short forms provided for user convenience that allow the computation of certain
thermodynamic state variables without using the ThermodynamicState record explicitly. Those short forms
are for example useful to compute consistent start values in the initial equation section. Let's
consider the function temperature_phX(p,h,X) as an example. This function computes the temperature
from pressure, specific enthalpy, and composition X (or Xi) and is a short form for writing
</p>
<blockquote><pre>
temperature(setState_phX(p,h,X))
</pre></blockquote>
<p>
The following functions are predefined in PartialMedium (other functions can be added in the actual
medium implementation package if they are useful)
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td>Medium.specificEnthalpy_pTX(p,T,X)</td>
      <td>J/kg</td>
      <td>Specific enthalpy at p, T, X </td></tr>
  <tr><td>Medium.temperature_phX(p,h,X)</td>
      <td>K</td>
      <td>Temperature at p, h, X</td></tr>
  <tr><td>Medium.density_phX(p,h,X)</td>
      <td>kg/m3</td>
      <td>Density at p, h, X</td></tr>
  <tr><td>Medium.temperature_psX(p,s,X)</td>
      <td>K</td>
      <td>Temperature at p, s, X</td></tr>
  <tr><td>Medium.specificEnthalpy_psX(p,s,X)</td>
      <td>J/(kg.K)</td>
      <td>Specific entropy at p, s, X</td></tr>
</table>
<p>
Assume for example that the dynamic viscosity eta is needed in
the pressure drop equation of a short pipe. Then, the
model of a short pipe has to be changed to:
</p>
<blockquote><pre>
<strong>model</strong> ShortPipe
    ...
  Medium.BaseProperties medium_a \"Medium properties in port_a\";
  Medium.BaseProperties medium_b \"Medium properties in port_b\";
    ...
  Medium.DynamicViscosity eta;
    ...
  eta = <strong>if</strong> port_a.m_flow &gt; 0 <strong>then</strong>
             Medium.dynamicViscosity(medium_a.state)
        <strong>else</strong>
             Medium.dynamicViscosity(medium_b.state);
  // use eta in the pressure drop equation: port_a.m_flow = f(dp, eta)
<strong>end</strong> ShortPipe;
</pre></blockquote>

<p>
Note, \"Medium.DynamicViscosity\" is a type defined in Modelica.Interfaces.PartialMedium
as
</p>

<blockquote><pre>
<strong>import</strong> Modelica.Units.SI;
<strong>type</strong> DynamicViscosity = SI.DynamicViscosity (
                                   min=0,
                                   max=1.e8,
                                   nominal=1.e-3,
                                   start=1.e-3);
</pre></blockquote>

<p>
Every medium model may modify the attributes, to provide, e.g.,
min, max, nominal, and start values adapted to the medium.
Also, other types, such as AbsolutePressure, Density, MassFlowRate,
etc. are defined in PartialMedium. Whenever possible, these medium
specific types should be used in a model in order that medium information,
e.g., about nominal or start values, are automatically utilized.
</p>
</html>"));
    end OptionalProperties;

    class Constants "Constants"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Every medium model provides the following <strong>constants</strong>. For example,
if a medium is declared as:
</p>
<blockquote><pre>
<strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
</pre></blockquote>
<p>
then constants \"Medium.mediumName\", \"Medium.nX\", etc. are defined:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Type</strong></td>
      <td><strong>Name</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>String</td><td>mediumName</td>
      <td>Unique name of the medium (is usually used to check whether
          the media in different components connected together
          are the same, by providing Medium.mediumName as quantity
          attribute of the mass flow rate in the connector)</td></tr>
  <tr><td>String</td><td>substanceNames[nS]</td>
      <td>Names of the substances that make up the medium.
          If only one substance is present, substanceNames = {mediumName}.</td></tr>
  <tr><td>String</td><td>extraPropertiesNames[nC]</td>
      <td>Names of the extra transported substances, outside of mass and
          energy balances.</td></tr>
  <tr><td>Boolean</td><td>singleState</td>
      <td>= <strong>true</strong>, if u and d are not a function of pressure, and thus only
          a function of a single thermal variable (temperature or enthalpy) and
          of Xi for a multiple substance medium. Usually, this flag is
          <strong>true</strong> for incompressible media. It is used in a model to determine
          whether 1+nXi (singleState=<strong>true</strong>) or 2+nXi (singleState=<strong>false</strong>)
          initial conditions have to be provided for a volume element that
          contains mass and energy balance.</td></tr>
  <tr><td>AbsolutePressure</td><td>reference_p</td>
      <td>Reference pressure for the medium</td></tr>
  <tr><td>MassFraction</td><td>reference_X[nX]</td>
      <td>Reference composition for the medium</td></tr>
  <tr><td>AbsolutePressure</td><td>p_default</td>
      <td>Default value for pressure of medium (for initialization)</td></tr>
  <tr><td>Temperature</td><td>T_default</td>
      <td>Default value for temperature of medium (for initialization)</td></tr>
  <tr><td>SpecificEnthalpy</td><td>h_default</td>
      <td>Default value for specific enthalpy of medium (for initialization)</td></tr>
  <tr><td>MassFraction</td><td>X_default[nX]</td>
      <td>Default value for mass fractions of medium (for initialization)</td></tr>
  <tr><td>Integer</td><td>nS</td>
      <td>number of substances contained in the medium.</td></tr>
  <tr><td>Integer</td><td>nX</td>
      <td>Size of the full mass fraction vector X nX=nS.</td></tr>
  <tr><td>Integer</td><td>nXi</td>
      <td>Number of independent mass fractions. If there is a single substance,
          then nXi = 0. </td></tr>
  <tr><td>Boolean</td><td>reducedX</td>
      <td>= <strong>true</strong>, if the medium has a single substance, or if the medium model
          has multiple substances and contains the equation sum(X) = 1.
          In both cases, nXi = nS - 1 (unless fixedX = true).<br>
          = <strong>false</strong>, if the medium has multiple substances and does not contain the
          equation sum(X)=1, i.e., nXi = nX = nS (unless fixedX = true).
       </td></tr>
  <tr><td>Boolean</td><td>fixedX</td>
      <td>= <strong>false</strong>: the composition of the medium can vary, and is
          determined by nXi independent mass fractions (see reducedX above).<br>
          = <strong>true</strong>: the composition of the medium is always reference_X,
          and nXi = 0.</td></tr>
  <tr><td>FluidConstants</td><td>fluidConstants[nS]</td>
      <td>Critical, triple, molecular and other
          standard data that are provided for
          every substance of a medium.</td></tr>
</table>

<p>
The record FluidConstants that is defined in PartialMedium contains the following elements
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Type</strong></td>
      <td><strong>Name</strong></td>
      <td><strong>Description</strong></td></tr>

  <tr><td>String</td>
      <td>iupacName</td>
      <td>complete IUPAC name</td></tr>

  <tr><td>String</td>
      <td>casRegistryNumber</td>
      <td>chemical abstracts sequencing number</td></tr>

  <tr><td>String</td>
      <td>chemicalFormula</td>
      <td>Chemical formula, (brutto, nomenclature according to Hill)</td></tr>

  <tr><td>String</td>
      <td>structureFormula</td>
      <td>Chemical structure formula</td></tr>

  <tr><td>MolarMass</td>
      <td>molarMass</td>
      <td>molar mass</td></tr>
</table>

<p> This record is extended in the partial packages further down the hierarchy (such as
PartialTwoPhaseMedium or PartialMixtureMedium) and may contain some or all of the following
elements</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td>Temperature</td>
      <td>criticalTemperature</td>
      <td>critical temperature</td></tr>

  <tr><td>AbsolutePressure</td>
      <td>criticalPressure</td>
      <td>critical pressure</td></tr>

  <tr><td>MolarVolume</td>
      <td>criticalMolarVolume</td>
      <td>critical molar Volume</td></tr>

  <tr><td>Real</td>
      <td>acentricFactor</td>
      <td>Pitzer acentric factor</td></tr>

  <tr><td>Temperature</td>
      <td>triplePointTemperature</td>
      <td>triple point temperature</td></tr>

  <tr><td>AbsolutePressure</td>
      <td>triplePointPressure</td>
      <td>triple point pressure</td></tr>

  <tr><td>Temperature</td>
      <td>meltingPoint</td>
      <td>melting point at 101325 Pa</td></tr>

  <tr><td>Temperature</td>
      <td>normalBoilingPoint</td>
      <td>normal boiling point (at 101325 Pa)</td></tr>

  <tr><td>DipoleMoment</td>
      <td>dipoleMoment</td>
      <td>dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)</td></tr>

  <tr><td>Boolean</td>
      <td>hasIdealGasHeatCapacity</td>
      <td>true if ideal gas heat capacity is available</td></tr>

  <tr><td>Boolean</td>
      <td>hasCriticalData</td>
      <td>true if critical data are known</td></tr>

  <tr><td>Boolean</td>
      <td>hasDipoleMoment</td>
      <td>true if a dipole moment known</td></tr>

  <tr><td>Boolean</td>
      <td>hasFundamentalEquation</td>
      <td>true if a fundamental equation</td></tr>

  <tr><td>Boolean</td>
      <td>hasLiquidHeatCapacity</td>
      <td>true if liquid heat capacity is available</td></tr>

  <tr><td>Boolean</td>
      <td>hasSolidHeatCapacity</td>
      <td>true if solid heat capacity is available</td></tr>

  <tr><td>Boolean</td>
      <td>hasAccurateViscosityData</td>
      <td>true if accurate data for a viscosity function is available</td></tr>

  <tr><td>Boolean</td>
      <td>hasAccurateConductivityData</td>
      <td>true if accurate data for thermal conductivity is available</td></tr>

  <tr><td>Boolean</td>
      <td>hasVapourPressureCurve</td>
      <td>true if vapour pressure data, e.g., Antoine coefficients are known</td></tr>

  <tr><td>Boolean</td>
      <td>hasAcentricFactor</td>
      <td>true if Pitzer acentric factor is known</td></tr>

  <tr><td>SpecificEnthalpy</td>
      <td>HCRIT0</td>
      <td>Critical specific enthalpy of the fundamental equation</td></tr>

  <tr><td>SpecificEntropy</td>
      <td>SCRIT0</td>
      <td>Critical specific entropy of the fundamental equation</td></tr>

  <tr><td>SpecificEnthalpy</td>
      <td>deltah</td>
      <td>Difference between specific enthalpy model
          (h_m) and f.eq. (h_f) (h_m - h_f)</td></tr>

  <tr><td>SpecificEntropy</td>
      <td>deltas</td>
      <td>Difference between specific enthalpy model (s_m) and f.eq.
          (s_f) (s_m - s_f)</td></tr>

</table>

</html>"));
    end Constants;

    class TwoPhase "Two-phase media"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Models for media which can exist in one-phase or two-phase conditions inherit
from <a href=\"modelica://Modelica.Media.Interfaces.PartialTwoPhaseMedium\">
Modelica.Media.Interfaces.PartialTwoPhaseMedium</a>
(which inherits from PartialMedium). The basic usage of these
media models is the same as described in the previous sections. However, additional
functionalities are provided, which apply only to potentially two-phase media.
</p>
<p>
The following additional medium <strong>constants</strong> are provided:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Type</strong></td>
      <td><strong>Name</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>Boolean</td>
      <td>smoothModel</td>
      <td>If this flag is false (default value), then events are triggered
          whenever the saturation boundary is crossed; otherwise, no events
      are generated.</td></tr>
  <tr><td>Boolean</td>
      <td>onePhase</td>
      <td>If this flag is true, then the medium model assumes it will be never
          called in the two-phase region. This can be useful to speed up
      the computations in a two-phase medium, when the user is sure it will
      always work in the one-phase region. Default value: false.</td></tr>
</table>
<p>
The setState_ph(), setState_ps(), setState_dT() and setState_pT() functions have
one extra input, named <em>phase</em>. If the phase input is not specified, or if
it is given a value of zero, then the setState function will determine the phase,
based on the other input values. An input phase = 1 will force the setState
function to return a state vector corresponding to a one-phase state, while
phase = 2 will force the setState value to return a state vector corresponding
to a two-phase state, as shown in the following example;
</p>
<blockquote><pre>
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  Medium.ThermodynamicState state, state1, state2;
<strong>equation</strong>
  // Set the state, given the pressure and the specific enthalpy
  // the phase is determined by the (p, h) values, and can be retrieved
  // from the state record
  state = Medium.setState_ph(p, h);
  phase = state1.phase;

  // Force the computation of the state with one-phase
  // equations of state, irrespective of the (p, h) values
  state1 = Medium.setState_ph(p, h, 1);

  // Force the computation of the state with 2-phase
  // equations of state, irrespective of the (p, h) values
  state2 = Medium.setState_ph(p, h, 2);
</pre></blockquote>
<p>
This feature can be used for the following purposes:
</p>
<ul>
<li> saving computational time, if one knows in advance the phase of the medium;</li>
<li> unambiguously determine the phase, when the two inputs correspond to a point on the saturation boundary (the derivative functions have substantially different values on either side);</li>
<li> get the properties of metastable states, like superheated water or subcooled vapour.</li>
</ul>
<p>
Many additional optional functions are defined to compute properties of
saturated media, either liquid (bubble point) or vapour (dew point).
The argument to such functions is a SaturationProperties record, which can be
set starting from either the saturation pressure or the saturation temperature,
as shown in the following example.
</p>
<blockquote><pre>
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  Medium.SaturationProperties sat_p;
  Medium.SaturationProperties sat_T;
<strong>equation</strong>
  // Set sat_p to saturation properties at pressure p
  sat_p = Medium.setSat_p(p);

  // Compute saturation properties at pressure p
  saturationTemperature_p = Medium.saturationTemperature_sat(sat_p);
  bubble_density_p =        Medium.bubbleDensity(sat_p);
  dew_enthalpy_p   =        Medium.dewEnthalpy(sat_p);

  // Set sat_T to saturation properties at temperature T
  sat_T = Medium.setSat_T(T);

  // Compute saturation properties at temperature T
  saturationTemperature_T = Medium.saturationPressure_sat(sat_T);
  bubble_density_T =        Medium.bubbleDensity(sat_T);
  dew_enthalpy_T =          Medium.dewEnthalpy(sat_T);
</pre></blockquote>
<p>With reference to a model defining a pressure p, a temperature T, and a
SaturationProperties record sat, the following functions are provided:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Function call</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>Medium.saturationPressure(T)</td>
      <td>Pa</td>
      <td>Saturation pressure at temperature T</td></tr>
  <tr><td>Medium.saturationTemperature(p)</td>
      <td>K</td>
      <td>Saturation temperature at pressure p</td></tr>
  <tr><td>Medium.saturationTemperature_derp(p)</td>
      <td>K/Pa</td>
      <td>Derivative of saturation temperature with respect to pressure</td></tr>
  <tr><td>Medium.saturationTemperature_sat(sat)</td>
      <td>K</td>
      <td>Saturation temperature</td></tr>
  <tr><td>Medium.saturationPressure_sat(sat)</td>
      <td>Pa</td>
      <td>Saturation pressure</td></tr>
  <tr><td>Medium.bubbleEnthalpy(sat)</td>
      <td>J/kg</td>
      <td>Specific enthalpy at bubble point</td></tr>
  <tr><td>Medium.dewEnthalpy(sat)</td>
      <td>J/kg</td>
      <td>Specific enthalpy at dew point</td></tr>
  <tr><td>Medium.bubbleEntropy(sat)</td>
      <td>J/(kg.K)</td>
      <td>Specific entropy at bubble point</td></tr>
  <tr><td>Medium.dewEntropy(sat)</td>
      <td>J/(kg.K)</td>
      <td>Specific entropy at dew point</td></tr>
  <tr><td>Medium.bubbleDensity(sat)</td>
      <td>kg/m3</td>
      <td>Density at bubble point</td></tr>
  <tr><td>Medium.dewDensity(sat)</td>
      <td>kg/m3</td>
      <td>Density at dew point</td></tr>
  <tr><td>Medium.saturationTemperature_derp_sat(sat)</td>
      <td>K/Pa</td>
      <td>Derivative of saturation temperature with respect to pressure</td></tr>
  <tr><td>Medium.dBubbleDensity_dPressure(sat)</td>
      <td>kg/(m3.Pa)</td>
      <td>Derivative of density at bubble point with respect to pressure</td></tr>
  <tr><td>Medium.dDewDensity_dPressure(sat)</td>
      <td>kg/(m3.Pa)</td>
      <td>Derivative of density at dew point with respect to pressure</td></tr>
  <tr><td>Medium.dBubbleEnthalpy_dPressure(sat)</td>
      <td>J/(kg.Pa)</td>
      <td>Derivative of specific enthalpy at bubble point with respect to pressure</td></tr>
  <tr><td>Medium.dDewEnthalpy_dPressure(sat)</td>
      <td>J/(kg.Pa)</td>
      <td>Derivative of specific enthalpy at dew point with respect to pressure</td></tr>
  <tr><td>Medium.surfaceTension(sat)</td>
      <td>N/m</td>
      <td>Surface tension between liquid and vapour phase</td></tr>
</table>
<p>
Sometimes it can be necessary to compute fluid properties in the thermodynamic
plane, just inside or outside the saturation dome. In this case, it is possible
to obtain an instance of a ThermodynamicState state vector, and then use it
to call the additional functions already defined for one-phase media.
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Function call</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>Medium.setBubbleState(sat, phase)</td>
      <td>Obtain the thermodynamic state vector
          corresponding to the bubble point. If phase==1 (default), the state is
      on the one-phase side; if phase==2, the state is on the two-phase
      side </td></tr>
  <tr><td>Medium.setDewState(sat, phase)</td>
      <td>Obtain the thermodynamic state vector
          corresponding to the dew point. If phase==1 (default), the state is
      on the one-phase side; if phase==2, the state is on the two-phase
      side </td></tr>
  </table>
<p>
Here are some examples:
</p>
<blockquote><pre>
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  Medium.SaturationProperties sat;
  Medium.ThermodynamicState   dew_1;    // dew point, one-phase side
  Medium.ThermodynamicState   bubble_2; // bubble point, two phase side
<strong>equation</strong>
  // Set sat to saturation properties at pressure p
  sat = setSat_p(p);

  // Compute dew point properties, (default) one-phase side
  dew_1 = setDewState(sat);
  cpDew = Medium.specificHeatCapacityCp(dew_1);
  drho_dp_h_1 = Medium.density_derp_h(dew_1);

  // Compute bubble point properties, two-phase side
  bubble_2    = setBubbleState(sat, 2);
  drho_dp_h_2 = Medium.density_derp_h(bubble_2);
</pre></blockquote>
</html>"));
    end TwoPhase;

    class Initialization "Initialization"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>

<p>
When a medium model is used in a balance volume, differential
equations for the independent medium variables are present and
therefore initial conditions have to be provided.
The following possibilities exist:
</p>

<h4>Steady state initialization</h4>
<p>
Modelica has currently no language element to define
steady state initialization. In the Modelica simulation
environment Dymola, the option
</p>
<blockquote><pre>
Advanced.DefaultSteadyStateInitialization = <strong>true</strong>
</pre></blockquote>
<p>
can be set before translation. Then, missing initial
conditions are provided by automatically setting appropriate
state derivatives to zero.
</p>

<h4>Explicit start values or initial equations</h4>
<p>
Explicit start values can be defined with the \"start\" and
\"fixed\" attributes. The number of independent variables nx
need to be known which can be deduced from the medium
constants (nx = nXi + <strong>if</strong> singleState <strong>then</strong> 1 <strong>else</strong> 2).
Then, start values or initial equations can be defined
for nx variables (= p, T, d, u, h, Xi) from Medium.BaseProperties,
e.g., in the form:
</p>
<blockquote><pre>
   <strong>replaceable</strong> package Medium = Medium.Interfaces.PartialMedium;
   Medium.BaseProperties medium1 (p(start=1e5, fixed=<strong>not</strong> Medium.singleState),
                                  T(start=300, fixed=<strong>true</strong>));
   Medium.BaseProperties medium2;
<strong>initial equation</strong>
   <strong>if not</strong> Medium.singleState <strong>then</strong>
      medium2.p = 1e5;
   <strong>end if</strong>;
   medium2.T = 300;
<strong>equation</strong>
</pre></blockquote>
<p>
If initial conditions are not provided for the independent
medium variables, non-linear systems of equations may
occur to compute the initial values of the independent
medium variables from the provided initial conditions.
</p>

<h4>Guess values</h4>
<p>
If non-linear systems of equations occur during initialization,
e.g., in case of steady state initialization, guess values
for the iteration variables of the non-linear system of equations
have to be provided via the \"start\" attribute (and fixed=false).
Unfortunately, it is usually not known in
advance which variables are selected as iteration variables of
a non-linear system of equations. One of the following possibilities
exist:
</p>
<ul>
<li> Do not supply start values and hope that the medium specific
     types have meaningful start values, such as in \"Medium.AbsolutePressure\"
     </li>
<li> Supply start values on all variables of the BaseProperties model,
     i.e., on p, T, d, u, h, Xi.</li>
<li> Determine the iteration variables of the non-linear systems of
     equations and provide start values for these variables.
     In the Modelica simulation environment Dymola, the iteration
     variables can be determined by setting the command
     <code>Advanced.OutputModelicaCode = <strong>true</strong></code>
     and by inspection of the file \"dsmodel.mof\" that is generated
     when this option is set (search for \"nonlinear\").</li>
</ul>
</html>"));
    end Initialization;

    annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Content:
</p>
<ol>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.BasicUsage\">Basic usage of medium model</a></li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.BalanceVolume\">Medium model for a balance volume</a></li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.ShortPipe\">Medium model for a pressure loss</a></li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">Optional medium properties</a></li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.Constants\">Constants provided by medium model</a></li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">Two-phase media</a></li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.Initialization\">Initialization</a></li>
</ol>

<p>
A good demonstration how to use the media from Modelica.Media is
given in package ModelicaTest.Media.TestsWithFluid. Under
<a href=\"modelica://Modelica.Media.Examples.Utilities\">
Modelica.Media.Examples.Utilities</a> the most basic components of a Fluid library
are defined. Additional media models with some very simple piping networks can be found in the
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/tree/master/ModelicaTest\">ModelicaTest library</a> under
<code>ModelicaTest.Media.TestsWithFluid.MediaTestModels</code>.
</p>

</html>"));
  end MediumUsage;

  package MediumDefinition "Medium definition"
    extends Modelica.Icons.Information;

    class BasicStructure "Basic structure"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
A medium model of Modelica.Media is essentially a <strong>package</strong>
that contains the following definitions:
</p>
<ul>
<li>
Definition of <strong>constants</strong>, such as the medium name.</li>
<li>
A <strong>model</strong> in the package that contains the 3 basic
thermodynamic equations that relate the 5+nXi primary medium variables.</li>
<li><strong>Optional functions</strong> to compute medium properties that are
only needed in certain circumstances, such as dynamic viscosity. These optional
functions need not be provided by every medium model.</li>
<li>
<strong>Type</strong> definitions, which are adapted to the particular
medium. For example, a type <strong>Temperature</strong> is defined where the attributes
<strong>min</strong>
and <strong>max</strong> define the validity region of the medium, and a suitable default
start value is given. In a device model, it is advisable to use these type
definitions, e.g., for parameters, in order that medium limits are checked as
early as possible, and that iteration variables of non-linear
systems of equations get reasonable start values.</li>
</ul>
<p>
Note, although we use the term <strong>medium model</strong>, it
is actually a Modelica <strong>package</strong> that contains all the constants and
definitions required for a complete <strong>medium model</strong>. The basic interface to a
medium is defined by Modelica.Media.Interfaces.PartialMedium that has the
following structure:</p>
<blockquote><pre>
<strong>partial package</strong> PartialMedium
  <strong>import</strong> Modelica.Units.SI;
  <strong>constant</strong> String           mediumName = \"\";
  <strong>constant</strong> String           substanceNames[:] = {mediumName};
  <strong>constant</strong> String           extraPropertiesNames[:] = fill(\"\",0);
  <strong>constant</strong> Boolean          singleState = <strong>false</strong>;
  <strong>constant</strong> Boolean          reducedX = <strong>true</strong>;
  <strong>constant</strong> Boolean          fixedX = <strong>false</strong>;
  <strong>constant</strong> AbsolutePressure reference_p = 101325;
  <strong>constant</strong> MassFraction     reference_X[nX]=fill(1/nX,nX);
  <strong>constant</strong> AbsolutePressure p_default = 101325;
  <strong>constant</strong> Temperature      T_default = Modelica.Units.Conversions.from_degC(20);
  <strong>constant</strong> SpecificEnthalpy h_default =
                            specificEnthalpy_pTX(p_default, T_default, X_default);
  <strong>constant</strong> MassFraction     X_default[nX]=reference_X;
  <strong>final constant</strong> Integer    nS  = size(substanceNames,1);
  <strong>final constant</strong> Integer    nX  = nS;
  <strong>final constant</strong> Integer    nXi = <strong>if</strong> fixedX <strong>then</strong> 0
                                  <strong>else if</strong> reducedX <strong>or</strong> nS == 1
                                  <strong>then</strong> nS-1 <strong>else</strong> nS;
  <strong>final constant</strong> Integer    nC  = size(extraPropertiesNames,1);
  <strong>constant</strong> FluidConstants[nS] fluidConstants;

  <strong>replaceable record</strong> BasePropertiesRecord
    AbsolutePressure p;
    Density d;
    Temperature T;
    SpecificEnthalpy h;
    SpecificInternalEnergy u;
    MassFraction[nX] X;
    MassFraction[nXi] Xi;
    SpecificHeatCapacity R_s;
    MolarMass MM;
  <strong>end</strong> BasePropertiesRecord;

  <strong>replaceable partial model</strong> BaseProperties
    <strong>extends</strong> BasePropertiesRecord;
    ThermodynamicState state;
    <strong>parameter</strong> Boolean preferredMediumStates=false;
    Modelica.Units.NonSI.Temperature_degC T_degC =
       Modelica.Units.Conversions.to_degC(T)
    Modelica.Units.NonSI.Pressure_bar p_bar =
       Modelica.Units.Conversions.to_bar(p)
  <strong>equation</strong>
    Xi = X[1:nXi];
    <strong>if</strong> nX > 1 <strong>then</strong>
       <strong>if</strong> fixedX <strong>then</strong>
          X = reference_X;
       <strong>elseif</strong> reducedX <strong>then</strong>
          X[nX] = 1 - sum(Xi);
       <strong>end if</strong>;
    <strong>end if</strong>;
    // equations such as
    //    d = d(p,T);
    //    u = u(p,T);
    //    h = u + p/d;
    //    state.p = p;
    //    state.T = T;
    // will go here in actual media implementations, but are not present
    // in the base class since the ThermodynamicState record is still empty
   <strong>end</strong> BaseProperties

  <strong>replaceable record</strong> ThermodynamicState
     // there are no \"standard\" thermodynamic variables in the base class
     // but they will be defined here in actual media extending PartialMedium
     // Example:
     //    AbsolutePressure p \"Absolute pressure of medium\";
     //    Temperature      T \"Temperature of medium\";
  <strong>end</strong> ThermodynamicState;

  // optional medium properties
  <strong>replaceable partial function</strong> dynamicViscosity
    <strong>input</strong>  ThermodynamicState state;
    <strong>output</strong> DynamicViscosity eta;
  <strong>end</strong> dynamicViscosity;

  // other optional functions

  // medium specific types
  <strong>type</strong> AbsolutePressure = SI.AbsolutePressure (
                               min     = 0,
                               max     = 1.e8,
                               nominal = 1.e5,
                               start   = 1.e5);
  <strong>type</strong> DynamicViscosity = ...;
  // other type definitions
<strong>end</strong> PartialMedium;
</pre></blockquote>
<p>
We will discuss all parts of this package in the
following paragraphs. An actual medium model should extend from PartialMedium
and has to provide implementations of the various parts.
</p>

<p>
Some of the constants at the beginning of the package do not have a value yet
(this is valid in Modelica), but a value has to be provided when extending from
package PartialMedium. A given value can be modified until the model is
translated or the <strong>final</strong> prefix is set.
The reason to use constants instead of parameters in the model BaseProperties
is that some of these constants are used in a context where parameters
are not allowed. For example, in connector definitions the
number of independent mass fractions nXi is used as dimension
of a vector Xi. When defining the
connector, only <em>constants</em> in packages can be accessed, but not
<em>parameters</em> in a model, because a connector cannot contain an instance
of BaseProperties.
</p>

<p>The record BasePropertiesRecord contains the variables
primarily used in balance equations. Three equations for these variables have
to be provided by every medium in model BaseProperties, plus two equations
for the gas constant and the molar mass.
</p>

<p>Optional medium properties are defined by functions, such as the function
dynamicViscosity (see code Section above) to compute the dynamic viscosity.
The argument of those functions is the ThermodynamicState record, defined
in BaseProperties, which contains the minimum number of thermodynamic variables
needed as an input to compute all the optional properties.
This construction simplifies the usage
considerably as demonstrated in the following code fragment:
</p>

<blockquote><pre>
<strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
Medium.BaseProperties   medium;
Medium.DynamicViscosity eta;
...
U   = m*medium.u; //Internal energy
eta = Medium.dynamicViscosity(medium.state);
</pre></blockquote>

<p>Medium is the medium package that satisfies the
requirements of a PartialMedium (when using the model above, a value for
Medium has to be provided by a redeclaration). The medium component is an
instance of the model Medium.BaseProperties and contains the core medium
equations. Variables in this model can be accessed just by dot-notation, such
as medium.u or medium.T. If an optional medium variable has to be computed, the
corresponding function from the actual Medium package is called, such as
Medium.dynamicViscosity. The medium.state vector can be given as input argument
to this function, and its fields are kept consistent to those of BaseProperties
by suitable equations, contained in BaseProperties itself (see above).
</p>

<p>If a medium model does not provide implementations of all
optional functions and one of these functions is called in a model, an error
occurs during translation since the optional functions which have not been
redeclared have the <em>partial</em> attribute. For example, if function
dynamicViscosity is not provided in the medium model when it is used, only
simple pressure drop loss models without a reference to the viscosity can be
used and not the sophisticated ones.
</p>

<p>At the bottom of the PartialMedium package type declarations
are present, that are used in all other parts of the PartialMedium package and
that should be used in all models and connectors where a medium model is
accessed. The reason is that minimum, maximum, nominal, and start
values are defined and these values can be adapted to the particular medium at
hand. For example, the nominal value of AbsolutePressure is 10<sup>5</sup>
Pa. If a simple model of water steam is used that is only valid above 100 &deg;C,
then the minimum value in the Temperature type should be set to this value. The
minimum and maximum values are also important for parameters in order to get an
early message if data outside of the validity region is given. The nominal
attribute is important as a scaling value if the variable is used as a state in
a differential equation or as an iteration variable in a non-linear system of
equations. The start attribute can be very useful to provide a meaningful
default start or guess value if the variable is used, e.g., as iteration
variable in a non-linear system of equations. Note, that all these attributes
can be set specifically for a medium in the following way:
</p>

<blockquote><pre>
<strong>package</strong> MyMedium
  <strong>extends</strong> Modelica.Media.Interfaces.PartialMedium(
     ...
     Temperature(min=373));
<strong>end</strong> MyMedium;
</pre></blockquote>

<p>
The type PartialMedium.MassFlowRate is defined as
</p>

<blockquote><pre>
<strong>type</strong> MassFlowRate = SI.MassFlowRate
     (quantity = \"MassFlowRate.\" + mediumName);
</pre></blockquote>

<p>Note that the constant mediumName, that has to be
defined in every medium model, is used in the quantity attribute. For example,
if mediumName = SimpleLiquidWater, then the quantity attribute has the value
MassFlowRate.SimpleLiquidWater. This type should be used in a connector
definition of a fluid library:
</p>

<blockquote><pre>
<strong>connector</strong> FluidPort
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
  <strong>flow</strong> Medium.MassFlowRate m_flow;
  ...
<strong>end</strong> FluidPort;
</pre></blockquote>

<p>In the model where this connector is used, the actual
Medium has to be defined. Connectors can only be connected together, if the
corresponding attributes are either not defined or have identical values. Since
mediumName is part of the quantity attribute of MassFlowRate, it is not
possible to connect connectors with different media models together.</p>
</html>"));
    end BasicStructure;

    class BasicDefinition "Basic definition"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Let's now walk through the definition of a new medium model. Please refer to
<a href=\"modelica://Modelica.Media.Interfaces.TemplateMedium\">
Modelica.Media.Interfaces.TemplateMedium</a> to obtain a template of the new
medium model code. For the moment being, consider a single-substance medium
model.
</p>
<p>
The new medium model is obtained by extending Modelica.Media.Interfaces.PartialMedium, and
setting the following package constants:
</p>
<ul>
<li>mediumName is a String containing the name of the medium.</li>
<li>substanceNames is a vector of strings containing the names of the substances
    that make up the medium. In this case, it will contain only mediumName.</li>
<li>singleState can be set to true if u and d in BaseProperties do not depend
    on pressure. In other words, density does not depend on pressure
    (incompressible fluid), and it is assumed that also u does not depend on
    pressure. This setting can be useful for fluids having high density and
    low compressibility (e.g., liquids at moderate pressure); fast states
    resulting from the low compressibility effects are automatically avoided.</li>
<li>reducedX = true for single-substance media, which do not need mass
    fractions at all.</li>
</ul>
<p>
It is also possible to change the default min, max, nominal, and start
attributes of Medium-defined types (see TemplateMedium).</p>
<p>
All other package constants, such as nX, nXi, nS, are automatically set
by the declarations of the base package Interfaces.PartialMedium.</p>
<p>
The second step is to provide an implementation to the BaseProperties model,
partially defined in the base class Interfaces.PartialMedium. In the case of
single-substance media, two independent state variables must be selected among
p, T, d, u, h, and three equations must be written to provide the values of
the remaining variables. Two equations must then be added to compute the molar
mass MM and the gas constant R_s.</p>
<p>
The third step is to consider the optional functions that are going to be
implemented, among the partial functions defined by the base class PartialMedium.
A minimal set of state variables that could be provided as an input to
<em>all</em> those functions must be selected, and included in the redeclaration
of the ThermodynamicState record. Subsequently, equations must be added to
BaseProperties in order that the instance of that record inside BaseProperties
(named \"state\") is kept updated. For example, assume that all additional
properties can be computed as a function of p and T. Then, ThermodynamicState
should be redeclared as follows:</p>
<blockquote><pre>
<strong>redeclare replaceable record</strong> ThermodynamicState
  AbsolutePressure p \"Absolute pressure of medium\";
  Temperature T \"Temperature of medium\";
<strong>end</strong> ThermodynamicState;
</pre></blockquote>
<p>
and the following equations should be added to BaseProperties:
</p>
<blockquote><pre>
state.p = p;
state.T = T;
</pre></blockquote>
<p>
The additional functions can now be implemented by redeclaring the functions
defined in the base class and adding their algorithms, e.g.:
</p>
<blockquote><pre>
<strong>redeclare function extends</strong> dynamicViscosity \"Return dynamic viscosity\"
<strong>algorithm</strong>
  eta := 10 - state.T*0.3 + state.p*0.2;
<strong>end</strong> dynamicViscosity;
</pre></blockquote>
</html>"));
    end BasicDefinition;

    class MultipleSubstances "Multiple Substances"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
When writing the model of a multiple-substance medium, a fundamental issue
concerns how to consider the mass fractions of the fluid. If there are nS
substances, there are also nS mass fractions; however, one of them is redundant,
as sum(X) = 1. Therefore there are basically two options, concerning the number
of independent mass fractions nXi:
</p>
<ul>
<li> <em>Reduced-state models</em>: reducedX = <strong>true</strong> and nXi = nS - 1. In this
case, the number of independent mass fractions nXi is the minimum possible.
The full state vector X is provided by equations declared in the base class
Interfaces.PartialMedium.BaseProperties: the first nXi elements are equal to
Xi, and the last one is 1 - sum(Xi).</li>
<li> <em>Full-state models</em>: reducedX = <strong>false</strong> and nXi = nS. In this case,
Xi = X, i.e., all the elements of the composition vector are considered as
independent variables, and the constraint sum(X) = 1 is never written explicitly.
Although this kind of model is heavier, as it provides one extra state variable,
it can be less prone to numerical and/or symbolic problems, which can be
caused by that constraint.</li>
<li> <em>Fixed-composition models</em>: fixedX = <strong>true</strong> and nXi = 0. In this case X = reference_X, i.e., all the elements of the composition vector are fixed.</li>
</ul>
<p> The medium implementer can declare the value reducedX as <strong>final</strong>. In
this way only one implementation must be given. For instance,
Modelica.Media.IdealGases models declare <strong>final</strong> reducedX = <strong>false</strong>, so that the
implementation can always assume nXi = nX. The same is true for Air.MoistAir,
which declares <strong>final</strong> reducedX = <strong>true</strong>, and always assumes nXi = nX - 1 = 1.</p>
<p>It is also possible to leave reducedX modifiable. In this case, the
BaseProperties model and all additional functions should check for the actual
value of reducedX, and provide the corresponding implementation.</p>

<p>If fixedX is left modifiable, then the implementation should also handle the
case fixedX = true properly.</p>
<p>Fluid connectors should always use composition vectors of size Xi, such as
in the Modelica.Fluid library:</p>
<blockquote><pre>
<strong>connector</strong> FluidPort
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
  Medium.AbsolutePressure p;
  <strong>flow</strong> Medium.MassFlowRate m_flow;

  Medium.SpecificEnthalpy h;
  <strong>flow</strong> Medium.EnthalpyFlowRate H_flow;

  Medium.MassFraction Xi [Medium.nXi];
  <strong>flow</strong> Medium.MassFlowRate mX_flow[Medium.nXi];
<strong>end</strong> FluidPort;
</pre></blockquote>
<p>
For further details, refer to the implementation of
<a href=\"modelica://Modelica.Media.IdealGases.Common.MixtureGasNasa\">
      MixtureGasNasa model</a> and
<a href=\"modelica://Modelica.Media.Air.MoistAir\">
      MoistAir model</a>.
</p>
</html>"));
    end MultipleSubstances;

    class SpecificEnthalpyAsFunction "Specific enthalpy as function"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
If pressure p and specific enthalpy h are <strong>not</strong> used as
independent medium variables, the specific enthalpy should
be computed by a Modelica function that has as input arguments
only the independent medium variables. It should <strong>not</strong> be
computed by an equation. For example, if p and T are used
as independent medium variables, a function h_pT(p,T) should
be defined that is called to compute h:
</p>

<blockquote><pre>
h = h_pT(p,T);
</pre></blockquote>

<p>
The reason for this rule requires a longer explanation.
In short, if h is not a computed by a Modelica function and
this function is non-linear in the independent medium variables,
then non-linear systems of equations will occur at
every connection point, if the FluidPort connectors from the
Modelica.Fluid library are used (these are the same as in
Modelica.Media.Examples.Utilities.FluidPort).
Only, if the above rule is fulfilled, a tool is able to
remove these non-linear system of equations in most cases.
</p>

<p>
The basic idea of the FluidPort connector is that 2 or more
components can be connected together at a point and that
automatically the mass and energy balance is fulfilled
in the connection point, i.e., the ideal mixing equations
are generated. Note, the momentum balance is only correct for
straight line connections. If \"ideal mixing\" is not sufficient,
a special component to define the mixing equations must be introduced.
</p>

<p>
The mass and momentum balance equations in a component are
derived from the partial differential equations along the
flow direction of a pipe:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/MediumDefinition/BalanceEquations1.png\">
</p>

<p>
Note, F<sub>F</sub> is the fanning friction factor.
The energy balance can be given in different forms.
Usually, it is given as:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/MediumDefinition/EnergyBalance1.png\">
</p>

<p>
This form describes the change of the internal energy, kinetic
energy and potential energy of a volume as function of the
in and out flowing fluid. Multiplying the momentum balance
with the flow velocity v and subtracting it from the energy
balance above, results in the following alternative form
of the energy balance:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/MediumDefinition/EnergyBalance2.png\">
</p>

<p>
This form has the advantage that the kinetic and potential
energy is no longer part of the energy balance and therefore
the energy balance is substantially simpler (e.g., additional non-linear
systems of equations occur in the first form since the velocity
is present in the energy balance; in the second form this is not
the case and it is still valid also for high speeds).
</p>

<p>
Assume now that the second form of the energy balance above
is used in all components and that the following FluidPort connector
is used in all components:
</p>

<blockquote><pre>
<strong>connector</strong> FluidPort
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
  Medium.AbsolutePressure p;
  <strong>flow</strong> Medium.MassFlowRate m_flow;

  Medium.SpecificEnthalpy h;
  <strong>flow</strong> Medium.EnthalpyFlowRate H_flow;

  Medium.MassFraction Xi [Medium.nXi];
  <strong>flow</strong> Medium.MassFlowRate mX_flow[Medium.nXi];
<strong>end</strong> FluidPort;
</pre></blockquote>

<p>
As an example, assume that 3 components
are connected together and that the medium is a single substance
fluid. This will result in the following
connection equations:
</p>

<blockquote><pre>
p1=p2=p3;
h1=h2=h3;
0 = m_flow1 + m_flow2 + m_flow3;
0 = H_flow1 + H_flow2 + H_flow3;
</pre></blockquote>

<p>
These are the mass balance and the
energy balance (form 2) of an infinitesimal volume
in the connection point under the assumption that no
mass or energy is stored in this volume. In other words,
the connection equations are the equations that describe
ideal mixing. Under the assumption that the velocity
vectors of the 3 flows are identical (especially, they are
parallel), also the momentum balance is fulfilled:
</p>

<blockquote><pre>
0 = m_flow1*v1 + m_flow2*v2 + m_flow3*v3;
  = v*(m_flow1 + m_flow2 + m_flow3);
  = 0;
</pre></blockquote>

<p>
With the above connector it is therefore possible to
connect components together in a nearly arbitrary fashion,
because every connection fulfills automatically the
balance equations. This approach has, however, one drawback:
If two components are connected together, then the medium
variables on both sides of the connector are identical.
However, due to the connector, only the two equations
</p>

<blockquote><pre>
p1 = p2;
h1 = h2;
</pre></blockquote>

<p>
are present. Assume, that p,T are the independent medium variables
and that the medium properties are computed at one side of the
connections. This means, the following equations are basically
present:
</p>

<blockquote><pre>
h1 = h(p1,T1);
h2 = h(p2,T2);
p1 = p2;
h1 = h2;
</pre></blockquote>

<p>
These equations can be solved in the following way:
</p>

<blockquote><pre>
h1 := h(p1,T1)
p2 := p1;
h2 := h1;
0  := h2 - h(p2,T2);   // non-linear system of equations for T2
</pre></blockquote>

<p>
This means that T2 is computed by solving a non-linear system
of equations. If h1 and h2 are provided as Modelica functions,
a Modelica translator can replace
this non-linear system of equations by the equation:
</p>

<blockquote><pre>
T2 := T1;
</pre></blockquote>

<p>
because after alias substitution there are two function calls
</p>

<blockquote><pre>
h1 := h(p1,T1);
h1 := h(p1,T2);
</pre></blockquote>

<p>
Since the left hand side of the function call and the first
argument are the same, the second arguments T1 and T2 must also be
identical and therefore T2 := T1. This type of analysis seems
to be only possible, if the specific enthalpy is defined as a function
of the independent medium variables.
</p>

</html>"));
    end SpecificEnthalpyAsFunction;

    class StaticStateSelection "Static State Selection"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Without pre-caution when implementing a medium model,
it is very easy that non-linear algebraic
systems of equations occur when using the medium model.
In this section it is explained how to avoid non-linear
systems of equations that result from unnecessary
dynamic state selections.
</p>
<p>
A medium model should be implemented in such a way that
a tool is able to select states of a medium in a balance volume
statically (during translation). This is only possible if the
medium equations are written in a specific way. Otherwise,
a tool has to dynamically select states during simulation.
Since medium equations are usually non-linear, this means that
non-linear algebraic systems of equations would occur in every
balance volume.
</p>
<p>
It is assumed that medium equations in a balance volume
are defined in the following way:
</p>
<blockquote><pre>
  <strong>package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
  Medium.BaseProperties medium;
<strong>equation</strong>
   // mass balance
     <strong>der</strong>(M)  = port_a.m_flow + port_b.m_flow;
     <strong>der</strong>(MX) = port_a_mX_flow + port_b_mX_flow;
           M = V*medium.d;
          MX = M*medium.X;

   // Energy balance
   U = M*medium.u;
   <strong>der</strong>(U) = port_a.H_flow+port_b.H_flow;
</pre></blockquote>
<p>
<strong>Single Substance Media</strong>
</p>
<p>
A medium consisting of a single substance
has to define two of \"p,T,d,u,h\" with
stateSelect=StateSelect.prefer if BaseProperties.preferredMediumstates = <strong>true</strong>
and has to provide the other three variables as function of these
states. This results in:
</p>
<ul>
<li> static state selection (no dynamic choices).</li>
<li> a linear system of equations in the two
     state derivatives.</li>
</ul>
<p>
<strong>Example for a single substance medium</strong>
</p>
<p>
p, T are preferred states (i.e., StateSelect.prefer is set)
and there are three equations written in the form:
</p>
<blockquote><pre>
d = fd(p,T)
u = fu(p,T)
h = fh(p,T)
</pre></blockquote>
<p>
Index reduction leads to the equations:
</p>
<blockquote><pre>
<strong>der</strong>(M) = V*<strong>der</strong>(d)
<strong>der</strong>(U) = <strong>der</strong>(M)*u + M*<strong>der</strong>(u)
<strong>der</strong>(d) = <strong>der</strong>(fd,p)*<strong>der</strong>(p) + <strong>der</strong>(fd,T)*<strong>der</strong>(T)
<strong>der</strong>(u) = <strong>der</strong>(fu,p)*<strong>der</strong>(p) + <strong>der</strong>(fu,T)*<strong>der</strong>(T)
</pre></blockquote>
<p>
Note, that <strong>der</strong>(y,x) is the partial derivative of y with respect to x
and that this operator is available in Modelica only for declaring partial derivative functions,
see <a href=\"https://specification.modelica.org/v3.4/Ch12.html#partial-derivatives-of-functions\">Section&nbsp;12.7.2
(Partial Derivatives of Functions) of the Modelica 3.4 specification</a>.
</p>
<p>
The above equations imply, that if p,T are provided from the
integrator as states, all functions, such as fd(p,T)
or <strong>der</strong>(fd,p) can be evaluated as function of the states.
The overall system results in a linear system
of equations in <strong>der</strong>(p) and <strong>der</strong>(T) after eliminating
<strong>der</strong>(M), <strong>der</strong>(U), <strong>der</strong>(d), <strong>der</strong>(u) via tearing.
</p>
<p>
<strong>Counter Example for a single substance medium</strong>
</p>
<p>
An ideal gas with one substance is written in the form
</p>
<blockquote><pre>
<strong>redeclare model extends</strong> BaseProperties(
   T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
   p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)
<strong>equation</strong>
   h = h(T);
     u = h - R_s*T;
     p = d*R_s*T;
    ...
<strong>end</strong> BaseProperties;
</pre></blockquote>
<p>
If p, T are preferred states, these equations are <strong>not</strong>
written in the recommended form, because d is not a
function of p and T. If p,T would be states, it would be
necessary to solve for the density:
</p>
<blockquote><pre>
   d = p/(R_s*T)
</pre></blockquote>
<p>
If T or R_s are zero, this results in a division by zero.
A tool does not know that R_s or T cannot become zero.
Therefore, a tool must assume that p, T <strong>cannot</strong> always be
selected as states and has to either use another static
state selection or use dynamic state selection. The only
other choice for static state selection is d,T, because
h,u,p are given as functions of d,T.
However, as potential states only variables appearing differentiated and variables
declared with StateSelect.prefer or StateSelect.always
are used. Since \"d\" does not appear differentiated and has
StateSelect.default, it cannot be selected as a state.
As a result, the tool has to select states dynamically
during simulation. Since the equations above are non-linear
and they are utilized in the dynamic state
selection, a non-linear system of equations is present
in every balance volume.
</p>
<p>
To summarize, for single substance ideal gas media there
are the following two possibilities to get static
state selection and linear systems of equations:
</p>
<ol>
<li> Use p,T as preferred states and write the equation
     for d in the form: d = p/(T*R_s)</li>
<li> Use d,T as preferred states and write the equation
     for p in the form: p = d*T*R_s</li>
</ol>
<p>
All other settings (other/no preferred states etc.) lead
to dynamic state selection and non-linear systems of
equations for a balance volume.
</p>
<p>
<strong>Multiple Substance Media</strong>
</p>
<p>
A medium consisting of multiple substance
has to define two of \"p,T,d,u,h\" as well
as the mass fractions Xi with
stateSelect=StateSelect.prefer (if BaseProperties.preferredMediumStates = <strong>true</strong>)
and has to provide
the other three variables as functions of these
states. Only then, static selection is possible
for a tool.
</p>
<p>
<strong>Example for a multiple substance medium:</strong>
</p>
<p>
p, T and Xi are defined as preferred states and
the equations are written in the form:
</p>
<blockquote><pre>
d = fp(p,T,Xi);
u = fu(p,T,Xi);
h = fh(p,T,Xi);
</pre></blockquote>
<p>
Since the balance equations are written in the form:
</p>
<blockquote><pre>
  M = V*medium.d;
MXi = M*medium.Xi;
</pre></blockquote>
<p>
The variables M and MXi appearing differentiated in the
balance equations are provided as functions of d and Xi
and since d is given as a function of p, T and Xi, it
is possible to compute M and MXi directly from the desired
states. This means that static state selection is possible.
</p>
</html>"));
    end StaticStateSelection;

    class TestOfMedium "Test of medium"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
After implementation of a new medium model, it should
be tested. A basic test is already provided with model
Modelica.Media.Examples.Utilities.PartialTestModel
which might be used in the following way:
</p>

<blockquote><pre>
<strong>model</strong> TestOfMyMedium
   <strong>extends</strong> Modelica.Media.Examples.Utilities.PartialTestModel(
            <strong>redeclare package</strong> Medium = MyMedium);
<strong>end</strong> TestOfMyMedium;
</pre></blockquote>

<p>
It might be necessary to adapt or change initial values
depending on the validity range of the medium.
The model above should translate and simulate.
If the medium model is written according to the
suggestions given in the previous sections (and the Modelica
translator has appropriate algorithms implemented),
there should be only static state selection everywhere
and no non-linear system of equations, provided h is an independent
medium variable or is only a function of T. If h is a function
of, say h=h(p,T), one non-linear system of equations occurs that
cannot be avoided.
</p>

<p>
The test model above can be used to test the most basic
properties. Of course, more tests should be performed.
</p>

</html>"));
    end TestOfMedium;
    annotation (DocumentationClass=true, Documentation(info="<html>
<p>
If a new medium model shall be introduced, copy package
<a href=\"modelica://Modelica.Media.Interfaces.TemplateMedium\">
Modelica.Media.Interfaces.TemplateMedium</a> to the desired
location, remove the
\"partial\" keyword from the package and provide
the information that is requested in the comments of the
Modelica source.
A more detailed description for the different parts of the
TemplateMedium package is given here:
</p>
<ol>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.BasicStructure\">
      Basic structure of medium interface</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.BasicDefinition\">
      Basic definition of medium model</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.MultipleSubstances\">
      Multiple Substances</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.SpecificEnthalpyAsFunction\">
      Specific enthalpy as function</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\">
      Static State Selection</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.TestOfMedium\">
      Test of medium model</a></li>
</ol>
</html>"));
  end MediumDefinition;

  class ReleaseNotes "Release notes"
    extends Modelica.Icons.ReleaseNotes;
    annotation (Documentation(info="<html>
<h4>Version included in Modelica 3.0</h4>
<p> See top-level release notes for MSL.</p>

<h4>Version 1.0, 2005-03-01</h4>
<p>
Many improvements in the library, e.g., providing mixtures
of the ideal gases, table based media, test suite for all media, improved and
updated User's Guide.
</p>

<h4>Version 0.9, 2004-10-18</h4>
<ul>
<li> Changed the redeclaration/extends within packages from the
     experimental feature to the language keywords introduced
     in Modelica 2.1.</li>
<li> Re-introduced package \"Water.SaltWater\" in order to test
     substance mixtures (this medium model does not describe
     real mixing of water and salt).</li>
<li> Started to improve the documentation in
     Modelica.Media.UsersGuide.MediumDefinition.BasicStructure</li>
</ul>

<h4>Version 0.792, 2003-10-28</h4>
<p>
This is the first version made available for the public
for the Modelica'2003 conference (for evaluation).
</p>
</html>"));
  end ReleaseNotes;

  class Contact "Contact"
    extends Modelica.Icons.Contact;
    annotation (Documentation(info="<html>
<h4>Library officer and main author</h4>

<p>
<strong>Hubertus Tummescheit</strong><br>
Modelon AB<br>
Ideon Science Park<br>
SE-22730 Lund, Sweden<br>
email: <a href=\"mailto:Hubertus.Tummescheit@Modelon.se\">Hubertus.Tummescheit@Modelon.se</a>
</p>

<h4>Acknowledgements</h4>

<p>
The development of this library has been a collaborative effort
and many have contributed:
</p>
<ul>
<li> The essential parts of the media models have been implemented
     in the ThermoFluid library by Hubertus Tummescheit with
     help from Jonas Eborn and Falko Jens Wagner. These media models
     have been converted to the Modelica.Media interface definition
     and have been improved by Hubertus Tummescheit.</li>
<li> The effort for the development of the Modelica.Media library has been
     organized by Martin Otter who also contributed to the design,
     implemented part of the generic models, contributed to the User's Guide
     and provided the generic test suite Modelica.Media.Examples.Tests.</li>
<li> The basic idea for the medium model interface based on packages
     is from Michael Tiller who also contributed to the design.</li>
<li> The first design of the medium model interface is from
     Hilding Elmqvist. The design and the implementation has been further
     improved at the Modelica design meetings in<br>
     Dearborn, Nov. 20-22, 2002<br>
     Dearborn, Sept. 2-4, 2003<br>
     Lund Jan. 28-30, 2004<br>
     Munich, May 26-28, 2004<br>
     Lund, Aug. 30-31, 2004<br>
     Dearborn, Nov. 15-17, 2004<br>
     Cremona Jan. 31 - Feb. 2, 2005.</li>
<li> Hans Olsson, Sven Erik Mattsson and Hilding Elmqvist developed
     symbolic transformation algorithms and implemented them in Dymola
     to improve the efficiency considerably (e.g., to avoid non-linear
        systems of equations).</li>
<li>Katrin Pr&ouml;&szlig; implemented the moist air model</li>
<li> R&uuml;diger Franke performed the first realistic tests of the Modelica.Media
        and Modelica_Fluid libraries and gave valuable feedback.</li>
<li> Francesco Casella has been the most relentless bug-hunter and tester of the
     water and ideal gas properties. He also contributed to the User's Guide.</li>
<li> John Batteh, Daniel Bouskela, Jonas Eborn, Andreas Idebrant, Charles Newman,
     Gerhart Schmitz, and the users of the ThermoFluid library provided
     many useful comments and feedback.</li>
</ul>
</html>"));
  end Contact;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Library <strong>Modelica.Media</strong> is a <strong>free</strong> Modelica package providing
a standardized interface to fluid media models and specific
media models based on this interface.
A fluid medium model defines <strong>algebraic</strong> equations
for the intensive thermodynamic variables used in the <strong>mass</strong>
and <strong>energy</strong> balance of component models. Optionally, additional
medium properties can be computed such as dynamic viscosity or thermal
conductivity. Medium models are defined for <strong>single</strong> and
<strong>multiple substance</strong> fluids with <strong>one</strong> and
<strong>multiple phases</strong>.
</p>
<p>
A large part of the library provides specific medium models
that can be directly utilized. This library can be used in
all types of Modelica fluid libraries that may have different connectors
and design philosophies. It is particularly utilized
in the Modelica.Fluid library (1D therm-fluid flow components for
single and multiple substance flow with one and multiple phases).
The Modelica.Media library has the following
main features:
</p>
<ul>
<li> Balance equations and media model equations
     are decoupled.
     This means that the used medium model does usually not have an
     influence on how the balance equations are formulated.
     For example, the same balance equations are used for media
     that use pressure and temperature, or pressure and specific
     enthalpy as independent variables, as well as for
     incompressible and compressible media models.
     A Modelica tool will have enough information to
     generate as efficient code as a traditional
     (coupled) definition. This feature is described in more
     detail in section
     <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\">Static State Selection</a>.</li>
<li> Optional variables, such as dynamic viscosity, are only computed if
     needed in the corresponding component.</li>
<li> The independent variables of a medium model do not
     influence the definition of a fluid connector port.
     Especially, the media models are implemented in such a way
     that a connector may have the minimum number of independent
     medium variables in a connector and still get the same
     efficiency as if all medium variables are passed by the
     connector from one component to the next one (the latter
     approach has the restriction that a fluid port can only
     connect two components and not more). Note, the Modelica.Fluid
     library uses the first approach, i.e., having a set of
     independent medium variables in a connector.</li>
<li> The medium models are implemented with regards to
     efficient dynamic simulation. For example, two phase
     medium models trigger state events at phase boundaries
     (because the medium variables are not differentiable
     at this point).</li>
</ul>
<p>
This User's Guide has the following main parts:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage\">Medium usage</a>
     describes how to use a medium model from
     this library in a component model.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition\">Medium definition</a>
     describes how a new fluid medium
     model has to be implemented.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.ReleaseNotes\">ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.Contact\">Contact</a>
    provides information about the authors of the library as well as
    acknowledgements.</li>
</ul>
</html>"));
end UsersGuide;
