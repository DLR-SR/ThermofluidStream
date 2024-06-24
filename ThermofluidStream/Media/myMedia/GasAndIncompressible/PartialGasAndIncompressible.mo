within ThermofluidStream.Media.myMedia.GasAndIncompressible;
partial package PartialGasAndIncompressible
  "Gas medium combined with incompressible medium, only parameters to PartialMedium 
  and selection of Gas and Liquid are incomplete. Observe that this implementation 
  only works for Gases and Liquids with one substance each."
  extends ThermofluidStream.Media.myMedia.Interfaces.PartialMedium(
    mediumName="incomplete combination of Gas and Incompressible",
    substanceNames=cat(
        1,
        Gas.substanceNames,
        Liquid.substanceNames),
        reference_X={0.0001,0.9999},
        reference_p =1e5,
        reference_T= 273.15,
        reducedX=false,
    AbsolutePressure(displayUnit="kPa"));
  replaceable package Gas =
      ThermofluidStream.Media.myMedia.Air.DryAirNasa;
  replaceable package Liquid =
      ThermofluidStream.Media.myMedia.Incompressible.Examples.JP8;
  redeclare record ThermodynamicState
    Modelica.Units.SI.AbsolutePressure p "Pressure";
    Modelica.Units.SI.Temperature T "Temperature";
    ThermofluidStream.Media.myMedia.Interfaces.Types.MassFraction[nS] X
      "MassFractions";
  end ThermodynamicState;

    redeclare replaceable model extends BaseProperties(
    T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    final standardOrderComponents=true)
    "Base properties (p, d, T, h, u, R_s, MM, X, and Xi of JP8 mixed with DryAirNasa"
       import Modelica.Math.Polynomials;

    equation
    MM = molarMass(state);
    h = h_TX(T, X);
    R_s = {Gas.data.R_s, Modelica.Constants.R/Liquid.MM_const}*X;
    u = h -reference_p/d;
    d = density_pTX(p,T,X);
    // connect state with BaseProperties
    state.T = T;
    state.p = p;
    state.X = X;
    end BaseProperties;

  redeclare function extends setState_pTX
    "set the thermodynamic state record from p, T, X"
  algorithm
    state.p := p;
    state.T := T;
    state.X := X;
    annotation (smoothOrder=5);
  end setState_pTX;

  redeclare function setState_phX
    input Modelica.Units.SI.AbsolutePressure p;
    input Modelica.Units.SI.SpecificEnthalpy h;
    input Modelica.Units.SI.MassFraction[:] X;
    output ThermodynamicState state;
  algorithm
    state := ThermodynamicState(
        p=p,
        T=T_hX(
          h,
          X),
        X=X);
    annotation (smoothOrder=2);
  end setState_phX;

 function T_hX
    input Modelica.Units.SI.SpecificEnthalpy h;
    input Modelica.Units.SI.MassFraction[:] X;
    output Modelica.Units.SI.Temperature T;
    //-------------------------------------------------
  protected
    function f_nonlinear "Solve h_TX(T,X) for T with given h"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction[nX] X "Mass fractions of composition";

    algorithm
      y := h_TX(
            T=u,
            X=X) - h;
    end f_nonlinear;

 algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(
          h=h,
          X=X),
        200,
        6000);
    //need to fix this such that it is actually the inverse of h = f(T);

    annotation (inverse(h=h_TX(
              T,
              X)));
 end T_hX;

  function h_TX
     input Modelica.Units.SI.Temperature T;
    input Modelica.Units.SI.MassFraction[:] X;
    output Modelica.Units.SI.SpecificEnthalpy h;
  algorithm
    h := X*{ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.h_T(Gas.data,T),Liquid.h_T(T)};
  end h_TX;

  redeclare function extends pressure
    "Return the pressure from the thermodynamic state"
  algorithm
    p := state.p;
  end pressure;

  redeclare function extends isentropicExponent
    "Return the isentropic exponent"
  algorithm
    gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(state);
  end isentropicExponent;

  redeclare function extends temperature
    "Return the temperature from the thermodynamicstate"
  algorithm
    T := state.T;
  end temperature;

  redeclare function extends massFraction
    "Return the massfraction from the thermodynamic state"
  algorithm
    Xi:= state.X;
  end massFraction;

  redeclare function density
    "Return the density from the thermodynamic state"
    input ThermodynamicState state;
    output Modelica.Units.SI.Density d;
    // The "{1}" in the following rows (and subsequent functions) need to be fixed to allow gases and liquids with more than one substance
  protected
     Gas.ThermodynamicState state_G = Gas.setState_pTX(state.p,state.T,{1});
    Liquid.ThermodynamicState state_L = Liquid.setState_pTX(state.p,state.T,{1});
  algorithm
   d:= 1/((max(1e-15,1-state.X[nS])*(1/Gas.density(state_G))+state.X[nS]*(1/Liquid.density(state_L))));
   //d:= spliceFunction(Liquid.density(state_L),Gas.density(state_G),state.X[nS]-0.5,0.5);
  annotation (smoothOrder=5);
  end density;
