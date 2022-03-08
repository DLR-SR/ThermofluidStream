within ThermofluidStream.Utilities.Functions;
function blendFunction "Smooth step between two values at two support points"
  extends Modelica.Icons.Function;
  import ThermofluidStream.Undirected.Internal.regStep;

  input Real y1 "Value of y at x1";
  input Real y2 "Value of y at x2";
  input Real x1;
  input Real x2;
  input Real x;
  output Real y;

protected
  Real u;

algorithm
  u := (2*x - (x1 + x2))/(x2 - x1);
  y := regStep(u, y2, y1, 1);
end blendFunction;
