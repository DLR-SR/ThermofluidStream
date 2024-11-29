within ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible;
partial package PartialSingleGasAndIncompressible
         "SingleGases medium combined with Incompressible medium"

 // Set the parameters to PartialMedium and select SingleGas and Incompressible. Observe that this implementation
 //  only works for Incompressible media with one substance."
   extends ThermofluidStream.Media.myMedia.Interfaces.PartialMedium(
     mediumName="incomplete combination of SingleGas and Incompressible",
     substanceNames=cat(
         1,
         SingleGas.substanceNames,
         Incompressible.substanceNames),
         reference_X={0.0001,0.9999},
         reference_p =1e5,
         reference_T= 273.15,
         reducedX=false,
     AbsolutePressure(displayUnit="kPa"));
   replaceable package SingleGas =
       ThermofluidStream.Media.myMedia.IdealGases.Common.SingleGasNasa
       "SingleGas choice" annotation(choicesAllMatching=true);
   replaceable package Incompressible =
       ThermofluidStream.Media.myMedia.Incompressible.TableBased "Incompressible choice" annotation(choicesAllMatching=true);
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
     "Base properties (p, d, T, h, u, R_s, MM, and X of Incompressible mixed with SingleGases"
        import Modelica.Math.Polynomials;

     equation
     MM = molarMass(state);
     h = h_TX(T, X);
     R_s = {SingleGas.data.R_s, Modelica.Constants.R/Incompressible.MM_const}*X;
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
     input SpecificEnthalpy h;
     input MassFraction[:] X;
     output Temperature T;
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
     // from .myMedia.IdealGases.Common.SingleGasNasa
     annotation (inverse(h=h_TX(
               T,
               X)));
  end T_hX;

   function h_TX
      input Temperature T;
     input MassFraction[:] X;
     output SpecificEnthalpy h;
   algorithm
     h := X*{ThermofluidStream.Media.myMedia.IdealGases.Common.Functions.h_T(SingleGas.data,T),Incompressible.h_T(T)};
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
     output Density d;
  protected
      Density d_SG= SingleGas.density(SingleGas.setState_pTX(state.p,state.T));
      Density d_I = Incompressible.density(Incompressible.setState_pTX(state.p,state.T));
   algorithm
    d:= d_SG*d_I/(state.X*{d_I, d_SG});
   annotation (smoothOrder=5);
   end density;

   function d_pT_Incompressible
         input AbsolutePressure p;
     input Temperature T;
        output Density d;
   algorithm
        d:= Incompressible.density(Incompressible.setState_pTX(p,T));
   end d_pT_Incompressible;

   redeclare function specificEnthalpy
     "Return the specific enthalpy from the thermodynamic state"
     input ThermodynamicState state "thermodynamic state record";
     output SpecificEnthalpy h "specific enthalpy";
  protected
     SpecificEnthalpy h_SG = SingleGas.specificEnthalpy(SingleGas.setState_pTX(state.p, state.T));
     SpecificEnthalpy h_I = Incompressible.specificEnthalpy(Incompressible.setState_pTX(state.p, state.T));
   algorithm
     h := {h_SG, h_I}*state.X;
     annotation(smoothOrder=5);
   end specificEnthalpy;

   redeclare function extends specificEntropy
     "Return the specific entropy from the thermodynamic state, total mixing assumed"
  protected
      SpecificEntropy s_SG = SingleGas.specificEntropy(SingleGas.setState_pTX(state.p,state.T));
      SpecificEntropy s_I = Incompressible.specificEntropy(Incompressible.setState_pTX(state.p,state.T));
   algorithm
     s := {s_SG,s_I}*state.X;

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
     SpecificHeatCapacity Cp_SG = SingleGas.specificHeatCapacityCp(SingleGas.setState_pTX(state.p, state.T));
     SpecificHeatCapacity Cp_I = Incompressible.specificHeatCapacityCp(Incompressible.setState_pTX(state.p, state.T));
   algorithm
     cp := {Cp_SG, Cp_I}*state.X;
     annotation(smoothOrder = 2);
   end specificHeatCapacityCp;

   redeclare function extends specificHeatCapacityCv
     "Return specific heat capacity at constant volume"
  protected
     SpecificHeatCapacity Cv_SG = SingleGas.specificHeatCapacityCv(SingleGas.setState_pTX(state.p, state.T));
     SpecificHeatCapacity Cv_I = Incompressible.specificHeatCapacityCv(Incompressible.setState_pTX(state.p, state.T));
   algorithm
     cv := {Cv_SG, Cv_I}*state.X;
     annotation(smoothOrder = 2);
   end specificHeatCapacityCv;

   redeclare function extends dynamicViscosity
     "Return dynamic viscosity from the thermodynamic state"
  protected
     DynamicViscosity eta_SG = SingleGas.dynamicViscosity(SingleGas.setState_pTX(state.p,state.T));
     DynamicViscosity eta_I = Incompressible.dynamicViscosity(Incompressible.setState_pTX(state.p, state.T));
   algorithm
     eta := {eta_SG, eta_I}*state.X;
     annotation(smoothOrder=2);
   end dynamicViscosity;

   redeclare function extends thermalConductivity
     "Return thermal conductivity from thermodynamic state"
  protected
     ThermalConductivity lambda_SG = SingleGas.thermalConductivity(SingleGas.setState_pTX(state.p,state.T));
     ThermalConductivity lambda_I = Incompressible.thermalConductivity(Incompressible.setState_pTX(state.p, state.T));
   algorithm
     lambda :={lambda_SG, lambda_I}*state.X;
   end thermalConductivity;

  redeclare function extends molarMass
    "Return molar mass from the thermodynamic state"
  protected
     MolarMass MM_SG = SingleGas.molarMass(SingleGas.setState_pTX(state.p,state.T));
     MolarMass MM_I = Incompressible.molarMass(Incompressible.setState_pTX(state.p, state.T));
  algorithm
     MM := MM_SG*MM_I /(state.X*{MM_I, MM_SG});
  end molarMass;
    annotation (Documentation(info="<html>
<p>Gas&nbsp;medium&nbsp;combined&nbsp;with&nbsp;incompressible&nbsp;medium.&nbsp;Only&nbsp;the parameters&nbsp;to&nbsp;PartialMedium&nbsp;&nbsp;and&nbsp;selection&nbsp;of&nbsp;SingleGases&nbsp;and&nbsp;Incompressible&nbsp;are&nbsp;incomplete.&nbsp;</p>
<p>Observe&nbsp;that&nbsp;this&nbsp;implementation&nbsp;only&nbsp;works&nbsp;for&nbsp;Incompressible&nbsp;with&nbsp;one&nbsp;substance&nbsp;.</p>
<p>It is assumed that the gas and the liquid do not interact. This is a simplification since many substances mix , e. g. water and air where there is air molecules mixed into the liquid water and water steam mixed in the air.</p>
<p>To calculate the media properties a linear interpolation based on the mass-fractions between the gas and liquid is performed. Depending on the chosen property this may be more or less meaningful. Whenever possible,</p>
<p>one shall therefore use the properties of gas and liquid directly. Compare e.g. with a typical refrigerant, where many of the properties are only defined in the one-phase regions.</p>
<p>The intended use for this media is in systems where the properties of the mix of the media is not very important to get absolutely correct, but where both of the substances of the mix can occur at any physical location </p>
<p>in the system, but then mostly in pure or nearly pure form. </p>
</html>",  revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"),     Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
         coordinateSystem(preserveAspectRatio=false)));
end PartialSingleGasAndIncompressible;
