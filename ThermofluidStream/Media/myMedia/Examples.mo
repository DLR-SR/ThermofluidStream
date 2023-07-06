within ThermofluidStream.Media.myMedia;
package Examples
  "Demonstrate usage of property models"

  extends Modelica.Icons.ExamplesPackage;

  model SimpleLiquidWater "Example for Water.SimpleLiquidWater medium model"
    extends Modelica.Icons.Example;

    parameter SI.Volume V=1 "Volume";
    parameter SI.EnthalpyFlowRate H_flow_ext=1.e6
      "Constant enthalpy flow rate into the volume";

    package Medium = Water.ConstantPropertyLiquidWater (SpecificEnthalpy(max=
              1e6)) "Medium model";
    Medium.BaseProperties medium(T(start=300, fixed=true));

    Medium.BaseProperties medium2;
    Medium.ThermodynamicState state;
    Real m_flow_ext2;
    Real der_p;
    Real der_T;

    SI.Mass m(start=1.0);
    SI.InternalEnergy U;

    // Use type declarations from the Medium
    Medium.MassFlowRate m_flow_ext;
    Medium.DynamicViscosity eta=Medium.dynamicViscosity(state);
    Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(state);
  equation
    medium.p = 1.0e5;
    m = medium.d*V;
    U = m*medium.u;

    // Mass balance
    der(m) = m_flow_ext;

    // Energy balance
    der(U) = H_flow_ext;

    // Smooth state
    medium2.p = 1e5*time/10;
    medium2.T = 330;
    m_flow_ext2 = time - 30;
    state = Medium.setSmoothState(
          m_flow_ext2,
          medium.state,
          medium2.state,
          10);
    der_p = der(state.p);
    der_T = der(state.T);
    annotation (__DLR_experiment(StopTime=100), Documentation(info="<html>

</html>"));
  end SimpleLiquidWater;

  model IdealGasH2O "IdealGas H20 medium model"
    extends Modelica.Icons.Example;
    package Medium = IdealGases.SingleGases.H2O "Medium model";
    Medium.ThermodynamicState state "Thermodynamic state record";
    Medium.ThermodynamicState state2;
    Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(state);
    Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(state);
    Medium.IsentropicExponent k=Medium.isentropicExponent(state);
    Medium.SpecificEntropy s=Medium.specificEntropy(state);
    //  Medium.SpecificEntropy s2=Medium.specificEntropy(state2);
    Medium.VelocityOfSound a=Medium.velocityOfSound(state);
    Real beta=Medium.isobaricExpansionCoefficient(state);
    Real gamma=Medium.isothermalCompressibility(state);
    Medium.SpecificEnthalpy h_is=Medium.isentropicEnthalpyApproximation(2.0,
        state);

    Medium.ThermodynamicState smoothState;
    Real m_flow_ext;
    Real der_p;
    Real der_T;

  equation
    state.p = 100000.0;
    state.T = 200 + 1000*time;
    state2.p = 2.0e5;
    state2.T = 500.0;
    //  s2 = s;

    // Smooth state
    m_flow_ext = time - 0.5;
    smoothState = Medium.setSmoothState(
          m_flow_ext,
          state,
          state2,
          0.1);
    der_p = der(smoothState.p);
    der_T = der(smoothState.T);

    annotation (Documentation(info="<html>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</html>"), __DLR_experiment(StopTime=1));
  end IdealGasH2O;

  model WaterIF97 "WaterIF97 medium model"
    extends Modelica.Icons.Example;
    package Medium = Water.StandardWater "Medium model";
    Medium.BaseProperties medium(
      p(start=1.e5,
        fixed=true,
        stateSelect=StateSelect.prefer),
      h(start=1.0e5,
        fixed=true,
        stateSelect=StateSelect.prefer),
      T(start=275.0),
      d(start=999.0));
    SI.Volume V(start=0.1, fixed=true);
    parameter SI.VolumeFlowRate dV=0.0
      "Fixed time derivative of volume";
    parameter Medium.MassFlowRate m_flow_ext=0
      "Fixed mass flow rate into volume";
    parameter Medium.EnthalpyFlowRate H_flow_ext=10000
      "Fixed enthalpy flow rate into volume";
    SI.Mass m "Mass of volume";
    SI.InternalEnergy U "Internal energy of volume";

    Medium.ThermodynamicState state2;
    Medium.ThermodynamicState state;
    Real m_flow_ext2;
    Real der_p;
    Real der_T;

  equation
    der(V) = dV;
    m = medium.d*V;
    U = m*medium.u;

    // Mass balance
    der(m) = m_flow_ext;

    // Energy balance
    der(U) = H_flow_ext;

    // smooth states
    m_flow_ext2 = time - 0.5;
    state2 = Medium.setState_pT(1e5*(1 + time), 300 + 200*time);
    state = Medium.setSmoothState(
          m_flow_ext2,
          medium.state,
          state2,
          0.05);
    der_p = der(state.p);
    der_T = der(state.T);
    annotation (Documentation(info="<html>

</html>"), __DLR_experiment(StopTime=1));
  end WaterIF97;

  model MixtureGases "Test gas mixtures"
    extends Modelica.Icons.Example;

    parameter SI.Volume V=1 "Fixed size of volume 1 and volume 2";
    parameter SI.MassFlowRate m_flow_ext=0.01
      "Fixed mass flow rate into volume 1 and into volume 2";
    parameter SI.EnthalpyFlowRate H_flow_ext=5000
      "Fixed enthalpy flow rate into volume 1 and into volume 2";

    package Medium1 =
        ThermofluidStream.Media.myMedia.IdealGases.MixtureGases.CombustionAir
      "Medium model";
    Medium1.BaseProperties medium1(
      p(start=1.e5,
        fixed=true,
        stateSelect=StateSelect.prefer),
      T(start=300,
        fixed=true,
        stateSelect=StateSelect.prefer),
      X(start={0.8,0.2}));
    Real m1(quantity=Medium1.mediumName, start=1.0);
    SI.InternalEnergy U1;
    Medium1.SpecificHeatCapacity cp1=Medium1.specificHeatCapacityCp(medium1.state);
    Medium1.DynamicViscosity eta1=Medium1.dynamicViscosity(medium1.state);
    Medium1.ThermalConductivity lambda1=Medium1.thermalConductivity(medium1.state);

    package Medium2 =
        ThermofluidStream.Media.myMedia.IdealGases.MixtureGases.SimpleNaturalGas
      "Medium model";
    Medium2.BaseProperties medium2(
      p(start=1.e5,
        fixed=true,
        stateSelect=StateSelect.prefer),
      T(start=300,
        fixed=true,
        stateSelect=StateSelect.prefer),
      X(start={0.1,0.1,0.1,0.2,0.2,0.3}));
    Real m2(quantity=Medium2.mediumName, start=1.0);
    SI.InternalEnergy U2;
    Medium2.SpecificHeatCapacity cp2=Medium2.specificHeatCapacityCp(medium2.state);
    Medium2.DynamicViscosity eta2=Medium2.dynamicViscosity(medium2.state);
    Medium2.ThermalConductivity lambda2=Medium2.thermalConductivity(medium2.state);

    Medium2.ThermodynamicState state2=Medium2.setState_pTX(
            1.005e5,
            302,
            {0.3,0.2,0.2,0.1,0.1,0.1});
    Medium2.ThermodynamicState smoothState;
    Real m_flow_ext2;
    Real der_p;
    Real der_T;

  equation
    medium1.X = {0.8,0.2};
    m1 = medium1.d*V;
    U1 = m1*medium1.u;
    der(m1) = m_flow_ext;
    der(U1) = H_flow_ext;

    medium2.X = {0.1,0.1,0.1,0.2,0.2,0.3};
    m2 = medium2.d*V;
    U2 = m2*medium2.u;
    der(m2) = m_flow_ext;
    der(U2) = H_flow_ext;

    // Smooth state
    m_flow_ext2 = time - 0.5;
    smoothState = Medium2.setSmoothState(
          m_flow_ext2,
          medium2.state,
          state2,
          0.2);
    der_p = der(smoothState.p);
    der_T = der(smoothState.T);
    annotation (Documentation(info="<html>

</html>"), __DLR_experiment(StopTime=1));
  end MixtureGases;

  model MoistAir "Example for moist air"
    extends Modelica.Icons.Example;
    package Medium = Air.MoistAir "Medium model";
    Medium.BaseProperties medium(
      T(start=274.0, fixed=true),
      X(start={0.95,0.05}),
      p(start=1.0e5, fixed=true));
    //  Medium.SpecificEntropy s=Medium.specificEntropy(medium);
    //  Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(medium, 2.0e5);
    parameter Medium.MolarMass[2] MMx={Medium.dryair.MM,Medium.steam.MM}
      "Vector of molar masses (consisting of dry air and of steam)";
    Medium.MolarMass MM=1/((1 - medium.X[1])/MMx[1] + medium.X[1]/MMx[2])
      "Molar mass of gas part of mixture";
    //  Real[4] dddX=Medium.density_derX(medium,MM);

    Medium.ThermodynamicState state1;
    Medium.ThermodynamicState state2;
    Medium.ThermodynamicState smoothState;
    Real m_flow_ext;
    Real der_p;
    Real der_T;
  protected
    constant SI.Time unitTime=1;
  equation
    der(medium.p) = 0.0;
    der(medium.T) = 90;
    medium.X[Medium.Air] = 0.95;
    //    medium.X[Medium.Water] = 0.05;
    // one simple assumption only for quick testing:
    //  medium.X_liquidWater = if medium.X_sat < medium.X[2] then medium.X[2] - medium.X_sat else 0.0;

    // Smooth state
    m_flow_ext = time - 0.5;
    state1.p = 1.e5*(1 + time);
    state1.T = 300 + 10*time;
    state1.X = {time,1 - time}/unitTime;
    state2.p = 1.e5*(1 + time/2);
    state2.T = 340 - 20*time;
    state2.X = {0.5*time,1 - 0.5*time}/unitTime;
    smoothState = Medium.setSmoothState(
          m_flow_ext,
          state1,
          state2,
          0.2);
    der_p = der(smoothState.p);
    der_T = der(smoothState.T);
    annotation (Documentation(info="<html>

</html>"), __DLR_experiment(StopTime=1.0, Tolerance=1e-005));
  end MoistAir;

  model PsychrometricData "Produces plot data for psychrometric charts"
    extends Modelica.Icons.Example;
    package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir
      "Used medium package";
    parameter SI.Pressure p_const=1e5 "Pressure";
    parameter Integer n_T=11 "Number of isotherms";
    parameter SI.Temperature T_min=253.15 "Lowest isotherm";
    parameter SI.Temperature T_step=10
      "Temperature step between two isotherms";
    parameter Integer n_h=16 "Number of lines with constant specific enthalpy";
    parameter SI.SpecificEnthalpy h_min=-20e3
      "Lowest line of constant enthalpy";
    parameter SI.SpecificEnthalpy h_step=1e4
      "Enthalpy step between two lines of constant enthalpy";
    parameter Integer n_phi=10
      "Number of lines with constant relative humidity";
    parameter Real phi_min=0.1 "Lowest line of constant humidity";
    parameter Real phi_step=0.1 "Step between two lines of constant humidity";
    parameter SI.MassFraction x_min=0.00
      "Minimum diagram absolute humidity";
    parameter SI.MassFraction x_max=0.03
      "Maximum diagram absolute humidity";
    parameter SI.Time t=1 "Simulation time";

    final parameter SI.Temperature[n_T] T_const={T_min - T_step + i*
        T_step for i in 1:n_T} "Constant temperatures";
    final parameter SI.SpecificEnthalpy[n_h] h_const={(i - 1)*h_step +
        h_min for i in 1:n_h} "Constant enthalpies";
    final parameter Real[n_phi] phi_const={(i - 1)*phi_step + phi_min for i in
            1:n_phi} "Constant relative humidities";
    final parameter Real diagSlope=Medium.enthalpyOfVaporization(273.15)
      "Rotation of diagram that zero degrees isotherm becomes horizontal outside the fog region";
    final parameter SI.MassFraction x_start=x_min
      "Initial absolute humidity in kg water/kg dry air";

    SI.MassFraction x(start=x_start)
      "Absolute humidity in kg water/kg dry air";
    SI.SpecificEnthalpy[n_T] hx_T "h_1+x for const T";
    SI.SpecificEnthalpy[n_h] hx_h(start=h_const, each fixed=true)
      "Const h_1+x";
    SI.SpecificEnthalpy[n_phi] hx_phi "h_1+x for const phi";
    SI.SpecificEnthalpy[n_T] y_T "Chart enthalpy for const T";
    SI.SpecificEnthalpy[n_h] y_h "Chart enthalpy for const h";
    SI.SpecificEnthalpy[n_phi] y_phi "Chart enthalpy for const phi";
    Medium.BaseProperties[n_T] medium_T "Medium properties for const T";
    Medium.BaseProperties[n_phi] medium_phi "Medium properties for const phi";

  protected
    SI.Pressure[n_phi] ps_phi "Saturation pressure for constant-phi-lines";
    SI.Temperature[n_phi] T_phi(each start=290);
    Boolean[n_T] fog(start=fill(false, n_T))
      "Triggers events at intersection of isotherms with phi=1";
    SI.Pressure[n_T] pd "Steam partial pressure along isotherms";
  initial equation
    x = x_min;
  equation

    der(x) = (x_max - x_min)/t;

    for i in 1:n_T loop
      medium_T[i].T = T_const[i];
      medium_T[i].p = p_const;
      medium_T[i].Xi = {x/(1 + x)};
      hx_T[i] = medium_T[i].h*(medium_T[i].x_water + 1);
      y_T[i] = hx_T[i] - diagSlope*x;

      //trigger events
      pd[i] = medium_T[i].Xi[1]*medium_T[i].MM/Medium.MMX[1]*p_const;
      fog[i] = pd[i] >= Medium.saturationPressure(T_const[i]);
    end for;
    for i in 1:n_h loop
      der(hx_h[i]) = 0.0;
      y_h[i] = hx_h[i] - diagSlope*x;
    end for;
    for i in 1:n_phi loop
      medium_phi[i].p = p_const;
      ps_phi[i] = p_const*x/phi_const[i]/(Medium.k_mair + x);
      T_phi[i] = if x < 5e-6 then 200 else Medium.saturationTemperature(
        ps_phi[i]);
      medium_phi[i].T = T_phi[i];
      medium_phi[i].Xi = {x/(1 + x)};
      hx_phi[i] = medium_phi[i].h*(medium_phi[i].x_water + 1);
      y_phi[i] = hx_phi[i] - diagSlope*x;
    end for;

    annotation (Documentation(info="<html>
<p>This model produces psychrometric data from the moist air model in this library to be plotted in charts. The two most common chart varieties are the Mollier Diagram and the Psychrometric Chart. The first is widely used in some European countries while the second is more common in the Anglo-American world. Specific enthalpy is plotted over absolute humidity in the Mollier Diagram, it is the other way round in the Psychrometric Chart.<br>
It must be noted that the relationship of both axis variables is not right-angled, the absolute humidity follows a slope which equals the enthalpy of vaporization at 0 &deg;C. For better reading and in order to reduce the fog region the humidity axis is rotated to obtain a right-angled plot. Both charts usually contain additional information as isochores or auxiliary scales for e.g., heat ratios. Those information are omitted in this model and the charts below. Other important features of psychrometric chart data are that all mass specific variables (like absolute humidity, specific enthalpy etc.) are expressed in terms of kg dry air and that their baseline of 0 enthalpy is found at 0 &deg;C and zero humidity.</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Media/Air/Mollier.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Media/Air/PsycroChart.png\">
</p>

<p>
<strong>Legend:</strong> blue - constant specific enthalpy, red - constant temperature, black - constant relative humidity</p>

<p>The model provides data for lines of constant specific enthalpy, temperature and relative humidity in a Mollier Diagram or Psychrometric Chart as they were used for the figures above. For limitations and ranges of validity please refer to the <a href=\"modelica://Modelica.Media.Air.MoistAir\">MoistAir package description</a>. Absolute humidity <strong>x</strong> is increased with time in this model. The specific enthalpies adjusted for plotting are then obtained from:</p>
<ul>
<li><strong>y_h</strong>: constant specific enthalpy</li>
<li><strong>y_T</strong>: constant temperature</li>
<li><strong>y_phi</strong>: constant relative humidity</li>
</ul>
</html>"), __DLR_experiment(StopTime=1.0, Interval=0.001));
  end PsychrometricData;

  package TwoPhaseWater "Extension of the StandardWater package"
    extends ThermofluidStream.Media.myMedia.Water.StandardWater;
    redeclare model extends BaseProperties
      "Make StandardWater.BaseProperties non replaceable in order that inheritance is possible in model ExtendedProperties"
    end BaseProperties;

    model ExtendedProperties "Plenty of two-phase properties"
      extends BaseProperties;
      ThermodynamicState dew "Dew line Properties";
      ThermodynamicState bubble "Bubble line Properties";
      ThermodynamicState bubble2 "Bubble line Properties, on the 2-phase side";
      DynamicViscosity eta "Viscosity (McAdams mixture rules if in 2-phase)";
      DynamicViscosity eta_d "Dew line viscosity";
      DynamicViscosity eta_b "Bubble line viscosity";
      ThermalConductivity lambda_d "Dew line thermal conductivity";
      ThermalConductivity lambda_b "Bubble line thermal conductivity";
      SpecificHeatCapacity cp_d "Dew line Specific heat capacity";
      SpecificHeatCapacity cp_b "Bubble line Specific heat capacity";
      Real ddhp;
      Real ddhp_d;
      Real ddhp_b "Derivatives";
      Real ddph;
      Real ddph_d;
      Real ddph_b "Derivatives";
      Real ddhp_b2;
      Real ddph_b2 "Derivatives";
      // no derivatives yet, ... sat should be temporary
      MassFraction x "Steam mass fraction";
      Real dTp;
      Real dTp2;
      SpecificEntropy s_b;
      SpecificEntropy s_d;
    equation
      eta = if phase == 1 then dynamicViscosity(state) else 1/(x/eta_d + (1 - x)
        /eta_b);
      dew = setDewState(sat);
      bubble = setBubbleState(sat);
      bubble2 = setBubbleState(sat, 2);
      x = (h - bubble.h)/max(dew.h - bubble.h, 1e-6);
      eta_d = dynamicViscosity(dew);
      eta_b = dynamicViscosity(bubble);
      lambda_d = thermalConductivity(dew);
      lambda_b = thermalConductivity(bubble);
      cp_d = specificHeatCapacityCp(dew);
      cp_b = specificHeatCapacityCp(bubble);
      s_d = specificEntropy(dew);
      s_b = specificEntropy(bubble);
      ddph = density_derp_h(state);
      ddph_d = density_derp_h(dew);
      ddph_b = density_derp_h(bubble);
      ddhp = density_derh_p(state);
      ddhp_d = density_derh_p(dew);
      ddhp_b = density_derh_p(bubble);
      ddhp_b2 = density_derh_p(bubble2);
      ddph_b2 = density_derp_h(bubble2);
      dTp = saturationTemperature_derp(p);
      dTp2 = (1/dew.d - 1/bubble.d)/max(s_d - s_b, 1e-6);
      annotation (Documentation(info="<html>
</html>"));
    end ExtendedProperties;

    model TestTwoPhaseStates "Test the TwoPhaseWater model"
      extends Modelica.Icons.Example;
      ExtendedProperties medium(p(start=2000.0, fixed=true), h(start=8.0e5,
            fixed=true));
      parameter Real dh(unit="J/(kg.s)", displayUnit="kJ/(kg.s)")=80000.0 "Derivative of specific enthalpy of medium";
      parameter Real dp(unit="Pa/s", displayUnit="bar/s")=1.0e6 "Derivative of pressure of medium";
    equation
      der(medium.p) = dp;
      der(medium.h) = dh;
      annotation (__DLR_experiment(StopTime=22, Interval=0.01), Documentation(info="<html>
<p> For details see the documentation of the example package TwoPhaseWater</p>
</html>"));
    end TestTwoPhaseStates;
    annotation (Documentation(info="<html>
<h4>Example: TwoPhaseWater</h4>
The TwoPhaseWater package demonstrates how to extend the parsimonious
BaseProperties with a minimal set of properties from the standard water
package with most properties that are needed in two-phase situations.
The model also demonstrates how to compute additional&nbsp; properties
for the medium model. In this scenario, that builds a new medium model
with many more properties than the default, the standard BaseProperties
is used as a basis. For additional properties, a user has to:<br>
<ol>
<li>Declare a new variable of the wanted type, e.g.,
<code>DynamicViscosity eta</code>.</li>
<li>Compute that variable by calling the function from the package,
e.g., <code>eta&nbsp;= dynamicViscosity(state)</code>.
Note that the instance of
ThermodynamicState is used as an input to the function. This instance
\"state\" is declared in PartialMedium and thus available in every medium
model. A user does not have to know what actual variables are required
to compute the dynamic viscosity, because the state instance is
guaranteed to contain what is needed.</li>
<li><strong>Note</strong>: Many
properties are not well defined in the two phase region and the
functions might return undesired values if called there. It is the
user's responsibility&nbsp; to take care of such situations. The example
uses one of several possible models to compute an averaged viscosity
for two-phase flows.</li>
</ol>
In two phase models, properties are often needed on the phase boundary
just outside the two phase dome, right on the border.. To compute the
thermodynamic state there, two auxiliary functions are provided: <strong>setDewState(sat)</strong> and <strong>setBubbleState(sat)</strong>. They take an
instance of SaturationProperties as input. By default they are in
one-phase, but with the optional phase argument set to 2, the output is
forced to be just inside the phase boundary. This is only needed when
derivatives like cv are computed with are different on both sides of
the boundaries. The usual steps to compute properties on the phase
boundary are:<br>
<ol>
<li>Declare an instance of ThermodynamicState, e.g., \"ThermodynamicState&nbsp; dew\".</li>
<li>Compute the state, using an instance of SaturationProperties,
e.g., dew = setDewState(sat)</li>
<li>Compute properties on the phase boundary to your full desire,
e.g., \"cp_d = specificHeatCapacityCp(dew)\".<br>
</li>
</ol>
<p>The sample model TestTwoPhaseStates test the extended properties</p>

<p>
The same procedure can be used to compute properties at other state
points, e.g., when an isentropic reference state is computed.
</p>
</html>"));
  end TwoPhaseWater;

  package ReferenceAir
    "Examples for detailed dry air and moist air medium models"
    extends Modelica.Icons.ExamplesPackage;

    model DryAir1 "Example 1 for dry air"
      extends Modelica.Icons.Example;
      extends
        ThermofluidStream.Media.myMedia.Examples.Utilities.PartialTestModel(
          redeclare package Medium =
            ThermofluidStream.Media.myMedia.Air.ReferenceAir.Air_pT);
      annotation (__DLR_experiment(StopTime=1.01));
    end DryAir1;

    model DryAir2 "Example 2 for dry air"
      extends Modelica.Icons.Example;
      extends
        ThermofluidStream.Media.myMedia.Examples.Utilities.PartialTestModel2(
          redeclare package Medium =
            ThermofluidStream.Media.myMedia.Air.ReferenceAir.Air_pT);
      annotation (__DLR_experiment(StopTime=1.01));
    end DryAir2;

    model MoistAir "Example for moist air"
      extends Modelica.Icons.Example;
      parameter SI.Temperature T_start=274
        "Initial guess value for temperature";
      parameter SI.Pressure p_start=1e5
        "Initial guess value for pressure";
      package Medium = ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir
        "Medium model";
      Medium.BaseProperties medium(
        T(start=T_start, fixed=true),
        X(start={0.95,0.05}),
        p(start=p_start, fixed=true));
      parameter Medium.MolarMass[2] MMx={Medium.dryair.MM,Medium.steam.MM}
        "Vector of molar masses (consisting of dry air and of steam)";
      Medium.MolarMass MM=1/((1 - medium.X[1])/MMx[1] + medium.X[1]/MMx[2])
        "Molar mass of gas part of mixture";
      Medium.ThermodynamicState state1;
      Medium.ThermodynamicState state2;
      Medium.ThermodynamicState smoothState(T(start=T_start), p(start=p_start));
      Real m_flow_ext;
      Real der_p;
      Real der_T;
    protected
      constant SI.Time unitTime=1;
    equation
      der(medium.p) = 0.0;
      der(medium.T) = 90;
      medium.X[Medium.Air] = 0.95;
      m_flow_ext = time - 0.5;
      state1.p = 1.e5*(1 + time);
      state1.T = 300 + 10*time;
      state1.X = {time,1 - time}/unitTime;
      state2.p = 1.e5*(1 + time/2);
      state2.T = 340 - 20*time;
      state2.X = {0.5*time,1 - 0.5*time}/unitTime;
      smoothState = Medium.setSmoothState(
              m_flow_ext,
              state1,
              state2,
              0.2);
      der_p = der(smoothState.p);
      der_T = der(smoothState.T);
      annotation (__DLR_experiment(StopTime=1.0, Tolerance=1e-005));
    end MoistAir;

    model MoistAir1 "Example 1 for moist air"
      extends Modelica.Icons.Example;
      extends
        ThermofluidStream.Media.myMedia.Examples.Utilities.PartialTestModel(
          redeclare package Medium =
            ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir);
      annotation (__DLR_experiment(StopTime=1.01));
    end MoistAir1;

    model MoistAir2 "Example 2 for moist air"
      extends Modelica.Icons.Example;
      extends
        ThermofluidStream.Media.myMedia.Examples.Utilities.PartialTestModel2(
          redeclare package Medium =
            ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir);
      annotation (__DLR_experiment(StopTime=1.01));
    end MoistAir2;

    model Inverse_sh_T
      "Solve h = h_pT(p, T), s = s_pT(p, T) for T, if h or s is given"
      extends Modelica.Icons.Example;

      import Medium = ThermofluidStream.Media.myMedia.Air.ReferenceAir.Air_pT
        "Medium model";

      parameter SI.Temperature T_min=300
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Temperature T_max=500
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Pressure p=1.0e5 "Fixed pressure in model";
      final parameter SI.SpecificEnthalpy h_min=
          Medium.specificEnthalpy(Medium.setState_pT(p, T_min))
        "Specific enthalpy at T_min";
      final parameter SI.SpecificEnthalpy h_max=
          Medium.specificEnthalpy(Medium.setState_pT(p, T_max))
        "Specific enthalpy at T_max";
      final parameter SI.SpecificEntropy s_min=
          Medium.specificEntropy(Medium.setState_pT(p, T_min))
        "Specific entropy at T_min";
      final parameter SI.SpecificEntropy s_max=
          Medium.specificEntropy(Medium.setState_pT(p, T_max))
        "Specific entropy at T_max";
      SI.SpecificEnthalpy h1 "Pre-defined specific enthalpy";
      SI.SpecificEnthalpy h2
        "Specific enthalpy computed from T (= h1 required)";
      SI.SpecificEntropy s1 "Pre-defined specific entropy";
      SI.SpecificEntropy s2
        "Specific entropy computed from T (= h1 required)";
      SI.Temperature Th "Temperature computed from h1";
      SI.Temperature Ts "Temperature computed from s1";

    protected
      constant SI.Time timeUnit=1.0;

    equation
      // Define specific enthalpy and specific entropy
      h1 = if time < 0 then h_min else if time >= 1 then h_max else h_min + time
        /timeUnit*(h_max - h_min);
      s1 = if time < 0 then s_min else if time >= 1 then s_max else s_min + time
        /timeUnit*(s_max - s_min);

      // Solve for temperature
      Th = Medium.temperature_phX(
              p,
              h1,
              fill(0.0, 0));
      Ts = Medium.temperature_psX(
              p,
              s1,
              fill(0.0, 0));

      // Check (h2 must be identical to h1)
      h2 = Medium.specificEnthalpy_pTX(
              p,
              Th,
              fill(0.0, 0));
      s2 = Medium.specificEntropy_pTX(
              p,
              Ts,
              fill(0, 0));
      assert(abs(h1 - h2) < 1e-3, "Inverse for h not correctly computed");
      assert(abs(s1 - s2) < 1e-3, "Inverse for s not correctly computed");
      annotation (__DLR_experiment(StopTime=1));
    end Inverse_sh_T;

    model Inverse_sh_TX
      "Solve h = h_pTX(p, T, X), s = s_pTX(p, T, X) for T, if h or s is given"
      extends Modelica.Icons.Example;

      import Medium = ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir
        "Medium model";

      parameter SI.Temperature T_min=300
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Temperature T_max=500
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Pressure p=1.0e5 "Fixed pressure in model";
      parameter SI.MassFraction[:] X=ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir.reference_X
        "Mass fraction vector";
      final parameter SI.SpecificEnthalpy h_min=
          ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir.specificEnthalpy(
          ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir.setState_pTX(
                p,
                T_min,
                X)) "Specific enthalpy at T_min";
      final parameter SI.SpecificEnthalpy h_max=
          ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir.specificEnthalpy(
          ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir.setState_pTX(
                p,
                T_max,
                X)) "Specific enthalpy at T_max";
      final parameter SI.SpecificEntropy s_min=
          ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir.specificEntropy(
          ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir.setState_pTX(
                p,
                T_min,
                X)) "Specific entropy at T_min";
      final parameter SI.SpecificEntropy s_max=
          ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir.specificEntropy(
          ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir.setState_pTX(
                p,
                T_max,
                X)) "Specific entropy at T_max";
      SI.SpecificEnthalpy h1 "Pre-defined specific enthalpy";
      SI.SpecificEnthalpy h2
        "Specific enthalpy computed from T (= h1 required)";
      SI.SpecificEntropy s1 "Pre-defined specific entropy";
      SI.SpecificEntropy s2
        "Specific entropy computed from T (= h1 required)";
      SI.Temperature Th "Temperature computed from h1";
      SI.Temperature Ts "Temperature computed from s1";

    protected
      constant SI.Time timeUnit=1.0;

    equation
      // Define specific enthalpy
      h1 = if time < 0 then h_min else if time >= 1 then h_max else h_min + time
        /timeUnit*(h_max - h_min);
      s1 = if time < 0 then s_min else if time >= 1 then s_max else s_min + time
        /timeUnit*(s_max - s_min);

      // Solve for temperature
      Th = Medium.temperature_phX(
              p,
              h1,
              X);
      Ts = Medium.temperature_psX(
              p,
              s1,
              X);

      // Check (h2 must be identical to h1)
      h2 = Medium.specificEnthalpy_pTX(
              p,
              Th,
              X);
      s2 = Medium.specificEntropy_pTX(
              p,
              Ts,
              X);
      assert(abs(h1 - h2) < 1e-3, "Inverse for h not correctly computed");
      assert(abs(s1 - s2) < 1e-3, "Inverse for s not correctly computed");

      annotation (__DLR_experiment(StopTime=1), Documentation(info="<html>

</html>"));
    end Inverse_sh_TX;
  end ReferenceAir;

  package R134a "Examples for R134a"
    extends Modelica.Icons.ExamplesPackage;

    model R134a1 "Example 1 for R134a"
      extends Modelica.Icons.Example;
      extends
        ThermofluidStream.Media.myMedia.Examples.Utilities.PartialTestModel(
        redeclare package Medium =
            ThermofluidStream.Media.myMedia.R134a.R134a_ph,
        h_start=107390,
        fixedMassFlowRate(use_T_ambient=false),
        volume(use_T_start=false),
        ambient(use_T_ambient=false));
      annotation (__DLR_experiment(StopTime=1.01));
    end R134a1;

    model R134a2 "Example 2 for R134a"
      extends Modelica.Icons.Example;
      extends
        ThermofluidStream.Media.myMedia.Examples.Utilities.PartialTestModel2(
        redeclare package Medium =
            ThermofluidStream.Media.myMedia.R134a.R134a_ph,
        h_start=107390,
        fixedMassFlowRate(use_T_ambient=false),
        volume(use_T_start=false),
        ambient(use_T_ambient=false));
      annotation (__DLR_experiment(StopTime=1.01));
    end R134a2;
  end R134a;

  package SolveOneNonlinearEquation
    "Demonstrate how to solve one non-linear algebraic equation in one unknown"
    extends Modelica.Icons.ExamplesPackage;

    model Inverse_sine "Solve y = A*sin(w*x) for x, given y"
      import Modelica.Utilities.Streams.print;
      extends Modelica.Icons.Example;

      parameter Real y_zero=0.5 "Desired value of A*sin(w*x)";
      parameter Real x_min=-1.7 "Minimum value of x_zero";
      parameter Real x_max=1.7 "Maximum value of x_zero";
      parameter Real A=1 "Amplitude of sine";
      parameter Real w=1 "Angular frequency of sine";
      Real x_zero "y_zero = A*sin(w*x_zero)";

      function f_nonlinear "Define sine as non-linear equation to be solved"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input Real A=1 "Amplitude of sine";
        input Real w=1 "Angular frequency of sine";
        input Real s=0 "Shift of sine";
      algorithm
        y := A*Modelica.Math.sin(w*u) + s;
      end f_nonlinear;

    equation
      x_zero = Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(A=A, w=w, s=-y_zero), x_min, x_max);

      print("x_zero = " + String(x_zero) + ", y_zero = " + String(y_zero) +
        ", A*sin(w*x_zero) = " + String(A*Modelica.Math.sin(w*x_zero)));
      annotation (__DLR_experiment(StopTime=0), Documentation(info="<html>
<p>
This models solves the following non-linear equation
</p>

<blockquote><pre>
y = A*sin(w*x); -> determine x for given y
</pre></blockquote>

<p>
Translate model \"Inverse_sine\"
and simulate for 0 sec. The result is printed to the
output window.
</p>

</html>"));
    end Inverse_sine;

    model Inverse_sh_T
      "Solve h = h_T(T), s = s_T(T) for T, if h or s is given for ideal gas NASA"
      extends Modelica.Icons.Example;

      replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa
        constrainedby ThermofluidStream.Media.myMedia.IdealGases.Common.SingleGasNasa
        "Medium model" annotation (choicesAllMatching=true);

      parameter SI.Temperature T_min=300
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Temperature T_max=500
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Pressure p=1.0e5 "Fixed pressure in model";
      final parameter SI.SpecificEnthalpy h_min=Medium.specificEnthalpy(
          Medium.setState_pT(p, T_min)) "Specific enthalpy at T_min";
      final parameter SI.SpecificEnthalpy h_max=Medium.specificEnthalpy(
          Medium.setState_pT(p, T_max)) "Specific enthalpy at T_max";
      final parameter SI.SpecificEntropy s_min=Medium.specificEntropy(
          Medium.setState_pT(p, T_min)) "Specific entropy at T_min";
      final parameter SI.SpecificEntropy s_max=Medium.specificEntropy(
          Medium.setState_pT(p, T_max)) "Specific entropy at T_max";
      SI.SpecificEnthalpy h1(start=h_min, fixed=true)
        "Pre-defined specific enthalpy";
      SI.SpecificEnthalpy h2
        "Specific enthalpy computed from Th (= h1 required)";
      SI.SpecificEntropy s1(start=s_min, fixed=true)
        "Pre-defined specific entropy";
      SI.SpecificEntropy s2 "Specific entropy computed from Ts (= s1 required)";
      SI.Temperature Th "Temperature computed from h1";
      SI.Temperature Ts "Temperature computed from s1";

    protected
      constant SI.Time timeUnit=1.0;

    equation
      // Define specific enthalpy and specific entropy
      der(h1) = if time < 1.0 then 1/timeUnit*(h_max - h_min) else 0.0;
      der(s1) = if time < 1.0 then 1/timeUnit*(s_max - s_min) else 0.0;

      // Solve for temperatures
      Th = Medium.temperature_phX(p, h1, fill(0.0, 0));
      Ts = Medium.temperature_psX(p, s1, fill(0.0, 0));

      // Check (h2 must be identical to h1, s2 must be identical to s1)
      h2 = Medium.specificEnthalpy_pTX(p, Th, fill(0.0, 0));
      s2 = Medium.specificEntropy(Medium.setState_pT(p, Ts));
      annotation (__DLR_experiment(StopTime=1), Documentation(info="<html>
<p>
This models computes the temperature <code>Th</code> for predefined specific enthalpy <code>h1</code> via numerical inversion of function <a href=\"modelica://Modelica.Media.IdealGases.Common.Functions.h_T\">Modelica.Media.IdealGases.Common.Functions.h_T</a>.
The specific enthalpy <code>h2</code> is computed as check variable from temperature <code>Th</code> and must be identical to <code>h1</code>.
</p>

<p>
In an analogous manner, the temperature <code>Ts</code> is computed for predefined specific entropy <code>s1</code> via numerical inversion of function <a href=\"modelica://Modelica.Media.IdealGases.Common.Functions.s0_T\">Modelica.Media.IdealGases.Common.Functions.s0_T</a>.
The specific entropy <code>s2</code> is computed as check variable from temperature <code>Ts</code> and must be identical to <code>s1</code>.
</p>

<p>
The numerical computation of the inverse function is performed by function <a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">Modelica.Math.Nonlinear.solveOneNonlinearEquation</a> in both cases.
</p>

</html>"));
    end Inverse_sh_T;

    model InverseIncompressible_sh_T
      "Inverse computation for incompressible media"
      extends Modelica.Icons.Example;

      replaceable package Medium = ThermofluidStream.Media.myMedia.Incompressible.Examples.Glycol47
        "Medium model"
        annotation (choicesAllMatching=true);

      parameter SI.Temperature T_min=Medium.T_min
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Temperature T_max=Medium.T_max
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Pressure p=1.0e5 "Fixed pressure in model";
      final parameter SI.SpecificEnthalpy h_min=Medium.h_T(Medium.T_min)
        "Specific enthalpy at T_min";
      final parameter SI.SpecificEnthalpy h_max=Medium.h_T(Medium.T_max)
        "Specific enthalpy at T_max";
      final parameter SI.SpecificEntropy s_min=Medium.specificEntropy(
          Medium.setState_pT(p, T_min)) "Specific entropy at T_min";
      final parameter SI.SpecificEntropy s_max=Medium.specificEntropy(
          Medium.setState_pT(p, T_max)) "Specific entropy at T_max";

      SI.SpecificEnthalpy h1(start=h_min, fixed=true)
        "Pre-defined specific enthalpy";
      SI.SpecificEnthalpy h2
        "Specific enthalpy computed from Th (= h1 required)";
      SI.SpecificEntropy s1(start=s_min, fixed=true)
        "Pre-defined specific entropy";
      SI.SpecificEntropy s2 "Specific entropy computed from Ts (= s1 required)";
      SI.Temperature Th "Temperature computed from h1";
      SI.Temperature Ts "Temperature computed from s1";

    protected
      constant SI.Time timeUnit=1.0;

    equation
      // Define specific enthalpy and specific entropy
      der(h1) = if time < 1.0 then 1/timeUnit*(h_max - h_min) else 0.0;
      der(s1) = if time < 1.0 then 1/timeUnit*(s_max - s_min) else 0.0;

      // Solve for temperatures
      Th = Medium.temperature_phX(p, h1, fill(0.0, 0));
      Ts = Medium.temperature_psX(p, s1, fill(0.0, 0));

      // Check (h2 must be identical to h1, s2 must be identical to s1)
      h2 = Medium.specificEnthalpy_pTX(p, Th, fill(0.0, 0));
      s2 = Medium.specificEntropy(Medium.setState_pT(p, Ts));
      annotation (__DLR_experiment(StopTime=1), Documentation(info="<html>
<p>
This models computes the temperature <code>Th</code> for predefined specific enthalpy <code>h1</code> via numerical inversion of function <a href=\"modelica://Modelica.Media.Incompressible.TableBased.h_T\">Modelica.Media.Incompressible.TableBased.h_T</a>.
The specific enthalpy <code>h2</code> is computed as check variable from temperature <code>Th</code> and must be identical to <code>h1</code>.
</p>

<p>
In an analogous manner, the temperature <code>Ts</code> is computed for predefined specific entropy <code>s1</code> via numerical inversion of function <a href=\"modelica://Modelica.Media.Incompressible.TableBased.s_T\">Modelica.Media.Incompressible.TableBased.s_T</a>.
The specific entropy <code>s2</code> is computed as check variable from temperature <code>Ts</code> and must be identical to <code>s1</code>.
</p>

<p>
The numerical computation of the inverse function is performed by function <a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">Modelica.Math.Nonlinear.solveOneNonlinearEquation</a> in both cases.
</p>

</html>"));
    end InverseIncompressible_sh_T;

    model Inverse_sh_TX
      "Solve h = h_TX(TX) for T, if h is given for ideal gas NASA"
      extends Modelica.Icons.Example;

      replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.MixtureGases.FlueGasLambdaOnePlus
        constrainedby ThermofluidStream.Media.myMedia.IdealGases.Common.MixtureGasNasa
        "Medium model" annotation (choicesAllMatching=true);

      parameter SI.Temperature T_min=300
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Temperature T_max=500
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Pressure p=1.0e5 "Fixed pressure in model";
      final parameter SI.SpecificEnthalpy h_min=Medium.h_TX(T_min, X)
        "Specific enthalpy at T_min";
      final parameter SI.SpecificEnthalpy h_max=Medium.h_TX(T_max, X)
        "Specific enthalpy at T_max";
      final parameter SI.SpecificEntropy s_min=Medium.specificEntropy(
        Medium.setState_pTX(p, T_min, Medium.reference_X)) "Specific entropy at T_min";
      final parameter SI.SpecificEntropy s_max=Medium.specificEntropy(
        Medium.setState_pTX(p, T_max, Medium.reference_X)) "Specific entropy at T_max";
      SI.SpecificEnthalpy h1(start=h_min, fixed=true)
        "Pre-defined specific enthalpy";
      SI.SpecificEnthalpy h2
        "Specific enthalpy computed from Th (= h1 required)";
      SI.SpecificEntropy s1(start=s_min, fixed=true)
        "Pre-defined specific entropy";
      SI.SpecificEntropy s2 "Specific entropy computed from Ts (= s1 required)";
      SI.Temperature Th "Temperature computed from h1";
      SI.Temperature Ts "Temperature computed from s1";
      parameter SI.MassFraction[4] X=Medium.reference_X "Mass fraction vector";

    protected
      constant SI.Time timeUnit=1.0;

    equation
      // Define specific enthalpy and specific entropy
      der(h1) = if time < 1.0 then 1/timeUnit*(h_max - h_min) else 0.0;
      der(s1) = if time < 1.0 then 1/timeUnit*(s_max - s_min) else 0.0;

      // Solve for temperatures
      Th = Medium.temperature_phX(p, h1, X);
      Ts = Medium.temperature_psX(p, s1, X);

      // Check (h2 must be identical to h1, s2 must be identical to s1)
      h2 = Medium.specificEnthalpy_pTX(p, Th, X);
      s2 = Medium.specificEntropy(Medium.setState_pTX(p, Ts, X));
      annotation (__DLR_experiment(StopTime=1), Documentation(info="<html>
<p>
This models computes the temperature <code>Th</code> for predefined specific enthalpy <code>h1</code> via numerical inversion of function <a href=\"modelica://Modelica.Media.IdealGases.Common.Functions.h_T\">Modelica.Media.IdealGases.Common.Functions.h_T</a>.
The specific enthalpy <code>h2</code> is computed as check variable from temperature <code>Th</code> and must be identical to <code>h1</code>.
</p>

<p>
In an analogous manner, the temperature <code>Ts</code> is computed for predefined specific entropy <code>s1</code> via numerical inversion of function <a href=\"modelica://Modelica.Media.IdealGases.Common.Functions.s0_T\">Modelica.Media.IdealGases.Common.Functions.s0_T</a>.
The specific entropy <code>s2</code> is computed as check variable from temperature <code>Ts</code> and must be identical to <code>s1</code>.
</p>

<p>
The numerical computation of the inverse function is performed by function <a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">Modelica.Math.Nonlinear.solveOneNonlinearEquation</a> in both cases.
</p>

</html>"));
    end Inverse_sh_TX;

    annotation (Documentation(info="<html>
<p>
This package demonstrates how to solve one non-linear algebraic
equation in one unknown with function <a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">solveOneNonlinearEquation</a>.
</p>

</html>"));
  end SolveOneNonlinearEquation;

    package Utilities
      "Functions, connectors and models needed for the media model tests"

      extends Modelica.Icons.UtilitiesPackage;

      connector FluidPort
        "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)"
        replaceable package Medium =
          ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        Medium.AbsolutePressure p "Pressure in the connection point";
        flow Medium.MassFlowRate m_flow
          "Mass flow rate from the connection point into the component";

        Medium.SpecificEnthalpy h
          "Specific mixture enthalpy in the connection point";
        flow Medium.EnthalpyFlowRate H_flow
          "Enthalpy flow rate into the component (if m_flow > 0, H_flow = m_flow*h)";

        Medium.MassFraction Xi[Medium.nXi]
          "Independent mixture mass fractions m_i/m in the connection point";
        flow Medium.MassFlowRate mXi_flow[Medium.nXi]
          "Mass flow rates of the independent substances from the connection point into the component (if m_flow > 0, mX_flow = m_flow*X)";

        Medium.ExtraProperty C[Medium.nC]
          "Properties c_i/m in the connection point";
        flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC]
          "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";

        annotation (Documentation(info="<html>

</html>"));
      end FluidPort;

      connector FluidPort_a "Fluid connector with filled icon"
        extends FluidPort;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                        extent={{-100,100},{100,-100}},
                        lineColor={0,127,255},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Ellipse(
                        extent={{-100,100},{100,-100}},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Text(
                        extent={{-88,206},{112,112}},
                        textString="%name",
                        textColor={0,0,255})}),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Ellipse(
                        extent={{-100,100},{100,-100}},
                        lineColor={0,127,255},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Ellipse(
                        extent={{-100,100},{100,-100}},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>Modelica.Media.Examples.Tests.Components.FluidPort_a
</html>"));
      end FluidPort_a;

      connector FluidPort_b "Fluid connector with outlined icon"
        extends FluidPort;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                        extent={{-100,100},{100,-100}},
                        lineColor={0,127,255},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Ellipse(
                        extent={{-100,100},{100,-100}},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Ellipse(
                        extent={{-80,80},{80,-80}},
                        lineColor={0,127,255},
                        fillColor={255,255,255},
                        fillPattern=FillPattern.Solid),Text(
                        extent={{-88,192},{112,98}},
                        textString="%name",
                        textColor={0,0,255})}),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Ellipse(
                        extent={{-100,100},{100,-100}},
                        lineColor={0,127,255},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Ellipse(
                        extent={{-100,100},{100,-100}},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Ellipse(
                        extent={{-80,80},{80,-80}},
                        lineColor={0,127,255},
                        fillColor={255,255,255},
                        fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>

</html>"));
      end FluidPort_b;

      model PortVolume
        "Fixed volume associated with a port by the finite volume method"
        replaceable package Medium =
          ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        parameter SI.Volume V=1e-6 "Fixed size of junction volume";

        parameter Boolean use_p_start=true "Select p_start or d_start"
          annotation (Evaluate=true, Dialog(group=
                "Initial pressure or initial density"));
        parameter Medium.AbsolutePressure p_start=101325 "Initial pressure"
          annotation (Dialog(group="Initial pressure or initial density",
              enable=use_p_start));
        parameter Medium.Density d_start=1 "Initial density" annotation (Dialog(
              group="Initial pressure or initial density", enable=not
                use_p_start));
        parameter Boolean use_T_start=true "Select T_start or h_start"
          annotation (Evaluate=true, Dialog(group=
                "Initial temperature or initial specific enthalpy"));
        parameter Medium.Temperature T_start=
            Modelica.Units.Conversions.from_degC(20) "Initial temperature"
          annotation (Dialog(group=
                "Initial temperature or initial specific enthalpy", enable=
                use_T_start));
        parameter Medium.SpecificEnthalpy h_start=1.e4
          "Initial specific enthalpy" annotation (Dialog(group=
                "Initial temperature or initial specific enthalpy", enable=not
                use_T_start));
        parameter Medium.MassFraction X_start[Medium.nX]
          "Initial mass fractions m_i/m" annotation (Dialog(group=
                "Only for multi-substance flow", enable=Medium.nX > 0));

        FluidPort_a port(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{-10,-10},{10,10}})));
        Medium.BaseProperties medium(preferredMediumStates=true);
        SI.Energy U "Internal energy of port volume";
        SI.Mass m "Mass of junction volume";
        SI.Mass mXi[Medium.nXi]
          "Independent substance masses of junction volume";

      initial equation
        if not Medium.singleState then
          if use_p_start then
            medium.p = p_start;
          else
            medium.d = d_start;
          end if;
        end if;

        if use_T_start then
          medium.T = T_start;
        else
          medium.h = h_start;
        end if;

        medium.Xi = X_start[1:Medium.nXi];
      equation
        // Connect port to medium variables
        medium.p = port.p;
        medium.h = port.h;
        medium.Xi = port.Xi;

        // Total quantities
        m = V*medium.d;
        mXi = m*medium.Xi;
        U = m*medium.u;

        // Mass and energy balance
        der(m) = port.m_flow;
        der(mXi) = port.mXi_flow;
        der(U) = port.H_flow;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Ellipse(
                        extent={{-100,100},{100,-100}},
                        fillPattern=FillPattern.Sphere,
                        fillColor={170,213,255}),Text(
                        extent={{-150,150},{150,110}},
                        textString="%name",
                        textColor={0,0,255}), Text(
                        extent={{-150,-110},{150,-150}},
                        textString="V=%V")}), Documentation(info="<html>
<p>
This component models the <strong>volume</strong> of <strong>fixed size</strong> that is
associated with the <strong>fluid port</strong> to which it is connected.
This means that all medium properties inside the volume, are identical
to the port medium properties. In particular, the specific enthalpy
inside the volume (= medium.h) is always identical to the specific enthalpy
in the port (port.h = medium.h). Usually, this model is used when
discretizing a component according to the finite volume method into
volumes in internal ports that only store energy and mass and into
transport elements that just transport energy, mass and momentum
between the internal ports without storing these quantities during the
transport.
</p>
</html>"));
      end PortVolume;

      model FixedMassFlowRate
        "Ideal pump that produces a constant mass flow rate from a large reservoir at fixed temperature and mass fraction"
        parameter Medium.MassFlowRate m_flow
          "Fixed mass flow rate from an infinite reservoir to the fluid port";

        parameter Boolean use_T_ambient=true "Select T_ambient or h_ambient"
          annotation (Evaluate=true, Dialog(group=
                "Ambient temperature or ambient specific enthalpy"));
        parameter Medium.Temperature T_ambient=
            Modelica.Units.Conversions.from_degC(20) "Ambient temperature"
          annotation (Dialog(group=
                "Ambient temperature or ambient specific enthalpy", enable=
                use_T_ambient));
        parameter Medium.SpecificEnthalpy h_ambient=1.e4
          "Ambient specific enthalpy" annotation (Dialog(group=
                "Ambient temperature or ambient specific enthalpy", enable=not
                use_T_ambient));
        parameter Medium.MassFraction X_ambient[Medium.nX]
          "Ambient mass fractions m_i/m of reservoir";

        replaceable package Medium =
          ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        Medium.BaseProperties medium "Medium in the source";
        FluidPort_b port(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        if use_T_ambient then
          medium.T = T_ambient;
        else
          medium.h = h_ambient;
        end if;

        medium.Xi = X_ambient[1:Medium.nXi];
        medium.p = port.p;
        port.m_flow = -m_flow;
        port.mXi_flow = semiLinear(
                  port.m_flow,
                  port.Xi,
                  medium.Xi);
        port.H_flow = semiLinear(
                  port.m_flow,
                  port.h,
                  medium.h);
        annotation (Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={Rectangle(
                        extent={{20,60},{100,-60}},
                        fillPattern=FillPattern.HorizontalCylinder,
                        fillColor={192,192,192}),Rectangle(
                        extent={{38,40},{100,-40}},
                        fillPattern=FillPattern.HorizontalCylinder,
                        fillColor={0,127,255}),Ellipse(
                        extent={{-100,80},{60,-80}},
                        fillColor={255,255,255},
                        fillPattern=FillPattern.Solid,
                        lineColor={0,0,255}),Polygon(
                        points={{-60,70},{60,0},{-60,-68},{-60,70}},
                        lineColor={0,0,255},
                        fillColor={0,0,255},
                        fillPattern=FillPattern.Solid),Text(
                        extent={{-54,32},{16,-30}},
                        textColor={255,0,0},
                        textString="m"),Text(
                        extent={{-150,150},{150,110}},
                        textString="%name",
                        textColor={0,0,255}), Text(
                        extent={{-150,-110},{150,-150}},
                        textString="%m_flow"), Ellipse(
                        extent={{-26,30},{-18,22}},
                        lineColor={255,0,0},
                        fillColor={255,0,0},
                        fillPattern=FillPattern.Solid)}), Documentation(info="<html>

</html>"));
      end FixedMassFlowRate;

      model FixedAmbient
        "Ambient pressure, temperature and mass fraction source"
        replaceable package Medium =
          ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        parameter Boolean use_p_ambient=true "Select p_ambient or d_ambient"
          annotation (Evaluate=true, Dialog(group=
                "Ambient pressure or ambient density"));
        parameter Medium.AbsolutePressure p_ambient=101325 "Ambient pressure"
          annotation (Dialog(group="Ambient pressure or ambient density",
              enable=use_p_ambient));
        parameter Medium.Density d_ambient=1 "Ambient density" annotation (
            Dialog(group="Ambient pressure or ambient density", enable=not
                use_p_ambient));
        parameter Boolean use_T_ambient=true "Select T_ambient or h_ambient"
          annotation (Evaluate=true, Dialog(group=
                "Ambient temperature or ambient specific enthalpy"));
        parameter Medium.Temperature T_ambient=
            Modelica.Units.Conversions.from_degC(20) "Ambient temperature"
          annotation (Dialog(group=
                "Ambient temperature or ambient specific enthalpy", enable=
                use_T_ambient));
        parameter Medium.SpecificEnthalpy h_ambient=1.e4
          "Ambient specific enthalpy" annotation (Dialog(group=
                "Ambient temperature or ambient specific enthalpy", enable=not
                use_T_ambient));
        parameter Medium.MassFraction X_ambient[Medium.nX]
          "Ambient mass fractions m_i/m" annotation (Dialog(group=
                "Only for multi-substance flow", enable=Medium.nX > 0));

        Medium.BaseProperties medium "Medium in the source";
        FluidPort_b port(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{100,-10},{120,10}})));

      equation
        if use_p_ambient or Medium.singleState then
          medium.p = p_ambient;
        else
          medium.d = d_ambient;
        end if;

        if use_T_ambient then
          medium.T = T_ambient;
        else
          medium.h = h_ambient;
        end if;

        medium.Xi = X_ambient[1:Medium.nXi];

        port.p = medium.p;
        port.H_flow = semiLinear(
                  port.m_flow,
                  port.h,
                  medium.h);
        port.mXi_flow = semiLinear(
                  port.m_flow,
                  port.Xi,
                  medium.Xi);
        annotation (Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={Ellipse(
                        extent={{-100,100},{100,-100}},
                        fillPattern=FillPattern.Sphere,
                        fillColor={0,127,255}), Text(
                        extent={{-150,150},{150,110}},
                        textString="%name",
                        textColor={0,0,255})}), Documentation(info="<html>
<p>
Model <strong>FixedAmbient_pt</strong> defines constant values for ambient conditions:
</p>
<ul>
<li> Ambient pressure.</li>
<li> Ambient temperature.</li>
<li> Ambient mass fractions (only for multi-substance flow).</li>
</ul>
<p>
Note, that ambient temperature
and mass fractions have only an effect if the mass flow
is from the ambient into the port. If mass is flowing from
the port into the ambient, the ambient definitions,
with exception of ambient pressure, do not have an effect.
</p>
</html>"));
      end FixedAmbient;

      model ShortPipe "Simple pressure loss in pipe"
        replaceable package Medium =
          ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        parameter Medium.AbsolutePressure dp_nominal(min=1e-10)
          "Nominal pressure drop";
        parameter Medium.MassFlowRate m_flow_nominal(min=1e-10)
          "Nominal mass flow rate at nominal pressure drop";

        FluidPort_a port_a(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{-120,-10},{-100,10}})));
        FluidPort_b port_b(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{120,-10},{100,10}})));
        // Medium.BaseProperties medium_a(p=port_a.p, h=port_a.h, Xi=port_a.Xi)
        //   "Medium properties in port_a";
        // Medium.BaseProperties medium_b(p=port_b.p, h=port_b.h, Xi=port_b.Xi)
        //   "Medium properties in port_b";
        Medium.MassFlowRate m_flow
          "Mass flow rate from port_a to port_b (m_flow > 0 is design flow direction)";
        SI.Pressure dp "Pressure drop from port_a to port_b";
      equation
        /* Handle reverse and zero flow */
        port_a.H_flow = semiLinear(
                  port_a.m_flow,
                  port_a.h,
                  port_b.h);
        port_a.mXi_flow = semiLinear(
                  port_a.m_flow,
                  port_a.Xi,
                  port_b.Xi);

        /* Energy, mass and substance mass balance */
        port_a.H_flow + port_b.H_flow = 0;
        port_a.m_flow + port_b.m_flow = 0;
        port_a.mXi_flow + port_b.mXi_flow = zeros(Medium.nXi);

        // Design direction of mass flow rate
        m_flow = port_a.m_flow;

        // Pressure drop
        dp = port_a.p - port_b.p;
        m_flow = (m_flow_nominal/dp_nominal)*dp;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                        extent={{-100,60},{100,-60}},
                        fillPattern=FillPattern.HorizontalCylinder,
                        fillColor={192,192,192}),Rectangle(
                        extent={{-100,34},{100,-36}},
                        fillPattern=FillPattern.HorizontalCylinder,
                        fillColor={0,127,255}),Text(
                        extent={{-150,110},{150,70}},
                        textString="%name", textColor={0,0,255}), Text(
                        extent={{-150,-70},{150,-110}},
                        textString="k=%m_flow_nominal/%dp_nominal")}),
            Documentation(info="<html>
<p>
Model <strong>ShortPipe</strong> defines a simple pipe model
with pressure loss due to friction. It is assumed that
no mass or energy is stored in the pipe.
</p>
</html>"));
      end ShortPipe;

      partial model PartialTestModel "Basic test model to test a medium"

        replaceable package Medium =
          ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);
        parameter SI.AbsolutePressure p_start=Medium.p_default
          "Initial value of pressure";
        parameter SI.Temperature T_start=Medium.T_default
          "Initial value of temperature";
        parameter SI.SpecificEnthalpy h_start=Medium.h_default
          "Initial value of specific enthalpy";
        parameter Real X_start[Medium.nX]=Medium.X_default
          "Initial value of mass fractions";

        /*
  parameter SI.AbsolutePressure p_start = 1.0e5 "Initial value of pressure";
  parameter SI.Temperature T_start = 300 "Initial value of temperature";
  parameter SI.Density h_start = 1 "Initial value of specific enthalpy";
  parameter Real X_start[Medium.nX] = Medium.reference_X
    "Initial value of mass fractions";
*/
        PortVolume volume(
          redeclare package Medium = Medium,
          p_start=p_start,
          T_start=T_start,
          h_start=h_start,
          X_start=X_start,
          V=0.1) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
        FixedMassFlowRate fixedMassFlowRate(
          redeclare package Medium = Medium,
          T_ambient=1.2*T_start,
          h_ambient=1.2*h_start,
          m_flow=1,
          X_ambient=0.5*X_start) annotation (Placement(transformation(extent={{
                  -80,0},{-60,20}})));
        FixedAmbient ambient(
          redeclare package Medium = Medium,
          T_ambient=T_start,
          h_ambient=h_start,
          X_ambient=X_start,
          p_ambient=p_start) annotation (Placement(transformation(extent={{60,0},
                  {40,20}})));
        ShortPipe shortPipe(
          redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5) annotation (Placement(transformation(extent={{0,0},
                  {20,20}})));
      equation
        connect(fixedMassFlowRate.port, volume.port)
          annotation (Line(points={{-59,10},{-30,10}}, color={0,127,255}));
        connect(volume.port, shortPipe.port_a)
          annotation (Line(points={{-30,10},{-1,10}}, color={0,127,255}));
        connect(shortPipe.port_b, ambient.port)
          annotation (Line(points={{21,10},{39,10}}, color={0,127,255}));
        annotation (Documentation(info="<html>

</html>"));
      end PartialTestModel;

      partial model PartialTestModel2
        "Slightly larger test model to test a medium"
        replaceable package Medium =
          ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);
        parameter SI.AbsolutePressure p_start=1.0e5 "Initial value of pressure";
        parameter SI.Temperature T_start=300 "Initial value of temperature";
        parameter SI.SpecificEnthalpy h_start=1
          "Initial value of specific enthalpy";
        parameter Real X_start[Medium.nX]=Medium.reference_X
          "Initial value of mass fractions";
        PortVolume volume(
          redeclare package Medium = Medium,
          p_start=p_start,
          T_start=T_start,
          h_start=h_start,
          X_start=X_start,
          V=0.1) annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
        FixedMassFlowRate fixedMassFlowRate(
          redeclare package Medium = Medium,
          T_ambient=1.2*T_start,
          h_ambient=1.2*h_start,
          m_flow=1,
          X_ambient=0.5*X_start) annotation (Placement(transformation(extent={{
                  -100,0},{-80,20}})));
        FixedAmbient ambient(
          redeclare package Medium = Medium,
          T_ambient=T_start,
          h_ambient=h_start,
          X_ambient=X_start,
          p_ambient=p_start) annotation (Placement(transformation(extent={{92,0},
                  {72,20}})));
        ShortPipe shortPipe(
          redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5) annotation (Placement(transformation(extent={{-30,0},
                  {-10,20}})));
        PortVolume volume1(
          redeclare package Medium = Medium,
          p_start=p_start,
          T_start=T_start,
          h_start=h_start,
          X_start=X_start,
          V=0.1) annotation (Placement(transformation(extent={{0,0},{20,20}})));
        ShortPipe shortPipe1(
          redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5) annotation (Placement(transformation(extent={{36,0},
                  {56,20}})));
      equation
        connect(fixedMassFlowRate.port, volume.port)
          annotation (Line(points={{-79,10},{-50,10}}, color={0,127,255}));
        connect(volume.port, shortPipe.port_a)
          annotation (Line(points={{-50,10},{-31,10}}, color={0,127,255}));
        connect(volume1.port, shortPipe1.port_a)
          annotation (Line(points={{10,10},{35,10}}, color={0,127,255}));
        connect(shortPipe.port_b, volume1.port)
          annotation (Line(points={{-9,10},{10,10}}, color={0,127,255}));
        connect(shortPipe1.port_b, ambient.port)
          annotation (Line(points={{57,10},{71,10}}, color={0,127,255}));
        annotation (Documentation(info="<html>

</html>"));
      end PartialTestModel2;
      annotation (Documentation(info="<html>

</html>"));
    end Utilities;
  annotation (Documentation(info="<html>
<h4>Examples</h4>
Physical properties for fluids are needed in so many different variants
that a library can only provide models for the most common situations.
With the following examples we are going to demonstrate how to use the
existing packages and functions in Modelica.Media to customize these
models for advanced applications. The high level functions try to
abstract as much as possible form the fact that different media are
based on different variables, e.g., ideal gases need pressure and
temperature, while many refrigerants are based on Helmholtz functions
of density and temperature, and many water properties are based on
pressure and specific enthalpy. Medium properties are needed in control
volumes in the dynamic state equations and in many thermodynamic state
locations that are independent of the dynamic states of a control
volume, e.g., at a wall temperature, an isentropic reference state or at
a phase boundary. The general structure of the library is such that:<br>
<ul>
<li>Each medium has a model called BaseProperties. BaseProperties
contains the minimum set of medium properties needed in a dynamic
control volume model.</li>
<li>Each instance of BaseProperties contains a \"state\" record that is
an input to all the functions to compute properties. If these functions
need further inputs, like e.g., the molarMass, these are accessible as
constants in the package.</li>
<li>The simplest way to compute properties at any other reference
point is to declare an instance of ThermodynamicState and use that as
input to arbitrary property functions.<br>
</li>
</ul>

<p>
A small library of generic volume, pipe, pump and ambient models
is provided in Modelica.Media.Examples.Tests.Components to demonstrate
how fluid components should be implemented that are using Modelica.Media
models. This library is also used to test all media models in
Modelica.Media.Examples.Tests.MediaTestModels.
</p>
</html>"));
end Examples;
