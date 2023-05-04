within ThermofluidStream.Media.myMedia;
package Interfaces "Interfaces for media models"
  extends Modelica.Icons.InterfacesPackage;

  partial package TemplateMedium "Template for media models"
    /* For a new medium, make a copy of this package and remove
     the "partial" keyword from the package definition above.
     The statement below extends from PartialMedium and sets some
     package constants. Provide values for these constants
     that are appropriate for your medium model. Note that other
     constants (such as nX, nXi) are automatically defined by
     definitions given in the base class Interfaces.PartialMedium"
  */
    extends ThermofluidStream.Media.myMedia.Interfaces.PartialMedium(
      final mediumName="NameOfMedium",
      final substanceNames={mediumName},
      final singleState=false,
      final reducedX=true,
      final fixedX=true,
      Temperature(
        min=273,
        max=450,
        start=323));

    // Provide medium constants here
    constant SpecificHeatCapacity cp_const=123456
      "Constant specific heat capacity at constant pressure";

    /* The vector substanceNames is mandatory, as the number of
         substances is determined based on its size. Here we assume
         a single-component medium.
         singleState is true if u and d do not depend on pressure, but only
         on a thermal variable (temperature or enthalpy). Otherwise, set it
         to false.
         For a single-substance medium, just set reducedX and fixedX to true, and there's
         no need to bother about medium compositions at all. Otherwise, set
         final reducedX = true if the medium model has nS-1 independent mass
         fraction, or reducedX = false if the medium model has nS independent
         mass fractions (nS = number of substances).
         If a mixture has a fixed composition set fixedX=true, otherwise false.
         The modifiers for reducedX and fixedX should normally be final
         since the other equations are based on these values.

         It is also possible to redeclare the min, max, and start attributes of
         Medium types, defined in the base class Interfaces.PartialMedium
         (the example of Temperature is shown here). Min and max attributes
         should be set in accordance to the limits of validity of the medium
         model, while the start attribute should be a reasonable default value
         for the initialization of nonlinear solver iterations */

    /* Provide an implementation of model BaseProperties,
     that is defined in PartialMedium. Select two independent
     variables from p, T, d, u, h. The other independent
     variables are the mass fractions "Xi", if there is more
     than one substance. Provide 3 equations to obtain the remaining
     variables as functions of the independent variables.
     It is also necessary to provide two additional equations to set
     the gas constant R_s and the molar mass MM of the medium.
     Finally, the thermodynamic state vector, defined in the base class
     Interfaces.PartialMedium.BaseProperties, should be set, according to
     its definition (see ThermodynamicState below).
     The computation of vector X[nX] from Xi[nXi] is already included in
     the base class Interfaces.PartialMedium.BaseProperties, so it should not
     be repeated here.
     The code fragment below is for a single-substance medium with
     p,T as independent variables.
  */

    redeclare model extends BaseProperties(final standardOrderComponents=true)
      "Base properties of medium"

    equation
      d = 1;
      h = cp_const*T;
      u = h - p/d;
      MM = 0.024;
      R_s = Modelica.Constants.R/MM;
      state.p = p;
      state.T = T;
    end BaseProperties;

    /* Provide implementations of the following optional properties.
     If not available, delete the corresponding function.
     The record "ThermodynamicState" contains the input arguments
     of all the function and is defined together with the used
     type definitions in PartialMedium. The record most often contains two of the
     variables "p, T, d, h" (e.g., medium.T)
  */
    redeclare replaceable record ThermodynamicState
      "A selection of variables that uniquely defines the thermodynamic state"
      extends Modelica.Icons.Record;
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
      annotation (Documentation(info="<html>

</html>"));
    end ThermodynamicState;

    redeclare function extends dynamicViscosity "Return dynamic viscosity"
    algorithm
      eta := 10 - state.T*0.3 + state.p*0.2;
      annotation (Documentation(info="<html>

</html>"));
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Return thermal conductivity"
    algorithm
      lambda := 0;
      annotation (Documentation(info="<html>

</html>"));
    end thermalConductivity;

    redeclare function extends specificEntropy "Return specific entropy"
    algorithm
      s := 0;
      annotation (Documentation(info="<html>

</html>"));
    end specificEntropy;

    redeclare function extends specificHeatCapacityCp
      "Return specific heat capacity at constant pressure"
    algorithm
      cp := 0;
      annotation (Documentation(info="<html>

</html>"));
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "Return specific heat capacity at constant volume"
    algorithm
      cv := 0;
      annotation (Documentation(info="<html>

</html>"));
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent "Return isentropic exponent"
      extends Modelica.Icons.Function;
    algorithm
      gamma := 1;
      annotation (Documentation(info="<html>

</html>"));
    end isentropicExponent;

    redeclare function extends velocityOfSound "Return velocity of sound"
      extends Modelica.Icons.Function;
    algorithm
      a := 0;
      annotation (Documentation(info="<html>

</html>"));
    end velocityOfSound;

    annotation (Documentation(info="<html>
<p>
This package is a <strong>template</strong> for <strong>new medium</strong> models. For a new
medium model just make a copy of this package, remove the
\"partial\" keyword from the package and provide
the information that is requested in the comments of the
Modelica source.
</p>
</html>"));
  end TemplateMedium;

  partial package PartialMedium
    "Partial medium properties (base package of all media packages)"
    extends ThermofluidStream.Media.myMedia.Interfaces.Types;
    extends Modelica.Icons.MaterialPropertiesPackage;

    // Constants to be set in Medium
    constant
      ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables ThermoStates
      "Enumeration type for independent variables";
    constant String mediumName="unusablePartialMedium" "Name of the medium";
    constant String substanceNames[:]={mediumName}
      "Names of the mixture substances. Set substanceNames={mediumName} if only one substance.";
    constant String extraPropertiesNames[:]=fill("", 0)
      "Names of the additional (extra) transported properties. Set extraPropertiesNames=fill(\"\",0) if unused";
    constant Boolean singleState
      "= true, if u and d are not a function of pressure";
    constant Boolean reducedX=true
      "= true, if medium contains the equation sum(X) = 1.0; set reducedX=true if only one substance (see docu for details)";
    constant Boolean fixedX=false
      "= true, if medium contains the equation X = reference_X";
    constant AbsolutePressure reference_p=101325
      "Reference pressure of Medium: default 1 atmosphere";
    constant Temperature reference_T=298.15
      "Reference temperature of Medium: default 25 deg Celsius";
    constant MassFraction reference_X[nX]=fill(1/nX, nX)
      "Default mass fractions of medium";
    constant AbsolutePressure p_default=101325
      "Default value for pressure of medium (for initialization)";
    constant Temperature T_default=Modelica.Units.Conversions.from_degC(20)
      "Default value for temperature of medium (for initialization)";
    constant SpecificEnthalpy h_default=specificEnthalpy_pTX(
            p_default,
            T_default,
            X_default)
      "Default value for specific enthalpy of medium (for initialization)";
    constant MassFraction X_default[nX]=reference_X
      "Default value for mass fractions of medium (for initialization)";
    constant ExtraProperty C_default[nC]=fill(0, nC)
      "Default value for trace substances of medium (for initialization)";

    final constant Integer nS=size(substanceNames, 1) "Number of substances";
    constant Integer nX=nS "Number of mass fractions";
    constant Integer nXi=if fixedX then 0 else if reducedX then nS - 1 else nS
      "Number of structurally independent mass fractions (see docu for details)";

    final constant Integer nC=size(extraPropertiesNames, 1)
      "Number of extra (outside of standard mass-balance) transported properties";
    constant Real C_nominal[nC](min=fill(Modelica.Constants.eps, nC)) = 1.0e-6*
      ones(nC) "Default for the nominal values for the extra properties";
    replaceable record FluidConstants =
        ThermofluidStream.Media.myMedia.Interfaces.Types.Basic.FluidConstants
      "Critical, triple, molecular and other standard data of fluid";

    replaceable record ThermodynamicState
      "Minimal variable set that is available as input argument to every medium function"
      extends Modelica.Icons.Record;
    end ThermodynamicState;

    replaceable partial model BaseProperties
      "Base properties (p, d, T, h, u, R_s, MM and, if applicable, X and Xi) of a medium"
      InputAbsolutePressure p "Absolute pressure of medium";
      InputMassFraction[nXi] Xi(start=reference_X[1:nXi])
        "Structurally independent mass fractions";
      InputSpecificEnthalpy h "Specific enthalpy of medium";
      Density d "Density of medium";
      Temperature T "Temperature of medium";
      MassFraction[nX] X(start=reference_X)
        "Mass fractions (= (component mass)/total mass m_i/m)";
      SpecificInternalEnergy u "Specific internal energy of medium";
      SpecificHeatCapacity R_s "Gas constant (of mixture if applicable)";
      MolarMass MM "Molar mass (of mixture or single fluid)";
      ThermodynamicState state
        "Thermodynamic state record for optional functions";
      parameter Boolean preferredMediumStates=false
        "= true, if StateSelect.prefer shall be used for the independent property variables of the medium"
        annotation (Evaluate=true, Dialog(tab="Advanced"));
      parameter Boolean standardOrderComponents=true
        "If true, and reducedX = true, the last element of X will be computed from the other ones";
      Modelica.Units.NonSI.Temperature_degC T_degC=
          Modelica.Units.Conversions.to_degC(T)
        "Temperature of medium in [degC]";
      Modelica.Units.NonSI.Pressure_bar p_bar=
          Modelica.Units.Conversions.to_bar(p)
        "Absolute pressure of medium in [bar]";

      // Local connector definition, used for equation balancing check
      connector InputAbsolutePressure = input SI.AbsolutePressure
        "Pressure as input signal connector";
      connector InputSpecificEnthalpy = input SI.SpecificEnthalpy
        "Specific enthalpy as input signal connector";
      connector InputMassFraction = input SI.MassFraction
        "Mass fraction as input signal connector";

    equation
      if standardOrderComponents then
        Xi = X[1:nXi];

        if fixedX then
          X = reference_X;
        end if;
        if reducedX and not fixedX then
          X[nX] = 1 - sum(Xi);
        end if;
        for i in 1:nX loop
          assert(X[i] >= -1.e-5 and X[i] <= 1 + 1.e-5, "Mass fraction X[" +
            String(i) + "] = " + String(X[i]) + "of substance " +
            substanceNames[i] + "\nof medium " + mediumName +
            " is not in the range 0..1");
        end for;

      end if;

      assert(p >= 0.0, "Pressure (= " + String(p) + " Pa) of medium \"" +
        mediumName + "\" is negative\n(Temperature = " + String(T) + " K)");
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}), Text(
              extent={{-152,164},{152,102}},
              textString="%name",
              textColor={0,0,255})}), Documentation(info="<html>
<p>
Model <strong>BaseProperties</strong> is a model within package <strong>PartialMedium</strong>
and contains the <strong>declarations</strong> of the minimum number of
variables that every medium model is supposed to support.
A specific medium inherits from model <strong>BaseProperties</strong> and provides
the equations for the basic properties.</p>
<p>
The BaseProperties model contains the following <strong>7+nXi variables</strong>
(nXi is the number of independent mass fractions defined in package
PartialMedium):
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Variable</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>Temperature</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>Absolute pressure</td></tr>
  <tr><td>d</td>
      <td>kg/m3</td>
      <td>Density</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>Specific enthalpy</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>Specific internal energy</td></tr>
  <tr><td>Xi[nXi]</td>
      <td>kg/kg</td>
      <td>Structurally independent mass fractions</td></tr>
  <tr><td>R_s</td>
      <td>J/(kg.K)</td>
      <td>Specific gas constant (of mixture if applicable)</td></tr>
  <tr><td>MM</td>
      <td>kg/mol</td>
      <td>Molar mass</td></tr>
</table>
<p>
In order to implement an actual medium model, one can extend from this
base model and add <strong>5 equations</strong> that provide relations among
these variables. Equations will also have to be added in order to
set all the variables within the ThermodynamicState record state.</p>
<p>
If standardOrderComponents=true, the full composition vector X[nX]
is determined by the equations contained in this base class, depending
on the independent mass fraction vector Xi[nXi].</p>
<p>Additional <strong>2 + nXi</strong> equations will have to be provided
when using the BaseProperties model, in order to fully specify the
thermodynamic conditions. The input connector qualifier applied to
p, h, and nXi indirectly declares the number of missing equations,
permitting advanced equation balance checking by Modelica tools.
Please note that this doesn't mean that the additional equations
should be connection equations, nor that exactly those variables
should be supplied, in order to complete the model.
For further information, see the <a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media User's guide</a>, and
<a href=\"https://specification.modelica.org/v3.4/Ch4.html#balanced-models\">Section 4.7 (Balanced Models) of the Modelica 3.4 specification</a>.</p>
</html>"));
    end BaseProperties;

    replaceable partial function setState_pTX
      "Return thermodynamic state as function of p, T and composition X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    end setState_pTX;

    replaceable partial function setState_phX
      "Return thermodynamic state as function of p, h and composition X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    end setState_phX;

    replaceable partial function setState_psX
      "Return thermodynamic state as function of p, s and composition X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    end setState_psX;

    replaceable partial function setState_dTX
      "Return thermodynamic state as function of d, T and composition X or Xi"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    end setState_dTX;

    replaceable partial function setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
      extends Modelica.Icons.Function;
      input Real x "m_flow or dp";
      input ThermodynamicState state_a "Thermodynamic state if x > 0";
      input ThermodynamicState state_b "Thermodynamic state if x < 0";
      input Real x_small(min=0)
        "Smooth transition in the region -x_small < x < x_small";
      output ThermodynamicState state
        "Smooth thermodynamic state for all x (continuous and differentiable)";
      annotation (Documentation(info="<html>
<p>
This function is used to approximate the equation
</p>
<blockquote><pre>
state = <strong>if</strong> x &gt; 0 <strong>then</strong> state_a <strong>else</strong> state_b;
</pre></blockquote>

<p>
by a smooth characteristic, so that the expression is continuous and differentiable:
</p>

<blockquote><pre>
state := <strong>smooth</strong>(1, <strong>if</strong> x &gt;  x_small <strong>then</strong> state_a <strong>else</strong>
                   <strong>if</strong> x &lt; -x_small <strong>then</strong> state_b <strong>else</strong> f(state_a, state_b));
</pre></blockquote>

<p>
This is performed by applying function <strong>Media.Common.smoothStep</strong>(..)
on every element of the thermodynamic state record.
</p>

<p>
If <strong>mass fractions</strong> X[:] are approximated with this function then this can be performed
for all <strong>nX</strong> mass fractions, instead of applying it for nX-1 mass fractions and computing
the last one by the mass fraction constraint sum(X)=1. The reason is that the approximating function has the
property that sum(state.X) = 1, provided sum(state_a.X) = sum(state_b.X) = 1.
This can be shown by evaluating the approximating function in the abs(x) &lt; x_small
region (otherwise state.X is either state_a.X or state_b.X):
</p>

<blockquote><pre>
X[1]  = smoothStep(x, X_a[1] , X_b[1] , x_small);
X[2]  = smoothStep(x, X_a[2] , X_b[2] , x_small);
   ...
X[nX] = smoothStep(x, X_a[nX], X_b[nX], x_small);
</pre></blockquote>

<p>
or
</p>

<blockquote><pre>
X[1]  = c*(X_a[1]  - X_b[1])  + (X_a[1]  + X_b[1])/2
X[2]  = c*(X_a[2]  - X_b[2])  + (X_a[2]  + X_b[2])/2;
   ...
X[nX] = c*(X_a[nX] - X_b[nX]) + (X_a[nX] + X_b[nX])/2;
c     = (x/x_small)*((x/x_small)^2 - 3)/4
</pre></blockquote>

<p>
Summing all mass fractions together results in
</p>

<blockquote><pre>
sum(X) = c*(sum(X_a) - sum(X_b)) + (sum(X_a) + sum(X_b))/2
       = c*(1 - 1) + (1 + 1)/2
       = 1
</pre></blockquote>
</html>"));
    end setSmoothState;

    replaceable partial function dynamicViscosity "Return dynamic viscosity"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output DynamicViscosity eta "Dynamic viscosity";
    end dynamicViscosity;

    replaceable partial function thermalConductivity
      "Return thermal conductivity"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output ThermalConductivity lambda "Thermal conductivity";
    end thermalConductivity;

    replaceable function prandtlNumber "Return the Prandtl number"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output PrandtlNumber Pr "Prandtl number";
    algorithm
      Pr := dynamicViscosity(state)*specificHeatCapacityCp(state)/
        thermalConductivity(state);
    end prandtlNumber;

    replaceable partial function massFraction "Return independent mass Fraction"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction Xi[nXi] "(independent) Mass Fraction";
    end massFraction;

    replaceable partial function pressure "Return pressure"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output AbsolutePressure p "Pressure";
    end pressure;

    replaceable partial function temperature "Return temperature"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output Temperature T "Temperature";
    end temperature;

    replaceable partial function density "Return density"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output Density d "Density";
    end density;

    replaceable partial function specificEnthalpy "Return specific enthalpy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnthalpy h "Specific enthalpy";
    end specificEnthalpy;

    replaceable partial function specificInternalEnergy
      "Return specific internal energy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnergy u "Specific internal energy";
    end specificInternalEnergy;

    replaceable partial function specificEntropy "Return specific entropy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEntropy s "Specific entropy";
    end specificEntropy;

    replaceable partial function specificGibbsEnergy
      "Return specific Gibbs energy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnergy g "Specific Gibbs energy";
    end specificGibbsEnergy;

    replaceable partial function specificHelmholtzEnergy
      "Return specific Helmholtz energy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnergy f "Specific Helmholtz energy";
    end specificHelmholtzEnergy;

    replaceable partial function specificHeatCapacityCp
      "Return specific heat capacity at constant pressure"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificHeatCapacity cp
        "Specific heat capacity at constant pressure";
    end specificHeatCapacityCp;

    function heatCapacity_cp = specificHeatCapacityCp
      "Alias for deprecated name";

    replaceable partial function specificHeatCapacityCv
      "Return specific heat capacity at constant volume"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificHeatCapacity cv
        "Specific heat capacity at constant volume";
    end specificHeatCapacityCv;

    function heatCapacity_cv = specificHeatCapacityCv
      "Alias for deprecated name";

    replaceable partial function isentropicExponent
      "Return isentropic exponent"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output IsentropicExponent gamma "Isentropic exponent";
    end isentropicExponent;

    replaceable partial function isentropicEnthalpy
      "Return isentropic enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p_downstream "Downstream pressure";
      input ThermodynamicState refState "Reference state for entropy";
      output SpecificEnthalpy h_is "Isentropic enthalpy";
      annotation (Documentation(info="<html>
<p>
This function computes an isentropic state transformation:
</p>
<ol>
<li> A medium is in a particular state, refState.</li>
<li> The enthalpy at another state (h_is) shall be computed
     under the assumption that the state transformation from refState to h_is
     is performed with a change of specific entropy ds = 0 and the pressure of state h_is
     is p_downstream and the composition X upstream and downstream is assumed to be the same.</li>
</ol>

</html>"));
    end isentropicEnthalpy;

    replaceable partial function velocityOfSound "Return velocity of sound"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output VelocityOfSound a "Velocity of sound";
    end velocityOfSound;

    replaceable partial function isobaricExpansionCoefficient
      "Return overall the isobaric expansion coefficient beta"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output IsobaricExpansionCoefficient beta "Isobaric expansion coefficient";
      annotation (Documentation(info="<html>
<blockquote><pre>
beta is defined as 1/v * der(v,T), with v = 1/d, at constant pressure p.
</pre></blockquote>
</html>"));
    end isobaricExpansionCoefficient;

    function beta = isobaricExpansionCoefficient
      "Alias for isobaricExpansionCoefficient for user convenience";

    replaceable partial function isothermalCompressibility
      "Return overall the isothermal compressibility factor"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SI.IsothermalCompressibility kappa "Isothermal compressibility";
      annotation (Documentation(info="<html>
<blockquote><pre>
kappa is defined as - 1/v * der(v,p), with v = 1/d at constant temperature T.
</pre></blockquote>
</html>"));
    end isothermalCompressibility;

    function kappa = isothermalCompressibility
      "Alias of isothermalCompressibility for user convenience";

    // explicit derivative functions for finite element models
    replaceable partial function density_derp_h
      "Return density derivative w.r.t. pressure at const specific enthalpy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output DerDensityByPressure ddph "Density derivative w.r.t. pressure";
    end density_derp_h;

    replaceable partial function density_derh_p
      "Return density derivative w.r.t. specific enthalpy at constant pressure"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output DerDensityByEnthalpy ddhp
        "Density derivative w.r.t. specific enthalpy";
    end density_derh_p;

    replaceable partial function density_derp_T
      "Return density derivative w.r.t. pressure at const temperature"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output DerDensityByPressure ddpT "Density derivative w.r.t. pressure";
    end density_derp_T;

    replaceable partial function density_derT_p
      "Return density derivative w.r.t. temperature at constant pressure"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output DerDensityByTemperature ddTp
        "Density derivative w.r.t. temperature";
    end density_derT_p;

    replaceable partial function density_derX
      "Return density derivative w.r.t. mass fraction"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output Density[nX] dddX "Derivative of density w.r.t. mass fraction";
    end density_derX;

    replaceable partial function molarMass
      "Return the molar mass of the medium"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MolarMass MM "Mixture molar mass";
    end molarMass;

    replaceable function specificEnthalpy_pTX
      "Return specific enthalpy from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_pTX(
              p,
              T,
              X));
      annotation (inverse(T=temperature_phX(
                    p,
                    h,
                    X)));
    end specificEnthalpy_pTX;

    replaceable function specificEntropy_pTX
      "Return specific enthalpy from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output SpecificEntropy s "Specific entropy";
    algorithm
      s := specificEntropy(setState_pTX(
              p,
              T,
              X));

      annotation (inverse(T=temperature_psX(
                    p,
                    s,
                    X)));
    end specificEntropy_pTX;

    replaceable function density_pTX "Return density from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions";
      output Density d "Density";
    algorithm
      d := density(setState_pTX(
              p,
              T,
              X));
    end density_pTX;

    replaceable function temperature_phX
      "Return temperature from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output Temperature T "Temperature";
    algorithm
      T := temperature(setState_phX(
              p,
              h,
              X));
    end temperature_phX;

    replaceable function density_phX "Return density from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output Density d "Density";
    algorithm
      d := density(setState_phX(
              p,
              h,
              X));
    end density_phX;

    replaceable function temperature_psX
      "Return temperature from p,s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output Temperature T "Temperature";
    algorithm
      T := temperature(setState_psX(
              p,
              s,
              X));
      annotation (inverse(s=specificEntropy_pTX(
                    p,
                    T,
                    X)));
    end temperature_psX;

    replaceable function density_psX "Return density from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output Density d "Density";
    algorithm
      d := density(setState_psX(
              p,
              s,
              X));
    end density_psX;

    replaceable function specificEnthalpy_psX
      "Return specific enthalpy from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_psX(
              p,
              s,
              X));
    end specificEnthalpy_psX;

    type MassFlowRate = SI.MassFlowRate (
        quantity="MassFlowRate." + mediumName,
        min=-1.0e5,
        max=1.e5) "Type for mass flow rate with medium specific attributes";

    // Only for backwards compatibility to version 3.2 (
    // (do not use these definitions in new models, but use Modelica.Media.Interfaces.Choices instead)
    package Choices = myMedia.Interfaces.Choices annotation (obsolete=
          "Use Modelica.Media.Interfaces.Choices");

    annotation (Documentation(info="<html>
<p>
<strong>PartialMedium</strong> is a package and contains all <strong>declarations</strong> for
a medium. This means that constants, models, and functions
are defined that every medium is supposed to support
(some of them are optional). A medium package
inherits from <strong>PartialMedium</strong> and provides the
equations for the medium. The details of this package
are described in
<a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.
</p>
</html>", revisions="<html>

</html>"));
  end PartialMedium;

  partial package PartialPureSubstance
    "Base class for pure substances of one chemical substance"
    extends PartialMedium(final reducedX=true, final fixedX=true);

    redeclare replaceable function massFraction "Return independent mass Fraction"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction Xi[nXi] "(independent) Mass Fraction";
    algorithm
      Xi := fill(0,0);
    end massFraction;

    replaceable function setState_pT "Return thermodynamic state from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_pTX(
              p,
              T,
              fill(0, 0));
    end setState_pT;

    replaceable function setState_ph "Return thermodynamic state from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_phX(
              p,
              h,
              fill(0, 0));
    end setState_ph;

    replaceable function setState_ps "Return thermodynamic state from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_psX(
              p,
              s,
              fill(0, 0));
    end setState_ps;

    replaceable function setState_dT "Return thermodynamic state from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_dTX(
              d,
              T,
              fill(0, 0));
    end setState_dT;

    replaceable function density_ph "Return density from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Density d "Density";
    algorithm
      d := density_phX(
              p,
              h,
              fill(0, 0));
    end density_ph;

    replaceable function temperature_ph "Return temperature from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Temperature T "Temperature";
    algorithm
      T := temperature_phX(
              p,
              h,
              fill(0, 0));
    end temperature_ph;

    replaceable function pressure_dT "Return pressure from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output AbsolutePressure p "Pressure";
    algorithm
      p := pressure(setState_dTX(
              d,
              T,
              fill(0, 0)));
    end pressure_dT;

    replaceable function specificEnthalpy_dT
      "Return specific enthalpy from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_dTX(
              d,
              T,
              fill(0, 0)));
    end specificEnthalpy_dT;

    replaceable function specificEnthalpy_ps
      "Return specific enthalpy from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy_psX(
              p,
              s,
              fill(0, 0));
    end specificEnthalpy_ps;

    replaceable function temperature_ps "Return temperature from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Temperature T "Temperature";
    algorithm
      T := temperature_psX(
              p,
              s,
              fill(0, 0));
    end temperature_ps;

    replaceable function density_ps "Return density from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Density d "Density";
    algorithm
      d := density_psX(
              p,
              s,
              fill(0, 0));
    end density_ps;

    replaceable function specificEnthalpy_pT
      "Return specific enthalpy from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy_pTX(
              p,
              T,
              fill(0, 0));
    end specificEnthalpy_pT;

    replaceable function density_pT "Return density from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output Density d "Density";
    algorithm
      d := density(setState_pTX(
              p,
              T,
              fill(0, 0)));
    end density_pT;

    redeclare replaceable partial model extends BaseProperties(final
        standardOrderComponents=true)
    end BaseProperties;
  end PartialPureSubstance;

  partial package PartialLinearFluid
    "Generic pure liquid model with constant cp, compressibility and thermal expansion coefficients"

    extends Interfaces.PartialPureSubstance(ThermoStates=ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.pTX,
        singleState=false);
    constant SpecificHeatCapacity cp_const
      "Specific heat capacity at constant pressure";
    constant IsobaricExpansionCoefficient beta_const
      "Thermal expansion coefficient at constant pressure";
    constant SI.IsothermalCompressibility kappa_const
      "Isothermal compressibility";
    constant MolarMass MM_const "Molar mass";
    constant Density reference_d "Density in reference conditions";
    constant SpecificEnthalpy reference_h
      "Specific enthalpy in reference conditions";
    constant SpecificEntropy reference_s
      "Specific entropy in reference conditions";
    constant Boolean constantJacobian
      "If true, entries in thermodynamic Jacobian are constant, taken at reference conditions";

    redeclare record ThermodynamicState
      "A selection of variables that uniquely defines the thermodynamic state"
      extends Modelica.Icons.Record;
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
    end ThermodynamicState;

    redeclare model extends BaseProperties(T(stateSelect=if
            preferredMediumStates then StateSelect.prefer else StateSelect.default),
        p(stateSelect=if preferredMediumStates then StateSelect.prefer else
            StateSelect.default)) "Base properties of medium"
    equation
      d = (1 + (p - reference_p)*kappa_const - (T - reference_T)*beta_const)*
        reference_d;
      h = reference_h + (T - reference_T)*cp_const + (p - reference_p)*(1 -
        beta_const*reference_T)/reference_d;
      u = h - p/d;
      p = state.p;
      T = state.T;
      MM = MM_const;
      R_s = Modelica.Constants.R/MM;
    end BaseProperties;

    redeclare function extends setState_pTX
      "Set the thermodynamic state record from p and T (X not needed)"
    algorithm
      state := ThermodynamicState(p=p, T=T);
    end setState_pTX;

    redeclare function extends setState_phX
      "Set the thermodynamic state record from p and h (X not needed)"
    algorithm
      state := ThermodynamicState(p=p, T=(h - reference_h - (p - reference_p)*(
        (1 - beta_const*reference_T)/reference_d))/cp_const + reference_T);
    end setState_phX;

    redeclare function extends setState_psX
      "Set the thermodynamic state record from p and s (X not needed)"
    algorithm
      state := ThermodynamicState(p=p, T=reference_T*cp_const/(cp_const - s +
        reference_s + (p - reference_p)*(-beta_const/reference_d)));
    end setState_psX;

    redeclare function extends setState_dTX
      "Set the thermodynamic state record from d and T (X not needed)"
    algorithm
      state := ThermodynamicState(p=((d - reference_d) + (T - reference_T)
        *beta_const*reference_d)/(reference_d*kappa_const) + reference_p, T=T);
    end setState_dTX;

    redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
    algorithm
      state := ThermodynamicState(p=myMedia.Common.smoothStep(
            x,
            state_a.p,
            state_b.p,
            x_small), T=myMedia.Common.smoothStep(
            x,
            state_a.T,
            state_b.T,
            x_small));
    end setSmoothState;

    redeclare function extends pressure
      "Return the pressure from the thermodynamic state"
    algorithm
      p := state.p;
    end pressure;

    redeclare function extends temperature
      "Return the temperature from the thermodynamic state"
    algorithm
      T := state.T;
    end temperature;

    redeclare function extends density
      "Return the density from the thermodynamic state"
    algorithm
      d := (1 + (state.p - reference_p)*kappa_const - (state.T - reference_T)*
        beta_const)*reference_d;
    end density;

    redeclare function extends specificEnthalpy
      "Return the specific enthalpy from the thermodynamic state"
    algorithm
      h := reference_h + (state.T - reference_T)*cp_const + (state.p -
        reference_p)*(1 - beta_const*reference_T)/reference_d;
    end specificEnthalpy;

    redeclare function extends specificEntropy
      "Return the specific entropy from the thermodynamic state"
    algorithm
      s := reference_s + (state.T - reference_T)*cp_const/state.T + (state.p -
        reference_p)*(-beta_const/reference_d);
    end specificEntropy;

    redeclare function extends specificInternalEnergy
      "Return the specific internal energy from the thermodynamic state"
    algorithm
      u := specificEnthalpy(state) - state.p/reference_d;
    end specificInternalEnergy;

    redeclare function extends specificGibbsEnergy
      "Return specific Gibbs energy from the thermodynamic state"
      extends Modelica.Icons.Function;
    algorithm
      g := specificEnthalpy(state) - state.T*specificEntropy(state);
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy
      "Return specific Helmholtz energy from the thermodynamic state"
      extends Modelica.Icons.Function;
    algorithm
      f := specificInternalEnergy(state) - state.T*specificEntropy(state);
    end specificHelmholtzEnergy;

    redeclare function extends velocityOfSound
      "Return velocity of sound from the thermodynamic state"
      extends Modelica.Icons.Function;
    algorithm
      a := sqrt(max(0, 1/(kappa_const*density(state) - beta_const*beta_const*
        state.T/cp_const)));
    end velocityOfSound;

    redeclare function extends isentropicExponent
      "Return isentropic exponent from the thermodynamic state"
      extends Modelica.Icons.Function;
    algorithm
      gamma := 1/(state.p*kappa_const)*cp_const/specificHeatCapacityCv(state);
    end isentropicExponent;

    redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"

      /* Previous wrong equation:

protected
  SpecificEntropy s_upstream = specificEntropy(refState)
    "Specific entropy at component inlet";
  ThermodynamicState downstreamState "State at downstream location";
algorithm
  downstreamState.p := p_downstream;
  downstreamState.T := reference_T*cp_const/
    (s_upstream -reference_s -(p_downstream-reference_p)*(-beta_const/reference_d) - cp_const);
  h_is := specificEnthalpy(downstreamState);
*/
    algorithm
      /* s := reference_s + (refState.T-reference_T)*cp_const/refState.T +
                        (refState.p-reference_p)*(-beta_const/reference_d)
        = reference_s + (state.T-reference_T)*cp_const/state.T +
                        (p_downstream-reference_p)*(-beta_const/reference_d);

      (state.T-reference_T)*cp_const/state.T
     = (refState.T-reference_T)*cp_const/refState.T + (refState.p-reference_p)*(-beta_const/reference_d)
       - (p_downstream-reference_p)*(-beta_const/reference_d)
     = (refState.T-reference_T)*cp_const/refState.T + (refState.p-p_downstream)*(-beta_const/reference_d)

     (x - reference_T)/x = k
     x - reference_T = k*x
     (1-k)*x = reference_T
     x = reference_T/(1-k);

     state.T = reference_T/(1 - ((refState.T-reference_T)*cp_const/refState.T + (refState.p-p_downstream)*(-beta_const/reference_d))/cp_const)
  */

      h_is := specificEnthalpy(setState_pTX(
              p_downstream,
              reference_T/(1 - ((refState.T - reference_T)/refState.T + (
          refState.p - p_downstream)*(-beta_const/(reference_d*cp_const)))),
              reference_X));
      annotation (Documentation(info="<html>
<p>
A minor approximation is used: the reference density is used instead of the real
one, which would require a numeric solution.
</p>
</html>"));
    end isentropicEnthalpy;

    redeclare function extends specificHeatCapacityCp
      "Return specific heat capacity at constant volume"
    algorithm
      cp := cp_const;
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "Return specific heat capacity at constant volume from the thermodynamic state"
    algorithm
      cv := if constantJacobian then cp_const - reference_T*beta_const*
        beta_const/(kappa_const*reference_d) else state.T*beta_const*beta_const
        /(kappa_const*reference_d);
    end specificHeatCapacityCv;

    redeclare function extends isothermalCompressibility
      "Return the isothermal compressibility kappa"
    algorithm
      kappa := kappa_const;
    end isothermalCompressibility;

    redeclare function extends isobaricExpansionCoefficient
      "Return the isobaric expansion coefficient"
    algorithm
      beta := beta_const;
    end isobaricExpansionCoefficient;

    redeclare function extends density_derp_h
      "Return density derivative w.r.t. pressure at const specific enthalpy"
    algorithm
      ddph := if constantJacobian then kappa_const*reference_d + (beta_const*(1
         - reference_T*beta_const))/cp_const else kappa_const*density(state) +
        (beta_const*(1 - temperature(state)*beta_const))/cp_const;
    end density_derp_h;

    redeclare function extends density_derh_p
      "Return density derivative w.r.t. specific enthalpy at constant pressure"
    algorithm
      ddhp := if constantJacobian then -beta_const*reference_d/cp_const else -
        beta_const*density(state)/cp_const;
    end density_derh_p;

    redeclare function extends density_derp_T
      "Return density derivative w.r.t. pressure at const temperature"
    algorithm
      ddpT := if constantJacobian then kappa_const*reference_d else kappa_const
        *density(state);
    end density_derp_T;

    redeclare function extends density_derT_p
      "Return density derivative w.r.t. temperature at constant pressure"
    algorithm
      ddTp := if constantJacobian then -beta_const*reference_d else -beta_const
        *density(state);
    end density_derT_p;

    redeclare function extends density_derX
      "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
    algorithm
      dddX := fill(0, nX);
    end density_derX;

    redeclare function extends molarMass "Return molar mass"
    algorithm
      MM := MM_const;
    end molarMass;

    function T_ph "Return temperature from pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input SpecificEnthalpy h "Specific enthalpy";
      input AbsolutePressure p "Pressure";
      output Temperature T "Temperature";
    algorithm
      T := (h - reference_h - (p - reference_p)*((1 - beta_const*reference_T)/
        reference_d))/cp_const + reference_T;
    end T_ph;

    function T_ps "Return temperature from pressure and specific entropy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Temperature T "Temperature";
    algorithm
      T := reference_T*cp_const/(s - reference_s - (p - reference_p)*(-
        beta_const/reference_d) - cp_const);
    end T_ps;

    annotation (Documentation(info="<html>
<h4>Linear Compressibility Fluid Model</h4>
<p>This linear compressibility fluid model is based on the assumptions that:
</p>
<ul>
  <li>The specific heat capacity at constant pressure (cp) is constant</li>
  <li>The isobaric expansion coefficient (beta) is constant</li>
  <li>The isothermal compressibility (kappa) is constant</li>
  <li>Pressure and temperature are used as states</li>
  <li>The influence of density on specific enthalpy (h), entropy (s), inner energy (u) and heat capacity (cv) at constant volume is neglected.</li>
</ul>
<p>
That means that the density is a linear function in temperature and in pressure.
In order to define the complete model, a number of constant reference values are needed which
are computed at the reference values of the states pressure p and temperature T. The model can
be interpreted as a linearization of a full non-linear fluid model (but it is not linear in all
thermodynamic coordinates). Reference values are needed for
</p>
<ol>
  <li>the density (reference_d),</li>
  <li>the specific enthalpy (reference_h),</li>
  <li>the specific entropy (reference_s).</li>
</ol>
<p>
Apart from that, a user needs to define the molar mass, MM_const.
Note that it is possible to define a fluid by computing the reference
values from a full non-linear fluid model by computing the package constants
using the standard functions defined in a fluid package (see example in liquids package).
</p>
<p>
In order to avoid numerical inversion of the temperature in the T_ph and T_ps functions, the density
is always taken to be the reference density in the computation of h, s, u and cv. For liquids (and this
model is intended only for liquids) the relative error of doing so is 1e-3 to 1e-4 at most. The model would
be more \"correct\" based on the other assumptions, if occurrences of reference_d in the computations of h,s,u
and cv would be replaced by a call to density(state). That would require a numerical solution for T_ps, while T_ph can be solved symbolically from a quadratic function. Errors from this approximation are small because liquid density varies little.</p>
<h4>Efficiency considerations</h4>
<p>One of the main reasons to use a simple, linear fluid model is to achieve high performance
in simulations. There are a number of possible compromises and possibilities to improve performance.
Some of them can be influenced by a flag. The following rules where used in this model:</p>
<ul>
  <li>
    All forward evaluations (using the ThermodynamicState record as input) are exactly
    following the assumptions above.
  </li>
  <li>
    If the flag <strong>constantJacobian</strong> is set to true in the package, all
    functions that typically appear in thermodynamic Jacobians (specificHeatCapacityCv,
    density_derp_h, density_derh_p, density_derp_T, density_derT_p) are evaluated at
    reference conditions (that means using the reference density) instead of the
    density of the current pressure and temperature. This makes it possible to evaluate
    the thermodynamic Jacobian at compile time.
  </li>
  <li>
    For inverse functions using other inputs than the states (e.g pressure p and specific 
    enthalpy h), the inversion is using the reference state whenever that is necessary to 
    achieve a symbolic inversion.
  </li>
  <li>
    If <strong>constantJacobian</strong> is set to false, the above list of functions is 
    computed exactly according to the above list of assumptions.
  </li>
</ul>
<dl>
<dt><strong>Authors:</strong></dt>
<dd>Francesco Casella<br>
    Dipartimento di Elettronica e Informazione<br>
    Politecnico di Milano<br>
    Via Ponzio 34/5<br>
    I-20133 Milano, Italy<br>
    email: <a href=\"mailto:casella@elet.polimi.it\">casella@elet.polimi.it</a><br>
    and<br>
    Hubertus Tummescheit<br>
    Modelon AB<br>
    Ideon Science Park<br>
    SE-22730 Lund, Sweden<br>
    email: <a href=\"mailto:Hubertus.Tummescheit@Modelon.se\">Hubertus.Tummescheit@Modelon.se</a>
</dd>
</dl>
</html>"));
  end PartialLinearFluid;

  partial package PartialMixtureMedium
    "Base class for pure substances of several chemical substances"
    extends PartialMedium(redeclare replaceable record FluidConstants =
          ThermofluidStream.Media.myMedia.Interfaces.Types.IdealGas.FluidConstants);

    redeclare replaceable record extends ThermodynamicState
      "Thermodynamic state variables"
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
      MassFraction[nX] X(start=reference_X)
        "Mass fractions (= (component mass)/total mass m_i/m)";
    end ThermodynamicState;

    redeclare replaceable function massFraction "Return independent mass Fraction"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction Xi[nXi] "(independent) Mass Fraction";
    algorithm
      Xi := state.X[1:nXi];
    end massFraction;

    constant FluidConstants[nS] fluidConstants "Constant data for the fluid";

    replaceable function gasConstant
      "Return the gas constant of the mixture (also for liquids)"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state";
      output SI.SpecificHeatCapacity R_s "Mixture gas constant";
    end gasConstant;

    function moleToMassFractions "Return mass fractions X from mole fractions"
      extends Modelica.Icons.Function;
      input SI.MoleFraction moleFractions[:] "Mole fractions of mixture";
      input MolarMass[:] MMX "Molar masses of components";
      output SI.MassFraction X[size(moleFractions, 1)]
        "Mass fractions of gas mixture";
    protected
      MolarMass Mmix=moleFractions*MMX "Molar mass of mixture";
    algorithm
      for i in 1:size(moleFractions, 1) loop
        X[i] := moleFractions[i]*MMX[i]/Mmix;
      end for;
      annotation (smoothOrder=5);
    end moleToMassFractions;

    function massToMoleFractions "Return mole fractions from mass fractions X"
      extends Modelica.Icons.Function;
      input SI.MassFraction X[:] "Mass fractions of mixture";
      input SI.MolarMass[:] MMX "Molar masses of components";
      output SI.MoleFraction moleFractions[size(X, 1)]
        "Mole fractions of gas mixture";
    protected
      Real invMMX[size(X, 1)] "Inverses of molar weights";
      SI.MolarMass Mmix "Molar mass of mixture";
    algorithm
      for i in 1:size(X, 1) loop
        invMMX[i] := 1/MMX[i];
      end for;
      Mmix := 1/(X*invMMX);
      for i in 1:size(X, 1) loop
        moleFractions[i] := Mmix*X[i]/MMX[i];
      end for;
      annotation (smoothOrder=5);
    end massToMoleFractions;

  end PartialMixtureMedium;

  partial package PartialCondensingGases
    "Base class for mixtures of condensing and non-condensing gases"
    extends PartialMixtureMedium(ThermoStates=ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.pTX);

    replaceable partial function saturationPressure
      "Return saturation pressure of condensing fluid"
      extends Modelica.Icons.Function;
      input Temperature Tsat "Saturation temperature";
      output AbsolutePressure psat "Saturation pressure";
    end saturationPressure;

    replaceable partial function enthalpyOfVaporization
      "Return vaporization enthalpy of condensing fluid"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SpecificEnthalpy r0 "Vaporization enthalpy";
    end enthalpyOfVaporization;

    replaceable partial function enthalpyOfLiquid
      "Return liquid enthalpy of condensing fluid"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SpecificEnthalpy h "Liquid enthalpy";
    end enthalpyOfLiquid;

    replaceable partial function enthalpyOfGas
      "Return enthalpy of non-condensing gas mixture"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      input MassFraction[:] X "Vector of mass fractions";
      output SpecificEnthalpy h "Specific enthalpy";
    end enthalpyOfGas;

    replaceable partial function enthalpyOfCondensingGas
      "Return enthalpy of condensing gas (most often steam)"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SpecificEnthalpy h "Specific enthalpy";
    end enthalpyOfCondensingGas;

    replaceable partial function enthalpyOfNonCondensingGas
      "Return enthalpy of the non-condensing species"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SpecificEnthalpy h "Specific enthalpy";
    end enthalpyOfNonCondensingGas;
  end PartialCondensingGases;

  partial package PartialRealCondensingGases
    "Base class for mixtures of real condensing and non-condensing gases"
    extends ThermofluidStream.Media.myMedia.Interfaces.PartialMixtureMedium(
        redeclare replaceable record FluidConstants =
          ThermofluidStream.Media.myMedia.Interfaces.Types.TwoPhase.FluidConstants);

    replaceable partial function saturationPressure
      "Return saturation pressure of condensing fluid"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output AbsolutePressure psat "Saturation pressure";
    end saturationPressure;

    replaceable partial function saturationTemperature
      "Return saturation temperature of condensing fluid"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output Temperature Tsat "Saturation temperature";
    end saturationTemperature;

    replaceable partial function massFractionSaturation
      "Return saturation mass fractions"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction[:] Xsat "Saturation mass fractions";
    end massFractionSaturation;

    replaceable partial function massFraction_pTphi
      "Return mass fractions as a function of pressure, temperature and relative humidity"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input Real phi "Relative humidity";
      output MassFraction[:] X "Mass fractions";
    end massFraction_pTphi;

    replaceable partial function relativeHumidity "Return relative humidity"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output Real phi "Relative humidity";
    end relativeHumidity;

    replaceable partial function enthalpyOfVaporization
      "Return vaporization enthalpy of condensing fluid"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnthalpy r0 "Vaporization enthalpy";
    end enthalpyOfVaporization;

    replaceable partial function enthalpyOfLiquid
      "Return liquid enthalpy of condensing fluid"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnthalpy h "Liquid enthalpy";
    end enthalpyOfLiquid;

    replaceable partial function enthalpyOfGas
      "Return enthalpy of non-condensing gas mixture"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnthalpy h "Specific enthalpy";
    end enthalpyOfGas;

    replaceable partial function enthalpyOfCondensingGas
      "Return enthalpy of condensing gas (most often steam)"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnthalpy h "Specific enthalpy";
    end enthalpyOfCondensingGas;

    replaceable partial function enthalpyOfNonCondensingGas
      "Return enthalpy of the non-condensing species"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnthalpy h "Specific enthalpy";
    end enthalpyOfNonCondensingGas;

    replaceable partial function specificEntropy_phX
      "Return specific entropy as a function of pressure, specific enthalpy and mass fractions"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output SpecificEntropy s "Specific entropy";
    algorithm
      s := specificEntropy(setState_phX(
              p,
              h,
              X));
    end specificEntropy_phX;

  end PartialRealCondensingGases;

  partial package PartialTwoPhaseMedium
    "Base class for two phase medium of one substance"
    extends PartialPureSubstance(redeclare replaceable record FluidConstants =
          ThermofluidStream.Media.myMedia.Interfaces.Types.TwoPhase.FluidConstants);
    constant Boolean smoothModel=false
      "True if the (derived) model should not generate state events";
    constant Boolean onePhase=false
      "True if the (derived) model should never be called with two-phase inputs";

    constant FluidConstants[nS] fluidConstants "Constant data for the fluid";

    redeclare replaceable record extends ThermodynamicState
      "Thermodynamic state of two phase medium"
      FixedPhase phase(min=0, max=2)
        "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use";
    end ThermodynamicState;

    redeclare replaceable partial model extends BaseProperties
      "Base properties (p, d, T, h, u, R_s, MM, sat) of two phase medium"
      SaturationProperties sat "Saturation properties at the medium pressure";
    end BaseProperties;

    replaceable partial function setDewState
      "Return the thermodynamic state on the dew line"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation point";
      input FixedPhase phase(
        min=1,
        max=2) = 1 "Phase: default is one phase";
      output ThermodynamicState state "Complete thermodynamic state info";
    end setDewState;

    replaceable partial function setBubbleState
      "Return the thermodynamic state on the bubble line"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation point";
      input FixedPhase phase(
        min=1,
        max=2) = 1 "Phase: default is one phase";
      output ThermodynamicState state "Complete thermodynamic state info";
    end setBubbleState;

    redeclare replaceable partial function extends setState_dTX
      "Return thermodynamic state as function of d, T and composition X or Xi"
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
    end setState_dTX;

    redeclare replaceable partial function extends setState_phX
      "Return thermodynamic state as function of p, h and composition X or Xi"
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
    end setState_phX;

    redeclare replaceable partial function extends setState_psX
      "Return thermodynamic state as function of p, s and composition X or Xi"
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
    end setState_psX;

    redeclare replaceable partial function extends setState_pTX
      "Return thermodynamic state as function of p, T and composition X or Xi"
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
    end setState_pTX;

    replaceable function setSat_T
      "Return saturation property record from temperature"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SaturationProperties sat "Saturation property record";
    algorithm
      sat.Tsat := T;
      sat.psat := saturationPressure(T);
    end setSat_T;

    replaceable function setSat_p
      "Return saturation property record from pressure"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      output SaturationProperties sat "Saturation property record";
    algorithm
      sat.psat := p;
      sat.Tsat := saturationTemperature(p);
    end setSat_p;

    replaceable partial function bubbleEnthalpy
      "Return bubble point specific enthalpy"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output SI.SpecificEnthalpy hl "Boiling curve specific enthalpy";
    end bubbleEnthalpy;

    replaceable partial function dewEnthalpy
      "Return dew point specific enthalpy"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output SI.SpecificEnthalpy hv "Dew curve specific enthalpy";
    end dewEnthalpy;

    replaceable partial function bubbleEntropy
      "Return bubble point specific entropy"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output SI.SpecificEntropy sl "Boiling curve specific entropy";
    end bubbleEntropy;

    replaceable partial function dewEntropy "Return dew point specific entropy"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output SI.SpecificEntropy sv "Dew curve specific entropy";
    end dewEntropy;

    replaceable partial function bubbleDensity "Return bubble point density"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output Density dl "Boiling curve density";
    end bubbleDensity;

    replaceable partial function dewDensity "Return dew point density"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output Density dv "Dew curve density";
    end dewDensity;

    replaceable partial function saturationPressure
      "Return saturation pressure"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output AbsolutePressure p "Saturation pressure";
    end saturationPressure;

    replaceable partial function saturationTemperature
      "Return saturation temperature"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      output Temperature T "Saturation temperature";
    end saturationTemperature;

    replaceable function saturationPressure_sat "Return saturation pressure"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output AbsolutePressure p "Saturation pressure";
    algorithm
      p := sat.psat;
    end saturationPressure_sat;

    replaceable function saturationTemperature_sat
      "Return saturation temperature"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output Temperature T "Saturation temperature";
    algorithm
      T := sat.Tsat;
    end saturationTemperature_sat;

    replaceable partial function saturationTemperature_derp
      "Return derivative of saturation temperature w.r.t. pressure"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      output DerTemperatureByPressure dTp
        "Derivative of saturation temperature w.r.t. pressure";
    end saturationTemperature_derp;

    replaceable function saturationTemperature_derp_sat
      "Return derivative of saturation temperature w.r.t. pressure"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output DerTemperatureByPressure dTp
        "Derivative of saturation temperature w.r.t. pressure";
    algorithm
      dTp := saturationTemperature_derp(sat.psat);
    end saturationTemperature_derp_sat;

    replaceable partial function surfaceTension
      "Return surface tension sigma in the two phase region"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output SurfaceTension sigma
        "Surface tension sigma in the two phase region";
    end surfaceTension;

    redeclare replaceable function extends molarMass
      "Return the molar mass of the medium"
    algorithm
      MM := fluidConstants[1].molarMass;
    end molarMass;

    replaceable partial function dBubbleDensity_dPressure
      "Return bubble point density derivative"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output DerDensityByPressure ddldp "Boiling curve density derivative";
    end dBubbleDensity_dPressure;

    replaceable partial function dDewDensity_dPressure
      "Return dew point density derivative"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output DerDensityByPressure ddvdp "Saturated steam density derivative";
    end dDewDensity_dPressure;

    replaceable partial function dBubbleEnthalpy_dPressure
      "Return bubble point specific enthalpy derivative"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output DerEnthalpyByPressure dhldp
        "Boiling curve specific enthalpy derivative";
    end dBubbleEnthalpy_dPressure;

    replaceable partial function dDewEnthalpy_dPressure
      "Return dew point specific enthalpy derivative"
      extends Modelica.Icons.Function;

      input SaturationProperties sat "Saturation property record";
      output DerEnthalpyByPressure dhvdp
        "Saturated steam specific enthalpy derivative";
    end dDewEnthalpy_dPressure;

    redeclare replaceable function specificEnthalpy_pTX
      "Return specific enthalpy from pressure, temperature and mass fraction"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "Specific enthalpy at p, T, X";
    algorithm
      h := specificEnthalpy(setState_pTX(
              p,
              T,
              X,
              phase));
    end specificEnthalpy_pTX;

    redeclare replaceable function temperature_phX
      "Return temperature from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:] "Mass fractions";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";
    algorithm
      T := temperature(setState_phX(
              p,
              h,
              X,
              phase));
    end temperature_phX;

    redeclare replaceable function density_phX
      "Return density from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:] "Mass fractions";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density(setState_phX(
              p,
              h,
              X,
              phase));
    end density_phX;

    redeclare replaceable function temperature_psX
      "Return temperature from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";
    algorithm
      T := temperature(setState_psX(
              p,
              s,
              X,
              phase));
    end temperature_psX;

    redeclare replaceable function density_psX
      "Return density from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density(setState_psX(
              p,
              s,
              X,
              phase));
    end density_psX;

    redeclare replaceable function specificEnthalpy_psX
      "Return specific enthalpy from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_psX(
              p,
              s,
              X,
              phase));
    end specificEnthalpy_psX;

    redeclare replaceable function setState_pT
      "Return thermodynamic state from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_pTX(
              p,
              T,
              fill(0, 0),
              phase);
    end setState_pT;

    redeclare replaceable function setState_ph
      "Return thermodynamic state from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_phX(
              p,
              h,
              fill(0, 0),
              phase);
    end setState_ph;

    redeclare replaceable function setState_ps
      "Return thermodynamic state from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_psX(
              p,
              s,
              fill(0, 0),
              phase);
    end setState_ps;

    redeclare replaceable function setState_dT
      "Return thermodynamic state from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_dTX(
              d,
              T,
              fill(0, 0),
              phase);
    end setState_dT;

    replaceable function setState_px
      "Return thermodynamic state from pressure and vapour quality"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input MassFraction x "Vapour quality";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_ph(
              p,
              (1 - x)*bubbleEnthalpy(setSat_p(p)) + x*dewEnthalpy(setSat_p(p)),
              2);
    end setState_px;

    replaceable function setState_Tx
      "Return thermodynamic state from temperature and vapour quality"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      input MassFraction x "Vapour quality";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_ph(
              saturationPressure_sat(setSat_T(T)),
              (1 - x)*bubbleEnthalpy(setSat_T(T)) + x*dewEnthalpy(setSat_T(T)),
              2);
    end setState_Tx;

    replaceable function vapourQuality "Return vapour quality"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction x "Vapour quality";
    protected
      constant SpecificEnthalpy eps=1e-8;
    algorithm
      x := min(max((specificEnthalpy(state) - bubbleEnthalpy(setSat_p(pressure(
        state))))/(dewEnthalpy(setSat_p(pressure(state))) - bubbleEnthalpy(
        setSat_p(pressure(state))) + eps), 0), 1);
    end vapourQuality;

    redeclare replaceable function density_ph "Return density from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density_phX(
              p,
              h,
              fill(0, 0),
              phase);
    end density_ph;

    redeclare replaceable function temperature_ph
      "Return temperature from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";
    algorithm
      T := temperature_phX(
              p,
              h,
              fill(0, 0),
              phase);
    end temperature_ph;

    redeclare replaceable function pressure_dT "Return pressure from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output AbsolutePressure p "Pressure";
    algorithm
      p := pressure(setState_dTX(
              d,
              T,
              fill(0, 0),
              phase));
    end pressure_dT;

    redeclare replaceable function specificEnthalpy_dT
      "Return specific enthalpy from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_dTX(
              d,
              T,
              fill(0, 0),
              phase));
    end specificEnthalpy_dT;

    redeclare replaceable function specificEnthalpy_ps
      "Return specific enthalpy from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy_psX(
              p,
              s,
              fill(0, 0));
    end specificEnthalpy_ps;

    redeclare replaceable function temperature_ps
      "Return temperature from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";
    algorithm
      T := temperature_psX(
              p,
              s,
              fill(0, 0),
              phase);
    end temperature_ps;

    redeclare replaceable function density_ps "Return density from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density_psX(
              p,
              s,
              fill(0, 0),
              phase);
    end density_ps;

    redeclare replaceable function specificEnthalpy_pT
      "Return specific enthalpy from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy_pTX(
              p,
              T,
              fill(0, 0),
              phase);
    end specificEnthalpy_pT;

    redeclare replaceable function density_pT "Return density from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density(setState_pTX(
              p,
              T,
              fill(0, 0),
              phase));
    end density_pT;
  end PartialTwoPhaseMedium;

  partial package PartialSimpleMedium
    "Medium model with linear dependency of u, h from temperature. All other quantities, especially density, are constant."

    extends Interfaces.PartialPureSubstance(final ThermoStates=
          ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.pT,
        final singleState=true);

    constant SpecificHeatCapacity cp_const
      "Constant specific heat capacity at constant pressure";
    constant SpecificHeatCapacity cv_const
      "Constant specific heat capacity at constant volume";
    constant Density d_const "Constant density";
    constant DynamicViscosity eta_const "Constant dynamic viscosity";
    constant ThermalConductivity lambda_const "Constant thermal conductivity";
    constant VelocityOfSound a_const "Constant velocity of sound";
    constant Temperature T_min "Minimum temperature valid for medium model";
    constant Temperature T_max "Maximum temperature valid for medium model";
    constant Temperature T0=reference_T "Zero enthalpy temperature";
    constant MolarMass MM_const "Molar mass";

    constant FluidConstants[nS] fluidConstants "Fluid constants";

    redeclare record extends ThermodynamicState "Thermodynamic state"
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
    end ThermodynamicState;

    redeclare replaceable model extends BaseProperties(T(stateSelect=if
            preferredMediumStates then StateSelect.prefer else StateSelect.default),
        p(stateSelect=if preferredMediumStates then StateSelect.prefer else
            StateSelect.default)) "Base properties"
    equation
      assert(T >= T_min and T <= T_max, "
Temperature T (= " + String(T) + " K) is not
in the allowed range (" + String(T_min) + " K <= T <= " + String(T_max) + " K)
required from medium model \"" + mediumName + "\".
");

      // h = cp_const*(T-T0);
      h = specificEnthalpy_pTX(
              p,
              T,
              X);
      u = cv_const*(T - T0);
      d = d_const;
      R_s = 0;
      MM = MM_const;
      state.T = T;
      state.p = p;
      annotation (Documentation(info="<html>
<p>
This is the most simple incompressible medium model, where
specific enthalpy h and specific internal energy u are only
a function of temperature T and all other provided medium
quantities are assumed to be constant.
Note that the (small) influence of the pressure term p/d is neglected.
</p>
</html>"));
    end BaseProperties;

    redeclare function setState_pTX
      "Return thermodynamic state from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p, T=T);
    end setState_pTX;

    redeclare function setState_phX
      "Return thermodynamic state from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p, T=T0 + h/cp_const);
    end setState_phX;

    redeclare replaceable function setState_psX
      "Return thermodynamic state from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p, T=Modelica.Math.exp(s/cp_const +
        Modelica.Math.log(reference_T)))
        "Here the incompressible limit is used, with cp as heat capacity";
    end setState_psX;

    redeclare function setState_dTX
      "Return thermodynamic state from d, T, and X or Xi"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      assert(false,
        "Pressure can not be computed from temperature and density for an incompressible fluid!");
    end setState_dTX;

    redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
    algorithm
      state := ThermodynamicState(p=myMedia.Common.smoothStep(
            x,
            state_a.p,
            state_b.p,
            x_small), T=myMedia.Common.smoothStep(
            x,
            state_a.T,
            state_b.T,
            x_small));
    end setSmoothState;

    redeclare function extends dynamicViscosity "Return dynamic viscosity"

    algorithm
      eta := eta_const;
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Return thermal conductivity"

    algorithm
      lambda := lambda_const;
    end thermalConductivity;

    redeclare function extends pressure "Return pressure"

    algorithm
      p := state.p;
    end pressure;

    redeclare function extends temperature "Return temperature"

    algorithm
      T := state.T;
    end temperature;

    redeclare function extends density "Return density"

    algorithm
      d := d_const;
    end density;

    redeclare function extends specificEnthalpy "Return specific enthalpy"

    algorithm
      h := cp_const*(state.T - T0);
    end specificEnthalpy;

    redeclare function extends specificHeatCapacityCp
      "Return specific heat capacity at constant pressure"

    algorithm
      cp := cp_const;
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "Return specific heat capacity at constant volume"

    algorithm
      cv := cv_const;
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent "Return isentropic exponent"

    algorithm
      gamma := cp_const/cv_const;
    end isentropicExponent;

    redeclare function extends velocityOfSound "Return velocity of sound"

    algorithm
      a := a_const;
    end velocityOfSound;

    redeclare function specificEnthalpy_pTX
      "Return specific enthalpy from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[nX] "Mass fractions";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := cp_const*(T - T0);
      annotation (Documentation(info="<html>
<p>
This function computes the specific enthalpy of the fluid, but neglects the (small) influence of the pressure term p/d.
</p>
</html>"));
    end specificEnthalpy_pTX;

    redeclare function temperature_phX
      "Return temperature from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[nX] "Mass fractions";
      output Temperature T "Temperature";
    algorithm
      T := T0 + h/cp_const;
    end temperature_phX;

    redeclare function density_phX "Return density from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[nX] "Mass fractions";
      output Density d "Density";
    algorithm
      d := density(setState_phX(
              p,
              h,
              X));
    end density_phX;

    redeclare function extends specificInternalEnergy
      "Return specific internal energy"
      extends Modelica.Icons.Function;
    algorithm
      //  u := cv_const*(state.T - T0) - reference_p/d_const;
      u := cv_const*(state.T - T0);
      annotation (Documentation(info="<html>
<p>
This function computes the specific internal energy of the fluid, but neglects the (small) influence of the pressure term p/d.
</p>
</html>"));
    end specificInternalEnergy;

    redeclare function extends specificEntropy "Return specific entropy"
      extends Modelica.Icons.Function;
    algorithm
      s := cv_const*Modelica.Math.log(state.T/T0);
    end specificEntropy;

    redeclare function extends specificGibbsEnergy
      "Return specific Gibbs energy"
      extends Modelica.Icons.Function;
    algorithm
      g := specificEnthalpy(state) - state.T*specificEntropy(state);
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy
      "Return specific Helmholtz energy"
      extends Modelica.Icons.Function;
    algorithm
      f := specificInternalEnergy(state) - state.T*specificEntropy(state);
    end specificHelmholtzEnergy;

    redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"
    algorithm
      h_is := cp_const*(temperature(refState) - T0);
    end isentropicEnthalpy;

    redeclare function extends isobaricExpansionCoefficient
      "Returns overall the isobaric expansion coefficient beta"
    algorithm
      beta := 0.0;
    end isobaricExpansionCoefficient;

    redeclare function extends isothermalCompressibility
      "Returns overall the isothermal compressibility factor"
    algorithm
      kappa := 0;
    end isothermalCompressibility;

    redeclare function extends density_derp_T
      "Returns the partial derivative of density with respect to pressure at constant temperature"
    algorithm
      ddpT := 0;
    end density_derp_T;

    redeclare function extends density_derp_h
      "Returns the partial derivative of density with respect to pressure at constant specific enthalpy"
    algorithm
      ddph := 0;
    end density_derp_h;

    redeclare function extends density_derT_p
      "Returns the partial derivative of density with respect to temperature at constant pressure"
    algorithm
      ddTp := 0;
    end density_derT_p;

    redeclare function extends density_derX
      "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
    algorithm
      dddX := fill(0, nX);
    end density_derX;

    redeclare function extends molarMass "Return the molar mass of the medium"
    algorithm
      MM := MM_const;
    end molarMass;
  end PartialSimpleMedium;

  partial package PartialSimpleIdealGasMedium
    "Medium model of Ideal gas with constant cp and cv. All other quantities, e.g., transport properties, are constant."

    extends Interfaces.PartialPureSubstance(
      redeclare replaceable record FluidConstants =
          ThermofluidStream.Media.myMedia.Interfaces.Types.Basic.FluidConstants,
      ThermoStates=ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.pT,
      final singleState=false);

    constant SpecificHeatCapacity cp_const
      "Constant specific heat capacity at constant pressure";
    constant SpecificHeatCapacity cv_const=cp_const - R_gas
      "Constant specific heat capacity at constant volume";
    constant SpecificHeatCapacity R_gas "Medium specific gas constant";
    constant MolarMass MM_const "Molar mass";
    constant DynamicViscosity eta_const "Constant dynamic viscosity";
    constant ThermalConductivity lambda_const "Constant thermal conductivity";
    constant Temperature T_min "Minimum temperature valid for medium model";
    constant Temperature T_max "Maximum temperature valid for medium model";
    constant Temperature T0=reference_T "Zero enthalpy temperature";
    constant FluidConstants[nS] fluidConstants "Fluid constants";

    redeclare record extends ThermodynamicState
      "Thermodynamic state of ideal gas"
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
    end ThermodynamicState;

    redeclare replaceable model extends BaseProperties(T(stateSelect=if
            preferredMediumStates then StateSelect.prefer else StateSelect.default),
        p(stateSelect=if preferredMediumStates then StateSelect.prefer else
            StateSelect.default)) "Base properties of ideal gas"
    equation
      assert(T >= T_min and T <= T_max, "
Temperature T (= " + String(T) + " K) is not
in the allowed range (" + String(T_min) + " K <= T <= " + String(T_max) + " K)
required from medium model \"" + mediumName + "\".
");   h = specificEnthalpy_pTX(
              p,
              T,
              X);
      u = h - R_s*T;
      R_s = R_gas;
      d = p/(R_s*T);
      MM = MM_const;
      state.T = T;
      state.p = p;
      annotation (Documentation(info="<html>
<p>
This is the most simple incompressible medium model, where
specific enthalpy h and specific internal energy u are only
a function of temperature T and all other provided medium
quantities are assumed to be constant.
</p>
</html>"));
    end BaseProperties;

    redeclare function setState_pTX
      "Return thermodynamic state from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p, T=T);
    end setState_pTX;

    redeclare function setState_phX
      "Return thermodynamic state from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p, T=T0 + h/cp_const);
    end setState_phX;

    redeclare replaceable function setState_psX
      "Return thermodynamic state from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p, T=Modelica.Math.exp(s/cp_const +
        Modelica.Math.log(reference_T) + R_gas*Modelica.Math.log(p/reference_p)));
    end setState_psX;

    redeclare function setState_dTX
      "Return thermodynamic state from d, T, and X or Xi"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=d*R_gas*T, T=T);
    end setState_dTX;

    redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
    algorithm
      state := ThermodynamicState(p=myMedia.Common.smoothStep(
            x,
            state_a.p,
            state_b.p,
            x_small), T=myMedia.Common.smoothStep(
            x,
            state_a.T,
            state_b.T,
            x_small));
    end setSmoothState;

    redeclare function extends pressure "Return pressure of ideal gas"

    algorithm
      p := state.p;
    end pressure;

    redeclare function extends temperature "Return temperature of ideal gas"

    algorithm
      T := state.T;
    end temperature;

    redeclare function extends density "Return density of ideal gas"
    algorithm
      d := state.p/(R_gas*state.T);
    end density;

    redeclare function extends specificEnthalpy "Return specific enthalpy"
      extends Modelica.Icons.Function;
    algorithm
      h := cp_const*(state.T - T0);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy
      "Return specific internal energy"
      extends Modelica.Icons.Function;
    algorithm
      u := cp_const*(state.T - T0) - R_gas*state.T;
    end specificInternalEnergy;

    redeclare function extends specificEntropy "Return specific entropy"
      extends Modelica.Icons.Function;
    algorithm
      s := cp_const*Modelica.Math.log(state.T/T0) - R_gas*Modelica.Math.log(
        state.p/reference_p);
    end specificEntropy;

    redeclare function extends specificGibbsEnergy
      "Return specific Gibbs energy"
      extends Modelica.Icons.Function;
    algorithm
      g := cp_const*(state.T - T0) - state.T*specificEntropy(state);
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy
      "Return specific Helmholtz energy"
      extends Modelica.Icons.Function;
    algorithm
      f := specificInternalEnergy(state) - state.T*specificEntropy(state);
    end specificHelmholtzEnergy;

    redeclare function extends dynamicViscosity "Return dynamic viscosity"

    algorithm
      eta := eta_const;
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Return thermal conductivity"

    algorithm
      lambda := lambda_const;
    end thermalConductivity;

    redeclare function extends specificHeatCapacityCp
      "Return specific heat capacity at constant pressure"

    algorithm
      cp := cp_const;
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "Return specific heat capacity at constant volume"

    algorithm
      cv := cv_const;
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent "Return isentropic exponent"

    algorithm
      gamma := cp_const/cv_const;
    end isentropicExponent;

    redeclare function extends velocityOfSound "Return velocity of sound"

    algorithm
      a := sqrt(cp_const/cv_const*R_gas*state.T);
    end velocityOfSound;

    redeclare function specificEnthalpy_pTX
      "Return specific enthalpy from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[nX] "Mass fractions";
      output SpecificEnthalpy h "Specific enthalpy at p, T, X";
    algorithm
      h := cp_const*(T - T0);
    end specificEnthalpy_pTX;

    redeclare function temperature_phX
      "Return temperature from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[nX] "Mass fractions";
      output Temperature T "Temperature";
    algorithm
      T := h/cp_const + T0;
    end temperature_phX;

    redeclare function density_phX "Return density from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[nX] "Mass fractions";
      output Density d "Density";
    algorithm
      d := density(setState_phX(
              p,
              h,
              X));
    end density_phX;

    redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"
    algorithm
      /*  s = cp_const*log(refState.T/T0) - R_gas*log(refState.p/reference_p)
          = cp_const*log(state.T/T0) - R_gas*log(p_downstream/reference_p)

        log(state.T) = log(refState.T) +
                       (R_gas/cp_const)*(log(p_downstream/reference_p) - log(refState.p/reference_p))
                     = log(refState.T) + (R_gas/cp_const)*log(p_downstream/refState.p)
                     = log(refState.T) + log( (p_downstream/refState.p)^(R_gas/cp_const) )
                     = log( refState.T*(p_downstream/refState.p)^(R_gas/cp_const) )
        state.T = refstate.T*(p_downstream/refstate.p)^(R_gas/cp_const)
    */
      h_is := cp_const*(refState.T*(p_downstream/refState.p)^(R_gas/cp_const)
         - T0);
    end isentropicEnthalpy;

    redeclare function extends isobaricExpansionCoefficient
      "Returns overall the isobaric expansion coefficient beta"
    algorithm
      /* beta = 1/v * der(v,T), with v = 1/d, at constant pressure p:
       v = R_s*T/p
       der(v,T) = R_s/p
       beta = p/(R_s*T)*R_s/p
            = 1/T
    */

      beta := 1/state.T;
    end isobaricExpansionCoefficient;

    redeclare function extends isothermalCompressibility
      "Returns overall the isothermal compressibility factor"
    algorithm
      /* kappa = - 1/v * der(v,p), with v = 1/d at constant temperature T.
       v = R_s*T/p
       der(v,T) = -R_s*T/p^2
       kappa = p/(R_s*T)*R_s*T/p^2
             = 1/p
    */
      kappa := 1/state.p;
    end isothermalCompressibility;

    redeclare function extends density_derp_T
      "Returns the partial derivative of density with respect to pressure at constant temperature"
    algorithm
      /*  d = p/(R_s*T)
        ddpT = 1/(R_s*T)
    */
      ddpT := 1/(R_gas*state.T);
    end density_derp_T;

    redeclare function extends density_derp_h
      "Returns the partial derivative of density with respect to pressure at constant enthalpy"
    algorithm
     // h = f(T) -> h=const -> T = const
      ddph := 1/(R_gas*state.T);
    end density_derp_h;

    redeclare function extends density_derT_p
      "Returns the partial derivative of density with respect to temperature at constant pressure"
    algorithm
      /*  d = p/(R_s*T)
        ddpT = -p/(R_s*T^2)
    */
      ddTp := -state.p/(R_gas*state.T*state.T);
    end density_derT_p;

    redeclare function extends density_derX
      "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
    algorithm
      dddX := fill(0, nX);
    end density_derX;

    redeclare function extends molarMass "Returns the molar mass of the medium"
    algorithm
      MM := MM_const;
    end molarMass;
  end PartialSimpleIdealGasMedium;

  package Choices "Types, constants to define menu choices"
    extends Modelica.Icons.Package;

    type IndependentVariables = enumeration(
        T "Temperature",
        pT "Pressure, Temperature",
        ph "Pressure, Specific Enthalpy",
        phX "Pressure, Specific Enthalpy, Mass Fraction",
        pTX "Pressure, Temperature, Mass Fractions",
        dTX "Density, Temperature, Mass Fractions")
      "Enumeration defining the independent variables of a medium";

    type Init = enumeration(
        NoInit "NoInit (no initialization)",
        InitialStates "InitialStates (initialize medium states)",
        SteadyState "SteadyState (initialize in steady state)",
        SteadyMass
          "SteadyMass (initialize density or pressure in steady state)")
      "Enumeration defining initialization for fluid flow" annotation (Evaluate=
         true);

    type ReferenceEnthalpy = enumeration(
        ZeroAt0K
          "The enthalpy is 0 at 0 K (default), if the enthalpy of formation is excluded",
        ZeroAt25C
          "The enthalpy is 0 at 25 degC, if the enthalpy of formation is excluded",
        UserDefined
          "The user-defined reference enthalpy is used at 293.15 K (25 degC)")
      "Enumeration defining the reference enthalpy of a medium" annotation (
        Evaluate=true);

    type ReferenceEntropy = enumeration(
        ZeroAt0K "The entropy is 0 at 0 K (default)",
        ZeroAt0C "The entropy is 0 at 0 degC",
        UserDefined
          "The user-defined reference entropy is used at 293.15 K (25 degC)")
      "Enumeration defining the reference entropy of a medium" annotation (
        Evaluate=true);

    type pd = enumeration(
        default "Default (no boundary condition for p or d)",
        p_known "p_known (pressure p is known)",
        d_known "d_known (density d is known)")
      "Enumeration defining whether p or d are known for the boundary condition"
      annotation (Evaluate=true);

    type Th = enumeration(
        default "Default (no boundary condition for T or h)",
        T_known "T_known (temperature T is known)",
        h_known "h_known (specific enthalpy h is known)")
      "Enumeration defining whether T or h are known as boundary condition"
      annotation (Evaluate=true);

    annotation (Documentation(info="<html>
<p>
Enumerations and data types for all types of fluids
</p>

<p>
Note: Reference enthalpy might have to be extended with enthalpy of formation.
</p>
</html>"));
  end Choices;

  package Types "Types to be used in fluid models"
    extends Modelica.Icons.Package;

    type AbsolutePressure = SI.AbsolutePressure (
        min=0,
        max=1.e8,
        nominal=1.e5,
        start=1.e5)
      "Type for absolute pressure with medium specific attributes";

    type Density = SI.Density (
        min=0,
        max=1.e5,
        nominal=1,
        start=1) "Type for density with medium specific attributes";
    type DynamicViscosity = SI.DynamicViscosity (
        min=0,
        max=1.e8,
        nominal=1.e-3,
        start=1.e-3)
      "Type for dynamic viscosity with medium specific attributes";
    type EnthalpyFlowRate = SI.EnthalpyFlowRate (
        nominal=1000.0,
        min=-1.0e8,
        max=1.e8) "Type for enthalpy flow rate with medium specific attributes";
    type MassFraction = Real (
        quantity="MassFraction",
        final unit="kg/kg",
        min=0,
        max=1,
        nominal=0.1) "Type for mass fraction with medium specific attributes";
    type MoleFraction = Real (
        quantity="MoleFraction",
        final unit="mol/mol",
        min=0,
        max=1,
        nominal=0.1) "Type for mole fraction with medium specific attributes";
    type MolarMass = SI.MolarMass (
        min=0.001,
        max=0.25,
        nominal=0.032) "Type for molar mass with medium specific attributes";
    type MolarVolume = SI.MolarVolume (
        min=1e-6,
        max=1.0e6,
        nominal=1.0) "Type for molar volume with medium specific attributes";
    type IsentropicExponent = SI.RatioOfSpecificHeatCapacities (
        min=1,
        max=500000,
        nominal=1.2,
        start=1.2)
      "Type for isentropic exponent with medium specific attributes";
    type SpecificEnergy = SI.SpecificEnergy (
        min=-1.0e8,
        max=1.e8,
        nominal=1.e6)
      "Type for specific energy with medium specific attributes";
    type SpecificInternalEnergy = SpecificEnergy
      "Type for specific internal energy with medium specific attributes";
    type SpecificEnthalpy = SI.SpecificEnthalpy (
        min=-1.0e10,
        max=1.e10,
        nominal=1.e6)
      "Type for specific enthalpy with medium specific attributes";
    type SpecificEntropy = SI.SpecificEntropy (
        min=-1.e7,
        max=1.e7,
        nominal=1.e3)
      "Type for specific entropy with medium specific attributes";
    type SpecificHeatCapacity = SI.SpecificHeatCapacity (
        min=0,
        max=1.e7,
        nominal=1.e3,
        start=1.e3)
      "Type for specific heat capacity with medium specific attributes";
    type SurfaceTension = SI.SurfaceTension
      "Type for surface tension with medium specific attributes";
    type Temperature = SI.Temperature (
        min=1,
        max=1.e4,
        nominal=300,
        start=288.15) "Type for temperature with medium specific attributes";
    type ThermalConductivity = SI.ThermalConductivity (
        min=0,
        max=500,
        nominal=1,
        start=1)
      "Type for thermal conductivity with medium specific attributes";
    type PrandtlNumber = SI.PrandtlNumber (
        min=1e-3,
        max=1e5,
        nominal=1.0) "Type for Prandtl number with medium specific attributes";
    type VelocityOfSound = SI.Velocity (
        min=0,
        max=1.e5,
        nominal=1000,
        start=1000)
      "Type for velocity of sound with medium specific attributes";
    type ExtraProperty = Real (min=0.0, start=1.0)
      "Type for unspecified, mass-specific property transported by flow";
    type CumulativeExtraProperty = Real (min=0.0, start=1.0)
      "Type for conserved integral of unspecified, mass specific property";
    type ExtraPropertyFlowRate = Real (unit="kg/s")
      "Type for flow rate of unspecified, mass-specific property";
    type IsobaricExpansionCoefficient = Real (
        min=0,
        max=1.0e8,
        unit="1/K")
      "Type for isobaric expansion coefficient with medium specific attributes";
    type DipoleMoment = Real (
        min=0.0,
        max=2.0,
        unit="debye",
        quantity="ElectricDipoleMoment")
      "Type for dipole moment with medium specific attributes";

    type DerDensityByPressure = SI.DerDensityByPressure
      "Type for partial derivative of density with respect to pressure with medium specific attributes";
    type DerDensityByEnthalpy = SI.DerDensityByEnthalpy
      "Type for partial derivative of density with respect to enthalpy with medium specific attributes";
    type DerEnthalpyByPressure = SI.DerEnthalpyByPressure
      "Type for partial derivative of enthalpy with respect to pressure with medium specific attributes";
    type DerDensityByTemperature = SI.DerDensityByTemperature
      "Type for partial derivative of density with respect to temperature with medium specific attributes";
    type DerTemperatureByPressure = Real (final unit="K/Pa")
      "Type for partial derivative of temperature with respect to pressure with medium specific attributes";

    replaceable record SaturationProperties
      "Saturation properties of two phase medium"
      extends Modelica.Icons.Record;
      AbsolutePressure psat "Saturation pressure";
      Temperature Tsat "Saturation temperature";
    end SaturationProperties;

    record FluidLimits "Validity limits for fluid model"
      extends Modelica.Icons.Record;
      Temperature TMIN "Minimum temperature";
      Temperature TMAX "Maximum temperature";
      Density DMIN "Minimum density";
      Density DMAX "Maximum density";
      AbsolutePressure PMIN "Minimum pressure";
      AbsolutePressure PMAX "Maximum pressure";
      SpecificEnthalpy HMIN "Minimum enthalpy";
      SpecificEnthalpy HMAX "Maximum enthalpy";
      SpecificEntropy SMIN "Minimum entropy";
      SpecificEntropy SMAX "Maximum entropy";
      annotation (Documentation(info="<html>
          <p>The minimum pressure mostly applies to the liquid state only.
          The minimum density is also arbitrary, but is reasonable for technical
          applications to limit iterations in non-linear systems. The limits in
          enthalpy and entropy are used as safeguards in inverse iterations.</p>
          </html>"));
    end FluidLimits;

    type FixedPhase = Integer (min=0, max=2)
      "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use";
    package Basic
      "The most basic version of a record used in several degrees of detail"
      extends Modelica.Icons.Package;

      record FluidConstants
        "Critical, triple, molecular and other standard data of fluid"
        extends Modelica.Icons.Record;
        String iupacName
          "Complete IUPAC name (or common name, if non-existent)";
        String casRegistryNumber
          "Chemical abstracts sequencing number (if it exists)";
        String chemicalFormula
          "Chemical formula, (brutto, nomenclature according to Hill";
        String structureFormula "Chemical structure formula";
        MolarMass molarMass "Molar mass";
      end FluidConstants;

    end Basic;

    package IdealGas
      "The ideal gas version of a record used in several degrees of detail"
      extends Modelica.Icons.Package;

      record FluidConstants "Extended fluid constants"
        extends
          ThermofluidStream.Media.myMedia.Interfaces.Types.Basic.FluidConstants;
        Temperature criticalTemperature "Critical temperature";
        AbsolutePressure criticalPressure "Critical pressure";
        MolarVolume criticalMolarVolume "Critical molar Volume";
        Real acentricFactor "Pitzer acentric factor";
        //   Temperature triplePointTemperature "Triple point temperature";
        //   AbsolutePressure triplePointPressure "Triple point pressure";
        Temperature meltingPoint "Melting point at 101325 Pa";
        Temperature normalBoilingPoint "Normal boiling point (at 101325 Pa)";
        DipoleMoment dipoleMoment
          "Dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
        Boolean hasIdealGasHeatCapacity=false
          "True if ideal gas heat capacity is available";
        Boolean hasCriticalData=false "True if critical data are known";
        Boolean hasDipoleMoment=false "True if a dipole moment known";
        Boolean hasFundamentalEquation=false "True if a fundamental equation";
        Boolean hasLiquidHeatCapacity=false
          "True if liquid heat capacity is available";
        Boolean hasSolidHeatCapacity=false
          "True if solid heat capacity is available";
        Boolean hasAccurateViscosityData=false
          "True if accurate data for a viscosity function is available";
        Boolean hasAccurateConductivityData=false
          "True if accurate data for thermal conductivity is available";
        Boolean hasVapourPressureCurve=false
          "True if vapour pressure data, e.g., Antoine coefficients are known";
        Boolean hasAcentricFactor=false
          "True if Pitzer acentric factor is known";
        SpecificEnthalpy HCRIT0=0.0
          "Critical specific enthalpy of the fundamental equation";
        SpecificEntropy SCRIT0=0.0
          "Critical specific entropy of the fundamental equation";
        SpecificEnthalpy deltah=0.0
          "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
        SpecificEntropy deltas=0.0
          "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
      end FluidConstants;
    end IdealGas;

    package TwoPhase
      "The two phase fluid version of a record used in several degrees of detail"
      extends Modelica.Icons.Package;

      record FluidConstants "Extended fluid constants"
        extends
          ThermofluidStream.Media.myMedia.Interfaces.Types.Basic.FluidConstants;
        Temperature criticalTemperature "Critical temperature";
        AbsolutePressure criticalPressure "Critical pressure";
        MolarVolume criticalMolarVolume "Critical molar Volume";
        Real acentricFactor "Pitzer acentric factor";
        Temperature triplePointTemperature "Triple point temperature";
        AbsolutePressure triplePointPressure "Triple point pressure";
        Temperature meltingPoint "Melting point at 101325 Pa";
        Temperature normalBoilingPoint "Normal boiling point (at 101325 Pa)";
        DipoleMoment dipoleMoment
          "Dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
        Boolean hasIdealGasHeatCapacity=false
          "True if ideal gas heat capacity is available";
        Boolean hasCriticalData=false "True if critical data are known";
        Boolean hasDipoleMoment=false "True if a dipole moment known";
        Boolean hasFundamentalEquation=false "True if a fundamental equation";
        Boolean hasLiquidHeatCapacity=false
          "True if liquid heat capacity is available";
        Boolean hasSolidHeatCapacity=false
          "True if solid heat capacity is available";
        Boolean hasAccurateViscosityData=false
          "True if accurate data for a viscosity function is available";
        Boolean hasAccurateConductivityData=false
          "True if accurate data for thermal conductivity is available";
        Boolean hasVapourPressureCurve=false
          "True if vapour pressure data, e.g., Antoine coefficients are known";
        Boolean hasAcentricFactor=false
          "True if Pitzer acentric factor is known";
        SpecificEnthalpy HCRIT0=0.0
          "Critical specific enthalpy of the fundamental equation";
        SpecificEntropy SCRIT0=0.0
          "Critical specific entropy of the fundamental equation";
        SpecificEnthalpy deltah=0.0
          "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
        SpecificEntropy deltas=0.0
          "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
      end FluidConstants;
    end TwoPhase;

  end Types;
  annotation (Documentation(info="<html>
<p>
This package provides basic interfaces definitions of media models for different
kind of media.
</p>
</html>"));
end Interfaces;
