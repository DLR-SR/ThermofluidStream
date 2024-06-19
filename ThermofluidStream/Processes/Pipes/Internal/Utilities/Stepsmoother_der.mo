within ThermofluidStream.Processes.Pipes.Internal.Utilities;
function Stepsmoother_der "Derivative of function Stepsmoother"
  extends Modelica.Icons.Function;
  input Real func "Input for that result = 100%";
  input Real nofunc "Input for that result = 0%";
  input Real x "Input for interpolation";
  input Real dfunc "Derivative of func";
  input Real dnofunc "Derivative of nofunc";
  input Real dx "Derivative of x";
  output Real dresult;
protected
  Real m = Modelica.Constants.pi/(func - nofunc);
  Real b = -Modelica.Constants.pi/2 - m*nofunc;
algorithm
  dresult := if x >= func and func > nofunc or x <= func and nofunc > func or x <= nofunc and func > nofunc or x >= nofunc and nofunc > func then 0 else (1 - Modelica.Math.tanh(Modelica.Math.tan(m*x + b))^2)*(1 + Modelica.Math.tan(m*x + b)^2)*(-m^2/Modelica.Constants.pi*(dfunc - dnofunc)*x + m*dx + m^2/Modelica.Constants.pi*(dfunc - dnofunc)*nofunc - m*dnofunc)/2;
end Stepsmoother_der;
