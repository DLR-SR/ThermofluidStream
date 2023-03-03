within ThermofluidStream.Media.myMedia;
package Common "Data structures and fundamental functions for fluid properties"

  extends Modelica.Icons.Package;
  type Rate = Real (final quantity="Rate", final unit="s-1");
  type MolarFlowRate = Real (final quantity="MolarFlowRate", final unit="mol/s");
  type MolarReactionRate = Real (final quantity="MolarReactionRate", final unit=
         "mol/(m3.s)");
  type MolarEnthalpy = Real (final quantity="MolarEnthalpy", final unit="J/mol");
  type DerDensityByEntropy = Real (final quantity="DerDensityByEntropy", final
        unit="kg2.K/(m3.J)");
  type DerEnergyByPressure = Real (final quantity="DerEnergyByPressure", final
        unit="J/Pa");
  type DerEnergyByMoles = Real (final quantity="DerEnergyByMoles", final unit=
          "J/mol");
  type DerEntropyByTemperature = Real (final quantity="DerEntropyByTemperature",
        final unit="J/K2");
  type DerEntropyByPressure = Real (final quantity="DerEntropyByPressure",
        final unit="J/(K.Pa)");
  type DerEntropyByMoles = Real (final quantity="DerEntropyByMoles", final unit=
         "J/(mol.K)");
  type DerPressureByDensity = Real (final quantity="DerPressureByDensity",
        final unit="Pa.m3/kg");
  type DerPressureBySpecificVolume = Real (final quantity=
          "DerPressureBySpecificVolume", final unit="Pa.kg/m3");
  type DerPressureByTemperature = Real (final quantity=
          "DerPressureByTemperature", final unit="Pa/K");
  type DerVolumeByTemperature = Real (final quantity="DerVolumeByTemperature",
        final unit="m3/K");
  type DerVolumeByPressure = Real (final quantity="DerVolumeByPressure", final
        unit="m3/Pa");
  type DerVolumeByMoles = Real (final quantity="DerVolumeByMoles", final unit=
          "m3/mol");
  type IsenthalpicExponent = Real (final quantity="IsenthalpicExponent", unit=
          "1");
  type IsentropicExponent = Real (final quantity="IsentropicExponent", unit="1");
  type IsobaricVolumeExpansionCoefficient = Real (final quantity=
          "IsobaricVolumeExpansionCoefficient", unit="1/K");
  type IsochoricPressureCoefficient = Real (final quantity=
          "IsochoricPressureCoefficient", unit="1/K");
  type IsothermalCompressibility = Real (final quantity=
          "IsothermalCompressibility", unit="1/Pa");
  type JouleThomsonCoefficient = Real (final quantity="JouleThomsonCoefficient",
        unit="K/Pa");
  // introduce min-manx-nominal values
  constant Real MINPOS=1.0e-9
    "Minimal value for physical variables which are always > 0.0";

  constant SI.Area AMIN=MINPOS "Minimal init area";
  constant SI.Area AMAX=1.0e5 "Maximal init area";
  constant SI.Area ANOM=1.0 "Nominal init area";
  constant SI.AmountOfSubstance MOLMIN=-1.0*MINPOS "Minimal Mole Number";
  constant SI.AmountOfSubstance MOLMAX=1.0e8 "Maximal Mole Number";
  constant SI.AmountOfSubstance MOLNOM=1.0 "Nominal Mole Number";
  constant SI.Density DMIN=1e-6 "Minimal init density";
  constant SI.Density DMAX=30.0e3 "Maximal init density";
  constant SI.Density DNOM=1.0 "Nominal init density";
  constant SI.ThermalConductivity LAMMIN=MINPOS "Minimal thermal conductivity";
  constant SI.ThermalConductivity LAMNOM=1.0 "Nominal thermal conductivity";
  constant SI.ThermalConductivity LAMMAX=1000.0 "Maximal thermal conductivity";
  constant SI.DynamicViscosity ETAMIN=MINPOS "Minimal init dynamic viscosity";
  constant SI.DynamicViscosity ETAMAX=1.0e8 "Maximal init dynamic viscosity";
  constant SI.DynamicViscosity ETANOM=100.0 "Nominal init dynamic viscosity";
  constant SI.Energy EMIN=-1.0e10 "Minimal init energy";
  constant SI.Energy EMAX=1.0e10 "Maximal init energy";
  constant SI.Energy ENOM=1.0e3 "Nominal init energy";
  constant SI.Entropy SMIN=-1.0e6 "Minimal init entropy";
  constant SI.Entropy SMAX=1.0e6 "Maximal init entropy";
  constant SI.Entropy SNOM=1.0e3 "Nominal init entropy";
  constant SI.MassFlowRate MDOTMIN=-1.0e5 "Minimal init mass flow rate";
  constant SI.MassFlowRate MDOTMAX=1.0e5 "Maximal init mass flow rate";
  constant SI.MassFlowRate MDOTNOM=1.0 "Nominal init mass flow rate";
  constant SI.MassFraction MASSXMIN=-1.0*MINPOS "Minimal init mass fraction";
  constant SI.MassFraction MASSXMAX=1.0 "Maximal init mass fraction";
  constant SI.MassFraction MASSXNOM=0.1 "Nominal init mass fraction";
  constant SI.Mass MMIN=-1.0*MINPOS "Minimal init mass";
  constant SI.Mass MMAX=1.0e8 "Maximal init mass";
  constant SI.Mass MNOM=1.0 "Nominal init mass";
  constant SI.MolarMass MMMIN=0.001 "Minimal initial molar mass";
  constant SI.MolarMass MMMAX=250.0 "Maximal initial molar mass";
  constant SI.MolarMass MMNOM=0.2 "Nominal initial molar mass";
  constant SI.MoleFraction MOLEYMIN=-1.0*MINPOS "Minimal init mole fraction";
  constant SI.MoleFraction MOLEYMAX=1.0 "Maximal init mole fraction";
  constant SI.MoleFraction MOLEYNOM=0.1 "Nominal init mole fraction";
  constant SI.MomentumFlux GMIN=-1.0e8 "Minimal init momentum flux";
  constant SI.MomentumFlux GMAX=1.0e8 "Maximal init momentum flux";
  constant SI.MomentumFlux GNOM=1.0 "Nominal init momentum flux";
  constant SI.Power POWMIN=-1.0e8 "Minimal init power or heat";
  constant SI.Power POWMAX=1.0e8 "Maximal init power or heat";
  constant SI.Power POWNOM=1.0e3 "Nominal init power or heat";
  constant SI.Pressure PMIN=1.0e4 "Minimal init pressure";
  constant SI.Pressure PMAX=1.0e8 "Maximal init pressure";
  constant SI.Pressure PNOM=1.0e5 "Nominal init pressure";
  constant SI.Pressure COMPPMIN=-1.0*MINPOS "Minimal init pressure";
  constant SI.Pressure COMPPMAX=1.0e8 "Maximal init pressure";
  constant SI.Pressure COMPPNOM=1.0e5 "Nominal init pressure";
  constant SI.RatioOfSpecificHeatCapacities KAPPAMIN=1.0
    "Minimal init isentropic exponent";
  constant SI.RatioOfSpecificHeatCapacities KAPPAMAX=1.7
    "Maximal init isentropic exponent";
  constant SI.RatioOfSpecificHeatCapacities KAPPANOM=1.2
    "Nominal init isentropic exponent";
  constant SI.SpecificEnergy SEMIN=-1.0e8 "Minimal init specific energy";
  constant SI.SpecificEnergy SEMAX=1.0e8 "Maximal init specific energy";
  constant SI.SpecificEnergy SENOM=1.0e6 "Nominal init specific energy";
  constant SI.SpecificEnthalpy SHMIN=-1.0e8 "Minimal init specific enthalpy";
  constant SI.SpecificEnthalpy SHMAX=1.0e8 "Maximal init specific enthalpy";
  constant SI.SpecificEnthalpy SHNOM=1.0e6 "Nominal init specific enthalpy";
  constant SI.SpecificEntropy SSMIN=-1.0e6 "Minimal init specific entropy";
  constant SI.SpecificEntropy SSMAX=1.0e6 "Maximal init specific entropy";
  constant SI.SpecificEntropy SSNOM=1.0e3 "Nominal init specific entropy";
  constant SI.SpecificHeatCapacity CPMIN=MINPOS
    "Minimal init specific heat capacity";
  constant SI.SpecificHeatCapacity CPMAX=1.0e6
    "Maximal init specific heat capacity";
  constant SI.SpecificHeatCapacity CPNOM=1.0e3
    "Nominal init specific heat capacity";
  constant SI.Temperature TMIN=1.0 "Minimal init temperature";
  constant SI.Temperature TMAX=6000.0 "Maximal init temperature";
  constant SI.Temperature TNOM=320.0 "Nominal init temperature";
  constant SI.ThermalConductivity LMIN=MINPOS
    "Minimal init thermal conductivity";
  constant SI.ThermalConductivity LMAX=500.0
    "Maximal init thermal conductivity";
  constant SI.ThermalConductivity LNOM=1.0 "Nominal init thermal conductivity";
  constant SI.Velocity VELMIN=-1.0e5 "Minimal init speed";
  constant SI.Velocity VELMAX=1.0e5 "Maximal init speed";
  constant SI.Velocity VELNOM=1.0 "Nominal init speed";
  constant SI.Volume VMIN=0.0 "Minimal init volume";
  constant SI.Volume VMAX=1.0e5 "Maximal init volume";
  constant SI.Volume VNOM=1.0e-3 "Nominal init volume";

  package ThermoFluidSpecial "Property records used by the ThermoFluid library"
    extends Modelica.Icons.Package;
    record FixedIGProperties "Constant properties for ideal gases"
      extends Modelica.Icons.Record;
      parameter Integer nspecies(min=1) "Number of components";
      SI.MolarMass[nspecies] MM "Molar mass of components";
      Real[nspecies] invMM "Inverse of molar mass of components";
      SI.SpecificHeatCapacity[nspecies] R_s "Gas constant";
      SI.SpecificEnthalpy[nspecies] Hf "Enthalpy of formation at 298.15K";
      SI.SpecificEnthalpy[nspecies] H0 "H0(298.15K) - H0(0K)";
    end FixedIGProperties;

    record ThermoBaseVars
      extends Modelica.Icons.Record;
      parameter Integer n(min=1) "Discretization number";
      parameter Integer nspecies(min=1) "Number of species";
      SI.Pressure[n] p(
        min=PMIN,
        max=PMAX,
        nominal=PNOM,
        start=fill(1.0e5, n)) "Pressure";
      SI.Temperature[n] T(
        min=TMIN,
        max=TMAX,
        nominal=TNOM) "Temperature";
      SI.Density[n] d(
        min=DMIN,
        max=DMAX,
        nominal=DNOM) "Density";
      SI.SpecificEnthalpy[n] h(
        min=SHMIN,
        max=SHMAX,
        nominal=SHNOM) "Specific enthalpy";
      SI.SpecificEntropy[n] s(
        min=SSMIN,
        max=SSMAX,
        nominal=SSNOM) "Specific entropy";
      SI.RatioOfSpecificHeatCapacities[n] kappa "Ratio of cp/cv";
      SI.Mass[n] M(
        min=MMIN,
        max=MMAX,
        nominal=MNOM) "Total mass";
      SI.Energy[n] U(
        min=EMIN,
        max=EMAX,
        nominal=ENOM) "Inner energy";
      SI.MassFlowRate[n] dM(
        min=MDOTMIN,
        max=MDOTMAX,
        nominal=MDOTNOM) "Change in total mass";
      SI.Power[n] dU(
        min=POWMIN,
        max=POWMAX,
        nominal=POWNOM) "Change in inner energy";
      SI.Volume[n] V(
        min=VMIN,
        max=VMAX,
        nominal=VNOM) "Volume";
      SI.MassFraction[n, nspecies] mass_x(
        min=MASSXMIN,
        max=MASSXMAX,
        nominal=MASSXNOM) "Mass fraction";
      SI.MoleFraction[n, nspecies] mole_y(
        min=MOLEYMIN,
        max=MOLEYMAX,
        nominal=MOLEYNOM) "Mole fraction";
      SI.Mass[n, nspecies] M_x(
        min=MMIN,
        max=MMAX,
        nominal=MNOM) "Component mass";
      SI.MassFlowRate[n, nspecies] dM_x(
        min=MDOTMIN,
        max=MDOTMAX,
        nominal=MDOTNOM) "Rate of change in component mass";
      MolarFlowRate[n, nspecies] dZ(
        min=-1.0e6,
        max=1.0e6,
        nominal=0.0) "Rate of change in component moles";
      MolarFlowRate[n, nspecies] rZ(
        min=-1.0e6,
        max=1.0e6,
        nominal=0.0) "Reaction(source) mole rates";
      SI.MolarMass[n] MM(
        min=MMMIN,
        max=MMMAX,
        nominal=MMNOM) "Molar mass of mixture";
      SI.AmountOfSubstance[n] Moles(
        min=MOLMIN,
        max=MOLMAX,
        nominal=MOLNOM) "Total moles";
      SI.AmountOfSubstance[n, nspecies] Moles_z(
        min=MOLMIN,
        max=MOLMAX,
        nominal=MOLNOM) "Mole vector";
      annotation (Documentation(info="<html>
<h4>Model description</h4>
<p>
<strong>ThermoBaseVars</strong> is inherited by all medium property models
and by all models defining the dynamic states for the conservation
of mass and energy. Thus it is a good choice as a restricting class
for any medium model or dynamic state model.
</p>
</html>"));
    end ThermoBaseVars;

    record ThermoProperties
      "Thermodynamic base property data for all state models"
      extends Modelica.Icons.Record;
      parameter Integer nspecies(min=1) "Number of species";
      SI.Temperature T(
        min=TMIN,
        max=TMAX,
        nominal=TNOM) "Temperature";
      SI.Density d(
        min=DMIN,
        max=DMAX,
        nominal=DNOM) "Density";
      SI.Pressure p(
        min=PMIN,
        max=PMAX,
        nominal=PNOM) "Pressure";
      SI.Volume V(
        min=VMIN,
        max=VMAX,
        nominal=VNOM) "Volume";
      SI.SpecificEnthalpy h(
        min=SHMIN,
        max=SHMAX,
        nominal=SHNOM) "Specific enthalpy";
      SI.SpecificEnergy u(
        min=SEMIN,
        max=SEMAX,
        nominal=SENOM) "Specific inner energy";
      SI.SpecificEntropy s(
        min=SSMIN,
        max=SSMAX,
        nominal=SSNOM) "Specific entropy";
      SI.SpecificGibbsFreeEnergy g(
        min=SHMIN,
        max=SHMAX,
        nominal=SHNOM) "Specific Gibbs free energy";
      SI.SpecificHeatCapacity cp(
        min=CPMIN,
        max=CPMAX,
        nominal=CPNOM) "Heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=CPMIN,
        max=CPMAX,
        nominal=CPNOM) "Heat capacity at constant volume";
      SI.SpecificHeatCapacity R_s(
        min=CPMIN,
        max=CPMAX,
        nominal=CPNOM) "Gas constant";
      SI.MolarMass MM(
        min=MMMIN,
        max=MMMAX,
        nominal=MMNOM) "Molar mass of mixture";
      SI.MassFraction[nspecies] mass_x(
        min=MASSXMIN,
        max=MASSXMAX,
        nominal=MASSXNOM) "Mass fraction";
      SI.MoleFraction[nspecies] mole_y(
        min=MOLEYMIN,
        max=MOLEYMAX,
        nominal=MOLEYNOM) "Mole fraction";
      SI.RatioOfSpecificHeatCapacities kappa "Ratio of cp/cv";
      SI.DerDensityByTemperature ddTp
        "Derivative of density by temperature at constant pressure";
      SI.DerDensityByPressure ddpT
        "Derivative of density by pressure at constant temperature";
      Real dupT(unit="m3.kg-1")
        "Derivative of inner energy by pressure at constant T";
      Real dudT(unit="(J.m3)/(kg2)")
        "Derivative of inner energy by density at constant T";
      SI.SpecificHeatCapacity duTp
        "Derivative of inner energy by temperature at constant p";
      SI.SpecificEnergy ddx[nspecies]
        "Derivative vector of density by change in mass composition";
      SI.SpecificEnergy[nspecies] compu(
        min=SEMIN,
        max=SEMAX,
        nominal=SENOM) "Inner energy of the components";
      SI.Pressure[nspecies] compp(
        min=COMPPMIN,
        max=COMPPMAX,
        nominal=COMPPNOM) "Partial pressures of the components";
      SI.Velocity a(
        min=VELMIN,
        max=VELMAX,
        nominal=VELNOM) "Speed of sound";
      SI.HeatCapacity dUTZ
        "Derivative of inner energy by temperature at constant moles";
      SI.MolarInternalEnergy[nspecies] dUZT
        "Derivative of inner energy by moles at constant temperature";
      SI.SpecificEnthalpy[nspecies] dHMxT(
        min=SEMIN,
        max=SEMAX,
        nominal=SENOM)
        "Derivative of total enthalpy w.r.t. component mass at constant T";
      Real dpT "Derivative of pressure w.r.t. temperature";
      Real dpZ[nspecies] "Derivative of pressure w.r.t. moles";
      annotation (Documentation(info="<html>
<h4>Model description</h4>
<p>
A base class for medium property models which work with most of the
versions of dynamic states that are available in the ThermoFluid
library. Currently used by all ideal gas models.
</p>
</html>"));
    end ThermoProperties;

    record ThermoProperties_ph
      "Thermodynamic property data for pressure p and specific enthalpy h as dynamic states"

      extends Modelica.Icons.Record;
      SI.Temperature T(
        min=1.0e-9,
        max=10000.0,
        nominal=298.15) "Temperature";
      SI.Density d(
        min=1.0e-9,
        max=10000.0,
        nominal=10.0) "Density";
      SI.SpecificEnergy u(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "Specific inner energy";
      SI.SpecificEntropy s(
        min=-1.0e6,
        max=1.0e6,
        nominal=1.0e3) "Specific entropy";
      SI.SpecificHeatCapacity cp(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Heat capacity at constant volume";
      SI.SpecificHeatCapacity R_s(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Gas constant";
      SI.RatioOfSpecificHeatCapacities kappa "Ratio of cp/cv";
      SI.Velocity a(
        min=1.0,
        max=10000.0,
        nominal=300.0) "Speed of sound";
      SI.DerDensityByEnthalpy ddhp
        "Derivative of density by enthalpy at constant pressure";
      SI.DerDensityByPressure ddph
        "Derivative of density by pressure at constant enthalpy";
      Real duph(unit="m3/kg")
        "Derivative of inner energy by pressure at constant enthalpy";
      Real duhp(unit="1")
        "Derivative of inner energy by enthalpy at constant pressure";
      annotation (Documentation(info="<html>
<h4>Model description</h4>
<p>
A base class for medium property models which
use pressure and enthalpy as dynamic states.
This is the preferred model for fluids that can also be in the
two phase and liquid regions.
</p>
</html>"));
    end ThermoProperties_ph;

    record ThermoProperties_pT
      "Thermodynamic property data for pressure p and temperature T as dynamic states"

      extends Modelica.Icons.Record;
      SI.Density d(
        min=1.0e-9,
        max=10000.0,
        nominal=10.0) "Density";
      SI.SpecificEnthalpy h(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "Specific enthalpy";
      SI.SpecificEnergy u(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "Specific inner energy";
      SI.SpecificEntropy s(
        min=-1.0e6,
        max=1.0e6,
        nominal=1.0e3) "Specific entropy";
      SI.SpecificHeatCapacity cp(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Heat capacity at constant volume";
      SI.SpecificHeatCapacity R_s(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Gas constant";
      SI.RatioOfSpecificHeatCapacities kappa "Ratio of cp/cv";
      SI.Velocity a(
        min=1.0,
        max=10000.0,
        nominal=300.0) "Speed of sound";
      SI.DerDensityByTemperature ddTp
        "Derivative of density by temperature at constant pressure";
      SI.DerDensityByPressure ddpT
        "Derivative of density by pressure at constant temperature";
      Real dupT(unit="m3.kg-1")
        "Derivative of inner energy by pressure at constant T";
      SI.SpecificHeatCapacity duTp
        "Derivative of inner energy by temperature at constant p";
      annotation (Documentation(info="<html>
<h4>Model description</h4>
<p>
A base class for medium property models which use pressure and temperature as dynamic states.
This is a reasonable model for fluids that can also be in the gas and
liquid regions, but never in the two-phase region.
</p>
</html>"));
    end ThermoProperties_pT;

    record ThermoProperties_dT
      "Thermodynamic property data for density d and temperature T as dynamic states"

      extends Modelica.Icons.Record;
      SI.Pressure p(
        min=1.0,
        max=1.0e9,
        nominal=1.0e5) "Pressure";
      SI.SpecificEnthalpy h(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "Specific enthalpy";
      SI.SpecificEnergy u(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "Specific inner energy";
      SI.SpecificEntropy s(
        min=-1.0e6,
        max=1.0e6,
        nominal=1.0e3) "Specific entropy";
      SI.SpecificHeatCapacity cp(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Heat capacity at constant volume";
      SI.SpecificHeatCapacity R_s(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Gas constant";
      SI.RatioOfSpecificHeatCapacities kappa "Ratio of cp/cv";
      SI.Velocity a(
        min=1.0,
        max=10000.0,
        nominal=300.0) "Speed of sound";
      Real dudT(unit="m5/(kg.s2)")
        "Derivative of inner energy by density at constant T";
      annotation (Documentation(info="<html>
<h4>Model description</h4>
<p>
A base class for medium property models which use density and temperature as dynamic states.
This is a reasonable model for fluids that can be in the gas, liquid
and two-phase region. The model is numerically not well suited for
liquids except if the pressure is always above approx. 80% of the
critical pressure.
</p>
</html>"));
    end ThermoProperties_dT;

    //   record GibbsDerivs

    //     "Derivatives of dimensionless Gibbs-function w.r.t. dimensionless pressure and temperature"
    //     extends Modelica.Icons.Record;
    //     Real pi "Dimensionless pressure";
    //     Real tau "Dimensionless temperature";
    //     Real g "Dimensionless Gibbs-function";
    //     Real gpi "Derivative of g w.r.t. pi";
    //     Real gpipi "2nd derivative of g w.r.t. pi";
    //     Real gtau "Derivative of g w.r.t. tau";
    //     Real gtautau "2nd derivative of g w.r.t. tau";
    //     Real gtaupi "Mixed derivative of g w.r.t. pi and tau";
    //   end GibbsDerivs;

    //   record HelmholtzDerivs

    //     "Derivatives of dimensionless Helmholtz-function w.r.t. dimensionless pressure, density and temperature"
    //     extends Modelica.Icons.Record;
    //     Real delta "Dimensionless density";
    //     Real tau "Dimensionless temperature";
    //     Real f "Dimensionless Helmholtz-function";
    //     Real fdelta "Derivative of f w.r.t. delta";
    //     Real fdeltadelta "2nd derivative of f w.r.t. delta";
    //     Real ftau "Derivative of f w.r.t. tau";
    //     Real ftautau "2nd derivative of f w.r.t. tau";
    //     Real fdeltatau "Mixed derivative of f w.r.t. delta and tau";
    //   end HelmholtzDerivs;

    record TransportProps "Record with transport properties"
      extends Modelica.Icons.Record;
      SI.DynamicViscosity eta;
      SI.ThermalConductivity lam;
    end TransportProps;

    function gibbsToProps_ph
      "Calculate property record for pressure and specific enthalpy as states from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
      output ThermoProperties_ph pro
        "Property record for pressure and specific enthalpy as dynamic states";
    protected
      Real vt(unit="m3.kg-1.K-1")
        "Derivative of specific volume w.r.t. temperature";
      Real vp(unit="m4.kg-2.s2")
        "Derivative of specific volume w.r.t. pressure";
    algorithm
      pro.T := g.T;
      pro.R_s := g.R_s;
      pro.d := g.p/(pro.R_s*pro.T*g.pi*g.gpi);
      pro.u := g.T*g.R_s*(g.tau*g.gtau - g.pi*g.gpi);
      pro.s := pro.R_s*(g.tau*g.gtau - g.g);
      pro.cp := -pro.R_s*g.tau*g.tau*g.gtautau;
      pro.cv := pro.R_s*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/(g.gpipi));
      pro.a := abs(g.R_s*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
        *g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;
      vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      pro.kappa := -1/(pro.d*g.p)*pro.cp/(vp*pro.cp + vt*vt*g.T);
      pro.ddhp := -pro.d*pro.d*vt/(pro.cp);
      pro.ddph := -pro.d*pro.d*(vp*pro.cp - vt/pro.d + g.T*vt*vt)/pro.cp;
      pro.duph := -1/pro.d + g.p/(pro.d*pro.d)*pro.ddph;
      pro.duhp := 1 + g.p/(pro.d*pro.d)*pro.ddhp;
    end gibbsToProps_ph;

    function gibbsToBoundaryProps
      "Calculate phase boundary property record from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
      output PhaseBoundaryProperties sat "Phase boundary properties";
    protected
      Real vt(unit="m3.kg-1.K-1")
        "Derivative of specific volume w.r.t. temperature";
      Real vp(unit="m4.kg-2.s2")
        "Derivative of specific volume w.r.t. pressure";
    algorithm
      sat.d := g.p/(g.R_s*g.T*g.pi*g.gpi);
      sat.h := g.R_s*g.T*g.tau*g.gtau;
      sat.u := g.T*g.R_s*(g.tau*g.gtau - g.pi*g.gpi);
      sat.s := g.R_s*(g.tau*g.gtau - g.g);
      sat.cp := -g.R_s*g.tau*g.tau*g.gtautau;
      sat.cv := g.R_s*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/(g.gpipi));
      vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
      sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
      sat.pd := -g.R_s*g.T*g.gpi*g.gpi/(g.gpipi);
    end gibbsToBoundaryProps;

    function gibbsToProps_dT
      "Calculate property record for density and temperature as states from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
      output ThermoProperties_dT pro
        "Property record for density and temperature as dynamic states";
    protected
      Real vt(unit="m3.kg-1.K-1")
        "Derivative of specific volume w.r.t. temperature";
      Real vp(unit="m4.kg-2.s2")
        "Derivative of specific volume w.r.t. pressure";
      SI.Density d;
    algorithm
      pro.R_s := g.R_s;
      pro.p := g.p;
      pro.u := g.T*g.R_s*(g.tau*g.gtau - g.pi*g.gpi);
      pro.h := g.R_s*g.T*g.tau*g.gtau;
      pro.s := pro.R_s*(g.tau*g.gtau - g.g);
      pro.cp := -pro.R_s*g.tau*g.tau*g.gtautau;
      pro.cv := pro.R_s*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/g.gpipi);
      vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      pro.kappa := -1/((g.p/(pro.R_s*g.T*g.pi*g.gpi))*g.p)*pro.cp/(vp*pro.cp + vt
        *vt*g.T);
      pro.a := abs(g.R_s*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
        *g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;

      d := g.p/(pro.R_s*g.T*g.pi*g.gpi);
      pro.dudT := (pro.p - g.T*vt/vp)/(d*d);
    end gibbsToProps_dT;

    function gibbsToProps_pT
      "Calculate property record for pressure and temperature as states from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
      output ThermoProperties_pT pro
        "Property record for pressure and temperature as dynamic states";
    protected
      Real vt(unit="m3.kg-1.K-1")
        "Derivative of specific volume w.r.t. temperature";
      Real vp(unit="m4.kg-2.s2")
        "Derivative of specific volume w.r.t. pressure";
    algorithm
      pro.R_s := g.R_s;
      pro.d := g.p/(pro.R_s*g.T*g.pi*g.gpi);
      pro.u := g.T*g.R_s*(g.tau*g.gtau - g.pi*g.gpi);
      pro.h := g.R_s*g.T*g.tau*g.gtau;
      pro.s := pro.R_s*(g.tau*g.gtau - g.g);
      pro.cp := -pro.R_s*g.tau*g.tau*g.gtautau;
      pro.cv := pro.R_s*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/g.gpipi);
      vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      pro.kappa := -1/(pro.d*g.p)*pro.cp/(vp*pro.cp + vt*vt*g.T);
      pro.a := abs(g.R_s*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
        *g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;
      pro.ddpT := -(pro.d*pro.d)*vp;
      pro.ddTp := -(pro.d*pro.d)*vt;
      pro.duTp := pro.cp - g.p*vt;
      pro.dupT := -g.T*vt - g.p*vp;
    end gibbsToProps_pT;

    function helmholtzToProps_ph
      "Calculate property record for pressure and specific enthalpy as states from dimensionless Helmholtz function"

      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
      output ThermoProperties_ph pro
        "Property record for pressure and specific enthalpy as dynamic states";
    protected
      SI.Pressure p "Pressure";
      DerPressureByDensity pd "Derivative of pressure w.r.t. density";
      DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
      DerPressureBySpecificVolume pv
        "Derivative of pressure w.r.t. specific volume";
    algorithm
      pro.d := f.d;
      pro.T := f.T;
      pro.R_s := f.R_s;
      pro.s := f.R_s*(f.tau*f.ftau - f.f);
      pro.u := f.R_s*f.T*f.tau*f.ftau;
      p := pro.d*pro.R_s*pro.T*f.delta*f.fdelta;
      pd := f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      pv := -pd*f.d*f.d;

      // calculating cp near the critical point may be troublesome (cp -> inf).
      pro.cp := f.R_s*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      pro.cv := f.R_s*(-f.tau*f.tau*f.ftautau);
      pro.kappa := 1/(f.d*f.R_s*f.d*f.T*f.delta*f.fdelta)*((-pv*pro.cv + pt*pt*f.T)
        /(pro.cv));
      pro.a := abs(f.R_s*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      pro.ddph := (f.d*(pro.cv*f.d + pt))/(f.d*f.d*pd*pro.cv + f.T*pt*pt);
      pro.ddhp := -f.d*f.d*pt/(f.d*f.d*pd*pro.cv + f.T*pt*pt);
      pro.duph := -1/pro.d + p/(pro.d*pro.d)*pro.ddph;
      pro.duhp := 1 + p/(pro.d*pro.d)*pro.ddhp;
    end helmholtzToProps_ph;

    function helmholtzToProps_pT
      "Calculate property record for pressure and temperature as states from dimensionless Helmholtz function"

      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
      output ThermoProperties_pT pro
        "Property record for pressure and temperature as dynamic states";
    protected
      DerPressureByDensity pd "Derivative of pressure w.r.t. density";
      DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
      DerPressureBySpecificVolume pv
        "Derivative of pressure w.r.t. specific volume";
      IsobaricVolumeExpansionCoefficient alpha
        "Isobaric volume expansion coefficient";
      // beta in Bejan
      IsothermalCompressibility gamma "Isothermal compressibility";
      // kappa in Bejan
      SI.Pressure p "Pressure";
    algorithm
      pro.d := f.d;
      pro.R_s := f.R_s;
      pro.s := f.R_s*(f.tau*f.ftau - f.f);
      pro.h := f.R_s*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
      pro.u := f.R_s*f.T*f.tau*f.ftau;
      pd := f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      pv := -(f.d*f.d)*pd;
      alpha := -f.d*pt/pv;
      gamma := -f.d/pv;
      p := f.R_s*f.d*f.T*f.delta*f.fdelta;
      // calculating cp near the critical point may be troublesome (cp -> inf).
      pro.cp := f.R_s*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      pro.cv := f.R_s*(-f.tau*f.tau*f.ftautau);
      pro.kappa := 1/(f.d*f.R_s*f.d*f.T*f.delta*f.fdelta)*((-pv*pro.cv + pt*pt*f.T)
        /(pro.cv));
      pro.a := abs(f.R_s*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      pro.ddTp := -pt/pd;
      pro.ddpT := 1/pd;
      //problem with units in last two lines
      pro.dupT := gamma*p/f.d - alpha*f.T/f.d;
      pro.duTp := pro.cp - alpha*p/f.d;
    end helmholtzToProps_pT;

    function helmholtzToProps_dT
      "Calculate property record for density and temperature as states from dimensionless Helmholtz function"

      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
      output ThermoProperties_dT pro
        "Property record for density and temperature as dynamic states";
    protected
      DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
      DerPressureBySpecificVolume pv "Derivative of pressure w.r.t. pressure";
    algorithm
      pro.p := f.R_s*f.d*f.T*f.delta*f.fdelta;
      pro.R_s := f.R_s;
      pro.s := f.R_s*(f.tau*f.ftau - f.f);
      pro.h := f.R_s*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
      pro.u := f.R_s*f.T*f.tau*f.ftau;
      pv := -(f.d*f.d)*f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);

      // calculating cp near the critical point may be troublesome (cp -> inf).
      pro.cp := f.R_s*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      pro.cv := f.R_s*(-f.tau*f.tau*f.ftautau);
      pro.kappa := 1/(f.d*pro.p)*((-pv*pro.cv + pt*pt*f.T)/(pro.cv));
      pro.a := abs(f.R_s*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      pro.dudT := (pro.p - f.T*pt)/(f.d*f.d);
    end helmholtzToProps_dT;

    function TwoPhaseToProps_ph
      "Compute property record for pressure and specific enthalpy as states from saturation properties"

      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output ThermoProperties_ph pro
        "Property record for pressure and specific enthalpy as dynamic states";
    protected
      Real dht(unit="(J/kg)/K")
        "Derivative of specific enthalpy w.r.t. temperature";
      Real dhd(unit="(J/kg)/(kg/m3)")
        "Derivative of specific enthalpy w.r.t. density";
      Real detph(unit="m4.s4/(K.s8)") "Thermodynamic determinant";
    algorithm
      pro.d := sat.d;
      pro.T := sat.T;
      pro.u := sat.u;
      pro.s := sat.s;
      pro.cv := sat.cv;
      pro.R_s := sat.R_s;
      pro.cp := Modelica.Constants.inf;
      pro.kappa := -1/(sat.d*sat.p)*sat.dpT*sat.dpT*sat.T/sat.cv;
      pro.a := Modelica.Constants.inf;
      dht := sat.cv + sat.dpT/sat.d;
      dhd := -sat.T*sat.dpT/(sat.d*sat.d);
      detph := -sat.dpT*dhd;
      pro.ddph := dht/detph;
      pro.ddhp := -sat.dpT/detph;
    end TwoPhaseToProps_ph;

    function TwoPhaseToProps_dT
      "Compute property record for density and temperature as states from saturation properties"

      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation properties";
      output ThermoProperties_dT pro
        "Property record for density and temperature as dynamic states";
    algorithm
      pro.p := sat.p;
      pro.h := sat.h;
      pro.u := sat.u;
      pro.s := sat.s;
      pro.cv := sat.cv;
      pro.cp := Modelica.Constants.inf;
      pro.R_s := sat.R_s;
      pro.kappa := -1/(sat.d*sat.p)*sat.dpT*sat.dpT*sat.T/sat.cv;
      pro.a := Modelica.Constants.inf;
      pro.dudT := (sat.p - sat.T*sat.dpT)/(sat.d*sat.d);
    end TwoPhaseToProps_dT;

  end ThermoFluidSpecial;

public
  record SaturationProperties "Properties in the two phase region"
    extends Modelica.Icons.Record;
    SI.Temperature T "Temperature";
    SI.Density d "Density";
    SI.Pressure p "Pressure";
    SI.SpecificEnergy u "Specific inner energy";
    SI.SpecificEnthalpy h "Specific enthalpy";
    SI.SpecificEntropy s "Specific entropy";
    SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv "Heat capacity at constant volume";
    SI.SpecificHeatCapacity R_s "Gas constant";
    SI.RatioOfSpecificHeatCapacities kappa "Isentropic expansion coefficient";
    PhaseBoundaryProperties liq
      "Thermodynamic base properties on the boiling curve";
    PhaseBoundaryProperties vap
      "Thermodynamic base properties on the dew curve";
    Real dpT(unit="Pa/K")
      "Derivative of saturation pressure w.r.t. temperature";
    SI.MassFraction x "Vapour mass fraction";
  end SaturationProperties;

  record SaturationBoundaryProperties
    "Properties on both phase boundaries, including some derivatives"

    extends Modelica.Icons.Record;
    SI.Temperature T "Saturation temperature";
    SI.Density dl "Liquid density";
    SI.Density dv "Vapour density";
    SI.SpecificEnthalpy hl "Liquid specific enthalpy";
    SI.SpecificEnthalpy hv "Vapour specific enthalpy";
    Real dTp "Derivative of temperature w.r.t. saturation pressure";
    Real ddldp "Derivative of density along boiling curve";
    Real ddvdp "Derivative of density along dew curve";
    Real dhldp "Derivative of specific enthalpy along boiling curve";
    Real dhvdp "Derivative of specific enthalpy along dew curve";
    SI.MassFraction x "Vapour mass fraction";
  end SaturationBoundaryProperties;

  record IF97BaseTwoPhase "Intermediate property data record for IF 97"
    extends Modelica.Icons.Record;
    Integer phase(start=0)
      "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
    Integer region(min=1, max=5) "IF 97 region";
    SI.Pressure p "Pressure";
    SI.Temperature T "Temperature";
    SI.SpecificEnthalpy h "Specific enthalpy";
    SI.SpecificHeatCapacity R_s "Gas constant";
    SI.SpecificHeatCapacity cp "Specific heat capacity";
    SI.SpecificHeatCapacity cv "Specific heat capacity";
    SI.Density rho "Density";
    SI.SpecificEntropy s "Specific entropy";
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    DerPressureByDensity pd "Derivative of pressure w.r.t. density";
    Real vt "Derivative of specific volume w.r.t. temperature";
    Real vp "Derivative of specific volume w.r.t. pressure";
    Real x "Dryness fraction";
    Real dpT "dp/dT derivative of saturation curve";
  end IF97BaseTwoPhase;

  record IF97PhaseBoundaryProperties
    "Thermodynamic base properties on the phase boundary for IF97 steam tables"

    extends Modelica.Icons.Record;
    Boolean region3boundary "True if boundary between 2-phase and region 3";
    SI.SpecificHeatCapacity R_s "Specific heat capacity";
    SI.Temperature T "Temperature";
    SI.Density d "Density";
    SI.SpecificEnthalpy h "Specific enthalpy";
    SI.SpecificEntropy s "Specific entropy";
    SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv "Heat capacity at constant volume";
    DerPressureByTemperature dpT "dp/dT derivative of saturation curve";
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    DerPressureByDensity pd "Derivative of pressure w.r.t. density";
    Real vt(unit="m3/(kg.K)")
      "Derivative of specific volume w.r.t. temperature";
    Real vp(unit="m3/(kg.Pa)") "Derivative of specific volume w.r.t. pressure";
  end IF97PhaseBoundaryProperties;

  record GibbsDerivs
    "Derivatives of dimensionless Gibbs-function w.r.t. dimensionless pressure and temperature"

    extends Modelica.Icons.Record;
    SI.Pressure p "Pressure";
    SI.Temperature T "Temperature";
    SI.SpecificHeatCapacity R_s "Specific heat capacity";
    Real pi(unit="1") "Dimensionless pressure";
    Real tau(unit="1") "Dimensionless temperature";
    Real g(unit="1") "Dimensionless Gibbs-function";
    Real gpi(unit="1") "Derivative of g w.r.t. pi";
    Real gpipi(unit="1") "2nd derivative of g w.r.t. pi";
    Real gtau(unit="1") "Derivative of g w.r.t. tau";
    Real gtautau(unit="1") "2nd derivative of g w.r.t. tau";
    Real gtaupi(unit="1") "Mixed derivative of g w.r.t. pi and tau";
  end GibbsDerivs;

  record HelmholtzDerivs
    "Derivatives of dimensionless Helmholtz-function w.r.t. dimensionless pressure, density and temperature"
    extends Modelica.Icons.Record;
    SI.Density d "Density";
    SI.Temperature T "Temperature";
    SI.SpecificHeatCapacity R_s "Specific heat capacity";
    Real delta(unit="1") "Dimensionless density";
    Real tau(unit="1") "Dimensionless temperature";
    Real f(unit="1") "Dimensionless Helmholtz-function";
    Real fdelta(unit="1") "Derivative of f w.r.t. delta";
    Real fdeltadelta(unit="1") "2nd derivative of f w.r.t. delta";
    Real ftau(unit="1") "Derivative of f w.r.t. tau";
    Real ftautau(unit="1") "2nd derivative of f w.r.t. tau";
    Real fdeltatau(unit="1") "Mixed derivative of f w.r.t. delta and tau";
  end HelmholtzDerivs;

  record TwoPhaseTransportProps
    "Defines properties on both phase boundaries, needed in the two phase region"
    extends Modelica.Icons.Record;
    SI.Density d_vap "Density on the dew line";
    SI.Density d_liq "Density on the bubble line";
    SI.DynamicViscosity eta_vap "Dynamic viscosity on the dew line";
    SI.DynamicViscosity eta_liq "Dynamic viscosity on the bubble line";
    SI.ThermalConductivity lam_vap "Thermal conductivity on the dew line";
    SI.ThermalConductivity lam_liq "Thermal conductivity on the bubble line";
    SI.SpecificHeatCapacity cp_vap "Cp on the dew line";
    SI.SpecificHeatCapacity cp_liq "Cp on the bubble line";
    SI.MassFraction x "Steam quality";
  end TwoPhaseTransportProps;

  record PhaseBoundaryProperties
    "Thermodynamic base properties on the phase boundary"
    extends Modelica.Icons.Record;
    SI.Density d "Density";
    SI.SpecificEnthalpy h "Specific enthalpy";
    SI.SpecificEnergy u "Inner energy";
    SI.SpecificEntropy s "Specific entropy";
    SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv "Heat capacity at constant volume";
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    DerPressureByDensity pd "Derivative of pressure w.r.t. density";
  end PhaseBoundaryProperties;

  record NewtonDerivatives_ph
    "Derivatives for fast inverse calculations of Helmholtz functions: p & h"

    extends Modelica.Icons.Record;
    SI.Pressure p "Pressure";
    SI.SpecificEnthalpy h "Specific enthalpy";
    DerPressureByDensity pd "Derivative of pressure w.r.t. density";
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    Real hd "Derivative of specific enthalpy w.r.t. density";
    Real ht "Derivative of specific enthalpy w.r.t. temperature";
  end NewtonDerivatives_ph;

  record NewtonDerivatives_ps
    "Derivatives for fast inverse calculation of Helmholtz functions: p & s"

    extends Modelica.Icons.Record;
    SI.Pressure p "Pressure";
    SI.SpecificEntropy s "Specific entropy";
    DerPressureByDensity pd "Derivative of pressure w.r.t. density";
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    Real sd "Derivative of specific entropy w.r.t. density";
    Real st "Derivative of specific entropy w.r.t. temperature";
  end NewtonDerivatives_ps;

  record NewtonDerivatives_pT
    "Derivatives for fast inverse calculations of Helmholtz functions:p & T"

    extends Modelica.Icons.Record;
    SI.Pressure p "Pressure";
    DerPressureByDensity pd "Derivative of pressure w.r.t. density";
  end NewtonDerivatives_pT;

  record ExtraDerivatives "Additional thermodynamic derivatives"
    extends Modelica.Icons.Record;
    IsentropicExponent kappa "Isentropic expansion coefficient";
    // k in Bejan
    IsenthalpicExponent theta "Isenthalpic exponent";
    // same as kappa, except derivative at const h
    IsobaricVolumeExpansionCoefficient alpha
      "Isobaric volume expansion coefficient";
    // beta in Bejan
    IsochoricPressureCoefficient beta "Isochoric pressure coefficient";
    // kT in Bejan
    IsothermalCompressibility gamma "Isothermal compressibility";
    // kappa in Bejan
    JouleThomsonCoefficient mu "Joule-Thomson coefficient";
    // mu_J in Bejan
  end ExtraDerivatives;

  record BridgmansTables
    "Calculates all entries in Bridgmans tables if first seven variables given"
    extends Modelica.Icons.Record;
    // the first 7 need to calculated in a function!
    SI.SpecificVolume v "Specific volume";
    SI.Pressure p "Pressure";
    SI.Temperature T "Temperature";
    SI.SpecificEntropy s "Specific entropy";
    SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
    IsobaricVolumeExpansionCoefficient alpha
      "Isobaric volume expansion coefficient";
    // beta in Bejan
    IsothermalCompressibility gamma "Isothermal compressibility";
    // kappa in Bejan
    // Derivatives at constant pressure
    Real dTp=1 "Coefficient in Bridgmans table, see info for usage";
    Real dpT=-dTp "Coefficient in Bridgmans table, see info for usage";
    Real dvp=alpha*v "Coefficient in Bridgmans table, see info for usage";
    Real dpv=-dvp "Coefficient in Bridgmans table, see info for usage";
    Real dsp=cp/T "Coefficient in Bridgmans table, see info for usage";
    Real dps=-dsp "Coefficient in Bridgmans table, see info for usage";
    Real dup=cp - alpha*p*v
      "Coefficient in Bridgmans table, see info for usage";
    Real dpu=-dup "Coefficient in Bridgmans table, see info for usage";
    Real dhp=cp "Coefficient in Bridgmans table, see info for usage";
    Real dph=-dhp "Coefficient in Bridgmans table, see info for usage";
    Real dfp=-s - alpha*p*v
      "Coefficient in Bridgmans table, see info for usage";
    Real dpf=-dfp "Coefficient in Bridgmans table, see info for usage";
    Real dgp=-s "Coefficient in Bridgmans table, see info for usage";
    Real dpg=-dgp "Coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant Temperature
    Real dvT=gamma*v "Coefficient in Bridgmans table, see info for usage";
    Real dTv=-dvT "Coefficient in Bridgmans table, see info for usage";
    Real dsT=alpha*v "Coefficient in Bridgmans table, see info for usage";
    Real dTs=-dsT "Coefficient in Bridgmans table, see info for usage";
    Real duT=alpha*T*v - gamma*p*v
      "Coefficient in Bridgmans table, see info for usage";
    Real dTu=-duT "Coefficient in Bridgmans table, see info for usage";
    Real dhT=-v + alpha*T*v
      "Coefficient in Bridgmans table, see info for usage";
    Real dTh=-dhT "Coefficient in Bridgmans table, see info for usage";
    Real dfT=-gamma*p*v "Coefficient in Bridgmans table, see info for usage";
    Real dTf=-dfT "Coefficient in Bridgmans table, see info for usage";
    Real dgT=-v "Coefficient in Bridgmans table, see info for usage";
    Real dTg=-dgT "Coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant v
    Real dsv=alpha*alpha*v*v - gamma*v*cp/T
      "Coefficient in Bridgmans table, see info for usage";
    Real dvs=-dsv "Coefficient in Bridgmans table, see info for usage";
    Real duv=T*alpha*alpha*v*v - gamma*v*cp
      "Coefficient in Bridgmans table, see info for usage";
    Real dvu=-duv "Coefficient in Bridgmans table, see info for usage";
    Real dhv=T*alpha*alpha*v*v - alpha*v*v - gamma*v*cp
      "Coefficient in Bridgmans table, see info for usage";
    Real dvh=-dhv "Coefficient in Bridgmans table, see info for usage";
    Real dfv=gamma*v*s "Coefficient in Bridgmans table, see info for usage";
    Real dvf=-dfv "Coefficient in Bridgmans table, see info for usage";
    Real dgv=gamma*v*s - alpha*v*v
      "Coefficient in Bridgmans table, see info for usage";
    Real dvg=-dgv "Coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant s
    Real dus=dsv*p "Coefficient in Bridgmans table, see info for usage";
    Real dsu=-dus "Coefficient in Bridgmans table, see info for usage";
    Real dhs=-v*cp/T "Coefficient in Bridgmans table, see info for usage";
    Real dsh=-dhs "Coefficient in Bridgmans table, see info for usage";
    Real dfs=alpha*v*s + dus
      "Coefficient in Bridgmans table, see info for usage";
    Real dsf=-dfs "Coefficient in Bridgmans table, see info for usage";
    Real dgs=alpha*v*s - v*cp/T
      "Coefficient in Bridgmans table, see info for usage";
    Real dsg=-dgs "Coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant u
    Real dhu=p*alpha*v*v + gamma*v*cp*p - v*cp - p*T*alpha*alpha*v*v
      "Coefficient in Bridgmans table, see info for usage";
    Real duh=-dhu "Coefficient in Bridgmans table, see info for usage";
    Real dfu=s*T*alpha*v - gamma*v*cp*p - gamma*v*s*p + p*T*alpha*alpha*v*v
      "Coefficient in Bridgmans table, see info for usage";
    Real duf=-dfu "Coefficient in Bridgmans table, see info for usage";
    Real dgu=alpha*v*v*p + alpha*v*s*T - v*cp - gamma*v*s*p
      "Coefficient in Bridgmans table, see info for usage";
    Real dug=-dgu "Coefficient in Bridgmans table, see info for usage";
    //  Derivatives at constant h
    Real dfh=(s - v*alpha*p)*(v - v*alpha*T) - gamma*v*cp*p
      "Coefficient in Bridgmans table, see info for usage";
    Real dhf=-dfh "Coefficient in Bridgmans table, see info for usage";
    Real dgh=alpha*v*s*T - v*(s + cp)
      "Coefficient in Bridgmans table, see info for usage";
    Real dhg=-dgh "Coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant g
    Real dfg=gamma*v*s*p - v*s - alpha*v*v*p
      "Coefficient in Bridgmans table, see info for usage";
    Real dgf=-dfg "Coefficient in Bridgmans table, see info for usage";
    annotation (Documentation(info="<html>
<p>
Important: the phase equilibrium conditions are not yet considered.
this means that Bridgman's tables do not yet work in the two phase region.
Some derivatives are 0 or infinity anyways.
Idea: Do not use the values in Bridgmans table directly, all
derivatives are calculated as the quotient of two entries in the
table. The last letter indicates which variable is held constant in
taking the derivative. The second letters are the two variables
involved in the derivative and the first letter is always a d to remind
of differentiation.
</p>

<blockquote><pre>
Example 1: Get the derivative of specific entropy s w.r.t. Temperature at
constant specific volume (between identical to constant density)
constant volume  --> last letter v
Temperature      --> second letter T
Specific entropy --> second letter s
--> the needed value is dsv/dTv
Known variables:
Temperature T
pressure p
specific volume v
specific inner energy u
specific enthalpy h
specific entropy s
specific Helmholtz energy f
specific gibbs enthalpy g
Not included but useful:
density d
In order to convert derivatives involving density use the following
rules:
at constant density == at constant specific volume
ddx/dyx = -d*d*dvx/dyx with y,x any of T,p,u,h,s,f,g
dyx/ddx = -1/(d*d)dyx/dvx with y,x any of T,p,u,h,s,f,g
Usage example assuming water as the medium:
model BridgmansTablesForWater
extends ThermoFluid.BaseClasses.MediumModels.Water.WaterSteamMedium_ph;
Real derOfsByTAtConstantv \"derivative of sp. entropy by temperature at constant sp. volume\"
ThermoFluid.BaseClasses.MediumModels.Common.ExtraDerivatives dpro;
ThermoFluid.BaseClasses.MediumModels.Common.BridgmansTables bt;
equation
dpro = ThermoFluid.BaseClasses.MediumModels.SteamIF97.extraDerivs_pT(p[1],T[1]);
bt.p = p[1];
bt.T = T[1];
bt.v = 1/pro[1].d;
bt.s = pro[1].s;
bt.cp = pro[1].cp;
bt.alpha = dpro.alpha;
bt.gamma = dpro.gamma;
derOfsByTAtConstantv =  bt.dsv/bt.dTv;
                ...
end BridgmansTablesForWater;
                </pre></blockquote>

                </html>"));
  end BridgmansTables;

  record FundamentalConstants "Constants of the medium"
    extends Modelica.Icons.Record;
    SI.MolarHeatCapacity R_bar;
    SI.SpecificHeatCapacity R_s;
    SI.MolarMass MM;
    SI.MolarDensity rhored;
    SI.Temperature Tred;
    SI.AbsolutePressure pred;
    SI.SpecificEnthalpy h_off;
    SI.SpecificEntropy s_off;
  end FundamentalConstants;

  record AuxiliaryProperties "Intermediate property data record"
    extends Modelica.Icons.Record;
    SI.Pressure p "Pressure";
    SI.Temperature T "Temperature";
    SI.SpecificEnthalpy h "Specific enthalpy";
    SI.SpecificHeatCapacity R_s "Gas constant";
    SI.SpecificHeatCapacity cp "Specific heat capacity";
    SI.SpecificHeatCapacity cv "Specific heat capacity";
    SI.Density rho "Density";
    SI.SpecificEntropy s "Specific entropy";
    SI.DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    SI.DerPressureByDensity pd "Derivative of pressure w.r.t. density";
    Real vt "Derivative of specific volume w.r.t. temperature";
    Real vp "Derivative of specific volume w.r.t. pressure";
  end AuxiliaryProperties;

  record GibbsDerivs2
    "Derivatives of Gibbs function w.r.t. pressure and temperature"

    extends Modelica.Icons.Record;
    SI.Pressure p "Pressure";
    SI.Temperature T "Temperature";
    SI.SpecificHeatCapacity R_s "Specific heat capacity";
    Real pi(unit="1") "Dimensionless pressure";
    Real theta(unit="1") "Dimensionless temperature";
    Real g(unit="J/kg") "Gibbs function";
    Real gp(unit="m3/kg") "Derivative of g w.r.t. p";
    Real gpp(unit="m3/(kg.Pa)") "2nd derivative of g w.r.t. p";
    Real gT(unit="J/(kg.K)") "Derivative of g w.r.t. T";
    Real gTT(unit="J/(kg.K2)") "2nd derivative of g w.r.t. T";
    Real gTp(unit="m3/(kg.K)") "Mixed derivative of g w.r.t. T and p";
  end GibbsDerivs2;

  record NewtonDerivatives_dT
    "Derivatives for fast inverse calculations of Gibbs function"
    extends Modelica.Icons.Record;
    SI.SpecificVolume v "Specific volume";
    Real vp "Derivative of specific volume w.r.t. pressure";
  end NewtonDerivatives_dT;

  function gibbsToBridgmansTables
    "Calculates base coefficients for Bridgman's tables from gibbs enthalpy"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
    output SI.SpecificVolume v "Specific volume";
    output SI.Pressure p=g.p "Pressure";
    output SI.Temperature T=g.T "Temperature";
    output SI.SpecificEntropy s "Specific entropy";
    output SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
    output IsobaricVolumeExpansionCoefficient alpha
      "Isobaric volume expansion coefficient";
    // beta in Bejan
    output IsothermalCompressibility gamma "Isothermal compressibility";
    // kappa in Bejan
  protected
    Real vt(unit="m3/(kg.K)")
      "Derivative of specific volume w.r.t. temperature";
    Real vp(unit="m4.kg-2.s2") "Derivative of specific volume w.r.t. pressure";
  algorithm
    vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    v := (g.R_s*g.T*g.pi*g.gpi)/g.p;
    s := g.R_s*(g.tau*g.gtau - g.g);
    cp := -g.R_s*g.tau*g.tau*g.gtautau;
    alpha := vt/v;
    gamma := -vp/v;
  end gibbsToBridgmansTables;

  function helmholtzToBridgmansTables
    "Calculates base coefficients for Bridgmans tables from Helmholtz energy"
    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
    output SI.SpecificVolume v=1/f.d "Specific volume";
    output SI.Pressure p "Pressure";
    output SI.Temperature T=f.T "Temperature";
    output SI.SpecificEntropy s "Specific entropy";
    output SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
    output IsobaricVolumeExpansionCoefficient alpha
      "Isobaric volume expansion coefficient";
    // beta in Bejan
    output IsothermalCompressibility gamma "Isothermal compressibility";
    // kappa in Bejan
  protected
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    DerPressureBySpecificVolume pv
      "Derivative of pressure w.r.t. specific volume";
    SI.SpecificHeatCapacity cv "Isochoric specific heat capacity";
  algorithm
    p := f.R_s*f.d*f.T*f.delta*f.fdelta;
    pv := -(f.d*f.d)*f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    s := f.R_s*(f.tau*f.ftau - f.f);
    alpha := -f.d*pt/pv;
    gamma := -f.d/pv;
    cp := f.R_s*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)
      ^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
  end helmholtzToBridgmansTables;

  function gibbsToBoundaryProps
    "Calculate phase boundary property record from dimensionless Gibbs function"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
    output PhaseBoundaryProperties sat "Phase boundary properties";
  protected
    Real vt "Derivative of specific volume w.r.t. temperature";
    Real vp "Derivative of specific volume w.r.t. pressure";
  algorithm
    sat.d := g.p/(g.R_s*g.T*g.pi*g.gpi);
    sat.h := g.R_s*g.T*g.tau*g.gtau;
    sat.u := g.T*g.R_s*(g.tau*g.gtau - g.pi*g.gpi);
    sat.s := g.R_s*(g.tau*g.gtau - g.g);
    sat.cp := -g.R_s*g.tau*g.tau*g.gtautau;
    sat.cv := g.R_s*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
      *g.gtaupi)/(g.gpipi));
    vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
    sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
    sat.pd := -g.R_s*g.T*g.gpi*g.gpi/(g.gpipi);
  end gibbsToBoundaryProps;

  function helmholtzToBoundaryProps
    "Calculate phase boundary property record from dimensionless Helmholtz function"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
    output PhaseBoundaryProperties sat "Phase boundary property record";
  protected
    SI.Pressure p "Pressure";
  algorithm
    p := f.R_s*f.d*f.T*f.delta*f.fdelta;
    sat.d := f.d;
    sat.h := f.R_s*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    sat.s := f.R_s*(f.tau*f.ftau - f.f);
    sat.u := f.R_s*f.T*f.tau*f.ftau;
    sat.cp := f.R_s*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)
      ^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    sat.cv := f.R_s*(-f.tau*f.tau*f.ftautau);
    sat.pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    sat.pd := f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  end helmholtzToBoundaryProps;

  function cv2Phase
    "Compute isochoric specific heat capacity inside the two-phase region"

    extends Modelica.Icons.Function;
    input PhaseBoundaryProperties liq "Properties on the boiling curve";
    input PhaseBoundaryProperties vap "Properties on the condensation curve";
    input SI.MassFraction x "Vapour mass fraction";
    input SI.Temperature T "Temperature";
    input SI.Pressure p "Properties";
    output SI.SpecificHeatCapacity cv "Isochoric specific heat capacity";
  protected
    Real dpT "Derivative of pressure w.r.t. temperature";
    Real dxv "Derivative of vapour mass fraction w.r.t. specific volume";
    Real dvTl "Derivative of liquid specific volume w.r.t. temperature";
    Real dvTv "Derivative of vapour specific volume w.r.t. temperature";
    Real duTl "Derivative of liquid specific inner energy w.r.t. temperature";
    Real duTv "Derivative of vapour specific inner energy w.r.t. temperature";
    Real dxt "Derivative of vapour mass fraction w.r.t. temperature";
  algorithm
    dxv := if (liq.d <> vap.d) then liq.d*vap.d/(liq.d - vap.d) else 0.0;
    dpT := (vap.s - liq.s)*dxv;
    // wrong at critical point
    dvTl := (liq.pt - dpT)/liq.pd/liq.d/liq.d;
    dvTv := (vap.pt - dpT)/vap.pd/vap.d/vap.d;
    dxt := -dxv*(dvTl + x*(dvTv - dvTl));
    duTl := liq.cv + (T*liq.pt - p)*dvTl;
    duTv := vap.cv + (T*vap.pt - p)*dvTv;
    cv := duTl + x*(duTv - duTl) + dxt*(vap.u - liq.u);
  end cv2Phase;

  function cvdpT2Phase
    "Compute isochoric specific heat capacity inside the two-phase region and derivative of pressure w.r.t. temperature"

    extends Modelica.Icons.Function;
    input PhaseBoundaryProperties liq "Properties on the boiling curve";
    input PhaseBoundaryProperties vap "Properties on the condensation curve";
    input SI.MassFraction x "Vapour mass fraction";
    input SI.Temperature T "Temperature";
    input SI.Pressure p "Properties";
    output SI.SpecificHeatCapacity cv "Isochoric specific heat capacity";
    output Real dpT "Derivative of pressure w.r.t. temperature";
  protected
    Real dxv "Derivative of vapour mass fraction w.r.t. specific volume";
    Real dvTl "Derivative of liquid specific volume w.r.t. temperature";
    Real dvTv "Derivative of vapour specific volume w.r.t. temperature";
    Real duTl "Derivative of liquid specific inner energy w.r.t. temperature";
    Real duTv "Derivative of vapour specific inner energy w.r.t. temperature";
    Real dxt "Derivative of vapour mass fraction w.r.t. temperature";
  algorithm
    dxv := if (liq.d <> vap.d) then liq.d*vap.d/(liq.d - vap.d) else 0.0;
    dpT := (vap.s - liq.s)*dxv;
    // wrong at critical point
    dvTl := (liq.pt - dpT)/liq.pd/liq.d/liq.d;
    dvTv := (vap.pt - dpT)/vap.pd/vap.d/vap.d;
    dxt := -dxv*(dvTl + x*(dvTv - dvTl));
    duTl := liq.cv + (T*liq.pt - p)*dvTl;
    duTv := vap.cv + (T*vap.pt - p)*dvTv;
    cv := duTl + x*(duTv - duTl) + dxt*(vap.u - liq.u);
  end cvdpT2Phase;

  function gibbsToExtraDerivs
    "Compute additional thermodynamic derivatives from dimensionless Gibbs function"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
    output ExtraDerivatives dpro "Additional property derivatives";
  protected
    Real vt "Derivative of specific volume w.r.t. temperature";
    Real vp "Derivative of specific volume w.r.t. pressure";
    SI.Density d "Density";
    SI.SpecificVolume v "Specific volume";
    SI.SpecificHeatCapacity cv "Isochoric heat capacity";
    SI.SpecificHeatCapacity cp "Isobaric heat capacity";
  algorithm
    d := g.p/(g.R_s*g.T*g.pi*g.gpi);
    v := 1/d;
    vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    cp := -g.R_s*g.tau*g.tau*g.gtautau;
    cv := g.R_s*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
      *g.gtaupi)/g.gpipi);
    dpro.kappa := -1/(d*g.p)*cp/(vp*cp + vt*vt*g.T);
    dpro.theta := cp/(d*g.p*(-vp*cp + vt*v - g.T*vt*vt));
    dpro.alpha := d*vt;
    dpro.beta := -vt/(g.p*vp);
    dpro.gamma := -d*vp;
    dpro.mu := -(v - g.T*vt)/cp;
  end gibbsToExtraDerivs;

  function helmholtzToExtraDerivs
    "Compute additional thermodynamic derivatives from dimensionless Helmholtz function"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
    output ExtraDerivatives dpro "Additional property derivatives";
  protected
    SI.Pressure p "Pressure";
    SI.SpecificVolume v "Specific volume";
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    DerPressureBySpecificVolume pv
      "Derivative of pressure w.r.t. specific volume";
    SI.SpecificHeatCapacity cv "Isochoric specific heat capacity";
  algorithm
    v := 1/f.d;
    p := f.R_s*f.d*f.T*f.delta*f.fdelta;
    pv := -(f.d*f.d)*f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    cv := f.R_s*(-f.tau*f.tau*f.ftautau);
    dpro.kappa := 1/(f.d*p)*((-pv*cv + pt*pt*f.T)/(cv));
    dpro.theta := -1/(f.d*p)*((-pv*cv + f.T*pt*pt)/(cv + pt*v));
    dpro.alpha := -f.d*pt/pv;
    dpro.beta := pt/p;
    dpro.gamma := -f.d/pv;
    dpro.mu := (v*pv + f.T*pt)/(pt*pt*f.T - pv*cv);
  end helmholtzToExtraDerivs;

  function Helmholtz_ph
    "Function to calculate analytic derivatives for computing d and t given p and h"
    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
    output NewtonDerivatives_ph nderivs
      "Derivatives for Newton iteration to calculate d and t from p and h";
  protected
    SI.SpecificHeatCapacity cv "Isochoric heat capacity";
  algorithm
    cv := -f.R_s*(f.tau*f.tau*f.ftautau);
    nderivs.p := f.d*f.R_s*f.T*f.delta*f.fdelta;
    nderivs.h := f.R_s*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    nderivs.pd := f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    nderivs.pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    nderivs.ht := cv + nderivs.pt/f.d;
    nderivs.hd := (nderivs.pd - f.T*nderivs.pt/f.d)/f.d;
  end Helmholtz_ph;

  function Helmholtz_pT
    "Function to calculate analytic derivatives for computing d and t given p and t"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
    output NewtonDerivatives_pT nderivs
      "Derivatives for Newton iteration to compute d and t from p and t";
  algorithm
    nderivs.p := f.d*f.R_s*f.T*f.delta*f.fdelta;
    nderivs.pd := f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  end Helmholtz_pT;

  function Helmholtz_ps
    "Function to calculate analytic derivatives for computing d and t given p and s"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
    output NewtonDerivatives_ps nderivs
      "Derivatives for Newton iteration to compute d and t from p and s";
  protected
    SI.SpecificHeatCapacity cv "Isochoric heat capacity";
  algorithm
    cv := -f.R_s*(f.tau*f.tau*f.ftautau);
    nderivs.p := f.d*f.R_s*f.T*f.delta*f.fdelta;
    nderivs.s := f.R_s*(f.tau*f.ftau - f.f);
    nderivs.pd := f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    nderivs.pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    nderivs.st := cv/f.T;
    nderivs.sd := -nderivs.pt/(f.d*f.d);
  end Helmholtz_ps;

  function smoothStep
    "Approximation of a general step, such that the characteristic is continuous and differentiable"
    extends Modelica.Icons.Function;
    input Real x "Abscissa value";
    input Real y1 "Ordinate value for x > 0";
    input Real y2 "Ordinate value for x < 0";
    input Real x_small(min=0) = 1e-5
      "Approximation of step for -x_small <= x <= x_small; x_small > 0 required";
    output Real y "Ordinate value to approximate y = if x > 0 then y1 else y2";
  algorithm
    y := smooth(1, if x > x_small then y1 else if x < -x_small then y2 else if
      abs(x_small) > 0 then (x/x_small)*((x/x_small)^2 - 3)*(y2 - y1)/4 + (y1
       + y2)/2 else (y1 + y2)/2);

    annotation (
      Inline=true,
      smoothOrder=1,
      Documentation(revisions="<html>
<ul>
<li><em>April 29, 2008</em>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
    Designed and implemented.</li>
<li><em>August 12, 2008</em>
    by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
    Minor modification to cover the limit case <code>x_small -> 0</code> without division by zero.</li>
</ul>
</html>", info="<html>
<p>
This function is used to approximate the equation
</p>
<blockquote><pre>
y = <strong>if</strong> x &gt; 0 <strong>then</strong> y1 <strong>else</strong> y2;
</pre></blockquote>

<p>
by a smooth characteristic, so that the expression is continuous and differentiable:
</p>

<blockquote><pre>
y = <strong>smooth</strong>(1, <strong>if</strong> x &gt;  x_small <strong>then</strong> y1 <strong>else</strong>
              <strong>if</strong> x &lt; -x_small <strong>then</strong> y2 <strong>else</strong> f(y1, y2));
</pre></blockquote>

<p>
In the region -x_small &lt; x &lt; x_small a 2nd order polynomial is used
for a smooth transition from y1 to y2.
</p>

<p>
If <strong>mass fractions</strong> X[:] are approximated with this function then this can be performed
for all <strong>nX</strong> mass fractions, instead of applying it for nX-1 mass fractions and computing
the last one by the mass fraction constraint sum(X)=1. The reason is that the approximating function has the
property that sum(X) = 1, provided sum(X_a) = sum(X_b) = 1
(and y1=X_a[i], y2=X_b[i]).
This can be shown by evaluating the approximating function in the abs(x) &lt; x_small
region (otherwise X is either X_a or X_b):
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
  end smoothStep;

  function Gibbs2_ph
    "Function to calculate analytic derivatives for computing T given p and h"
    extends Modelica.Icons.Function;
    input ThermofluidStream.Media.myMedia.Common.GibbsDerivs2 g
      "Dimensionless derivatives of Gibbs function";
    output ThermofluidStream.Media.myMedia.Common.NewtonDerivatives_ph nderivs
      "Derivatives for Newton iteration to calculate d and t from p and h";

  algorithm
    nderivs.h := g.g - g.T*g.gT;
    nderivs.ht := -g.T*g.gTT;

    //dummy values - DO NOT USE
    nderivs.p := 0.0;
    nderivs.pd := 0.0;
    nderivs.pt := 0.0;
    nderivs.hd := 0.0;
  end Gibbs2_ph;

  function Gibbs2_dT
    "Function to calculate analytic derivatives for computing p given d and T"
    extends Modelica.Icons.Function;
    input ThermofluidStream.Media.myMedia.Common.GibbsDerivs2 g
      "Dimensionless derivatives of Gibbs function";
    output ThermofluidStream.Media.myMedia.Common.NewtonDerivatives_dT nderivs
      "Derivatives for Newton iteration to compute p from d and T";

  algorithm
    nderivs.v := g.gp;
    nderivs.vp := nderivs.v*g.gpp/g.gp;
  end Gibbs2_dT;

  function Gibbs2_ps
    "Function to calculate analytic derivatives for computing d and t given p and s"

    extends Modelica.Icons.Function;
    input ThermofluidStream.Media.myMedia.Common.GibbsDerivs2 g
      "Dimensionless derivatives of Gibbs function";
    output ThermofluidStream.Media.myMedia.Common.NewtonDerivatives_ps nderivs
      "Derivatives for Newton iteration to compute T from p and s";

  algorithm
    nderivs.s := -g.gT;
    nderivs.st := -g.gTT;

    //dummy values - DO NOT USE
    nderivs.p := 0.0;
    nderivs.pd := 0.0;
    nderivs.pt := 0.0;
    nderivs.sd := 0.0;
  end Gibbs2_ps;

  annotation (
    Documentation(
      info="<html>
<h4>Package description</h4>
<p>Package Modelica.Media.Common provides records and functions shared by many of the property sub-packages.
High accuracy fluid property models share a lot of common structure, even if the actual models are different.
Common data structures and computations shared by these property models are collected in this library.
</p>
</html>",
      revisions="<html>
<ul>
  <li>
    First implemented: <em>July, 2000</em>
    by Hubertus Tummescheit
    for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
  </li>
  <li>
    Code reorganization, enhanced documentation, additional functions: <em>December, 2002</em>
    by Hubertus Tummescheit and move to Modelica properties library.
  </li>
  <li>
    Inclusion into Modelica.Media: September 2003
  </li>
</ul>

<address>
Author: Hubertus Tummescheit,<br>
Lund University<br>
Department of Automatic Control<br>
Box 118, 22100 Lund, Sweden<br>
email: hubertus@control.lth.se
</address>
</html>"));
end Common;
