within TILMediaWrapper.VLEFluidWrapper;
package PartialModels
  extends Modelica.Icons.InternalPackage;

  record BaseVLEFluid "Base record for VLEFluid definitions"
    extends TILMedia.Internals.ClassTypes.Record;
    constant Boolean fixedMixingRatio
      "Treat medium as pseudo pure in Modelica if it is a mixture"
      annotation(Dialog, HideResult = true);
    constant Integer nc_propertyCalculation(min=1)
      "Number of components for fluid property calculations"
      annotation(Dialog, HideResult = true);
    final constant Integer nc=if fixedMixingRatio then 1 else nc_propertyCalculation
      "Number of components in Modelica models"
      annotation(Evaluate=true, HideResult = true);
    parameter TILMedia.Internals.VLEFluidName[:] vleFluidNames={""}
      "Array of VLEFluid names e.g. {\"vleFluidName\"} for pure component"
      annotation (Dialog, choices);
    parameter Real[nc_propertyCalculation] mixingRatio_propertyCalculation = {1}
      "Mixing ratio for fluid property calculation (={1} for pure components)"
      annotation(Dialog, HideResult = true);
    final parameter Real[nc] defaultMixingRatio = if fixedMixingRatio then {1} else mixingRatio_propertyCalculation
      "Default composition for models in Modelica (={1} for pure components)"
      annotation(HideResult = true);
    final parameter Real xi_default[nc-1] = defaultMixingRatio[1:nc-1]/sum(defaultMixingRatio)
      "Default mass fractions"
      annotation(HideResult = true);
    final parameter String concatVLEFluidName=TILMedia.Internals.concatNames(vleFluidNames)
      annotation(Dialog(tab="Internals"));
    constant Integer ID=0
      "ID is used to map the selected VLEFluid to the sim.cumulatedVLEFluidMass array item" annotation(HideResult = true);
    annotation (
    Documentation(info="<html>
<p><br>Every VLEFluid substance model contains a substance record as replaceable parameter extending from this base VLEFluid model. The substance record contains the following parameters: </p>
<ul>
<li>fixedMixingRatio - Boolean = true, if mixing ratio is fixed during simulation. </li>
<li>nc_propertyCalculation - Integer with number of components which are calculated. </li>
<li>&QUOT;substanceNames&QUOT; - VLEFluidName 1, VLEFluidName 2, and so on. Array which lists the substance names. </li>
<li>mixingRatio_propertyCalculation - Array with the mixing ratio of all substances. </li>
</ul>
<p><b>Access additional substances:</b> </p>
<p>To acces the properties of an additional substance, it is possible to create a new substance reccord. For more information on the acces of additional propeties see the <a href=\"Modelica:TILMedia.UsersGuide.SubstanceRecord\">substance record documentation</a>. </p>
<p>Furthermore it is possible to parameterize this VLEFluide base record, using a VLEFluid substance name, listed in the <a href=\"Modelica:TILMedia.UsersGuide.SubstanceNames\">substance names documentation</a>. An example how to parameterize the base VLEFluid model is shown below. However note that this is only a local configuration and therefore only accesible in the corresponding model.</p>
<p><img src=\"modelica://TILMedia/Images/Base_VLE_Parameter_frame.PNG\"/> </p>
</html>"));
  end BaseVLEFluid;

  package VLEFluid_ph "TIL-media two-phase fluid"
    extends ThermofluidStream.Media.myMedia.Interfaces.PartialTwoPhaseMedium(
      final ThermoStates=ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.phX,
      final mediumName=myFluidInstance.concatVLEFluidName,
      final substanceNames={myFluidInstance.concatVLEFluidName},
      final singleState=false,
      final reference_X=cat(
          1,
          myFluidInstance.xi_default,
          {1 - sum(myFluidInstance.xi_default)}),
      fluidConstants=vlefluidConstants);
        //TODO: reference_p, reference_T, p_default, T_default

    replaceable record FluidType = PartialModels.BaseVLEFluid
        annotation(choicesAllMatching=true, Dialog(tab="TIL_Media"));
    constant Modelica.Units.SI.Temperature triplePointTemperature=0;
    constant Modelica.Units.SI.AbsolutePressure triplePointPressure=0;
    constant Modelica.Units.SI.Temperature meltingPoint=0;

    // fluid type should be defined here, instead of in the funcitons, but this results in a weird error in dymola: "Error, not all 'end' could be expanded."
    // hencce workaround mit illegalFluidInstance in den funktionen (da es vmlt. nicht legales Modelica ist: illegalFluidInstance)
    constant FluidType myFluidInstance;

    //TODO: implement missing values as data record for each fluid when needed.
    constant ThermofluidStream.Media.myMedia.Interfaces.Types.TwoPhase.FluidConstants[1] vlefluidConstants(
      each chemicalFormula=myFluidInstance.concatVLEFluidName,
      each structureFormula=myFluidInstance.concatVLEFluidName,
      each iupacName=myFluidInstance.concatVLEFluidName,
      each casRegistryNumber=myFluidInstance.concatVLEFluidName,
      each molarMass=TILMedia.VLEFluidFunctions.molarMass_n(vleFluidType=myFluidInstance, compNo=0),
      each criticalMolarVolume=TILMedia.VLEFluidFunctions.molarMass_n(vleFluidType=myFluidInstance, compNo=0)/
          TILMedia.VLEFluidFunctions.criticalDensity_xi(vleFluidType=myFluidInstance, xi=myFluidInstance.xi_default),
      each criticalTemperature=TILMedia.VLEFluidFunctions.criticalTemperature_xi(vleFluidType=myFluidInstance, xi=myFluidInstance.xi_default),
      each criticalPressure=TILMedia.VLEFluidFunctions.criticalPressure_xi(vleFluidType=myFluidInstance, xi=myFluidInstance.xi_default),
      each triplePointTemperature=triplePointTemperature,
      each triplePointPressure=triplePointPressure,
      each meltingPoint=meltingPoint,
      each normalBoilingPoint=saturationTemperature(101325),
      each acentricFactor=Modelica.Constants.inf,
      each dipoleMoment=Modelica.Constants.inf,
      each hasCriticalData=true);

    // VLEFluid ignores FixedPhase phase in state
    redeclare record extends ThermodynamicState "Thermodynamic state variables"
      AbsolutePressure p "Absolute pressure of medium";
      SpecificEnthalpy h "Specific enthalpy of medium";
      MassFraction[nX] X(start=reference_X) "Mass fractions (= (component mass)/total mass  m_i/m)";
    end ThermodynamicState;

    redeclare model extends BaseProperties
      TILMedia.VLEFluid_ph fluid( p=p, h=h, xi=Xi,
        redeclare parameter FluidType vleFluidType,
        final stateSelectPreferForInputs=preferredMediumStates,
        final computeTransportProperties=false,
        final interpolateTransportProperties=true,
        final computeSurfaceTension=false,
        final deactivateDensityDerivatives=true,
        final computeVLEAdditionalProperties=false,
        final deactivateTwoPhaseRegion=false);

    equation
      d = fluid.d;
      T = fluid.T;
      u = h-p/d; // TODO: or from fluid somehow?
      R_s = Modelica.Constants.R/MM;  // TODO: or from fluid somehow?
      MM = fluid.M;

      state.h = h;
      state.p = p;
      state.X = X;
      state.phase = 0;

      //2phase specific
      sat.psat = p;
      sat.Tsat = TILMedia.VLEFluidObjectFunctions.dewTemperature_pxi(fluid.p, fluid.xi, fluid.vleFluidPointer);
    end BaseProperties;
    ///////////////////////////////////////////////////////////////////////////
    // start fks to implement the interface PartialMedium
    ///////////////////////////////////////////////////////////////////////////
    redeclare function extends setState_pTX
    algorithm
      state.p :=p;
      state.h := TILMedia.VLEFluidFunctions.specificEnthalpy_pTxi(vleFluidType=myFluidInstance, p=p, T=T, xi=X);
      state.X := if size(X, 1) == nX then X else cat(1, X, {1 - sum(X)});
    end setState_pTX;

    redeclare function extends setState_phX
    algorithm
      state.p :=p;
      state.h :=h;
      state.X := if size(X, 1) == nX then X else cat(1, X, {1 - sum(X)});
    end setState_phX;

    redeclare function extends setState_psX
    algorithm
      state.p :=p;
      state.h := TILMedia.VLEFluidFunctions.specificEnthalpy_psxi(vleFluidType=myFluidInstance, p=p, s=s, xi=X);
      state.X := if size(X, 1) == nX then X else cat(1, X, {1 - sum(X)});
    end setState_psX;

    redeclare function extends setState_dTX
    algorithm
      state.p := TILMedia.VLEFluidFunctions.pressure_dTxi(vleFluidType=myFluidInstance, d=d, T=T, xi=X);
      state.h := TILMedia.VLEFluidFunctions.specificEnthalpy_dTxi(vleFluidType=myFluidInstance, d=d, T=T, xi=X);
      state.X := if size(X, 1) == nX then X else cat(1, X, {1 - sum(X)});
    end setState_dTX;

    redeclare function extends setSmoothState
    protected
      AbsolutePressure p;
      SpecificEnthalpy h;
      MassFraction Xi[nXi];
    algorithm
        p := ThermofluidStream.Undirected.Internal.regStep(x, pressure(state_a), pressure(state_b), x_small);
        h := ThermofluidStream.Undirected.Internal.regStep(x, specificEnthalpy(state_a), specificEnthalpy(state_b), x_small);
        for i in 1:nXi loop
          Xi[i] := ThermofluidStream.Undirected.Internal.regStep(x, state_a.X[i], state_b.X[i], x_small);
        end for;

        state := setState_phX(p, h, Xi);
    end setSmoothState;

    redeclare function extends dynamicViscosity
    algorithm
      eta := TILMedia.VLEFluidFunctions.dynamicViscosity_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi= state.X);
    end dynamicViscosity;

    redeclare function extends thermalConductivity
    algorithm
      lambda := TILMedia.VLEFluidFunctions.thermalConductivity_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi= state.X);
    end thermalConductivity;
    //redeclare function extends massFraction //  done in PartialPureSubstance

    redeclare function extends pressure
    algorithm
      p :=state.p;
    end pressure;

    redeclare function extends temperature
    algorithm
      T := TILMedia.VLEFluidFunctions.temperature_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi= state.X);
    end temperature;

    redeclare function extends density
    algorithm
      d := TILMedia.VLEFluidFunctions.density_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi= state.X);
    end density;

    redeclare function extends specificEnthalpy
    algorithm
      h :=state.h;
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy
    algorithm
      u :=specificEnthalpy(state) - pressure(state)/density(state);
    end specificInternalEnergy;

    redeclare function extends specificEntropy
    algorithm
      s := TILMedia.VLEFluidFunctions.specificEntropy_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi= state.X);
    end specificEntropy;

    redeclare function extends specificGibbsEnergy
    algorithm
      assert(false, "The VLEFluid wrapper currently does not implement specificGibbsEnergy");
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy
    algorithm
      assert(false, "The VLEFluid wrapper currently does not implement specificHelmholtzEnergy");
    end specificHelmholtzEnergy;

    redeclare function extends specificHeatCapacityCp
    algorithm
      cp := TILMedia.VLEFluidFunctions.specificIsobaricHeatCapacity_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi= state.X);
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
    algorithm
      cv := TILMedia.VLEFluidFunctions.specificIsochoricHeatCapacity_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi= state.X);
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent
    algorithm
      gamma := TILMedia.VLEFluidFunctions.heatCapacityRatio_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi= state.X);
    end isentropicExponent;

    redeclare function extends isentropicEnthalpy
    algorithm
      h_is :=specificEnthalpy_psX(p=p_downstream, s=specificEntropy(refState), X=refState.X);
    end isentropicEnthalpy;

    redeclare function extends velocityOfSound
    algorithm
      a :=TILMedia.VLEFluidFunctions.speedOfSound_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi=state.X);
    end velocityOfSound;

    redeclare function extends isobaricExpansionCoefficient
    algorithm
      beta := TILMedia.VLEFluidFunctions.isobaricThermalExpansionCoefficient_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi= state.X);
    end isobaricExpansionCoefficient;

    redeclare function extends isothermalCompressibility
    algorithm
      kappa :=TILMedia.VLEFluidFunctions.isothermalCompressibility_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi=state.X);
    end isothermalCompressibility;

    redeclare function extends density_derp_h
    algorithm
      ddph :=TILMedia.VLEFluidFunctions.densityDerivativeWRTpressure_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi=state.X);
    end density_derp_h;

    redeclare function extends density_derh_p
    algorithm
      ddhp :=TILMedia.VLEFluidFunctions.densityDerivativeWRTspecificEnthalpy_phxi(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi=state.X);
    end density_derh_p;

    redeclare function extends density_derp_T
    protected
      Modelica.Units.SI.Density d=density(state);
    algorithm
      // ANNAHME: mehrere annahmen, sh. ideen doc
      ddpT := density_derp_h(state)+density_derh_p(state)*(1/d-temperature(state)*Modelica.Math.log(d)*density_derT_p(state));
    end density_derp_T;

    redeclare function extends density_derT_p
    algorithm
      // ANNAHME: dh/dT = cp
      ddTp := density_derh_p(state)*specificHeatCapacityCp(state);
    end density_derT_p;

    redeclare function extends density_derX
    algorithm
      // TODO: check if that is correct component number
      for i in 1:nX loop
        dddX[i] :=TILMedia.VLEFluidFunctions.densityDerivativeWRTmassFraction_phxin(vleFluidType=myFluidInstance, p=state.p, h=state.h, xi=state.X, compNo=i);
      end for;
    end density_derX;

    // for some reason vlefluidConstants.molarMass does not work in initialization
    redeclare function molarMass
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MolarMass MM "Mixture molar mass";

    algorithm

      MM :=TILMedia.VLEFluidFunctions.molarMass_n(vleFluidType=myFluidInstance, compNo=0);
    end molarMass;

    ///////////////////////////////////////////////////////////////////////////
    // start fks to implement the interface PartialTwoPhaseMedium
    ///////////////////////////////////////////////////////////////////////////

    redeclare function extends setDewState
    algorithm
      state := setState_phX(p=sat.psat, h=dewEnthalpy(sat),  X=X_default);
    end setDewState;

    redeclare function extends setBubbleState
    algorithm
      state := setState_ph(p=sat.psat, h=bubbleEnthalpy(sat));
    end setBubbleState;

    redeclare function extends bubbleEnthalpy
    algorithm
      hl := TILMedia.VLEFluidFunctions.bubbleSpecificEnthalpy_pxi(vleFluidType=myFluidInstance, p=sat.psat, xi=X_default[1:nXi]);
    end bubbleEnthalpy;

    redeclare function extends dewEnthalpy
    algorithm
      hv := TILMedia.VLEFluidFunctions.dewSpecificEnthalpy_pxi(vleFluidType=myFluidInstance, p=sat.psat, xi=X_default[1:nXi]);
    end dewEnthalpy;

    redeclare function extends bubbleEntropy
    algorithm
      sl :=TILMedia.VLEFluidFunctions.bubbleSpecificEntropy_pxi(vleFluidType=myFluidInstance, p=sat.psat, xi=X_default[1:nXi]);
    end bubbleEntropy;

    redeclare function extends dewEntropy
    algorithm
      sv :=TILMedia.VLEFluidFunctions.dewSpecificEntropy_pxi(vleFluidType=myFluidInstance, p=sat.psat, xi=X_default[1:nXi]);
    end dewEntropy;

    redeclare function extends bubbleDensity
    algorithm
      dl :=TILMedia.VLEFluidFunctions.bubbleDensity_pxi(vleFluidType=myFluidInstance, p=sat.psat, xi=X_default[1:nXi]);
    end bubbleDensity;

    redeclare function extends dewDensity
    algorithm
      dv :=TILMedia.VLEFluidFunctions.dewDensity_pxi(vleFluidType=myFluidInstance, p=sat.psat, xi=X_default[1:nXi]);
    end dewDensity;

    redeclare function extends saturationPressure
    algorithm
      p :=TILMedia.VLEFluidFunctions.dewPressure_Txi(vleFluidType=myFluidInstance, T=T, xi=X_default[1:nXi]);
    end saturationPressure;

    redeclare function extends saturationTemperature
    algorithm
      T :=TILMedia.VLEFluidFunctions.dewTemperature_pxi(vleFluidType=myFluidInstance, p=p, xi=X_default[1:nXi]);
    end saturationTemperature;

    redeclare function extends saturationTemperature_derp
    algorithm
      assert(false, "The VLEFluid wrapper currently does not implement saturationTemperature_derp.");
    end saturationTemperature_derp;

    redeclare function extends surfaceTension
    algorithm
      sigma :=TILMedia.VLEFluidFunctions.surfaceTension_pTxi(vleFluidType=myFluidInstance, p=sat.psat, T=sat.Tsat, xi=X_default[1:nXi]);
    end surfaceTension;

    redeclare function extends dBubbleDensity_dPressure
    algorithm
      assert(false, "The VLEFluid wrapper currently does not implement dBubbleDensity_dPressure.");
    end dBubbleDensity_dPressure;

    redeclare function extends dDewDensity_dPressure
    algorithm
      assert(false, "The VLEFluid wrapper currently does not implement dDewDensity_dPressure.");
    end dDewDensity_dPressure;

    redeclare function extends dBubbleEnthalpy_dPressure
    algorithm
      assert(false, "The VLEFluid wrapper currently does not implement dBubbleEnthalpy_dPressure.");
    end dBubbleEnthalpy_dPressure;

    redeclare function extends dDewEnthalpy_dPressure
    algorithm
      assert(false, "The VLEFluid wrapper currently does not implement dDewEnthalpy_dPressure.");
    end dDewEnthalpy_dPressure;
    annotation (
      Documentation(info="<html>
<p>FLE (fluid-liquid-equilibrium) fluids are the correspondance of a TwoPhaseMedium within the TIL media. </p>
<p>This wrapper makes the functional and the class interface accassable over the MSL Media interfaces PartialMedium and PartialTwoPhaseMedium.</p>
<p>The state is represented by p and h (Xi is empty).</p>
</html>"));
  end VLEFluid_ph;
end PartialModels;
