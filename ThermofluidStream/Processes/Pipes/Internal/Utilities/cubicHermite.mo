within ThermofluidStream.Processes.Pipes.Internal.Utilities;
function cubicHermite
  extends Modelica.Icons.Function;
  input Real x "Abscissa value";
  input Real x1 "Lower abscissa value";
  input Real x2 "Upper abscissa value";
  input Real y1 "Lower ordinate value";
  input Real y2 "Upper ordinate value";
  input Real y1d "Lower gradient";
  input Real y2d "Upper gradient";
  output Real y "Interpolated ordinate value";
protected
  Real h "Distance between x1 and x2";
  Real t "Abscissa scaled with h, i.e., t=[0..1] within x=[x1..x2]";
  Real h00 "Basis function 00 of cubic Hermite spline";
  Real h10 "Basis function 10 of cubic Hermite spline";
  Real h01 "Basis function 01 of cubic Hermite spline";
  Real h11 "Basis function 11 of cubic Hermite spline";
  Real aux3 "t cube";
  Real aux2 "t square";
algorithm
  h := x2 - x1;
  if abs(h) > 0 then
    // Regular case
    t := (x - x1)/h;
    aux3 := t^3;
    aux2 := t^2;
    h00 := 2*aux3 - 3*aux2 + 1;
    h10 := aux3 - 2*aux2 + t;
    h01 := -2*aux3 + 3*aux2;
    h11 := aux3 - aux2;
    y := y1*h00 + h*y1d*h10 + y2*h01 + h*y2d*h11;
  else
    // Degenerate case, x1 and x2 are identical, return step function
    y := (y1 + y2)/2;
  end if;
  annotation (
    smoothOrder = 3,
    Documentation(revisions = "<html><head></head><body></body></html>", info = "<html><head></head><body><br></body></html>"));
end cubicHermite;
