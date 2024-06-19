within ThermofluidStream.Processes;
package Pipes
  extends Modelica.Icons.Package;

  import Modelica.Constants.pi;

  annotation (
    Icon(graphics={  Line(points={{-100,0},{100,0}},      color = {26, 95, 180}), Rectangle(origin={1,-1},    lineColor = {26, 95, 180}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-77, 41}, {77, -41}}), Line(
          origin={1,50},
          points={{-77,0},{77,0}},
          color={28,108,200},
          thickness=0.75),                                                                                                                                                                                                        Line(
          origin={1,-52},
          points={{-77,0},{77,0}},
          color={28,108,200},
          thickness=0.75)},                                                                                                                                                                                                        coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Documentation(info="<html>
<p>
Package containing basic piping components, such as pipes, bends and topolgy components.
</p>

<p>
<em>[P. Jordan; HTWG Konstanz; 03/24]</em>
</p>

<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"350\" height=\"100\">  
</p>
</html>"));
end Pipes;
