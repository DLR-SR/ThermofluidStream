within ThermofluidStream.Media.additionalMedia.Incompressible;
package JP8 "Jet propulsion 8, JetA with additives, typical density"
    // Data from Handbook of Aviation Fuel properties, Coordinating Research Council Inc., 1983
    //Density data between -40 degC and 90 degC, linear in T, relative density data linear up to 120 degC
    //density could vary with 30 % between batches, the typical density used here is an average of measured data
    //Heat capacity data between 30 degC and 180 degC, linear in T
    //Thermal conductivity data between -8 degC and 220 degC, linear in T
    //Kinematic viscosity data between -50 and 145 degC, log(viscosity) is linear in T
    //True vapor pressure data between 50 degC and 140 degC, log(VaporPressure) is linear in 1/T(in Kelvin)
    extends ThermofluidStream.Media.myMedia.Incompressible.TableBased(
      mediumName="Jet propulsion 8 (JetA with additives)",
      T_min=Modelica.Units.Conversions.from_degC(-40),
      T_max=Modelica.Units.Conversions.from_degC(120),
      enthalpyOfT=true,
      TinK=false,
      T0=273.15,
      npolDensity=1,
      tableDensity=[-40,852; 90,758],
      npolHeatCapacity=1,
      tableHeatCapacity=[30,2000;  180,2650],
      npolConductivity =1,
      tableConductivity=[-8,0.12; 220,0.08],
      npolViscosity = 4,
      tableViscosity=[-50,0.016; -40,0.0095; -30,0.006; -20,0.0042; -10,0.0032; 30,0.0014; 70,0.0008;110,0.00053; 144,0.0004],
      npolVaporPressure= 4,
      tableVaporPressure=[50,1300; 72,3200; 112,12500;  143,32000]);
      annotation (Documentation(info="<html>
<h4>JP8</h4>
<p>JP8 is a jet propulsion fuel often used in military aircraft. It is essentially the same as JetA, but with some additives that e.g. allows for higher mass flows without static electricity build up. The data of this implementation comes from&nbsp;Handbook&nbsp;of&nbsp;Aviation&nbsp;Fuel&nbsp;properties,&nbsp;Coordinating&nbsp;Research&nbsp;Council&nbsp;Inc.(USA),&nbsp;1983. There are both more detailed property models available, for example in REFPROP, or with more attention to computational robustness, for example in Modelon&acute;s Fuel library. The data used in this model does not take into account properties important for combustion of the fuel, only those important for transportation and heat storage.</p>
<p>&nbsp;The main source of the density gives data&nbsp;between&nbsp;-40&nbsp;degC&nbsp;and&nbsp;90&nbsp;degC,&nbsp;linear&nbsp;in&nbsp;T,&nbsp;but complemetary relative&nbsp;density&nbsp;data&nbsp;is given as linear&nbsp;up&nbsp;to&nbsp;120&nbsp;degC, which implies that linear extraploation can be possible above 90 degC. Observe that the density&nbsp;can&nbsp;vary&nbsp;with&nbsp;30&percnt;&nbsp;between&nbsp;batches or over time as the ligther fractions tend to evaporate depending on manner of storage.&nbsp;The&nbsp;typical&nbsp;density&nbsp;used&nbsp;here&nbsp;is&nbsp;an&nbsp;average&nbsp;of&nbsp;measured&nbsp;data.</p>
<p><br>The heat&nbsp;capacity&nbsp;data is given&nbsp;between&nbsp;30&nbsp;degC&nbsp;and&nbsp;180&nbsp;degC,&nbsp;linear&nbsp;in&nbsp;T.</p>
<p><br>The thermal&nbsp;conductivity&nbsp;data&nbsp;is given between&nbsp;-8&nbsp;degC&nbsp;and&nbsp;220&nbsp;degC,&nbsp;linear&nbsp;in&nbsp;T.</p>
<p><br>The kinematic&nbsp;viscosity&nbsp;data&nbsp;is given between&nbsp;-50&nbsp;and&nbsp;145&nbsp;degC,&nbsp;with log(viscosity)&nbsp;linear&nbsp;in&nbsp;T.</p>
<p><br>The true&nbsp;vapor&nbsp;pressure&nbsp;data&nbsp;is given between&nbsp;50&nbsp;degC&nbsp;and&nbsp;140&nbsp;degC,&nbsp;with log(VaporPressure)&nbsp;linear&nbsp;in&nbsp;1/T(in&nbsp;Kelvin).</p>
<p>Density</p>
<p><img src=\"modelica://ThermofluidStream/Media/additionalMedia/Resources/TestJP8_density.png\"/></p>
<p>Heat capacity</p>
<p><img src=\"modelica://ThermofluidStream/Media/additionalMedia/Resources/TestJP8_specHeat.png\"/></p>
<p>Dynamic viscosity</p>
<p><img src=\"modelica://ThermofluidStream/Media/additionalMedia/Resources/TestJP8_dynVis.png\"/></p>
<p>Thermal conductivity</p>
<p><img src=\"modelica://ThermofluidStream/Media/additionalMedia/Resources/TestJP8_thermCond.png\"/></p>
</html>",
        revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end JP8;
