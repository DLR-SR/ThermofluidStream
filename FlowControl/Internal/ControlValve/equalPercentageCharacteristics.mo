within ThermofluidStream.FlowControl.Internal.ControlValve;
function equalPercentageCharacteristics "Equal percentage"

  extends Internal.ControlValve.partialValveCharacteristics;

algorithm
  k_u := k_min*exp(u*log(1/k_min));

end equalPercentageCharacteristics;
