within ThermofluidStream.Processes.Pipes.Internal.BaseClasses;
package WallFriction "Different variants for pressure drops due to pipe wall friction"
  extends Modelica.Icons.VariantsPackage;

  annotation (
    Documentation(info = "<html>
      <p>
      This package provides functions to compute
      pressure losses due to <strong>wall friction</strong> in a pipe.
      Every correlation is defined by a package that is derived
      by inheritance from the package WallFriction.PartialWallFriction.
      The details of the underlying pipe wall friction model are described in the
      <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a>.
      Basically, different variants of the equation
      </p>
      
      <blockquote><pre>
      dp = &lambda;(Re,&Delta;)*(L/D)*&rho;*v*|v|/2
      </pre></blockquote>
      
      <p>
      are used, where the friction loss factor &lambda; is shown
      in the next figure:
      </p>
      
      <p>
      <img src=\"modelica://Modelica/Resources/Images/Fluid/Pipes/BaseClasses/PipeFriction1.png\"
       alt=\"PipeFriction1.png\">
      </p>
      
      </html>"));
end WallFriction;
