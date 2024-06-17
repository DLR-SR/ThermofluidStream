within ThermofluidStream.Processes.Pumps.BaseClasses;
partial model PartialCentrifugalPumpEfficiency "Base model of centrifugal pump based on 3+1+2 coefficients for head, power and efficiency"

  extends ThermofluidStream.Processes.Pumps.BaseClasses.PartialCentrifugalPump(
    final w_ref=coefficients.w_ref,
    final rho_ref=coefficients.rho_ref,
    final V_flow_ref=coefficients.V_flow_ref,
    final head_ref=coefficients.head_ref_internal,
    final c_head={1,coefficients.c2_head,-(1 + coefficients.c2_head)},
    final c_power={c1_power,c2_power,coefficients.c3_power},
    final eta_ref=coefficients.eta_ref);

  replaceable parameter
    ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients.CoefficientsData.GenericPumpCoefficientsEfficiency
    coefficients "Pump coefficients" annotation (choicesAllMatching=true);
protected
  final parameter Real c1_power =  coefficients.Vr_peak^2*(2*coefficients.Vr_peak + coefficients.c2_head*(2*coefficients.Vr_peak-1) +  coefficients.c3_power)
    "First (constant) coefficient of 2nd order power approximation polynomial"; // c1_power = Vrp^2*(2*Vrp + ch2*(2*Vrp-1) + cP3)
  final parameter Real c2_power =  1 - 3*coefficients.Vr_peak^2 + coefficients.c2_head*(2*coefficients.Vr_peak - 3*coefficients.Vr_peak^2)- 2*coefficients.c3_power*coefficients.Vr_peak
    "Second (linear) coefficient of 2nd order power approximation polynomial"; // c2_power = 1 - 3*Vrp^2 + ch2*(2*Vrp-3*Vrp^2) - 2*cP3*Vrp

end PartialCentrifugalPumpEfficiency;
