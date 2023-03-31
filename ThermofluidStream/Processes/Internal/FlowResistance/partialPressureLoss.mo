within ThermofluidStream.Processes.Internal.FlowResistance;
partial function partialPressureLoss
  "Interface for pressure loss functions"
  input SI.MassFlowRate m_flow "Mass flow rate";
  input SI.Density rho "Medium density";
  input SI.DynamicViscosity mu "Medium dynamic viscosity";
  input SI.Length r(min=0) "Pipe radius";
  input SI.Length l(min=0) "Pipe length";

  output SI.Pressure pressureLoss "Pressure lost in Pipe";

  annotation(Inline=true, smoothOrder=100,
    Documentation(info="<html>
<p>Interface definition for a pressure loss in a pipe. Inputs are information about flow condition and the medium as well as the geometry of the pipe, output is the pressure drop.</p>
</html>"));
end partialPressureLoss;
