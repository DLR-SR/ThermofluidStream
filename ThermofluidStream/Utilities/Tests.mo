within ThermofluidStream.Utilities;
package Tests
  extends Modelica.Icons.ExamplesPackage;



  model TestFunctions
    extends Modelica.Icons.Example;

    output Real y_blend = Functions.blendFunction(-2, 1, 3, 8, time);


    annotation (
      experiment(StopTime=10),
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TestFunctions;
end Tests;
