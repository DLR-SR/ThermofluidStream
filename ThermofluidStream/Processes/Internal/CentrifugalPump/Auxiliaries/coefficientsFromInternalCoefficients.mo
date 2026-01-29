within ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries;
function coefficientsFromInternalCoefficients "Calculates coefficients record from InternalCoefficients record"
  extends Modelica.Icons.Function;

  input ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.InternalCoefficients data "Internal pump coefficients";
  output ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump coefficients(
    rho_ref=data.rho_ref,
    w_ref=data.w_ref,
    head_peak=data.head_ref,
    V_flow_peak=data.V_flow_ref,
    eta_peak=data.eta_ref,
    V_0n=V_0n,
    h_0n=h_0n,
    P_0n=P_0n) "Input pump coefficients";

protected
  Real h_0n = data.c_head[1] "Normalized head at zero flow";
  Real P_0n = data.c_power[1] "Normalized power at zero flow";
  Real V_0n = -1/(2*data.c_head[3])*(data.c_head[2] + sqrt(data.c_head[2]^2 - 4*data.c_head[1]*data.c_head[3]));
algorithm

  annotation (Documentation(info="<html>
<p>
Function to calculate <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump\">coefficients record</a>
based on
<a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.InternalCoefficients\">InternalCoefficients record</a>.<br>
It is used in the example <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.CalculateCoefficientsFromMeasurements\">CalculateCoefficientsFromMeasurements</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
end coefficientsFromInternalCoefficients;
