within ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.Examples;
model TestJP8DryAir "Test JP8DryAir Medium model"
     extends Modelica.Icons.Example;
     package Medium =
      ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir   "Jet fuel medium model";

         Medium.BaseProperties medium;
         Medium.ThermodynamicState state2;
         String[:] name = Medium.substanceNames;
     Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium.state);
     Medium.ThermalConductivity lambda=Medium.thermalConductivity(medium.state);
     Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
     Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
     Medium.SpecificInternalEnergy u=Medium.specificInternalEnergy(medium.state);
     Medium.SpecificInternalEnergy h=Medium.specificEnthalpy(medium.state);
     Medium.Density d=Medium.density(medium.state);
     Medium.Density dG=Medium.SingleGas.density(medium.state);
     Medium.Density dL=Medium.Incompressible.density(medium.state);
     Real n=Medium.nS;
     Real nXi=Medium.nXi;

protected
     constant Modelica.Units.SI.Time timeUnit=1;
     constant Modelica.Units.SI.Temperature Ta=1;
equation
     medium.p = 1.013e5;
     medium.T = 233.15 + time/timeUnit*Ta;
     medium.X={0.001,0.999};
     state2=Medium.setState_phX(medium.p,medium.h,medium.X);

       annotation (
       experiment(StopTime=159, __Dymola_Algorithm="Dassl"),
       Documentation(info="<html>
<p>Density</p>
<p><img src=\"modelica://SAABdefinedMedia/TestJP8_density.png\"/></p>
<p>Heat capacity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestJP8_specHeat.png\"/></p>
<p>Dynamic viscosity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestJP8_dynVis.png\"/></p>
<p>Thermal conductivity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestJP8_thermCond.png\"/></p>
</html>",    revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end TestJP8DryAir;
