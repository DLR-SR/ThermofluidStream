within ThermofluidStream.Media.myMedia.IdealGases.Common;
partial package SingleGasNasa
  "Medium model of an ideal gas based on NASA source"

  extends Interfaces.PartialPureSubstance(
     ThermoStates=ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.pT,
     redeclare final record FluidConstants =
        ThermofluidStream.Media.myMedia.Interfaces.Types.IdealGas.FluidConstants,
     mediumName=data.name,
     substanceNames={data.name},
     singleState=false,
     Temperature(min=200, max=6000, start=500, nominal=500),
     SpecificEnthalpy(start=if Functions.referenceChoice==ReferenceEnthalpy.ZeroAt0K then data.H0 else
        if Functions.referenceChoice==ReferenceEnthalpy.UserDefined then Functions.h_offset else 0, nominal=1.0e5),
     Density(start=10, nominal=10),
     AbsolutePressure(start=10e5, nominal=10e5));

  redeclare record extends ThermodynamicState
    "Thermodynamic state variables for ideal gases"
    AbsolutePressure p "Absolute pressure of medium";
    Temperature T "Temperature of medium";
  end ThermodynamicState;
  import Modelica.Math;
  import ThermofluidStream.Media.myMedia.Interfaces.Choices.ReferenceEnthalpy;

  constant IdealGases.Common.DataRecord data
    "Data record of ideal gas substance";

  constant FluidConstants[nS] fluidConstants "Constant data for the fluid";

  redeclare model extends BaseProperties(
   T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
   p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default))
    "Base properties of ideal gas medium"
  equation
    assert(T >= 200 and T <= 6000, "
Temperature T (= " + String(T) + " K) is not in the allowed range
200 K <= T <= 6000 K required from medium model \"" + mediumName + "\".
"); MM = data.MM;
    R_s = data.R_s;
    h = ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.h_T(
        data,
        T,
        ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.excludeEnthalpyOfFormation,
        ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.referenceChoice,
        ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.h_offset);
    u = h - R_s*T;

    // Has to be written in the form d=f(p,T) in order that static
    // state selection for p and T is possible
    d = p/(R_s*T);
    // connect state with BaseProperties
    state.T = T;
    state.p = p;
  end BaseProperties;

    redeclare function setState_pTX
    "Return thermodynamic state as function of p, T and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := ThermodynamicState(p=p,T=T);
      annotation(Inline=true,smoothOrder=2);
    end setState_pTX;

    redeclare function setState_phX
    "Return thermodynamic state as function of p, h and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := ThermodynamicState(p=p,T=T_h(h));
      annotation(Inline=true,smoothOrder=2);
    end setState_phX;

    redeclare function setState_psX
    "Return thermodynamic state as function of p, s and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := ThermodynamicState(p=p,T=T_ps(p,s));
      annotation(Inline=true,smoothOrder=2);
    end setState_psX;

    redeclare function setState_dTX
    "Return thermodynamic state as function of d, T and composition X"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := ThermodynamicState(p=d*data.R_s*T,T=T);
      annotation(Inline=true,smoothOrder=2);
    end setState_dTX;

      redeclare function extends setSmoothState "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
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
        annotation(Inline=true,smoothOrder=2);
      end setSmoothState;

  redeclare function extends pressure "Return pressure of ideal gas"
  algorithm
    p := state.p;
    annotation(Inline=true,smoothOrder=2);
  end pressure;

  redeclare function extends temperature "Return temperature of ideal gas"
  algorithm
    T := state.T;
    annotation(Inline=true,smoothOrder=2);
  end temperature;

  redeclare function extends density "Return density of ideal gas"
  algorithm
    d := state.p/(data.R_s*state.T);
    annotation(Inline=true,smoothOrder=2);
  end density;

  redeclare function extends specificEnthalpy "Return specific enthalpy"
    extends Modelica.Icons.Function;
  algorithm
    h := ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.h_T(data,
      state.T);
    annotation(Inline=true,smoothOrder=2);
  end specificEnthalpy;

  redeclare function extends specificInternalEnergy
    "Return specific internal energy"
    extends Modelica.Icons.Function;
  algorithm
    u := ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.h_T(data,
      state.T) - data.R_s*state.T;
    annotation(Inline=true,smoothOrder=2);
  end specificInternalEnergy;

  redeclare function extends specificEntropy "Return specific entropy"
    extends Modelica.Icons.Function;
  algorithm
    s := ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.s0_T(data,
      state.T) - data.R_s*Modelica.Math.log(state.p/reference_p);
    annotation(Inline=true,smoothOrder=2);
  end specificEntropy;

  redeclare function extends specificGibbsEnergy "Return specific Gibbs energy"
    extends Modelica.Icons.Function;
  algorithm
    g := ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.h_T(data,
      state.T) - state.T*specificEntropy(state);
    annotation(Inline=true,smoothOrder=2);
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy
    "Return specific Helmholtz energy"
    extends Modelica.Icons.Function;
  algorithm
    f := ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.h_T(data,
      state.T) - data.R_s*state.T - state.T*specificEntropy(state);
    annotation(Inline=true,smoothOrder=2);
  end specificHelmholtzEnergy;

  redeclare function extends specificHeatCapacityCp
    "Return specific heat capacity at constant pressure"
  algorithm
    cp := ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.cp_T(data,
      state.T);
    annotation(Inline=true,smoothOrder=2);
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
    "Compute specific heat capacity at constant volume from temperature and gas data"
  algorithm
    cv := ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.cp_T(data,
      state.T) - data.R_s;
    annotation(Inline=true,smoothOrder=2);
  end specificHeatCapacityCv;

  redeclare function extends isentropicExponent "Return isentropic exponent"
  algorithm
    gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(state);
    annotation(Inline=true,smoothOrder=2);
  end isentropicExponent;

  redeclare function extends velocityOfSound "Return velocity of sound"
    extends Modelica.Icons.Function;
  algorithm
    a := sqrt(max(0, data.R_s*state.T*
      ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.cp_T(data,
      state.T)/specificHeatCapacityCv(state)));
    annotation(Inline=true,smoothOrder=2);
  end velocityOfSound;

  function isentropicEnthalpyApproximation
    "Approximate method of calculating h_is from upstream properties and downstream pressure"
    extends Modelica.Icons.Function;
    input SI.Pressure p2 "Downstream pressure";
    input ThermodynamicState state "Properties at upstream location";
    input Boolean exclEnthForm=Functions.excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
    input ReferenceEnthalpy refChoice=Functions.referenceChoice
      "Choice of reference enthalpy";
    input SpecificEnthalpy h_off=Functions.h_offset
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    output SI.SpecificEnthalpy h_is "Isentropic enthalpy";
  protected
    IsentropicExponent gamma =  isentropicExponent(state) "Isentropic exponent";
  algorithm
    h_is := ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.h_T(
        data,
        state.T,
        exclEnthForm,
        refChoice,
        h_off) + gamma/(gamma - 1.0)*state.p/density(state)*((p2/state.p)^((
      gamma - 1)/gamma) - 1.0);
    annotation(Inline=true,smoothOrder=2);
  end isentropicEnthalpyApproximation;

  redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"
  input Boolean exclEnthForm=Functions.excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  input ReferenceEnthalpy refChoice=Functions.referenceChoice
      "Choice of reference enthalpy";
  input SpecificEnthalpy h_off=Functions.h_offset
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
  algorithm
    h_is := isentropicEnthalpyApproximation(p_downstream,refState,exclEnthForm,refChoice,h_off);
    annotation(Inline=true,smoothOrder=2);
  end isentropicEnthalpy;

  redeclare function extends isobaricExpansionCoefficient
    "Returns overall the isobaric expansion coefficient beta"
  algorithm
    beta := 1/state.T;
    annotation(Inline=true,smoothOrder=2);
  end isobaricExpansionCoefficient;

  redeclare function extends isothermalCompressibility
    "Returns overall the isothermal compressibility factor"
  algorithm
    kappa := 1.0/state.p;
    annotation(Inline=true,smoothOrder=2);
  end isothermalCompressibility;

  redeclare function extends density_derp_T
    "Returns the partial derivative of density with respect to pressure at constant temperature"
  algorithm
    ddpT := 1/(state.T*data.R_s);
    annotation(Inline=true,smoothOrder=2);
  end density_derp_T;

  redeclare function extends density_derT_p
    "Returns the partial derivative of density with respect to temperature at constant pressure"
  algorithm
    ddTp := -state.p/(state.T*state.T*data.R_s);
    annotation(Inline=true,smoothOrder=2);
  end density_derT_p;

  redeclare function extends density_derX
    "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
  algorithm
    dddX := fill(0,nX);
    annotation(Inline=true,smoothOrder=2);
  end density_derX;

  redeclare function extends density_derp_h
    "Returns the partial derivative of density with respect to pressure at constant enthalpy"
  algorithm
    ddph := specificHeatCapacityCp(state)/(state.T*data.R_s*data.R_s);
    annotation(Inline=true,smoothOrder=2);
  end density_derp_h;

  redeclare replaceable function extends dynamicViscosity "Dynamic viscosity"
  algorithm
    assert(fluidConstants[1].hasCriticalData,
    "Failed to compute dynamicViscosity: For the species \"" + mediumName + "\" no critical data is available.");
    assert(fluidConstants[1].hasDipoleMoment,
    "Failed to compute dynamicViscosity: For the species \"" + mediumName + "\" no critical data is available.");
    eta :=
      ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.dynamicViscosityLowPressure(
        state.T,
        fluidConstants[1].criticalTemperature,
        fluidConstants[1].molarMass,
        fluidConstants[1].criticalMolarVolume,
        fluidConstants[1].acentricFactor,
        fluidConstants[1].dipoleMoment);
    annotation (smoothOrder=2);
  end dynamicViscosity;

  redeclare replaceable function extends thermalConductivity
    "Thermal conductivity of gas"
  //  input IdealGases.Common.DataRecord data "Ideal gas data";
    input Integer method=Functions.methodForThermalConductivity
      "1: Eucken Method, 2: Modified Eucken Method";
  algorithm
    assert(fluidConstants[1].hasCriticalData,
    "Failed to compute thermalConductivity: For the species \"" + mediumName + "\" no critical data is available.");
    lambda :=
      ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.thermalConductivityEstimate(
        specificHeatCapacityCp(state),
        dynamicViscosity(state),
        method=method,
        data=data);
    annotation (smoothOrder=2);
  end thermalConductivity;

  redeclare function extends molarMass "Return the molar mass of the medium"
  algorithm
    MM := data.MM;
    annotation(Inline=true,smoothOrder=2);
  end molarMass;

  function T_h "Compute temperature from specific enthalpy"
    extends Modelica.Icons.Function;
    input SpecificEnthalpy h "Specific enthalpy";
    output Temperature T "Temperature";

  protected
    function f_nonlinear "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input DataRecord data "Ideal gas data";
      input SpecificEnthalpy h "Specific enthalpy";
    algorithm
      y := Functions.h_T(data=data, T=u) - h;
    end f_nonlinear;

  algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function f_nonlinear(data=data, h=h), 200, 6000);
  end T_h;

  function T_ps "Compute temperature from pressure and specific entropy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    output Temperature T "Temperature";

  protected
    function f_nonlinear "Solve s(data,T) for T with given s (use only indirectly via temperature_psX)"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input DataRecord data "Ideal gas data";
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
    algorithm
      y := Functions.s0_T(data=data, T=u) - data.R_s*Modelica.Math.log(p/reference_p) - s;
    end f_nonlinear;

  algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function f_nonlinear(data=data, p=p, s=s), 200, 6000);
  end T_ps;
