within ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries;
function pumpCoefficientsFromCoefficients
  extends Modelica.Icons.Function;

  input ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump data
    "Pump coefficients (using efficiency)";
  output ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.InternalCoefficients coefficients(
    rho_ref=data.rho_ref,
    w_ref=data.w_ref,
    head_ref=data.head_ref_internal,
    V_flow_ref=data.V_flow_ref,
    eta_ref=data.eta_ref,
    c_head={1,data.c2_head,-(1 + data.c2_head)},
    c_power={c1_power,c2_power,data.c3_power}) "Pump coefficients";

protected
  Real c1_power = data.Vr_peak^2*(2*data.Vr_peak + data.c2_head*(2*data.Vr_peak-1) +  data.c3_power)
    "First (constant) coefficient of 2nd order power approximation polynomial"; // c1_power = Vrp^2*(2*Vrp + ch2*(2*Vrp-1) + cP3)
  Real c2_power = 1 - 3*data.Vr_peak^2 + data.c2_head*(2*data.Vr_peak - 3*data.Vr_peak^2)- 2*data.c3_power*data.Vr_peak
    "Second (linear) coefficient of 2nd order power approximation polynomial"; // c2_power = 1 - 3*Vrp^2 + ch2*(2*Vrp-3*Vrp^2) - 2*cP3*Vrp
algorithm

  annotation (Documentation(info="<html>
<p>
Function to calculate
<a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.InternalCoefficients\">InternalCoefficients record</a> 
based on <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients\">coefficients record</a>.<br>
It is used in <a href=\"modelica://ThermofluidStream.Processes.CentrifugalPump\">CentrifugalPump</a>.
</p>
</html>"));
end pumpCoefficientsFromCoefficients;
