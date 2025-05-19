within ThermofluidStream.Media.additionalMedia.Incompressible;
model TestDowcal100E "Test Dowcal100E Medium model"
     extends Modelica.Icons.Example;
     package Medium =
         ThermofluidStream.Media.additionalMedia.Incompressible.Dowcal100E
                               "Medium model (Dowcal100E)";
     Medium.BaseProperties medium;

     Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium.state);
     Medium.ThermalConductivity lambda=Medium.thermalConductivity(medium.state);
     Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
     Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
     Medium.SpecificInternalEnergy u=Medium.specificInternalEnergy(medium.state);
     Medium.SpecificInternalEnergy h=Medium.specificEnthalpy(medium.state);
     Medium.SpecificInternalEnergy d=Medium.density(medium.state);
protected
     constant Modelica.Units.SI.Time timeUnit=1;
     constant Modelica.Units.SI.Temperature Ta=1;
equation
     medium.p = 1.013e5;
     medium.T = Medium.T_min + time/timeUnit*Ta;
       annotation (__DLR_experiment(StopTime=1.01),
       experiment(StopTime=225, __Dymola_Algorithm="Dassl"),
       Documentation(info="<html>
<p>Density</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100E_density_T.png\"/></p>
<p>Heat capacity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100E_specHeat_T.png\"/></p>
<p>Dynamic viscosity (about half of Dowcal100)</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100E_dynVis_T.png\"/></p>
<p>Thermal conductivity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100E_thermCond.png\"/></p>
</html>"));
end TestDowcal100E;
