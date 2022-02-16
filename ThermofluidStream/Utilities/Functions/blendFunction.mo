within ThermofluidStream.Utilities.Functions;

function blendFunction
extends Modelica.Icons.Function;

input Real y1;
input Real y2;
input Real x1;
input Real x2;
input Real x;
output Real y;

protected
Real u;
Real transition;

algorithm // inspired by the MATLAB Simscape Foundation Library
  u := (x-x1)/(x2-x1);
  transition := 3*u^2 - 2*u^3;

  if x < x1 then
    y := y1;
  elseif x > x2 then
    y := y2;
  else
    y := (1-transition)*y1 + transition*y2;
  end if;

end blendFunction;
