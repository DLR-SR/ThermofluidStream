within ThermofluidStream.Utilities.Functions;
function sigmoid
  input Real x;
  output Real y;

algorithm
  y:=0.5*(1 + tanh(x/2));
end sigmoid;
