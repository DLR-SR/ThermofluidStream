within ThermofluidStream.Processes.Internal.FlowResistance;
partial model partialPressureLoss "Partial pressure loss model"

  input SI.MassFlowRate m_flow "Mass flow rate";
  input SI.Density rho "Density";
  input SI.DynamicViscosity mu "Dynamic viscosity";
  input SI.Length r(min=0) "Radius";
  input SI.Length l(min=0) "Length";

  output SI.PressureDifference pressureLoss "pressure loss (dp)";

  annotation(Documentation(info="<html>
<p>Interface definition for a pressure loss in a pipe. Inputs are information about flow condition and the medium as well as the geometry of the pipe, output is the pressure drop.</p>
</html>"));
end partialPressureLoss;