// the functions below are not strictly necessary, there are just here for compatibility reasons

  function dynamicViscosityLowPressure
    "Dynamic viscosity of low pressure gases"
    extends Modelica.Icons.Function;
    input SI.Temperature T "Gas temperature";
    input SI.Temperature Tc "Critical temperature of gas";
    input SI.MolarMass M "Molar mass of gas";
    input SI.MolarVolume Vc "Critical molar volume of gas";
    input Real w "Acentric factor of gas";
    input ThermofluidStream.Media.myMedia.Interfaces.Types.DipoleMoment mu
      "Dipole moment of gas molecule";
    input Real k =  0.0 "Special correction for highly polar substances";
    output ThermofluidStream.Media.myMedia.Interfaces.Types.DynamicViscosity eta
      "Dynamic viscosity of gas";
  protected
    parameter Real Const1_SI=40.785*10^(-9.5)
      "Constant in formula for eta converted to SI units";
    parameter Real Const2_SI=131.3/1000.0
      "Constant in formula for mur converted to SI units";
    Real mur=Const2_SI*mu/sqrt(Vc*Tc)
      "Dimensionless dipole moment of gas molecule";
    Real Fc=1 - 0.2756*w + 0.059035*mur^4 + k
      "Factor to account for molecular shape and polarities of gas";
    Real Tstar "Dimensionless temperature defined by equation below";
    Real Ov "Viscosity collision integral for the gas";

  algorithm
    eta := Functions.dynamicViscosityLowPressure(T,Tc,M,Vc,w,mu,k);
    annotation (smoothOrder=2,
                Documentation(info="<html>
<p>
The used formula are based on the method of Chung et al (1984, 1988) referred to in ref [1] chapter 9.
The formula 9-4.10 is the one being used. The formula is given in non-SI units, the following conversion constants were used to
transform the formula to SI units:
</p>

<ul>
  <li>
    <strong>Const1_SI:</strong> The factor 10^(-9.5) =10^(-2.5)*1e-7 where the
    factor 10^(-2.5) originates from the conversion of g/mol->kg/mol + cm^3/mol->m^3/mol
    and the factor 1e-7 is due to conversion from microPoise->Pa.s.
  </li>
  <li>
    <strong>Const2_SI:</strong> The factor 1/3.335641e-27 = 1e-3/3.335641e-30
    where the factor 3.335641e-30 comes from debye->C.m and
    1e-3 is due to conversion from cm^3/mol->m^3/mol
  </li>
</ul>

<h4>References</h4>
<p>
[1] Bruce E. Poling, John E. Prausnitz, John P. O'Connell, \"The Properties of Gases and Liquids\" 5th Ed. Mc Graw Hill.
</p>

<h4>Author</h4>
<p>T. Skoglund, Lund, Sweden, 2004-08-31</p>

</html>"));
  end dynamicViscosityLowPressure;

  function thermalConductivityEstimate
    "Thermal conductivity of polyatomic gases(Eucken and Modified Eucken correlation)"
    extends Modelica.Icons.Function;
    input ThermofluidStream.Media.myMedia.Interfaces.Types.SpecificHeatCapacity
      Cp "Constant pressure heat capacity";
    input ThermofluidStream.Media.myMedia.Interfaces.Types.DynamicViscosity eta
      "Dynamic viscosity";
    input Integer method(min=1,max=2)=1
      "1: Eucken Method, 2: Modified Eucken Method";
    input IdealGases.Common.DataRecord data "Ideal gas data";
    output ThermofluidStream.Media.myMedia.Interfaces.Types.ThermalConductivity
      lambda "Thermal conductivity [W/(m.k)]";
  algorithm
    lambda := Functions.thermalConductivityEstimate(Cp,eta,method,data);
    annotation (smoothOrder=2,
                Documentation(info="<html>
<p>
This function provides two similar methods for estimating the
thermal conductivity of polyatomic gases.
The Eucken method (input method == 1) gives good results for low temperatures,
but it tends to give an underestimated value of the thermal conductivity
(lambda) at higher temperatures.<br>
The Modified Eucken method (input method == 2) gives good results for
high-temperatures, but it tends to give an overestimated value of the
thermal conductivity (lambda) at low temperatures.
</p>
</html>"));
  end thermalConductivityEstimate;
  annotation (
    Documentation(info="<html>
<p>
This model calculates medium properties
for an ideal gas of a single substance, or for an ideal
gas consisting of several substances where the
mass fractions are fixed. Independent variables
are temperature <strong>T</strong> and pressure <strong>p</strong>.
Only density is a function of T and p. All other quantities
are solely a function of T. The properties
are valid in the range:
</p>
<blockquote><pre>
200 K &le; T &le; 6000 K
</pre></blockquote>
<p>
The following quantities are always computed:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Variable</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy h = h(T)</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy u = u(T)</td></tr>
  <tr><td>d</td>
      <td>kg/m^3</td>
      <td>density d = d(p,T)</td></tr>
</table>
<p>
For the other variables, see the functions in
Modelica.Media.IdealGases.Common.SingleGasNasa.
Note, dynamic viscosity and thermal conductivity are only provided
for gases that use a data record from Modelica.Media.IdealGases.FluidData.
Currently these are the following gases:
</p>
<blockquote><pre>
Ar
C2H2_vinylidene
C2H4
C2H5OH
C2H6
C3H6_propylene
C3H7OH
C3H8
C4H8_1_butene
C4H9OH
C4H10_n_butane
C5H10_1_pentene
C5H12_n_pentane
C6H6
C6H12_1_hexene
C6H14_n_heptane
C7H14_1_heptene
C8H10_ethylbenz
CH3OH
CH4
CL2
CO
CO2
F2
H2
H2O
He
N2
N2O
NH3
NO
O2
SO2
SO3
</pre></blockquote>
<p>
<strong>Sources for model and literature:</strong><br>
Original Data: Computer program for calculation of complex chemical
equilibrium compositions and applications. Part 1: Analysis
Document ID: 19950013764 N (95N20180) File Series: NASA Technical Reports
Report Number: NASA-RP-1311  E-8017  NAS 1.61:1311
Authors: Gordon, Sanford (NASA Lewis Research Center)
 Mcbride, Bonnie J. (NASA Lewis Research Center)
Published: Oct 01, 1994.
</p>
<p><strong>Known limits of validity:</strong><br>
The data is valid for
temperatures between 200K and 6000K.  A few of the data sets for
monatomic gases have a discontinuous 1st derivative at 1000K, but
this never caused problems so far.
</p>
<p>
This model has been copied from the ThermoFluid library
and adapted to the Modelica.Media package.
</p>
</html>"));
end SingleGasNasa;
