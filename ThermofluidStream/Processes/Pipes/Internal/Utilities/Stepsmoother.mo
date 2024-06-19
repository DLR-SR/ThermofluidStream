within ThermofluidStream.Processes.Pipes.Internal.Utilities;
function Stepsmoother "Continuous interpolation for x"
  extends Modelica.Icons.Function;
  input Real func "Input value for that result = 100%";
  input Real nofunc "Input value for that result = 0%";
  input Real x "Input variable for continuous interpolation";
  output Real result "Output value";
protected
  Real m = Modelica.Constants.pi/(func - nofunc);
  Real b = -Modelica.Constants.pi/2 - m*nofunc;
algorithm
  result := if x >= func and func > nofunc or x <= func and nofunc > func then 1 else if x <= nofunc and func > nofunc or x >= nofunc and nofunc > func then 0 else (1 + Modelica.Math.tanh(Modelica.Math.tan(m*x + b)))/2;
  annotation (
    Inline = false,
    derivative=Utilities.Stepsmoother_der,
    Documentation(info = "<html>
      <p>
      The function is used for continuous fading of variable inputs within a defined range. It allows a differentiable and smooth transition between function outputs, e.g., laminar and turbulent pressure drop or correlations for certain ranges.
      </p>
      <h4>Function</h4>
      <p>
      The tanh-function is used, since it provides an existing derivative and the derivative is zero at the borders [<strong>nofunc</strong>, <strong>func</strong>] of the interpolation domain (smooth derivative for transitions).<br>
      <br>
      In order to work correctly, the internal interpolation range in terms of the external arbitrary input <strong>x</strong> needs to be scaled such that:
      </p>
      <blockquote><pre>
      f(func)   = 0.5 &pi;
      f(nofunc) = -0.5 &pi;
      </pre></blockquote>
      
      <h4>Example </h4>
      <p>
      In the picture below the input x is increased from 0 to 1. The range of interpolation is defined by:
      </p>
      <ul>
      <li>func = 0.75</li>
      <li>nofunc = 0.25</li>
      </ul>
      
      <p>
      <img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/Functions/General/Stepsmoother.png\" alt=\"Stepsmoother\"/>
      </p>
      
      <h4>References</h4>
      <dl>
      <dt>Wischhusen, St.</dt>
      <dd><strong>Simulation von K&auml;ltemaschinen-Prozessen mit MODELICA / DYMOLA</strong>.
      Diploma thesis, Hamburg University of Technology, Institute of Thermofluiddynamics, 2000.</dd>
      </dl></html>"),
    smoothOrder = 5);
end Stepsmoother;