//   function d_pTX
//         input Modelica.Units.SI.AbsolutePressure p;
//     input Modelica.Units.SI.Temperature T;
//     input Modelica.Units.SI.MassFraction[:] X;
//
//        output Modelica.Units.SI.Density d;
//   protected
//          Gas.ThermodynamicState state_G = Gas.setState_pTX(p,T,{1});
//     Liquid.ThermodynamicState state_L = Liquid.setState_pTX(p,T,{1});
//
//   algorithm
//        d:= 1/((1-X[nS])*(1/Gas.density(state_G))+X[nS]*(1/Liquid.density(state_L)));
//   end d_pTX;

  function d_pT_Liquid
        input Modelica.Units.SI.AbsolutePressure p;
    input Modelica.Units.SI.Temperature T;
       output Modelica.Units.SI.Density d;
  protected
    Liquid.ThermodynamicState state_L = Liquid.setState_pTX(p,T,{1});

  algorithm
       d:= Liquid.density(state_L);
  end d_pT_Liquid;

  redeclare function specificEnthalpy
    "Return the specific enthalpy from the thermodynamic state"
    input ThermodynamicState state "thermodynamic state record";
    output Modelica.Units.SI.SpecificEnthalpy h "specific enthalpy";
  protected
    Gas.ThermodynamicState state_G = Gas.setState_pTX(state.p, state.T,{1});
    Liquid.ThermodynamicState state_L = Liquid.setState_pTX(state.p, state.T,{1});
  algorithm
    h := (1-state.X[nS])*Gas.specificEnthalpy(state_G) + state.X[nS]*Liquid.specificEnthalpy(state_L);
    annotation(smoothOrder=5);
  end specificEnthalpy;

  redeclare function extends specificEntropy
    "Return the specific entropy from the thermodynamic state, total mixing assumed"
  algorithm
    s := {Gas.specificEntropy(Gas.setState_pTX(state.p,state.T,{1})),Liquid.specificEntropy(Liquid.setState_pTX(state.p,state.T,{1}))}*state.X;

  end specificEntropy;

  redeclare function extends specificInternalEnergy
    "Return the specific internal energy from the thermodynamic state"
  algorithm
    u := specificEnthalpy(state)-state.p/density(state);
  end specificInternalEnergy;

  redeclare function extends specificGibbsEnergy
    "Return specific Gibbs energy from the thermodynamic state"
  algorithm
    g := specificEnthalpy(state) - temperature(state)*specificEntropy(state);
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy
    "Return specific Helmholtz energy from thermodynamic state"
  algorithm
    f := specificInternalEnergy(state)- temperature(state)*specificEntropy(state);
  end specificHelmholtzEnergy;

  redeclare function extends specificHeatCapacityCp
    "Return specific heat capacity at constant pressure"
  protected
    Gas.ThermodynamicState state_G = Gas.setState_pTX(state.p, state.T,{1});
    Liquid.ThermodynamicState state_L = Liquid.setState_pTX(state.p, state.T, {1});
  algorithm
    cp := (1-state.X[nS])*Gas.specificHeatCapacityCp(state_G) + state.X[nS]*Liquid.specificHeatCapacityCp(state_L);
    annotation(smoothOrder = 2);
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
    "Return specific heat capacity at constant volume"
  protected
    Gas.ThermodynamicState state_G = Gas.setState_pTX(state.p, state.T,{1});
    Liquid.ThermodynamicState state_L = Liquid.setState_pTX(state.p, state.T, {1});
  algorithm
    cv := (1-state.X[nS])*Gas.specificHeatCapacityCv(state_G) + state.X[nS]*Liquid.specificHeatCapacityCv(state_L);
    annotation(smoothOrder = 2);
  end specificHeatCapacityCv;

  redeclare function extends dynamicViscosity
    "Return dynamic viscosity from the thermodynamic state"
  protected
    Gas.ThermodynamicState state_G = Gas.setState_pTX(state.p,state.T,{1});
    Liquid.ThermodynamicState state_L = Liquid.setState_pTX(state.p, state.T, {1});
  algorithm
    eta := (1-state.X[nS])*Gas.dynamicViscosity(state_G) +state.X[nS]*Liquid.dynamicViscosity(state_L);
    annotation(smoothOrder=2);
  end dynamicViscosity;

  redeclare function extends thermalConductivity
    "Return thermal conductivity from thermodynamic state"
  protected
    Gas.ThermodynamicState state_G = Gas.setState_pTX(state.p,state.T,{1});
    Liquid.ThermodynamicState state_L = Liquid.setState_pTX(state.p, state.T, {1});
  algorithm
    lambda :={Gas.thermalConductivity(state_G), Liquid.thermalConductivity(state_L)}*state.X;
  end thermalConductivity;

 redeclare function extends molarMass
   "Return molar mass from the thermodynamic state"
  protected
    Gas.ThermodynamicState state_G = Gas.setState_pTX(state.p,state.T,{1});
    Liquid.ThermodynamicState state_L = Liquid.setState_pTX(state.p, state.T, {1});
 algorithm
    MM := Gas.molarMass(state_G)*Liquid.molarMass(state_L) / (state.X[nS]*Gas.molarMass(state_G) + (1-state.X[nS])*Liquid.molarMass(state_L));
 end molarMass;
   annotation (Documentation(info="<html>
<p>Gas&nbsp;medium&nbsp;combined&nbsp;with&nbsp;incompressible&nbsp;medium.&nbsp;Only&nbsp;the parameters&nbsp;to&nbsp;PartialMedium&nbsp;&nbsp;and&nbsp;selection&nbsp;of&nbsp;Gas&nbsp;and&nbsp;Liquid&nbsp;are&nbsp;incomplete.&nbsp;</p>
<p>Observe&nbsp;that&nbsp;this&nbsp;first implementation&nbsp;only&nbsp;works&nbsp;for&nbsp;Gases&nbsp;and&nbsp;Liquids&nbsp;with&nbsp;one&nbsp;substance&nbsp;each.</p>
<p>It is assumed that the gas and the liquid do not interact. This is a simplification since many substances mix , e. g. water and air where there is air molecules mixed into the liquid water and water steam mixed in the air.</p>
<p>To calculate the media properties a linear interpolation between the gas and liquid is performed depending on the mass-fraction. Depending on the chosen poperty this may be more or less meaningful. Whenever possible, one shall therefore use the propertis of gas and liquid directly.</p>
</html>"));
end PartialGasAndIncompressible;
