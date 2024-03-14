within ThermofluidStream.Processes.Internal.FlowResistance;
partial function partialPressureLoss "Partial pressure loss function"
  extends Modelica.Icons.Function;

  input SI.MassFlowRate m_flow "Mass flow rate";
  input SI.Density rho "Density";
  input SI.DynamicViscosity mu "Dynamic viscosity";
  input SI.Length r(min=0) "Radius";
  input SI.Length l(min=0) "Length";

  output SI.Pressure pressureLoss "pressure loss (dp)";

  annotation(Inline=true, smoothOrder=100,
    Documentation(info="<html>
<p>Interface definition for a pressure loss in a pipe. Inputs are information about flow condition and the medium as well as the geometry of the pipe, output is the pressure drop.</p>
</html>"));
end partialPressureLoss;
