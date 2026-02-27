within ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries;
function internalCoefficientsFromCoefficients "Calculates InteralCoefficients record from input coefficients record"
  extends Modelica.Icons.Function;

  input ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump data "Input pump coefficients";
  output ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.InternalCoefficients coefficients(
    rho_ref=data.rho_ref,
    w_ref=data.w_ref,
    head_ref=data.head_ref_internal,
    V_flow_ref=data.V_flow_peak,
    eta_ref=data.eta_peak,
    c_head={ch0,ch1,ch2},
    c_power={cp0,cp1,cp2},
    P_ref = data.rho_ref*Modelica.Constants.g_n*data.head_ref_internal* data.V_flow_peak/data.eta_peak,
    tau_ref = data.rho_ref*Modelica.Constants.g_n*data.head_ref_internal* data.V_flow_peak/data.eta_peak/data.w_ref) "Internal pump coefficients";

protected
  Real ch0 = data.h_0n "First head coefficient";
  Real ch1 = data.V_0n/(data.V_0n-1) - data.h_0n*(data.V_0n+1)/data.V_0n "Second head coefficient";
  Real ch2 = data.h_0n/data.V_0n - 1/(data.V_0n-1) "Third head coefficient";
  Real cp0 = data.P_0n "First power coefficient";
  Real cp1 = -2*data.P_0n + ch0 - ch2 "Second power coefficient";
  Real cp2 = data.P_0n + ch1 + 2*ch2 "Third power coefficient";
algorithm

  annotation (Documentation(info="<html>
<p>
Function to calculate
<a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.InternalCoefficients\">InternalCoefficients record</a> 
based on <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump\">coefficients record</a>.<br>
It is used in <a href=\"modelica://ThermofluidStream.Processes.CentrifugalPump\">CentrifugalPump</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
end internalCoefficientsFromCoefficients;
