within ThermofluidStream.Processes.Internal.FlowResistance;
function zetaPressureLoss "Pressure loss function based on zeta value"
  extends Internal.FlowResistance.partialPressureLoss;

  input Real zeta( unit = "1") "Zeta value of component"
    annotation(Dialog(enable=true));



  //SI.Area A_zeta "Reference area either from radius or set by parameter";
protected
    SI.Area A "Reference area either from radius or set by parameter";
algorithm

//   if shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.circular then
//     d_h := 2*r;
//     A_zeta :=Modelica.Constants.pi*r*r;
//   elseif shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.rectangle then
//     d_h := 2*a*b/(a+b);
//     A_zeta := Modelica.Constants.pi*d_h/4;
//   elseif shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.other then
//     A_zeta := A;
//   end if;
  A := Modelica.Constants.pi*r*r;
  pressureLoss := zeta/(2*rho)*Modelica.Fluid.Utilities.regSquare(m_flow/A);


  annotation (Documentation(info="<html>
<p>For specific components (armatures, fittings, pipe sections, grids, ...), the zeta value is often given in the data sheet.</p>
<p>Together with a given reference area A, the pressure drop can be calculated:</p>
<p style=\"margin-left: 40px;\"><span style=\"font-family: Courier New;\">dp := zeta/(2*rho)*m_flow^2/A^2</span></p>
<p>The square of the mass-flow is regularized using the regSquare function from the MSL.</p>
</html>"));
end zetaPressureLoss;
