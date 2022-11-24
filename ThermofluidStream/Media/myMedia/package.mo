within ThermofluidStream.Media;
package myMedia "Library of media property models"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;
  import Cv = Modelica.Units.Conversions;




annotation (preferredView="info",Documentation(info="<html>
<p>
This library contains <a href=\"modelica://Modelica.Media.Interfaces\">interface</a>
definitions for media and the following <strong>property</strong> models for
single and multiple substance fluids with one and multiple phases:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Media.IdealGases\">Ideal gases:</a><br>
     1241 high precision gas models based on the
     NASA Glenn coefficients, plus ideal gas mixture models based
     on the same data.</li>
<li> <a href=\"modelica://Modelica.Media.Water\">Water models:</a><br>
     ConstantPropertyLiquidWater, WaterIF97 (high precision
     water model according to the IAPWS/IF97 standard)</li>
<li> <a href=\"modelica://Modelica.Media.Air\">Air models:</a><br>
     SimpleAir, DryAirNasa, ReferenceAir, MoistAir, ReferenceMoistAir.</li>
<li> <a href=\"modelica://Modelica.Media.Incompressible\">
     Incompressible media:</a><br>
     TableBased incompressible fluid models (properties are defined by tables rho(T),
     HeatCapacity_cp(T), etc.)</li>
<li> <a href=\"modelica://Modelica.Media.CompressibleLiquids\">
     Compressible liquids:</a><br>
     Simple liquid models with linear compressibility</li>
<li> <a href=\"modelica://Modelica.Media.R134a\">Refrigerant Tetrafluoroethane (R134a)</a>.</li>
</ul>
<p>
The following parts are useful, when newly starting with this library:</p>
<ul>
<li> <a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage\">Modelica.Media.UsersGuide.MediumUsage</a>
     describes how to use a medium model in a component model.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition\">
     Modelica.Media.UsersGuide.MediumDefinition</a>
     describes how a new fluid medium model has to be implemented.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.ReleaseNotes\">Modelica.Media.UsersGuide.ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li> <a href=\"modelica://Modelica.Media.Examples\">Modelica.Media.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>", revisions="<html>
<ul>
<li><em>February 01, 2017</em> by Thomas Beutlich:<br>
    Fixed data errors of the NASA Glenn coefficients in some ideal gases (CH2, CH3, CH3OOH, C2CL2, C2CL4, C2CL6, C2HCL, C2HCL3, CH2CO_ketene, O_CH_2O, HO_CO_2OH, CH2BrminusCOOH, C2H3CL, CH2CLminusCOOH, HO2, HO2minus, OD, ODminus), see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1922\">#1922</a></li>
<li><em>May 16, 2013</em> by Stefan Wischhusen (XRG Simulation):<br>
    Added new media models Air.ReferenceMoistAir, Air.ReferenceAir, R134a.</li>
<li><em>May 25, 2011</em> by Francesco Casella:<br>Added min/max attributes to Water, TableBased, MixtureGasNasa, SimpleAir and MoistAir local types.</li>
<li><em>May 25, 2011</em> by Stefan Wischhusen:<br>Added individual settings for polynomial fittings of properties.</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Line(
          points = {{-76,-80},{-62,-30},{-32,40},{4,66},{48,66},{73,45},{62,-8},{48,-50},{38,-80}},
          color={64,64,64},
          smooth=Smooth.Bezier),
        Line(
          points={{-40,20},{68,20}},
          color={175,175,175}),
        Line(
          points={{-40,20},{-44,88},{-44,88}},
          color={175,175,175}),
        Line(
          points={{68,20},{86,-58}},
          color={175,175,175}),
        Line(
          points={{-60,-28},{56,-28}},
          color={175,175,175}),
        Line(
          points={{-60,-28},{-74,84},{-74,84}},
          color={175,175,175}),
        Line(
          points={{56,-28},{70,-80}},
          color={175,175,175}),
        Line(
          points={{-76,-80},{38,-80}},
          color={175,175,175}),
        Line(
          points={{-76,-80},{-94,-16},{-94,-16}},
          color={175,175,175})}));
end myMedia;
